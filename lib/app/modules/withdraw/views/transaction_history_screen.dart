import 'package:falangthai/app/controller/wallet_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final walletController = Get.find<WalletController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      walletController.getRecentWithdraw();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar(),
      body: Obx(() {
        if (walletController.isloading.value) {
          return const Center(
            child: CupertinoActivityIndicator(color: AppColors.primaryColor),
          );
        }
        if (walletController.recentWithdraw.isEmpty) {
          return Center(
            child: Text(
              l10n.transactionHistoryEmpty,
              style: GoogleFonts.fredoka(color: Colors.white),
            ),
          );
        }
        final transactions = walletController.recentWithdraw;
        return buildListViewBuilder(transactions: transactions);
      }),
    );
  }

  Widget buildListViewBuilder({required List transactions}) {
    final l10n = AppLocalizations.of(Get.context!)!;
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isWithdrawal = transaction.type == 'withdrawal';
        final amount = transaction.amount;
        final status = transaction.status ?? '';

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
                      transaction.paymentMethod,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM d, yyyy').format(transaction.date),
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
                    '${amount > 0 ? '+' : ''}${amount.toStringAsFixed(2)} USD',
                    style: TextStyle(
                      color: amount > 0 ? Colors.green : Colors.orange,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  transaction.type == "commission"
                      ? SizedBox.shrink()
                      : Container(
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
                            status == 'completed'
                                ? l10n.transactionStatusCompleted
                                : l10n.transactionStatusPending,
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
    );
  }

  AppBar buildAppBar() {
    final l10n = AppLocalizations.of(Get.context!)!;
    final style = GoogleFonts.fredoka(color: AppColors.textPrimary);
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Get.back(),
      ),
      title: Text(
        l10n.transactionHistoryTitle,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      actions: [
        PopupMenuButton(
          color: AppColors.backgroundColor,
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'recent',
              height: 40,
              onTap: () async {
                await walletController.getRecentWithdraw();
              },
              child: Text(l10n.transactionFilterRecent, style: style),
            ),
            PopupMenuItem(
              value: 'withdraws',
              height: 40,
              onTap: () async {
                await walletController.getWithdrawals();
              },
              child: Text(l10n.transactionFilterWithdrawals, style: style),
            ),
            PopupMenuItem(
              value: 'commissions',
              height: 40,
              onTap: () async {
                await walletController.getCommissions();
              },
              child: Text(l10n.transactionFilterCommissions, style: style),
            ),
          ],
        ),
      ],
    );
  }
}
