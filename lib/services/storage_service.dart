import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';
import '../models/budget.dart';

/// Handles persisting transactions and category budgets on the device
/// using shared_preferences. Both are stored as JSON-encoded strings.
class StorageService {
  static const String _transactionsKey = 'transactions';
  static const String _budgetsKey = 'budgets';

  Future<List<ExpenseTransaction>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_transactionsKey);
    if (raw == null || raw.isEmpty) return [];

    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => ExpenseTransaction.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTransactions(List<ExpenseTransaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(transactions.map((t) => t.toJson()).toList());
    await prefs.setString(_transactionsKey, encoded);
  }

  Future<Map<String, double>> loadBudgets() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_budgetsKey);
    if (raw == null || raw.isEmpty) return {};

    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    final budgets = decoded.map((item) => Budget.fromJson(item as Map<String, dynamic>));
    return {for (final b in budgets) b.category: b.limit};
  }

  Future<void> saveBudgets(Map<String, double> budgets) async {
    final prefs = await SharedPreferences.getInstance();
    final list = budgets.entries.map((e) => Budget(category: e.key, limit: e.value).toJson()).toList();
    await prefs.setString(_budgetsKey, jsonEncode(list));
  }
}
