// ignore_for_file: prefer_const_constructors

import 'package:docu_genie/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:docu_genie/widgets/widgets.dart' as widgets;

class Tipsandguide extends StatelessWidget {
  const Tipsandguide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text(
          'Tips & Guide',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1D1E33),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1D1E33), Color(0xFF0A0E21)],
            center: Alignment.center,
            radius: 0.8,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            buildWelcomeSection(),
            const SizedBox(height: 30),
            buildTipSection(
              'Getting Started',
              Icons.rocket_launch,
              [
                'Choose the document type that best fits your needs',
                'Fill in all required fields for better results',
                'Be specific and detailed in your inputs',
                'Use the info (i) buttons for field guidance',
              ],
            ),
            const SizedBox(height: 25),
            buildTipSection(
              'Writing Effective Prompts',
              Icons.edit_note,
              [
                'Provide clear and specific information',
                'Include relevant keywords for your industry',
                'Mention your target audience when applicable',
                'Specify the tone you want (professional, casual, etc.)',
              ],
            ),
            const SizedBox(height: 25),
            buildTipSection(
              'Cover Letter Tips',
              Icons.description,
              [
                'Tailor each letter to the specific job and company',
                'Highlight your most relevant skills and experiences',
                'Keep it concise - aim for one page',
                'Use specific examples to demonstrate your value',
              ],
            ),
            const SizedBox(height: 25),
            buildTipSection(
              'SOP Best Practices',
              Icons.school,
              [
                'Tell a compelling story about your academic journey',
                'Connect your past experiences to your future goals',
                'Be specific about why you chose this program',
                'Show passion and genuine interest in your field',
              ],
            ),
            const SizedBox(height: 25),
            buildTipSection(
              'Professional Bio Guidelines',
              Icons.person,
              [
                'Start with your current role and key accomplishments',
                'Include relevant keywords for your industry',
                'Keep it engaging and authentic to your personality',
                'End with a call-to-action or contact information',
              ],
            ),
            const SizedBox(height: 25),
            buildTipSection(
              'Legal Document Notes',
              Icons.gavel,
              [
                'Always review generated legal content carefully',
                'Consider consulting with a legal professional',
                'Customize the template to fit your specific needs',
                'Ensure all parties and terms are clearly defined',
              ],
            ),
            const SizedBox(height: 30),
            buildProTipsSection(),
            const SizedBox(height: 30),
            buildContactSection(context),
          ],
        ),
      ),
    );
  }
}
