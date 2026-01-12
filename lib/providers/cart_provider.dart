import 'package:flutter/material.dart';
import 'package:praktikumuiux_7020230073/models/product_model.dart';
import 'package:praktikumuiux_7020230073/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.name)) {
      _items.update(
        product.name,
        (existingCartItem) => CartItem(
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.name,
        () => CartItem(
          name: product.name,
          price: _parsePrice(product.price),
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productName) {
    _items.remove(productName);
    notifyListeners();
  }

  void removeSingleItem(String productName) {
    if (!_items.containsKey(productName)) {
      return;
    }
    if (_items[productName]!.quantity > 1) {
      _items.update(
        productName,
        (existingCartItem) => CartItem(
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productName);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  double _parsePrice(String price) {
    return double.parse(price.replaceAll('Rp ', '').replaceAll('.', '').replaceAll(',', ''));
  }
}