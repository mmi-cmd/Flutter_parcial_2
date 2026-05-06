import 'package:flutter/material.dart';
import 'package:parcial_2/model/product_model.dart';
import 'package:parcial_2/service/product_service.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductModel> _products = [];
  bool _loading = false;
  bool _hasMore = true; // si hay más productos por cargar
  int _offset = 0;
  static const int _limit = 8;
  final ScrollController _sc = ScrollController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _sc.addListener(() {
      // Cuando el scroll llega cerca del final, carga más
      if (_sc.position.pixels >= _sc.position.maxScrollExtent - 200) {
        _loadProducts();
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    if (_loading || !_hasMore) return; // evita llamadas duplicadas
    print('>>> Haciendo GET — offset: $_offset, limit: $_limit');

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final products = await ProductService.getProducts(
        offset: _offset,
        limit: _limit,
      );
      print('>>> Productos recibidos: ${products.length}');
      if (!mounted) return;
      setState(() {
        _offset += products.length;
        _products.addAll(products); // agrega al final en lugar de reemplazar
        _hasMore = products.length == _limit; // si recibió menos del límite, no hay más
        _loading = false;
      });
    } catch (e) {
      print('>>> Error: $e');
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  // Recarga desde cero (pull to refresh)
  Future<void> _refresh() async {
    setState(() {
      _products = [];
      _offset = 0;
      _hasMore = true;
    });
    await _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null && _products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(_error!),
            const SizedBox(height: 12),
            FilledButton(onPressed: _refresh, child: const Text('Reintentar')),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _sc,
        padding: const EdgeInsets.all(12),
        // +1 para el indicador de carga al final
        itemCount: _products.length + (_loading ? 1 : 0),
        itemBuilder: (context, index) {
          // Último item — muestra el spinner de carga
          if (index == _products.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return _ProductCard(product: _products[index]);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: product.image.isNotEmpty
                ? Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image_not_supported_outlined, size: 40),
                  )
                : const Icon(Icons.image_not_supported_outlined, size: 40),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.category.isNotEmpty)
                    Text(
                      product.category.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(product.title,
                      style: theme.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
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
}