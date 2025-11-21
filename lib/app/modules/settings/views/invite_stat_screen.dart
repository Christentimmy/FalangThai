import 'package:falangthai/app/controller/invite_controller.dart';
import 'package:falangthai/app/controller/user_controller.dart';
import 'package:falangthai/app/data/models/invite_model.dart';
import 'package:falangthai/app/resources/colors.dart';
import 'package:falangthai/app/widgets/snack_bar.dart';
import 'package:falangthai/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InviteStatScreen extends StatefulWidget {
  const InviteStatScreen({super.key});

  @override
  State<InviteStatScreen> createState() => _InviteStatScreenState();
}

class _InviteStatScreenState extends State<InviteStatScreen> {
  final userController = Get.find<UserController>();
  final inviteController = Get.find<InviteController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inviteController.getInviteStats();
      if (userController.userModel.value?.inviteCode?.isNotEmpty ?? false) {
        return;
      }
      inviteController.getMyInviteCode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1625),
      appBar: buildAppBar(),
      body: Obx(() {
        if (inviteController.isloading.value) {
          return buildLoader();
        }
        return buildContent();
      }),
    );
  }

  AppBar buildAppBar() {
    final l10n = AppLocalizations.of(Get.context!)!;
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xFF1A1625),
      foregroundColor: Colors.white,
      title: Text(
        l10n.inviteStatsTitle,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      centerTitle: true,
    );
  }

  Widget buildLoader() {
    return Center(
      child: CupertinoActivityIndicator(color: AppColors.primaryColor),
    );
  }

  Widget buildContent() {
    final l10n = AppLocalizations.of(Get.context!)!;
    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: () async {
        inviteController.getInviteStats(showLoader: false);
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildContentCotainerHeader(),
            const SizedBox(height: 24),
            buildCodeCard(),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  l10n.inviteRecentInvites,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Obx(() {
                    final inviteModel = inviteController.inviteModel.value;
                    if (inviteModel == null) return const SizedBox();
                    return Text(
                      l10n.inviteTotalInvites(inviteModel.totalInvites ?? 0),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Obx(() {
              final inviteModel = inviteController.inviteModel.value;
              if (inviteModel == null) return const SizedBox();
              if (inviteModel.recentInvites!.isEmpty) {
                return buildEmptyRecentInvite();
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: inviteModel.recentInvites!.length,
                itemBuilder: (context, index) {
                  final invite = inviteModel.recentInvites![index];
                  return buildRecentInviteCard(invite);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Card buildRecentInviteCard(RecentInvites invite) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color.fromARGB(255, 36, 31, 30),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.15),
          child: Text(
            invite.displayName!.substring(0, 1),
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          invite.displayName!,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          DateFormat("MMM dd, yyyy").format(invite.redeemedAt!),
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        // trailing: Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        //   decoration: BoxDecoration(
        //     color: AppColors.primaryColor.withOpacity(0.1),
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Text(
        //     '+${invite.rewardGiven} credits',
        //     style: const TextStyle(
        //       color: AppColors.primaryColor,
        //       fontSize: 12,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget buildEmptyRecentInvite() {
    final l10n = AppLocalizations.of(Get.context!)!;
    return SizedBox(
      height: Get.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline_rounded, size: 50, color: Colors.grey[300]),
          const SizedBox(height: 10),
          Text(
            l10n.inviteEmptyTitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            l10n.inviteEmptySubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Card buildCodeCard() {
    final l10n = AppLocalizations.of(Get.context!)!;
    return Card(
      elevation: 3,
      color: const Color.fromARGB(255, 36, 31, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.qr_code_2_rounded,
                color: AppColors.primaryColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.inviteYourCode,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Obx(() {
                    final inviteModel = inviteController.inviteModel.value;
                    if (inviteModel == null) return const SizedBox();
                    return Text(
                      inviteModel.myInviteCode ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: AppColors.primaryColor,
                      ),
                    );
                  }),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                final inviteModel = inviteController.inviteModel.value;
                if (inviteModel == null) return;
                await Clipboard.setData(
                  ClipboardData(text: inviteModel.myInviteCode!),
                );
                CustomSnackbar.showSuccessToast(l10n.inviteCopied);
              },
              icon: const Icon(Icons.copy),
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Container buildContentCotainerHeader() {
    final l10n = AppLocalizations.of(Get.context!)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(24, 15, 24, 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 55),
          const SizedBox(height: 10),
          Text(
            l10n.inviteImpactTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Obx(() {
            final inviteModel = inviteController.inviteModel.value;
            if (inviteModel == null) return const SizedBox();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildStatBubble(
                  value: inviteModel.totalInvites.toString(),
                  label: l10n.inviteStatTotalInvitesLabel,
                ),
                buildStatBubble(
                  value: inviteModel.premiumCredits.toString(),
                  label: l10n.inviteStatCreditsEarnedLabel,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget buildStatBubble({required String value, required String label}) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
