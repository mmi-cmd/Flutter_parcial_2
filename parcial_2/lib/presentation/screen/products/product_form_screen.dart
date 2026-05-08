import 'package:flutter/material.dart';
import 'package:parcial_2/service/product_service.dart';


class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  int _categoryId = 1;
  bool _loading = false;

  final List<Map<String, dynamic>> _categories = [
    {'id': 1, 'name': 'Clothes'},
    {'id': 2, 'name': 'Electronics'},
    {'id': 3, 'name': 'Furniture'},
    {'id': 4, 'name': 'Shoes'},
    {'id': 5, 'name': 'Miscellaneous'},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final error = await ProductService.createProduct(
      title: _titleController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      description: _descriptionController.text.trim(),
      categoryId: _categoryId,
      imageUrl: _imageController.text.trim(),
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Producto creado correctamente!'),
          backgroundColor: Colors.green,
        ),
      );
<<<<<<< HEAD

=======
>>>>>>> 95be59b (updates)
      // Limpia el form
      _formKey.currentState!.reset();
      _titleController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _imageController.clear();
      setState(() => _categoryId = 1);

      // Vuelve al tab 0 (lista de productos)
      DefaultTabController.of(context).animateTo(1);
<<<<<<< HEAD

      //context.go('/products'); //los nuevos productos se obtienen con la paginación usando el ScrollController

=======
>>>>>>> 95be59b (updates)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nuevo producto', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),

            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) => v == null || v.isEmpty ? 'El título es requerido' : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.isEmpty) return 'El precio es requerido';
                if (double.tryParse(v) == null) return 'Ingresa un número válido';
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                prefixIcon: Icon(Icons.description_outlined),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (v) => v == null || v.isEmpty ? 'La descripción es requerida' : null,
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<int>(
              value: _categoryId,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                prefixIcon: Icon(Icons.category_outlined),
                border: OutlineInputBorder(),
              ),
              items: _categories
                  .map((c) => DropdownMenuItem<int>(
                        value: c['id'] as int,
                        child: Text(c['name'] as String),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _categoryId = v ?? 1),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'URL de imagen',
                prefixIcon: Icon(Icons.image_outlined),
                border: OutlineInputBorder(),
                hintText: 'https://i.imgur.com/QkIa5tT.jpeg',
              ),
              keyboardType: TextInputType.url,
              validator: (v) {
                if (v == null || v.isEmpty) return 'La imagen es requerida';
                if (!v.startsWith('http')) return 'Debe ser una URL válida';
                return null;
              },
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _loading ? null : _submit,
                icon: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: const Text('Guardar producto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}