import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';
import '../utils/categories.dart';
import '../widgets/month_selector.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final data = provider.monthlyExpensesByCategory;
    final total = provider.monthlyExpense;

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
                  'Spending by Category',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const MonthSelector(),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: data.isEmpty
                ? Center(
                    child: Text(
                      'No expenses recorded this month.',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  )
                : ListView(
                    children: [
                      SizedBox(
                        height: 220,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 3,
                            centerSpaceRadius: 50,
                            sections: data.entries.map((entry) {
                              final info = getCategoryInfo(entry.key, isExpense: true);
                              final percent = total == 0 ? 0 : (entry.value / total) * 100;
                              return PieChartSectionData(
                                value: entry.value,
                                color: info.color,
                                title: '${percent.toStringAsFixed(0)}%',
                                radius: 55,
                                titleStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ...data.entries.map((entry) {
                        final info = getCategoryInfo(entry.key, isExpense: true);
                        final limit = provider.budgetFor(entry.key);
                        final isOver = limit != null && entry.value > limit;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: isOver ? Border.all(color: Colors.red.shade200) : null,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(color: info.color, shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500)),
                              ),
                              if (isOver) ...[
                                Icon(Icons.warning_amber_rounded, size: 16, color: Colors.red.shade400),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                NumberFormat.currency(symbol: 'RWF ', decimalDigits: 0)
                                    .format(entry.value),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isOver ? Colors.red.shade400 : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
