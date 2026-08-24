import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../services/storage_service.dart';

class TransactionProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<ExpenseTransaction> _transactions = [];
  Map<String, double> _budgets = {};
  bool _isLoading = true;

  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  bool get isLoading => _isLoading;
  DateTime get selectedMonth => _selectedMonth;
  Map<String, double> get budgets => _budgets;

  /// All transactions, newest first (not filtered by month).
  List<ExpenseTransaction> get transactions {
    final sorted = [..._transactions];
    sorted.sort((a, b) => b.date.compareTo(a.date));
    return sorted;
  }

  bool _isInSelectedMonth(ExpenseTransaction t) =>
      t.date.year == _selectedMonth.year && t.date.month == _selectedMonth.month;

  /// Transactions for the currently selected month, newest first.
  List<ExpenseTransaction> get monthlyTransactions {
    final filtered = _transactions.where(_isInSelectedMonth).toList();
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  double get monthlyIncome => _transactions
      .where((t) => _isInSelectedMonth(t) && t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get monthlyExpense => _transactions
      .where((t) => _isInSelectedMonth(t) && t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get monthlyBalance => monthlyIncome - monthlyExpense;

  /// Total expense amount for the selected month, grouped by category.
  Map<String, double> get monthlyExpensesByCategory {
    final Map<String, double> result = {};
    for (final t in _transactions.where(
      (t) => _isInSelectedMonth(t) && t.type == TransactionType.expense,
    )) {
      result[t.category] = (result[t.category] ?? 0) + t.amount;
    }
    return result;
  }

  void setSelectedMonth(DateTime month) {
    _selectedMonth = DateTime(month.year, month.month);
    notifyListeners();
  }

  void goToPreviousMonth() {
    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    notifyListeners();
  }

  void goToNextMonth() {
    _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    notifyListeners();
  }

  bool get isCurrentMonth {
    final now = DateTime.now();
    return _selectedMonth.year == now.year && _selectedMonth.month == now.month;
  }

  // ---------------------------------------------------------------
  // Budgets
  // ---------------------------------------------------------------

  /// The budget limit set for [category], or null if none has been set.
  double? budgetFor(String category) => _budgets[category];

  /// How much has been spent in [category] for the currently selected month.
  double spentForCategory(String category) => monthlyExpensesByCategory[category] ?? 0.0;

  Future<void> setBudget(String category, double limit) async {
    _budgets[category] = limit;
    notifyListeners();
    await _storageService.saveBudgets(_budgets);
  }

  Future<void> removeBudget(String category) async {
    _budgets.remove(category);
    notifyListeners();
    await _storageService.saveBudgets(_budgets);
  }

  // ---------------------------------------------------------------
  // Loading / mutating transactions
  // ---------------------------------------------------------------

  Future<void> loadTransactions() async {
    _isLoading = true;
    notifyListeners();
    _transactions = await _storageService.loadTransactions();
    _budgets = await _storageService.loadBudgets();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(ExpenseTransaction transaction) async {
    _transactions.add(transaction);
    notifyListeners();
    await _storageService.saveTransactions(_transactions);
  }

  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
    await _storageService.saveTransactions(_transactions);
  }
}
