// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildWelcomeSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF2A2D47), Color(0xFF1D1E33)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.lightbulb, color: Colors.amber, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'Welcome to DocuGenie!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'DocuGenie uses advanced AI to help you create professional documents quickly and efficiently. Follow these tips to get the best results from our platform.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget buildTipSection(String title, IconData icon, List<String> tips) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF1D1E33).withOpacity(0.6),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.lightBlueAccent, size: 24),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ...tips.map((tip) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.greenAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}

Widget buildProTipsSection() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF4A148C), Color(0xFF2A2D47)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  const Icon(Icons.star, color: Colors.purpleAccent, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'Pro Tips',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          '💡 Use the info buttons on each form field for specific guidance\n\n'
          '🎯 The more specific your input, the better your results\n\n'
          '📝 Save time by keeping a list of your key skills and experiences\n\n'
          '🔄 Don\'t hesitate to regenerate if the first result isn\'t perfect\n\n'
          '📄 Always review and customize the generated content',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}

Widget buildContactSection(BuildContext parentContext) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF1D1E33).withOpacity(0.4),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white.withOpacity(0.1)),
    ),
    child: Column(
      children: [
        const Icon(Icons.support_agent,
            color: Colors.lightBlueAccent, size: 32),
        const SizedBox(height: 10),
        const Text(
          'Need Help?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'If you need additional assistance or have suggestions for improving DocuGenie, feel free to reach out to our support team.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: parentContext,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: const Color(0xFF1D1E33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.support_agent,
                        color: Colors.lightBlueAccent, size: 48),
                    const SizedBox(height: 16),
                    const Text(
                      'Contact Support',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: Colors.white24, thickness: 1),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.email, color: Colors.amber, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SelectableText(
                            'dev1604karan@gmail.com',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy,
                              color: Colors.white38, size: 18),
                          tooltip: 'Copy Email',
                          onPressed: () {
                            Clipboard.setData(const ClipboardData(
                                text: 'dev1604karan@gmail.com'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Email copied!')),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.phone,
                            color: Colors.greenAccent, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SelectableText(
                            '88680919315',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 15),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy,
                              color: Colors.white38, size: 18),
                          tooltip: 'Copy Phone',
                          onPressed: () {
                            Clipboard.setData(
                                const ClipboardData(text: '88680919315'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Phone copied!')),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close',
                        style: TextStyle(color: Colors.amber)),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text(
            'Contact Support',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
