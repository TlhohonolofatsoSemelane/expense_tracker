import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/summary_card.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/month_selector.dart';
import 'add_transaction_screen.dart';
import 'statistics_screen.dart';
import 'budget_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransactionProvider>().loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [const _HomeTab(), const StatisticsScreen(), const BudgetScreen()];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(child: pages[_tabIndex]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3A5CFF),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        selectedItemColor: const Color(0xFF3A5CFF),
        onTap: (index) => setState(() => _tabIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Statistics'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Budgets'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                  'ExpenseTracker',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const MonthSelector(),
            ],
          ),
          const SizedBox(height: 16),
          SummaryCard(
            balance: provider.monthlyBalance,
            income: provider.monthlyIncome,
            expense: provider.monthlyExpense,
          ),
          const SizedBox(height: 20),
          const Text(
            'Transactions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: provider.monthlyTransactions.isEmpty
                ? Center(
                    child: Text(
                      'No transactions this month.\nTap + to add one.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.monthlyTransactions.length,
                    itemBuilder: (context, index) {
                      final t = provider.monthlyTransactions[index];
                      return TransactionTile(
                        transaction: t,
                        onDelete: () => context.read<TransactionProvider>().deleteTransaction(t.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
