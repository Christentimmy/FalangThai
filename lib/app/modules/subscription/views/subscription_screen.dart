import 'package:falangthai/app/controller/subscription_controller.dart';
import 'package:falangthai/app/data/models/subscription_model.dart';
import 'package:falangthai/app/modules/auth/widgets/auth_widgets.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final subscriptionController = Get.find<SubscriptionController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (subscriptionController.subscriptionPlans.isNotEmpty) return;
      subscriptionController.getSubscriptionPlans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        height: Get.height,
        decoration: AuthWidgets().buildBackgroundDecoration(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Premium Matches, Premium Love',
                style: GoogleFonts.figtree(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'pick the best plan for you!',
                style: GoogleFonts.figtree(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Obx(() {
                if (subscriptionController.subscriptionPlans.isEmpty) {
                  return SizedBox(
                    height: Get.height * 0.55,
                    width: Get.width,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: subscriptionController.subscriptionPlans.length,
                  itemBuilder: (context, index) {
                    final plans = subscriptionController.subscriptionPlans;
                    return buildSubCard(plan: plans[index]);
                  },
                );
              }),
              // buildSubCard(title: 'Basic', price: 9),
              // SizedBox(height: Get.height * 0.03),
              // buildSubCard(title: 'Premium', price: 54, month: 6),
              // SizedBox(height: Get.height * 0.03),
              // buildSubCard(title: 'Premium Plus', price: 108, month: 12),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF1A1625),
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
      ),
      title: Text(
        "Subscription",
        style: GoogleFonts.fredoka(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget buildSubCard({required SubscriptionModel plan}) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 15, 5, 12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            plan.name ?? "",
            style: GoogleFonts.figtree(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "\$${plan.price.toString()}",
              style: GoogleFonts.figtree(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              "${plan.billingCycle} months",
              style: GoogleFonts.figtree(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.03),
          CustomButton(
            ontap: () {},
            isLoading: false.obs,
            child: Text(
              'Get Started',
              style: GoogleFonts.figtree(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Column(
            children: plan.features!
                .map(
                  (e) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        e ?? "",
                        style: GoogleFonts.figtree(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
