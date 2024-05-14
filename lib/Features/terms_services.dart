import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tej_mart/constants/colors.dart';

class MyTermsAndPolicy extends StatelessWidget {
  static const routeName = '/myTerms';
  const MyTermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Terms and Conditions",
          style: GoogleFonts.montserrat().copyWith(color: black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
          child: Expanded(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              '''Welcome to Tezz Mart mobile application. By downloading, accessing, or using the App, you agree to be bound by these Terms and Conditions. If you do not agree to these Terms, please do not use the App.
You may be required to create an account to access certain features of the App. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.
All content and materials available on the App, including but not limited to text, graphics, logos, images, and software, are the property of [Your Fashion Brand] or its licensors and are protected by copyright, trademark, and other intellectual property laws.
By submitting any content to the App, including but not limited to reviews, comments, or images, you grant Tezz Mart a non-exclusive, royalty-free, perpetual, and worldwide license to use, reproduce, modify, adapt, publish, translate, and distribute such content in any media.
Your use of the App is also subject to our Privacy Policy, which explains how we collect, use, and disclose your personal information. By using the App, you consent to the collection, use, and disclosure of your personal information as described in the Privacy Policy.
Any purchases made through the App are subject to our Payment Terms, including pricing, billing, and refund policies.
We may revise these Terms from time to time in our sole discretion. All changes are effective immediately upon posting. Your continued use of the App after the posting of revised Terms constitutes your acceptance of such changes.
These Terms are governed by and construed in accordance with the laws of surat. Any dispute arising out of or related to these Terms shall be subject to the exclusive jurisdiction of the courts of surat.
If you have any questions or concerns about these Terms, please contact us at tezz.mart@gmail.com.
              ''',
              style:
                  GoogleFonts.montserrat().copyWith(color: black, fontSize: 14),
            ),
          ]),
        ),
      )),
    );
  }
}
