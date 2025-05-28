import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/screens/product_detail_screen.dart';
import 'package:flutter_application_1/screens/challenge_screen2.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

//productos 
class _ChallengeScreenState extends State<ChallengeScreen> {
  final List<Product> productos = [
    Product(
      id: '1',
      name: 'Pirma Edge',
      price: 769.99,
      description: 'Zapatos de corte moderno con detalles en relieve, ideales para un look sofisticado y cómodo en entornos urbanos.',
      imageUrl: 'assets/ShopH/Pirma_Edge.jpg',
      galleryImages: [
        'assets/ShopH/Pirma_Edge.jpg',
        'assets/ShopH/Pirma_Edge2.jpg',
        'assets/ShopH/Pirma_Edge3.jpg',
      ],
      availableSizes: [25, 26, 27, 28, 29, 30],
      availableColors: ['Negro', 'Azul', 'Gris'],
    ),
    Product(
      id: '2',
      name: 'Vans Urban X',
      price: 499.99,
      description: 'Estilo urbano con máxima comodidad para el día a día.',
      imageUrl: 'assets/ShopH/Vans_night.jpg',
      galleryImages: [
        'assets/ShopH/Vans_night.jpg',
        'assets/ShopH/Vans_night2.jpg',
      ],
      availableSizes: [26, 27, 28, 29, 30, 31],
      availableColors: ['Negro', 'Blanco', 'Rojo'],
    ),
    Product(
      id: '3',
      name: 'Converse Bota',
      price: 1799.99,
      description: 'Diseño urbano y ligereza extrema: el calzado perfecto para tu rutina diaria.',
      imageUrl: 'assets/ShopH/Converse.jpg',
      galleryImages: [
        'assets/ShopH/Converse.jpg',
        'assets/ShopH/Converse2.jpg',
      ],
      availableSizes: [25, 26, 27, 28, 29, 30],
      availableColors: ['Negro', 'Blanco', 'Azul'],
    ),
    Product(
      id: '4',
      name: 'Chancla - Sandalia',
      price: 199.99,
      description: 'Herramienta multipropósito: mata moscas, aplasta cucarachas y educa hijos rebeldes.\nAdvertencia: Puede causar flashbacks de infancia',
      imageUrl: 'assets/ShopH/Chancla.jpg',
      galleryImages: [
        'assets/ShopH/Chancla.jpg',
        'assets/ShopH/Chancla2.jpg',
        'assets/ShopH/Chancla3.jpg',
      ],
      availableSizes: [25, 26, 27, 28, 29, 30],
      availableColors: ['Negro', 'Azul', 'Rojo'],
    ),
    Product(
      id: '5',
      name: 'Pirma Blue',
      price: 599.99,
      description: 'El balance perfecto entre estilo urbano y confort excepcional.',
      imageUrl: 'assets/ShopH/Pirma_Blue.jpg',
      galleryImages: [
        'assets/ShopH/Pirma_Blue.jpg',
        'assets/ShopH/Pirma_Blue2.jpg',
        'assets/ShopH/Pirma_Blue3.jpg',
      ],
      availableSizes: [27, 28, 29, 30],
      availableColors: ['Azul', 'Blanco', 'Gris'],
    ),
    Product(
      id: '6',
      name: 'Fila Sports',
      price: 2299.99,
      description: 'Desde la cancha hasta la calle: máximo confort sin sacrificar el look urbano.',
      imageUrl: 'assets/ShopH/Fila_Sports.jpg',
      galleryImages: [
        'assets/ShopH/Fila_Sports.jpg',
        'assets/ShopH/Fila_Sports2.jpg',
        'assets/ShopH/Fila_Sports3.jpg',
      ],
      availableSizes: [25, 26, 27, 28, 29],
      availableColors: ['Blanco', 'Rojo', 'Negro'],
    ),
    Product(
      id: '7',
      name: 'Nike Air Flex',
      price: 1699.99,
      description: 'Amortiguación premium y flexibilidad mejorada.',
      imageUrl: 'assets/ShopH/Nike_Air.jpg',
      galleryImages: [
        'assets/ShopH/Nike_Air.jpg',
        'assets/ShopH/Nike_Air2.jpg',
      ],
      availableSizes: [26, 27, 28, 29, 30],
      availableColors: ['Negro', 'Blanco', 'Rojo'],
    ),
    Product(
      id: '8',
      name: 'French elegance',
      price: 199.99,
      description: 'Para ocasiones formales que exigen sofisticación sin sacrificar comodidad.',
      imageUrl: 'assets/ShopH/Clasicos.jpg',
      galleryImages: [
        'assets/ShopH/Clasicos.jpg',
        'assets/ShopH/Clasicos2.jpg',
      ],
      availableSizes: [25, 26, 27, 28, 29],
      availableColors: ['Negro', 'Café'],
    ),
    Product(
      id: '9',
      name: 'Classic Vintage',
      price: 299.99,
      description: 'Comodidad que dura todo el día, ideal para trabajo.',
      imageUrl: 'assets/ShopH/Classic_Vintage.jpg',
      galleryImages: [
        'assets/ShopH/Classic_Vintage.jpg',
        'assets/ShopH/Classic_Vintage2.jpg',
      ],
      availableSizes: [27, 28, 29, 30],
      availableColors: ['Café', 'Negro'],
    ),
    Product(
      id: '10',
      name: 'Vans Modern',
      price: 1199.99,
      description: 'No elijas entre moda y comodidad: estos tenis lo tienen todo.',
      imageUrl: 'assets/ShopH/Vans_modern.jpg',
      galleryImages: [
        'assets/ShopH/Vans_modern.jpg',
        'assets/ShopH/Vans_modern2.jpg',
      ],
      availableSizes: [26, 27, 28, 29],
      availableColors: ['Negro', 'Blanco', 'Gris'],
    ),
  ];
  bool isLoading = true;
  bool isWomenSection = false;

  @override
  void initState() {
    super.initState();
    _loadCatalog();
  }
// simula la carga de catalogo 
  Future<void> _loadCatalog() async {
    setState(() {
      isLoading = true;
    });
    
    await Future.delayed(const Duration(seconds: 4));
    
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
//alterna entre el catalogo de hombre y mujer 
  void _toggleSection() {
    setState(() {
      isWomenSection = !isWomenSection;
      isLoading = true;
    });
    _loadCatalog();
    
    if (isWomenSection) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChallengeScreen2(),
        ),
      );
    }
  }
// barra de seleccion y de titulo 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'DarkStride - Hombres',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Text(
                  'Hombres',
                  style: TextStyle(color: Colors.white),
                ),
                Switch(
                  value: isWomenSection,
                  onChanged: (value) => _toggleSection(),
                  activeColor: Colors.pink,
                  inactiveThumbColor: Colors.indigo,
                ),
                const Text(
                  'Mujeres',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Stack(
        children: [

          if (!isLoading)
            SingleChildScrollView(
              child: Column(
                children: [
//Encabezado de oferta 
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
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'PRODUCTOS DE TEMPORADA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(height: 15),
                        //lista de productos 
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
                    ),//animación 
                    const SizedBox(height: 20),
                    const Text(
                      'Cargando catálogo hombres...',
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
              Text(
                producto.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
//contenedor de tallas 
              const SizedBox(height: 12),
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
                    label: Text( // contenedor de colores 
                      'Colores: ${producto.availableColors.join(', ')}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.indigo.shade50,
                  ),
                ],
              ),

              const SizedBox(height: 12),
      
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
                  ),//boton de detalles
                  child: const Text(
                    'VER DETALLES',
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