import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock transaction data
    final transactions = [
      {
        'type': 'withdrawal',
        'amount': -150,
        'method': 'Bank Transfer',
        'date': 'Nov 8, 2025',
        'status': 'completed',
      },
      {
        'type': 'earning',
        'amount': 250,
        'method': 'Project Payment',
        'date': 'Nov 5, 2025',
        'status': 'completed',
      },
      {
        'type': 'withdrawal',
        'amount': -75,
        'method': 'PayPal',
        'date': 'Nov 1, 2025',
        'status': 'pending',
      },
      {
        'type': 'earning',
        'amount': 400,
        'method': 'Project Payment',
        'date': 'Oct 28, 2025',
        'status': 'completed',
      },
      {
        'type': 'withdrawal',
        'amount': -200,
        'method': 'Bank Transfer',
        'date': 'Oct 25, 2025',
        'status': 'completed',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          final isWithdrawal = transaction['type'] == 'withdrawal';
          final amount = transaction['amount'] as int;
          final status = transaction['status'] as String;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (isWithdrawal ? Colors.orange : Colors.green)
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isWithdrawal ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isWithdrawal ? Colors.orange : Colors.green,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['method'] as String,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transaction['date'] as String,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${amount > 0 ? '+' : ''}$amount USD',
                      style: TextStyle(
                        color: amount > 0 ? Colors.green : Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: status == 'completed'
                            ? Colors.green.withValues(alpha: 0.2)
                            : Colors.orange.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status == 'completed' ? 'Completed' : 'Pending',
                        style: TextStyle(
                          color: status == 'completed'
                              ? Colors.green
                              : Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ====================
// REUSABLE INPUT FIELD
// ====================
