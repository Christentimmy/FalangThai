import 'package:falangthai/app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.primaryColor,
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.fredoka(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Text(
          """ 
# Privacy Policy for FalangThai

**Effective Date:** 13 December 2025
**Last Updated:** 13 December 2025

## 1. Introduction

Welcome to FalangThai ("we," "our," or "us"). We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our dating application (the "App").

By using FalangThai, you agree to the collection and use of information in accordance with this Privacy Policy. If you do not agree with our policies and practices, please do not use the App.

**Contact Information:**  
FalangThai  
Michigan, USA  
Email: darak.withoon@gmail.com

## 2. Information We Collect

### 2.1 Information You Provide to Us

**Account Information:**
- Name
- Email address
- Date of birth (to verify you are 18 years or older)
- Gender and gender preferences
- Photos you upload to your profile

**Profile Information:**
- Dating preferences (age range, distance, gender)
- Bio and personal description
- Interests and hobbies

**Location Information:**
- Precise or approximate location data to enable location-based matching
- This information is collected when you grant location permissions to the App

**Communications:**
- Messages and content you send through our in-app chat feature
- Customer support inquiries and correspondence

### 2.2 Information Collected Automatically

**Device Information:**
- Device type, operating system, and version
- Unique device identifiers
- Mobile network information

**Usage Information:**
- App features you use
- Time and duration of your activities
- Profiles you view and interact with

**Log Data:**
- IP address
- Browser type
- Access times and dates

### 2.3 Information from Third-Party Services

**Google Sign-In:**
- When you sign in using Google, we receive basic profile information including your name, email address, and profile picture as permitted by your Google account settings

**Payment Information:**
- We use Stripe as our payment processor for subscription services
- We do not store your payment card details on our servers
- Stripe collects and processes payment information in accordance with their privacy policy

## 3. How We Use Your Information

We use the information we collect for the following purposes:

**To Provide and Maintain Our Service:**
- Create and manage your account
- Enable you to connect with other users
- Facilitate location-based matching
- Process subscription payments through Stripe

**To Improve Our Service:**
- Understand how users interact with the App
- Develop new features and functionality
- Troubleshoot technical issues

**To Communicate with You:**
- Send service-related notifications
- Respond to your inquiries and support requests
- Notify you about matches and messages

**To Ensure Safety and Security:**
- Verify user age (18+)
- Prevent fraud and abuse
- Enforce our Terms of Service
- Protect the rights and safety of our users

**Legal Compliance:**
- Comply with applicable laws and regulations
- Respond to legal requests and prevent harm

## 4. How We Share Your Information

We do not sell your personal information to third parties. We may share your information in the following circumstances:

**With Other Users:**
- Your profile information, photos, and location (approximate) are visible to other users of the App
- Your messages are shared with users you communicate with

**With Service Providers:**
- **Stripe:** For payment processing of subscriptions
- **Google:** When you use Google Sign-In for authentication
- **MongoDB:** Our database provider that stores your information securely
- These third parties are contractually obligated to protect your information

**For Legal Reasons:**
- To comply with legal obligations, court orders, or government requests
- To protect the rights, property, or safety of FalangThai, our users, or the public
- To enforce our Terms of Service

**Business Transfers:**
- In connection with a merger, acquisition, or sale of assets, your information may be transferred to the new entity

## 5. Data Storage and Security

**Storage Location:**
- Your data is stored in MongoDB databases with appropriate security measures
- Data may be stored and processed in the United States or other countries where our service providers operate

**Security Measures:**
- We implement industry-standard security measures to protect your information
- Data transmission is encrypted using SSL/TLS protocols
- Access to personal information is restricted to authorized personnel only
- Regular security assessments and updates

**No Guarantee:**
- While we strive to protect your information, no method of transmission or storage is 100% secure
- You use our service at your own risk

## 6. Data Retention

We retain your personal information for as long as necessary to:
- Provide you with our services
- Comply with legal obligations
- Resolve disputes and enforce our agreements

**Account Deletion:**
- You may request deletion of your account at any time
- Upon deletion, we will remove your profile and personal information within 30 days
- Some information may be retained for legal or safety purposes as permitted by law

## 7. Your Rights and Choices

You have the following rights regarding your personal information:

**Access and Update:**
- You can access and update your profile information within the App settings

**Delete Your Account:**
- You may delete your account at any time through the App or by contacting us

**Location Data:**
- You can disable location services through your device settings, though this may limit app functionality

**Marketing Communications:**
- You can opt out of promotional emails by following the unsubscribe link

**Google Sign-In:**
- You can manage permissions granted to FalangThai through your Google account settings

## 8. Age Restriction

FalangThai is intended for users who are 18 years of age or older. We do not knowingly collect information from individuals under 18. If we learn that we have collected information from someone under 18, we will delete that information promptly.

## 9. International Data Transfers

FalangThai operates in the United States and Thailand. By using our App, you consent to the transfer of your information to the United States and other countries where our service providers operate. These countries may have different data protection laws than your country of residence.

## 10. California Privacy Rights

If you are a California resident, you have additional rights under the California Consumer Privacy Act (CCPA):

- Right to know what personal information we collect, use, and disclose
- Right to request deletion of your personal information
- Right to opt out of the sale of personal information (we do not sell personal information)
- Right to non-discrimination for exercising your privacy rights

To exercise these rights, contact us at darak.withoon@gmail.com.

## 11. Changes to This Privacy Policy

We may update this Privacy Policy from time to time. We will notify you of significant changes by:
- Posting the new Privacy Policy in the App
- Updating the "Last Updated" date
- Sending you a notification for material changes

Your continued use of the App after changes become effective constitutes acceptance of the revised Privacy Policy.

## 12. Third-Party Links

Our App may contain links to third-party websites or services. We are not responsible for the privacy practices of these third parties. We encourage you to review their privacy policies.

## 13. Contact Us

If you have questions, concerns, or requests regarding this Privacy Policy or our privacy practices, please contact us at:

**Email:** darak.withoon@gmail.com  
**Company:** Withoon DARAK Entreprise  
**Location:** 70 RESIDENCE LA DEMOISELLE 85500 Les Herbiers FRANCE

---

**Note:** This Privacy Policy should be reviewed by a legal professional to ensure compliance with all applicable laws and regulations in the jurisdictions where you operate.
        """,
          style: GoogleFonts.fredoka(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
