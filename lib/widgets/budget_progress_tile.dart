import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/categories.dart';

class BudgetProgressTile extends StatelessWidget {
  final CategoryInfo categoryInfo;
  final double spent;
  final double? limit;
  final VoidCallback onTap;

  const BudgetProgressTile({
    super.key,
    required this.categoryInfo,
    required this.spent,
    required this.limit,
    required this.onTap,
  });

  String _fmt(double v) => NumberFormat.currency(symbol: 'RWF ', decimalDigits: 0).format(v);

  @override
  Widget build(BuildContext context) {
    final hasLimit = limit != null && limit! > 0;
    final ratio = hasLimit ? (spent / limit!).clamp(0.0, 1.0) : 0.0;
    final isOver = hasLimit && spent > limit!;
    final isClose = hasLimit && !isOver && ratio >= 0.7;

    final barColor = isOver
        ? Colors.red.shade400
        : isClose
            ? Colors.orange.shade400
            : Colors.green.shade400;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isOver ? Border.all(color: Colors.red.shade200) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: categoryInfo.color.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(categoryInfo.icon, size: 16, color: categoryInfo.color),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(categoryInfo.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                Icon(Icons.edit, size: 16, color: Colors.grey.shade400),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: hasLimit ? ratio : 0,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(barColor),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hasLimit
                      ? '${_fmt(spent)} of ${_fmt(limit!)}'
                      : '${_fmt(spent)} spent · no budget set',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                if (isOver)
                  Text(
                    'Over budget',
                    style: TextStyle(fontSize: 12, color: Colors.red.shade400, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
