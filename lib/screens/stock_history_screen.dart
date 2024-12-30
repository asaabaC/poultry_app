import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/product.dart';

class StockHistoryScreen extends StatefulWidget {
  final Product product;

  const StockHistoryScreen({super.key, required this.product});

  @override
  State<StockHistoryScreen> createState() => _StockHistoryScreenState();
}

class _StockHistoryScreenState extends State<StockHistoryScreen> {
  String _selectedTimeRange = '1W'; // 1W, 1M, 3M, 6M, 1Y
  List<StockEntry> _stockHistory = [];

  @override
  void initState() {
    super.initState();
    _loadStockHistory();
  }

  void _loadStockHistory() {
    // In a real app, this would load from a database
    // For now, we'll generate sample data
    final now = DateTime.now();
    _stockHistory = List.generate(30, (index) {
      return StockEntry(
        date: now.subtract(Duration(days: 29 - index)),
        quantity: widget.product.quantity + (index * 5) - (index % 3 * 10),
        type: index % 3 == 0 ? 'Restock' : 'Sale',
      );
    });
  }

  List<StockEntry> _getFilteredHistory() {
    final now = DateTime.now();
    switch (_selectedTimeRange) {
      case '1W':
        return _stockHistory
            .where((entry) =>
                entry.date.isAfter(now.subtract(const Duration(days: 7))))
            .toList();
      case '1M':
        return _stockHistory
            .where((entry) =>
                entry.date.isAfter(now.subtract(const Duration(days: 30))))
            .toList();
      case '3M':
        return _stockHistory
            .where((entry) =>
                entry.date.isAfter(now.subtract(const Duration(days: 90))))
            .toList();
      case '6M':
        return _stockHistory
            .where((entry) =>
                entry.date.isAfter(now.subtract(const Duration(days: 180))))
            .toList();
      case '1Y':
        return _stockHistory
            .where((entry) =>
                entry.date.isAfter(now.subtract(const Duration(days: 365))))
            .toList();
      default:
        return _stockHistory;
    }
  }

  Widget _buildStockChart() {
    final filteredHistory = _getFilteredHistory();
    if (filteredHistory.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString());
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= 0 &&
                        value.toInt() < filteredHistory.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          DateFormat('MM/dd')
                              .format(filteredHistory[value.toInt()].date),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: filteredHistory.asMap().entries.map((entry) {
                  return FlSpot(
                      entry.key.toDouble(), entry.value.quantity.toDouble());
                }).toList(),
                isCurved: true,
                color: Colors.orange,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.orange.withOpacity(0.2),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final entry = filteredHistory[touchedSpot.x.toInt()];
                    return LineTooltipItem(
                      '${DateFormat('MM/dd').format(entry.date)}\n',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Quantity: ${entry.quantity}\n',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'Type: ${entry.type}',
                          style: TextStyle(
                            color: entry.type == 'Restock'
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStockList() {
    final filteredHistory = _getFilteredHistory();
    return Expanded(
      child: ListView.builder(
        itemCount: filteredHistory.length,
        itemBuilder: (context, index) {
          final entry = filteredHistory[index];
          final isRestock = entry.type == 'Restock';
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  isRestock ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              child: Icon(
                isRestock ? Icons.add : Icons.remove,
                color: isRestock ? Colors.green : Colors.red,
              ),
            ),
            title: Text(
              '${isRestock ? '+' : '-'}${entry.quantity} units',
              style: TextStyle(
                color: isRestock ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              DateFormat('MMM d, y').format(entry.date),
            ),
            trailing: Text(
              entry.type,
              style: TextStyle(
                color: isRestock ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.product.name} Stock History'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Stock: ${widget.product.quantity}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedTimeRange,
                  items: ['1W', '1M', '3M', '6M', '1Y'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedTimeRange = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          _buildStockChart(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Stock History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildStockList(),
        ],
      ),
    );
  }
}

class StockEntry {
  final DateTime date;
  final int quantity;
  final String type; // 'Restock' or 'Sale'

  StockEntry({
    required this.date,
    required this.quantity,
    required this.type,
  });
}
