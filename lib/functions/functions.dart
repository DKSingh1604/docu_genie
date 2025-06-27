import 'package:docu_genie/models/document_model.dart';
import 'package:docu_genie/screens/form_screen.dart';
import 'package:flutter/material.dart';

class Functions {
  static void navigateToForm(BuildContext context, Document document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(document: document),
      ),
    );
  }
}
