import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Ana uygulama
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// 1️⃣ Ana Sayfa
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Mini Katalog Uygulaması",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt),
              label: const Text("Ürünleri Görüntüle"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductListScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 2️⃣ Ürün Listesi (GridView)
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = <Map<String, dynamic>>[
      {
        'name': 'Kahve Makinesi',
        'price': '250₺',
        'desc': 'Ev için küçük boyutlu kahve makinesi',
        'icon': Icons.coffee,
      },
      {
        'name': 'Bluetooth Hoparlör',
        'price': '150₺',
        'desc': 'Taşınabilir mini hoparlör',
        'icon': Icons.speaker,
      },
      {
        'name': 'Kablosuz Mouse',
        'price': '75₺',
        'desc': 'Bilgisayar için kablosuz mouse',
        'icon': Icons.mouse,
      },
      {
        'name': 'Laptop Stand',
        'price': '120₺',
        'desc': 'Ergonomik laptop standı',
        'icon': Icons.laptop,
      },
      {
        'name': 'Kulaklık',
        'price': '180₺',
        'desc': 'Kablosuz bluetooth kulaklık',
        'icon': Icons.headphones,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Ürün Listesi")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Icon(
                        product['icon'] as IconData,
                        size: 80,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product['name'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        product['price'].toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 3️⃣ Ürün Detay Sayfası
class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['name'].toString())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              product['icon'] as IconData,
              size: 150,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            Text(
              product['name'].toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              product['price'].toString(),
              style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            Text(product['desc'].toString()),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Sepete Ekle"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ürün sepete eklendi!")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
