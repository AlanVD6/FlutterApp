import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:lottie/lottie.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  int? selectedSize;
  String? selectedColor;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
  bool _showAnimation = false; 

  //inicia el carrusel 
  @override
  void initState() {
    super.initState();
    if (widget.product.galleryImages.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        if (_currentPage < widget.product.galleryImages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (widget.product.galleryImages.length > 1) {
      _timer.cancel();
    }
    super.dispose();
  }

//activa animacion de compra.
  void _showAnimationAndDialog(BuildContext context) {
    setState(() {
      _showAnimation = true;
    });

   
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _showAnimation = false;
      });

      _showPurchaseSuccess(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.product.price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    //carrusel de imagenes Si la imagen está vacía o falla, muestra un ícono de fallback.
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: widget.product.galleryImages.length,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: widget.product.galleryImages[index].isEmpty
                                ? Container(
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                      child: Icon(
                                        Icons.shopping_bag,
                                        size: 100,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    widget.product.galleryImages[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => 
                                      Container(
                                        color: Colors.grey.shade200,
                                        child: const Center(
                                          child: Icon(
                                            Icons.shopping_bag,
                                            size: 50,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                      ),
                                  ),
                          );
                        },
                      ),
                      //indicadores del carrusel 
                      if (widget.product.galleryImages.length > 1)
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.product.galleryImages.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == index ? 12 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4),
                                  color: _currentPage == index
                                      ? Colors.indigo
                                      : Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                          ),
                          Text(
                            'MXN \$${widget.product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 15),

                      // Descripción
                      Text(
                        widget.product.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      // Selector de color
                      const Text(
                        'COLOR DISPONIBLE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.product.availableColors.map((color) {
                          return ChoiceChip(
                            label: Text(
                              color,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedColor == color ? Colors.white : Colors.black,
                              ),
                            ),
                            selected: selectedColor == color,
                            onSelected: (selected) {
                              setState(() {
                                selectedColor = selected ? color : null;
                              });
                            },
                            selectedColor: _getColorFromString(color),
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      // Selector de talla
                      const Text(
                        'SELECCIONA TU TALLA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.product.availableSizes.map((size) {
                          return ChoiceChip(
                            label: Text(
                              size.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedSize == size ? Colors.white : Colors.black,
                              ),
                            ),
                            selected: selectedSize == size,
                            onSelected: (selected) {
                              setState(() {
                                selectedSize = selected ? size : null;
                              });
                            },
                            selectedColor: Colors.indigo,
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          );
                        }).toList(),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      // Selector de cantidad
                      const Text(
                        'CANTIDAD',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.indigo,
                              iconSize: 30,
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              color: Colors.indigo,
                              iconSize: 30,
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      // Precio total
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                            Text(
                              'MXN \$${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Botón de compra
                      ElevatedButton(
                        onPressed: () {
                          if (selectedSize == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Por favor selecciona una talla'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                            return;
                          }
                          if (selectedColor == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Por favor selecciona un color'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                            return;
                          }
                          _showAnimationAndDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 3,
                        ),
                        child: const Text(
                          'COMPRAR AHORA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Animación de carga de compra 
          if (_showAnimation)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Lottie.asset(
                  'assets/compra.json', 
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }

//colores de los tenis para los botones 
  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'negro':
        return Colors.black;
      case 'blanco':
        return Colors.white;
      case 'gris':
        return Colors.grey;
      case 'azul':
        return Colors.blue;
      case 'rojo':
        return Colors.red;
      case 'café':
      case 'cafe':
        return const Color(0xFF795548);
      default:
        return Colors.indigo;
    }
  }

//mesanje de compra exitosa
  void _showPurchaseSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                const SizedBox(height: 20),
                const Text(
                  '¡Compra Exitosa!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  '¡Gracias por tu compra!',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                _buildDetailRow('Producto:', widget.product.name),
                _buildDetailRow('Color:', selectedColor ?? ''),
                _buildDetailRow('Talla:', selectedSize?.toString() ?? ''),
                _buildDetailRow('Cantidad:', quantity.toString()),
                _buildDetailRow(
                  'Total:', 
                  'MXN \$${(widget.product.price * quantity).toStringAsFixed(2)}',
                  isTotal: true,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('ACEPTAR'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.indigo : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}