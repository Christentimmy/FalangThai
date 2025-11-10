import 'package:falangthai/app/modules/withdraw/views/wallet_screen.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
            InputField(
              controller: _holderController,
              label: 'Account Holder Name',
              hint: 'Enter full name',
              icon: Icons.person,
            ),
            const SizedBox(height: 16),
            InputField(
              controller: _accountController,
              label: 'Account Number',
              hint: 'Enter account number',
              icon: Icons.numbers,
            ),
            const SizedBox(height: 16),
            InputField(
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
