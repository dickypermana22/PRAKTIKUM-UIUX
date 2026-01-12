class Product {
  final String name;
  final String price;
  final String description;
  final String imageUrl; 
  
  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl, 
  });
}

final List<Product> dummyProducts = [
  Product(
    name: 'MacBook Pro',
    price: 'Rp 25.000.000',
    description: 'Laptop premium untuk profesional.',
    imageUrl: 'https://picsum.photos/300/300?random=1',
  ),
  Product(
    name: 'iPhone 15',
    price: 'Rp 18.000.000',
    description: 'Smartphone flagship Apple.',
    imageUrl: 'https://picsum.photos/300/300?random=2',
  ),
  Product(
    name: 'AirPods Pro',
    price: 'Rp 3.500.000',
    description: 'Earphone nirkabel dengan noise cancellation.',
    imageUrl: 'https://picsum.photos/300/300?random=3',
  ),
  Product(
    name: 'iPad Air',
    price: 'Rp 12.000.000',
    description: 'Tablet ringan untuk kerja & hiburan.',
    imageUrl: 'https://picsum.photos/300/300?random=4',
  ),
  Product(
    name: 'Apple Watch',
    price: 'Rp 7.000.000',
    description: 'Smartwatch kesehatan & gaya hidup.',
    imageUrl: 'https://picsum.photos/300/300?random=5',
  ),
  Product(
    name: 'Magic Mouse',
    price: 'Rp 1.200.000',
    description: 'Mouse ergonomis dari Apple.',
    imageUrl: 'https://picsum.photos/300/300?random=6',
  ),
  Product(
    name: 'HomePod Mini',
    price: 'Rp 2.000.000',
    description: 'Speaker pintar dengan suara mantap.',
    imageUrl: 'https://picsum.photos/300/300?random=7',
  ),
  Product(
    name: 'Thunderbolt Cable',
    price: 'Rp 500.000',
    description: 'Kabel kecepatan tinggi untuk perangkat Apple.',
    imageUrl: 'https://picsum.photos/300/300?random=8',
  ),
];