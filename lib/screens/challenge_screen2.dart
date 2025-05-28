import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/screens/product_detail_screen2.dart';
import 'package:flutter_application_1/screens/challenge_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class ChallengeScreen2 extends StatefulWidget {
  const ChallengeScreen2({super.key});

  @override
  State<ChallengeScreen2> createState() => _ChallengeScreen2State();
}

class _ChallengeScreen2State extends State<ChallengeScreen2> {
  final List<Product> productos = [
    Product(
      id: 'w1',
      name: 'Zapatilla Casual Mujer',
      price: 899.99,
      description: 'Zapatos elegantes para mujer con máximo confort y estilo urbano.',
      imageUrl: 'assets/ShopM/Casual.jpg',
      galleryImages: [
        'assets/ShopM/Casual.jpg',
        'assets/ShopM/Casual2.jpg',
      ],
      availableSizes: [20, 21, 22, 23],
      availableColors: ['Rosa', 'Blanco', 'Negro'],
    ),
    Product(
      id: 'w2',
      name: 'Sandalia Verano',
      price: 499.99,
      description: 'Sandalia cómoda perfecta para el verano con diseño femenino.',
      imageUrl: 'assets/ShopM/Sandalia.jpg',
      galleryImages: [
        'assets/ShopM/Sandalia.jpg',
        'assets/ShopM/Sandalia2.jpg',
      ],
      availableSizes: [22, 23, 24,25],
      availableColors: ['Dorado', 'Plateado', 'Bronce'],
    ),
    Product(
      id: 'w3',
      name: 'Tenis Deportivos',
      price: 799.99,
      description: 'Tenis deportivos para mujer con tecnología de amortiguación.',
      imageUrl: 'assets/ShopM/Tenis.jpg',
      galleryImages: [
        'assets/ShopM/Tenis.jpg',
        'assets/ShopM/Tenis2.jpg',
      ],
      availableSizes: [21, 22, 23, 24],
      availableColors: ['Rosa', 'Morado', 'Blanco'],
    ),
    Product(
      id: 'w4',
      name: 'Botín Elegante',
      price: 599.99,
      description: 'Botín de vestir para mujer con tacón cómodo y diseño sofisticado.',
      imageUrl: 'assets/ShopM/Botin.jpg',
      galleryImages: [
        'assets/ShopM/Botin.jpg',
        'assets/ShopM/Botin2.jpg',
      ],
      availableSizes: [20,22,23, 24, 25],
      availableColors: ['Negro', 'Café', 'Vino'],
    ),
    Product(
      id: 'w5',
      name: 'Mocasín Clásico',
      price: 799.99,
      description: 'Mocasín elegante para mujer, ideal para el trabajo o eventos casuales.',
      imageUrl: 'assets/ShopM/Mocasin.jpg',
      galleryImages: [
        'assets/ShopM/Mocasin.jpg',
        'assets/ShopM/Mocasin2.jpg',
      ],
      availableSizes: [23,24, 25, 26],
      availableColors: ['Rojo', 'Azul Marino', 'Beige'],
    ),
    Product(
      id: 'w6',
      name: 'Zapato Tacón Medio',
      price: 1099.99,
      description: 'Zapato de tacón medio para mujer con diseño ergonómico para mayor comodidad.',
      imageUrl: 'assets/ShopM/Tacon.jpg',
      galleryImages: [
        'assets/ShopM/Tacon.jpg',
        'assets/ShopM/Tacon2.jpg',
      ],
      availableSizes: [22,23, 24, 25],
      availableColors: ['Negro', 'azul', 'Rojo'],
    ),
    Product(
      id: 'w7',
      name: 'Bota Invierno',
      price: 799.99,
      description: 'Bota para invierno con forro térmico y suela antideslizante.',
      imageUrl: 'assets/ShopM/Bota.jpg',
      galleryImages: [
        'assets/ShopM/Bota.jpg',
        'assets/ShopM/Bota2.jpg',
      ],
      availableSizes: [22, 23, 24, 25, 26],
      availableColors: ['Negro', 'Marrón', 'Gris'],
    ),
    Product(
      id: 'w8',
      name: 'Zapatilla Running',
      price: 399.99,
      description: 'Zapatilla para running con tecnología de absorción de impacto.',
      imageUrl: 'assets/ShopM/Zapatilla.jpg',
      galleryImages: [
        'assets/ShopM/Zapatilla.jpg',
        'assets/ShopM/Zapatilla2.jpg',
      ],
      availableSizes: [22,23,24, 25, 26, 27],
      availableColors: ['Azul', 'Rosa', 'Verde'],
    ),
    Product(
      id: 'w9',
      name: 'Alpargata Comfort',
      price: 499.99,
      description: 'Alpargata cómoda para el día a día con suela flexible.',
      imageUrl: 'assets/ShopM/Alpa.jpg',
      galleryImages: [
        'assets/ShopM/Alpa.jpg',
        'assets/ShopM/Alpa2.jpg',
      ],
      availableSizes: [22,23, 24, 25],
      availableColors: ['Azul', 'Blanco', 'Rayas'],
    ),
    Product(
      id: 'w10',
      name: 'Zapato Fiesta',
      price: 1299.99,
      description: 'Zapato elegante para fiestas con detalles brillantes y tacón seguro.',
      imageUrl: 'assets/ShopM/Fiesta.jpg',
      galleryImages: [
        'assets/ShopM/Fiesta.jpg',
        'assets/ShopM/Fiesta2.jpg',
        'assets/ShopM/Fiesta3.jpg',
      ],
      availableSizes: [23, 24, 25],
      availableColors: ['Dorado', 'Plateado', 'Negro'],
    ),
  ];

  bool isLoading = true;
  bool isWomenSection = true; // Inicia en true para la sección de mujeres

  @override
  void initState() {
    super.initState();
    _loadCatalog();
  }

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

  void _toggleSection() {
    setState(() {
      isWomenSection = !isWomenSection;
      isLoading = true;
    });
    _loadCatalog();
    
    if (!isWomenSection) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChallengeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'DarkStride - Mujeres',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.pink, // Color diferente para mujeres
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.pink.shade800,
                          Colors.pink.shade400,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '¡OFERTA ESPECIAL MUJERES!',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '20% DE DESCUENTO EN CALZADO DE TEMPORADA',
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
                              'Envío gratis en compras > MXN\$2,500',
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
                          'LO ÚLTIMO EN MODA FEMENINA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
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
                      'Cargando catálogo mujeres...',
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
              builder: (context) => ProductDetailScreen2(product: producto),
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
                              child: Icon(Icons.shopping_bag, size: 50, color: Colors.pink),
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
                        color: Colors.pink,
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
                    backgroundColor: Colors.pink.shade50,
                  ),
                  Chip(
                    label: Text(
                      'Colores: ${producto.availableColors.join(', ')}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.pink.shade50,
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
                        builder: (context) => ProductDetailScreen2(product: producto),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade200,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
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