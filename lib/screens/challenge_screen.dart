import 'package:flutter/material.dart';
import 'package:flutter_application_1/mode/product.dart';
import 'package:flutter_application_1/screens/product_detail_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}
  //Lista de los productos
class _ChallengeScreenState extends State<ChallengeScreen> {
  final List<Product> productos = [
    Product(
      id: '1',
      name: 'Pirma Edge',
      price: 769.99,
      description: 'Zapatos de corte moderno con detalles en relieve, ideales para un look sofisticado y cómodo en entornos urbanos.',
      imageUrl: 'assets/Shop/Pirma_Edge.jpg',
      galleryImages: [
        'assets/Shop/Pirma_Edge.jpg',
        'assets/Shop/Pirma_Edge2.jpg',
        'assets/Shop/Pirma_Edge3.jpg',
      ],
      availableSizes: [25, 26, 27, 28, 29, 30],
      availableColors: ['Negro', 'Azul', 'Gris'],
    ),
    Product(
      id: '2',
      name: 'Vans Urban X',
      price: 499.99,
      description: 'Estilo urbano con máxima comodidad para el día a día.',
      imageUrl: 'assets/Shop/Vans_night.jpg',
      galleryImages: [
        'assets/Shop/Vans_night.jpg',
        'assets/Shop/Vans_night2.jpg',
      ],
      availableSizes: [26, 27, 28, 29, 30, 31],
      availableColors: ['Negro', 'Blanco', 'Rojo'],
    ),
    Product(
      id: '3',
      name: 'Converse Bota',
      price: 1799.99,
      description: 'Diseño urbano y ligereza extrema: el calzado perfecto para tu rutina diaria.',
      imageUrl: 'assets/Shop/Converse.jpg',
      galleryImages: [
        'assets/Shop/Converse.jpg',
        'assets/Shop/Converse2.jpg',
      ],
      availableSizes: [25, 26, 27, 28, 29, 30],
      availableColors: ['Negro', 'Blanco', 'Azul'],
    ),
    Product(
      id: '4',
      name: 'Chancla - Sandalia',
      price: 199.99,
      description: 'Herramienta multipropósito: mata moscas, aplasta cucarachas y educa hijos rebeldes.\nAdvertencia: Puede causar flashbacks de infancia',
      imageUrl: 'assets/Shop/Chancla.jpg',
      galleryImages: [
        'assets/Shop/Chancla.jpg',
        'assets/Shop/Chancla2.jpg',
        'assets/Shop/Chancla3.jpg',
      ],
      availableSizes: [25, 26, 27, 28,29,30],
      availableColors: ['Negro', 'Azul', 'Rojo'],
    ),
    Product(
      id: '5',
      name: 'Pirma Blue',
      price: 599.99,
      description: 'El balance perfecto entre estilo urbano y confort excepcional.',
      imageUrl: 'assets/Shop/Pirma_Blue.jpg',
      galleryImages: [
        'assets/Shop/Pirma_Blue.jpg',
        'assets/Shop/Pirma_Blue2.jpg',
        'assets/Shop/Pirma_Blue3.jpg',
      ],
      availableSizes: [27, 28, 29, 30],
      availableColors: ['Azul', 'Blanco', 'Gris'],
    ),
    Product(
      id: '6',
      name: 'Fila Sports',
      price: 2299.99,
      description: 'Desde la cancha hasta la calle: máximo confort sin sacrificar el look urbano.',
      imageUrl: 'assets/Shop/Fila_Sports.jpg',
      galleryImages: [
        'assets/Shop/Fila_Sports.jpg',
        'assets/Shop/Fila_Sports2.jpg',
        'assets/Shop/Fila_Sports3.jpg',
      ],
      availableSizes: [25, 26, 27, 28, 29],
      availableColors: ['Blanco', 'Rojo', 'Negro'],
    ),
    Product(
      id: '7',
      name: 'Nike Air Flex',
      price: 1699.99,
      description: 'Amortiguación premium y flexibilidad mejorada.',
      imageUrl: 'assets/Shop/Nike_Air.jpg',
      galleryImages: [
        'assets/Shop/Nike_Air.jpg',
        'assets/Shop/Nike_Air2.jpg',
      ],
      availableSizes: [26, 27, 28, 29, 30],
      availableColors: ['Negro', 'Blanco', 'Rojo'],
    ),
    Product(
      id: '8',
      name: 'French elegance',
      price: 199.99,
      description: 'Para ocasiones formales que exigen sofisticación sin sacrificar comodidad.',
      imageUrl: 'assets/Shop/Clasicos.jpg',
      galleryImages: [
        'assets/Shop/Clasicos.jpg',
        'assets/Shop/Clasicos2.jpg',
      ],
      availableSizes: [25, 26, 27,28,29],
      availableColors: ['Negro', 'Café'],
    ),
    Product(
      id: '9',
      name: 'Classic Vintage',
      price: 299.99,
      description: 'Comodidad que dura todo el día, ideal para trabajo.',
      imageUrl: 'assets/Shop/Classic_Vintage.jpg',
      galleryImages: [
        'assets/Shop/Classic_Vintage.jpg',
        'assets/Shop/Classic_Vintage2.jpg',
      ],
      availableSizes: [27, 28, 29, 30],
      availableColors: ['Café', 'Negro'],
    ),
    Product(
      id: '10',
      name: 'Vans Modern',
      price: 1199.99,
      description: 'No elijas entre moda y comodidad: estos tenis lo tienen todo.',
      imageUrl: 'assets/Shop/Vans_modern.jpg',
      galleryImages: [
        'assets/Shop/Vans_modern.jpg',
        'assets/Shop/Vans_modern2.jpg',
      ],
      availableSizes: [26, 27, 28, 29],
      availableColors: ['Negro', 'Blanco', 'Gris'],
    ),
  ];

  //ESTADO DE CARGA
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
//Titulo de la Empresa
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Shop DarkStride',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
        centerTitle: true,
      ),
      //Apartado de descuento 
      body: Stack(
        children: [
          // Contenido principal
          if (!isLoading)
            SingleChildScrollView(
              child: Column(
                children: [
                  // Banner promocional
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.shade800,
                          Colors.indigo.shade400,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '¡OFERTA ESPECIAL!',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '15% DE DESCUENTO EN TU PRIMERA COMPRA',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.local_shipping, color: Colors.white),
                            Text(
                              'Envío gratis en compras > MXN\$3,000',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.verified_user, color: Colors.white),
                            Text(
                              'Garantía 3 meses',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Lista de productos
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'NUESTROS PRODUCTOS DE TEMPORADA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productos.length,
                          itemBuilder: (context, index) {
                            return _buildProductCard(productos[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Overlay de carga
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/loading.json',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Cargando catálogo...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product producto) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: producto),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto con indicador de galería
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 16/9,
                      child: Image.asset(
                        producto.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                          Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(Icons.shopping_bag, size: 50, color: Colors.indigo),
                            ),
                          ),
                      ),
                    ),
                  ),
                  if (producto.galleryImages.length > 1)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: 12),

              // Nombre y precio
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      producto.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  Text(
                    'MXN \$${producto.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),

              // Descripción
              Text(
                producto.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              
              const SizedBox(height: 12),

              // Tallas y colores
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  Chip(
                    label: Text(
                      'Tallas: ${producto.availableSizes.join(', ')}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.indigo.shade50,
                  ),
                  Chip(
                    label: Text(
                      'Colores: ${producto.availableColors.join(', ')}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.indigo.shade50,
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Botón de detalles
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: producto),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade200,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'VER ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}