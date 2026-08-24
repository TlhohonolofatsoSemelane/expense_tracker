import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../utils/categories.dart';
import '../widgets/budget_progress_tile.dart';
import '../widgets/month_selector.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  Future<void> _showEditDialog(BuildContext context, CategoryInfo category, double? currentLimit) async {
    final controller = TextEditingController(
      text: currentLimit != null && currentLimit > 0 ? currentLimit.toStringAsFixed(0) : '',
    );
    final provider = context.read<TransactionProvider>();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(category.icon, color: category.color),
              const SizedBox(width: 8),
              Text('${category.name} budget'),
            ],
          ),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Monthly limit (RWF)',
              hintText: 'e.g. 20000',
            ),
          ),
          actions: [
            if (currentLimit != null)
              TextButton(
                onPressed: () {
                  provider.removeBudget(category.name);
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Remove', style: TextStyle(color: Colors.red)),
              ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = double.tryParse(controller.text.trim());
                if (value != null && value > 0) {
                  provider.setBudget(category.name, value);
                }
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final spentByCategory = provider.monthlyExpensesByCategory;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Budgets',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const MonthSelector(),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Tap a category to set or edit its monthly limit.',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: expenseCategories.map((category) {
                final spent = spentByCategory[category.name] ?? 0.0;
                final limit = provider.budgetFor(category.name);
                return BudgetProgressTile(
                  categoryInfo: category,
                  spent: spent,
                  limit: limit,
                  onTap: () => _showEditDialog(context, category, limit),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
