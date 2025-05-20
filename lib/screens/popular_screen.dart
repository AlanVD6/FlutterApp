import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/popular_model.dart';
import 'package:flutter_application_1/network/api_popular.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;
  List<PopularModel> movies = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final moviesList = await apiPopular!.getPopularMovies();
      setState(() {
        movies = moviesList;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = 'Error al cargar películas: ${e.toString()}';
      });
    }
  }

  Future<void> _refreshMovies() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    await _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Populares'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshMovies,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _refreshMovies,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (movies.isEmpty) {
      return const Center(child: Text('No se encontraron películas'));
    }

    return RefreshIndicator(
      onRefresh: _refreshMovies,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ItemPopular(movies[index]);
        },
      ),
    );
  }

  Widget ItemPopular(PopularModel popular) {
    return Hero(
      tag: 'movie-${popular.id}',
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/detail',
              arguments: popular,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                // Imagen de fondo con efecto de carga
                FadeInImage(
                  placeholder: const AssetImage('assets/loading.json'),
                  image: NetworkImage(popular.backdropPath),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      height: 200,
                      child: const Center(
                        child: Icon(Icons.error_outline, size: 50),
                      ),
                    );
                  },
                ),
                
                // Degradado para mejorar legibilidad del texto
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                
                // Información de la película
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título y rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              popular.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                popular.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Fecha de lanzamiento
                      Text(
                        'Estreno: ${popular.releaseDate}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Botón de favoritos (en esquina superior derecha)
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {
                      // Aquí implementarías la lógica para agregar a favoritos
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Funcionalidad de favoritos por implementar'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}