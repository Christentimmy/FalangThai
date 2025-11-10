import 'package:falangthai/app/controller/wallet_controller.dart';
import 'package:falangthai/app/modules/withdraw/widgets/input_field_widget.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBankTransferScreen extends StatefulWidget {
  const EditBankTransferScreen({super.key});

  @override
  State<EditBankTransferScreen> createState() => _EditBankTransferScreenState();
}

class _EditBankTransferScreenState extends State<EditBankTransferScreen> {
  final _holderController = TextEditingController();
  final _accountController = TextEditingController();
  final _bankController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final walletController = Get.find<WalletController>();

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
        child: Form(
          key: formKey,
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
                keyboardType: TextInputType.number,
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
      ),
      bottomNavigationBar: continueButton(),
    );
  }

  SafeArea continueButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          ontap: () async {
            if (!formKey.currentState!.validate()) return;
            final paymentDetails = {
              'accountHolderName': _holderController.text,
              'accountNumber': _accountController.text,
              'bankName': _bankController.text,
            };
            await walletController.updatePayment(
              paymentMethod: PaymentMethod().bankTransfer,
              paymentDetails: paymentDetails,
            );
          },
          isLoading: walletController.isloading,
          child: Text(
            'Save Changes',
            style: GoogleFonts.fredoka(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
