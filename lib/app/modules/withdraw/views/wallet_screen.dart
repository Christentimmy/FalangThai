import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final wallet = userController.userModel.value?.wallet;
    final currency = wallet?.currency ?? 'USD';

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.3),
                    AppColors.cardColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${wallet?.balance ?? 0} $currency',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Total Earned',
                    amount: wallet?.totalEarned ?? 0,
                    currency: currency,
                    icon: Icons.trending_up,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Withdrawn',
                    amount: wallet?.totalWithdrawn ?? 0,
                    currency: currency,
                    icon: Icons.trending_down,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Action Buttons
            _ActionButton(
              icon: Icons.account_balance_wallet,
              title: 'Withdraw Funds',
              subtitle: 'Transfer money to your account',
              onTap: () => Get.to(() => const WithdrawScreen()),
            ),
            const SizedBox(height: 12),
            _ActionButton(
              icon: Icons.payment,
              title: 'Payment Methods',
              subtitle: 'Manage your payment accounts',
              onTap: () => Get.to(() => const PaymentMethodsScreen()),
            ),
            const SizedBox(height: 12),
            _ActionButton(
              icon: Icons.history,
              title: 'Transaction History',
              subtitle: 'View all transactions',
              onTap: () => Get.to(() => const TransactionHistoryScreen()),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      foregroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Wallet',
        style: GoogleFonts.fredoka(color: AppColors.textPrimary),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.history, color: AppColors.primaryColor),
          onPressed: () => Get.to(() => const TransactionHistoryScreen()),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int amount;
  final String currency;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.amount,
    required this.currency,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            '$amount $currency',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// ====================
// WITHDRAW SCREEN
// ====================
class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final wallet = userController.userModel.value?.wallet;
    final paymentInfo = userController.userModel.value?.paymentInfo;
    final balance = wallet?.balance ?? 0;
    final currency = wallet?.currency ?? 'USD';

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
          'Withdraw Funds',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$balance $currency',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Amount Input
            Text(
              'Withdrawal Amount',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardColor,
                hintText: 'Enter amount',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: AppColors.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _QuickAmountButton(
                  amount: 50,
                  currency: currency,
                  onTap: () => _amountController.text = '50',
                ),
                const SizedBox(width: 8),
                _QuickAmountButton(
                  amount: 100,
                  currency: currency,
                  onTap: () => _amountController.text = '100',
                ),
                const SizedBox(width: 8),
                _QuickAmountButton(
                  amount: 500,
                  currency: currency,
                  onTap: () => _amountController.text = '500',
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _QuickAmountButton(
                    amount: balance,
                    currency: currency,
                    label: 'All',
                    onTap: () => _amountController.text = balance.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Payment Method Selection
            Text(
              'Withdrawal Method',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            if (paymentInfo?.bankTransfer != null)
              _PaymentMethodTile(
                icon: Icons.account_balance,
                title: 'Bank Transfer',
                subtitle: paymentInfo!.bankTransfer!.accountNumber ?? 'Not set',
                isSelected: selectedMethod == 'bank',
                onTap: () => setState(() => selectedMethod = 'bank'),
              ),

            if (paymentInfo?.paypal != null && paymentInfo!.paypal!.isNotEmpty)
              _PaymentMethodTile(
                icon: Icons.payment,
                title: 'PayPal',
                subtitle: paymentInfo.paypal ?? '',
                isSelected: selectedMethod == 'paypal',
                onTap: () => setState(() => selectedMethod = 'paypal'),
              ),

            if (paymentInfo?.stripe != null && paymentInfo!.stripe!.isNotEmpty)
              _PaymentMethodTile(
                icon: Icons.credit_card,
                title: 'Stripe',
                subtitle: 'Account ID: ${paymentInfo.stripe}',
                isSelected: selectedMethod == 'stripe',
                onTap: () => setState(() => selectedMethod = 'stripe'),
              ),

            if (paymentInfo?.bankTransfer == null &&
                (paymentInfo?.paypal == null || paymentInfo!.paypal!.isEmpty) &&
                (paymentInfo?.stripe == null || paymentInfo!.stripe!.isEmpty))
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.primaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'No payment methods available. Please add one first.',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),

            // Processing Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Withdrawals typically process within 3-5 business days',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () => _handleWithdraw(balance),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Withdraw Funds',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleWithdraw(int balance) {
    final amount = int.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      Get.snackbar(
        'Error',
        'Please enter a valid amount',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (amount > balance) {
      Get.snackbar(
        'Error',
        'Insufficient balance',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedMethod == null) {
      Get.snackbar(
        'Error',
        'Please select a withdrawal method',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.cardColor,
        title: const Text(
          'Confirm Withdrawal',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Withdraw $amount to your $selectedMethod account?',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.snackbar(
                'Success',
                'Withdrawal request submitted',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

class _QuickAmountButton extends StatelessWidget {
  final int amount;
  final String currency;
  final String? label;
  final VoidCallback onTap;

  const _QuickAmountButton({
    required this.amount,
    required this.currency,
    this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cardColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
          ),
          child: Text(
            label ?? '$amount',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primaryColor, size: 24)
            else
              Icon(
                Icons.radio_button_unchecked,
                color: AppColors.textSecondary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

// ====================
// PAYMENT METHODS SCREEN
// ====================
class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final paymentInfo = userController.userModel.value?.paymentInfo;

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
          'Payment Methods',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank Transfer
            _PaymentMethodCard(
              icon: Icons.account_balance,
              title: 'Bank Transfer',
              isConfigured: paymentInfo?.bankTransfer != null,
              details: paymentInfo?.bankTransfer != null
                  ? {
                      'Account Holder':
                          paymentInfo!.bankTransfer!.accountHolderName ?? '-',
                      'Account Number':
                          paymentInfo.bankTransfer!.accountNumber ?? '-',
                      'Bank Name': paymentInfo.bankTransfer!.bankName ?? '-',
                    }
                  : null,
              onEdit: () => Get.to(() => const EditBankTransferScreen()),
            ),
            const SizedBox(height: 16),

            // PayPal
            _PaymentMethodCard(
              icon: Icons.payment,
              title: 'PayPal',
              isConfigured:
                  paymentInfo?.paypal != null &&
                  paymentInfo!.paypal!.isNotEmpty,
              details:
                  paymentInfo?.paypal != null && paymentInfo!.paypal!.isNotEmpty
                  ? {'Email': paymentInfo.paypal!}
                  : null,
              onEdit: () => Get.to(() => const EditPayPalScreen()),
            ),
            const SizedBox(height: 16),

            // Stripe
            _PaymentMethodCard(
              icon: Icons.credit_card,
              title: 'Stripe',
              isConfigured:
                  paymentInfo?.stripe != null &&
                  paymentInfo!.stripe!.isNotEmpty,
              details:
                  paymentInfo?.stripe != null && paymentInfo!.stripe!.isNotEmpty
                  ? {'Account ID': paymentInfo.stripe!}
                  : null,
              onEdit: () => Get.to(() => const EditStripeScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isConfigured;
  final Map<String, String>? details;
  final VoidCallback onEdit;

  const _PaymentMethodCard({
    required this.icon,
    required this.title,
    required this.isConfigured,
    this.details,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isConfigured ? 'Configured' : 'Not configured',
                      style: TextStyle(
                        color: isConfigured
                            ? Colors.green
                            : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isConfigured
                      ? Colors.green.withOpacity(0.2)
                      : AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isConfigured ? 'Active' : 'Setup',
                  style: TextStyle(
                    color: isConfigured ? Colors.green : AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (details != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: details!.entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.key,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              e.value,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onEdit,
              icon: Icon(
                isConfigured ? Icons.edit : Icons.add,
                color: AppColors.primaryColor,
                size: 18,
              ),
              label: Text(
                isConfigured ? 'Edit Details' : 'Add Method',
                style: const TextStyle(color: AppColors.primaryColor),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====================
// EDIT BANK TRANSFER SCREEN
// ====================
class EditBankTransferScreen extends StatefulWidget {
  const EditBankTransferScreen({super.key});

  @override
  State<EditBankTransferScreen> createState() => _EditBankTransferScreenState();
}

class _EditBankTransferScreenState extends State<EditBankTransferScreen> {
  final _holderController = TextEditingController();
  final _accountController = TextEditingController();
  final _bankController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          'Bank Transfer',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InputField(
              controller: _holderController,
              label: 'Account Holder Name',
              hint: 'Enter full name',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            _InputField(
              controller: _accountController,
              label: 'Account Number',
              hint: 'Enter account number',
              icon: Icons.numbers,
            ),
            const SizedBox(height: 16),
            _InputField(
              controller: _bankController,
              label: 'Bank Name',
              hint: 'Enter bank name',
              icon: Icons.account_balance,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Success',
                'Bank details saved successfully',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ====================
// EDIT PAYPAL SCREEN
// ====================
class EditPayPalScreen extends StatefulWidget {
  const EditPayPalScreen({Key? key}) : super(key: key);

  @override
  State<EditPayPalScreen> createState() => _EditPayPalScreenState();
}

class _EditPayPalScreenState extends State<EditPayPalScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          'PayPal Account',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InputField(
              controller: _emailController,
              label: 'PayPal Email',
              hint: 'Enter PayPal email address',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Make sure this email is verified with your PayPal account',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Success',
                'PayPal email saved successfully',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ====================
// EDIT STRIPE SCREEN
// ====================
class EditStripeScreen extends StatefulWidget {
  const EditStripeScreen({Key? key}) : super(key: key);

  @override
  State<EditStripeScreen> createState() => _EditStripeScreenState();
}

class _EditStripeScreenState extends State<EditStripeScreen> {
  final _accountIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          'Stripe Account',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InputField(
              controller: _accountIdController,
              label: 'Stripe Account ID',
              hint: 'Enter Stripe account ID',
              icon: Icons.credit_card,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your Stripe account must be verified to receive payments',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Success',
                'Stripe account saved successfully',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ====================
// TRANSACTION HISTORY SCREEN
// ====================
class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

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
                        .withOpacity(0.2),
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
                            ? Colors.green.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
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
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cardColor,
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class UserModel {
  final Wallet? wallet;
  final PaymentInfo? paymentInfo;

  UserModel({this.wallet, this.paymentInfo});
}

class PaymentInfo {
  final String? preferredMethod;
  final BankTansfer? bankTransfer;
  final String? paypal;
  final String? stripe;

  PaymentInfo({
    this.preferredMethod,
    this.bankTransfer,
    this.paypal,
    this.stripe,
  });
}

class BankTansfer {
  final String? accountHolderName;
  final String? accountNumber;
  final String? bankName;

  BankTansfer({this.accountHolderName, this.accountNumber, this.bankName});
}

class Wallet {
  final int? balance;
  final String? currency;
  final int? totalEarned;
  final int? totalWithdrawn;

  Wallet({this.balance, this.currency, this.totalEarned, this.totalWithdrawn});
}
