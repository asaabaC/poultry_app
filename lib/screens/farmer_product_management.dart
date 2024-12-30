import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product.dart';
import 'stock_history_screen.dart';

class FarmerProductManagement extends StatefulWidget {
  const FarmerProductManagement({super.key});

  @override
  State<FarmerProductManagement> createState() => _FarmerProductManagementState();
}

class _FarmerProductManagementState extends State<FarmerProductManagement> {
  final List<Product> _products = [];
  final ImagePicker _picker = ImagePicker();
  String _selectedCategory = 'Broilers';
  List<String> _tempImages = [];

  final List<String> _categories = [
    'Broilers',
    'Layers',
    'Eggs',
    'Chicks',
    'Feed',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    // Load initial products
    _products.addAll([
      Product(
        id: 'p1',
        name: 'Broilers',
        wholesalePrice: 25000,
        retailPrice: 28000,
        quantity: 150,
        minWholesaleQuantity: 20,
        description: 'Healthy broilers, ready for sale',
        category: 'Broilers',
        farmerId: 'farmer1',
        images: ['assets/broiler.jpg'],
      ),
      Product(
        id: 'p2',
        name: 'Layers',
        wholesalePrice: 30000,
        retailPrice: 33000,
        quantity: 200,
        minWholesaleQuantity: 15,
        description: 'Productive layers, good egg laying rate',
        category: 'Layers',
        farmerId: 'farmer1',
        images: ['assets/layers.jpg'],
      ),
    ]);
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _tempImages.add(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _showAddEditProductDialog([Product? product]) {
    final isEditing = product != null;
    final nameController = TextEditingController(text: product?.name ?? '');
    final wholesalePriceController = TextEditingController(
        text: (product?.wholesalePrice ?? '').toString());
    final retailPriceController =
        TextEditingController(text: (product?.retailPrice ?? '').toString());
    final quantityController =
        TextEditingController(text: (product?.quantity ?? '').toString());
    final minWholesaleController = TextEditingController(
        text: (product?.minWholesaleQuantity ?? '').toString());
    final descriptionController =
        TextEditingController(text: product?.description ?? '');

    _selectedCategory = product?.category ?? 'Broilers';
    _tempImages = List.from(product?.images ?? []);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Edit Product' : 'Add New Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image picker section
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _tempImages.isEmpty
                    ? IconButton(
                        icon: const Icon(Icons.add_photo_alternate),
                        onPressed: _pickImage,
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _tempImages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _tempImages.length) {
                            return IconButton(
                              icon: const Icon(Icons.add_photo_alternate),
                              onPressed: _pickImage,
                            );
                          }
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Image.file(
                                  File(_tempImages[index]),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.remove_circle),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      _tempImages.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  hintText: 'e.g., Broilers, Layers, Eggs',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: wholesalePriceController,
                      decoration: const InputDecoration(
                        labelText: 'Wholesale Price (UGX)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: retailPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Retail Price (UGX)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Available Quantity',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: minWholesaleController,
                      decoration: const InputDecoration(
                        labelText: 'Min. Wholesale Qty',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Product details',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _tempImages.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newProduct = Product(
                id: product?.id ?? 'p${_products.length + 1}',
                name: nameController.text,
                wholesalePrice: double.tryParse(wholesalePriceController.text) ?? 0,
                retailPrice: double.tryParse(retailPriceController.text) ?? 0,
                quantity: int.tryParse(quantityController.text) ?? 0,
                minWholesaleQuantity:
                    int.tryParse(minWholesaleController.text) ?? 0,
                description: descriptionController.text,
                category: _selectedCategory,
                images: List.from(_tempImages),
                farmerId: 'farmer1', // Replace with actual farmer ID
              );

              setState(() {
                if (isEditing) {
                  final index =
                      _products.indexWhere((p) => p.id == product.id);
                  _products[index] = newProduct;
                } else {
                  _products.add(newProduct);
                }
              });

              _tempImages.clear();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: Text(isEditing ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildStockIndicator(Product product) {
    final stockLevel = product.quantity / product.minWholesaleQuantity;
    Color color;
    String label;

    if (stockLevel <= 1) {
      color = Colors.red;
      label = 'Low Stock';
    } else if (stockLevel <= 2) {
      color = Colors.orange;
      label = 'Medium Stock';
    } else {
      color = Colors.green;
      label = 'Good Stock';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Group products by category
    final groupedProducts = <String, List<Product>>{};
    for (final product in _products) {
      if (!groupedProducts.containsKey(product.category)) {
        groupedProducts[product.category] = [];
      }
      groupedProducts[product.category]!.add(product);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: Colors.orange,
      ),
      body: _products.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inventory,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No products added yet',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showAddEditProductDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Your First Product'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: groupedProducts.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, categoryIndex) {
                final category = groupedProducts.keys.elementAt(categoryIndex);
                final categoryProducts = groupedProducts[category]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoryProducts.length,
                      itemBuilder: (context, productIndex) {
                        final product = categoryProducts[productIndex];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.images.isNotEmpty)
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product.images.length,
                                    itemBuilder: (context, imageIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Image.file(
                                          File(product.images[imageIndex]),
                                          height: 180,
                                          width: 180,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                product.description,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        _buildStockIndicator(product),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Wholesale: UGX ${NumberFormat('#,###').format(product.wholesalePrice)}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'Min Qty: ${product.minWholesaleQuantity}',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Retail: UGX ${NumberFormat('#,###').format(product.retailPrice)}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'Stock: ${product.quantity}',
                                              style: TextStyle(
                                                color: product.quantity <
                                                        product.minWholesaleQuantity
                                                    ? Colors.red
                                                    : Colors.grey,
                                                fontWeight: product.quantity <
                                                        product.minWholesaleQuantity
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Last updated: ${DateFormat('MMM d, y').format(product.lastUpdated)}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () =>
                                              _showAddEditProductDialog(product),
                                          child: const Text('Edit'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StockHistoryScreen(
                                                  product: product,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Stock History'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _products.remove(product);
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditProductDialog(),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
