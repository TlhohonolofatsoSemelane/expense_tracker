import 'package:flutter/material.dart';

class CategoryInfo {
  final String name;
  final IconData icon;
  final Color color;

  const CategoryInfo(this.name, this.icon, this.color);
}

const List<CategoryInfo> expenseCategories = [
  CategoryInfo('Food', Icons.restaurant, Color(0xFFEF6C6C)),
  CategoryInfo('Transport', Icons.directions_bus, Color(0xFF6C8CEF)),
  CategoryInfo('Bills', Icons.receipt_long, Color(0xFFEFA96C)),
  CategoryInfo('Shopping', Icons.shopping_bag, Color(0xFFB06CEF)),
  CategoryInfo('Health', Icons.local_hospital, Color(0xFF6CEFC0)),
  CategoryInfo('Entertainment', Icons.movie, Color(0xFFEF6CBB)),
  CategoryInfo('Education', Icons.school, Color(0xFF6CD0EF)),
  CategoryInfo('Other', Icons.category, Color(0xFF9E9E9E)),
];

const List<CategoryInfo> incomeCategories = [
  CategoryInfo('Salary', Icons.work, Color(0xFF4CAF50)),
  CategoryInfo('Gift', Icons.card_giftcard, Color(0xFF66BB6A)),
  CategoryInfo('Freelance', Icons.laptop_mac, Color(0xFF81C784)),
  CategoryInfo('Other', Icons.category, Color(0xFF9E9E9E)),
];

CategoryInfo getCategoryInfo(String name, {required bool isExpense}) {
  final list = isExpense ? expenseCategories : incomeCategories;
  return list.firstWhere(
    (c) => c.name == name,
    orElse: () => list.last,
  );
}
