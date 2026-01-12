import 'package:flutter/material.dart';
import 'package:praktikumuiux_7020230073/models/product_model.dart';
import 'package:praktikumuiux_7020230073/widgets/product_card.dart';
import 'package:praktikumuiux_7020230073/screens/cart_screen.dart';
import 'package:praktikumuiux_7020230073/screens/profile_screen.dart';
import 'package:praktikumuiux_7020230073/providers/theme_provider.dart';
import 'package:praktikumuiux_7020230073/widgets/wave_nav_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = dummyProducts;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 0) {
        _searchController.clear();
        _filteredProducts = dummyProducts;
      }
    });
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = dummyProducts;
      } else {
        _filteredProducts = dummyProducts
            .where(
              (product) =>
                  product.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Color(0xFF000000) : Colors.white,
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: isDark ? Color(0xFF000000) : Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0095F6),
                          Color(0xFF00D4FF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Color(0xFF0095F6).withOpacity(0.3),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shopping_bag_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "ShopPractices",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                ),
                SizedBox(width: 8),
              ],
            )
          : null,
      body: _buildBody(),
      extendBody: true,
      bottomNavigationBar: WaveNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return ProductGridScreen(
          searchController: _searchController,
          filteredProducts: _filteredProducts,
          onSearch: _filterProducts,
        );
      case 1:
        return CartScreen();
      case 2:
        return ProfileScreen();
      default:
        return ProductGridScreen(
          searchController: _searchController,
          filteredProducts: _filteredProducts,
          onSearch: _filterProducts,
        );
    }
  }
}


class ProductGridScreen extends StatelessWidget {
  final TextEditingController searchController;
  final List<Product> filteredProducts;
  final Function(String) onSearch;

  const ProductGridScreen({
    super.key,
    required this.searchController,
    required this.filteredProducts,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Color(0xFF1C1C1E) : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              boxShadow: isDark
                  ? []
                  : [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
            ),
            child: TextField(
              controller: searchController,
              onChanged: onSearch,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[500],
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                  size: 24,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear_rounded,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                        onPressed: () {
                          searchController.clear();
                          onSearch('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
              ),
            ),
          ),
        ),

        Expanded(
          child: filteredProducts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 80,
                        color: isDark ? Colors.grey[700] : Colors.grey[400],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Produk tidak ditemukan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Coba cari dengan kata kunci lain',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey[600] : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount;
                    if (constraints.maxWidth > 1200) {
                      crossAxisCount = 4;
                    } else if (constraints.maxWidth > 800) {
                      crossAxisCount = 3;
                    } else if (constraints.maxWidth > 600) {
                      crossAxisCount = 2;
                    } else {
                      crossAxisCount = 2;
                    }

                    return GridView.builder(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                        bottom: 100, 
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: filteredProducts[index]);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}