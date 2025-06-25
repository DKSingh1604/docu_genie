import 'package:flutter/material.dart';
import 'package:docu_genie/models/document_model.dart';
import 'package:docu_genie/screens/result_screen.dart';
import 'package:docu_genie/services/api_service.dart';

class FormScreen extends StatefulWidget {
  final Document document;

  FormScreen({required this.document});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Add controllers for each field based on document type
    // This is a simplified example. You can make this more dynamic.
    if (widget.document.name == 'Cover Letter') {
      _controllers['Full Name'] = TextEditingController();
      _controllers['Role Applying For'] = TextEditingController();
      _controllers['Company Name'] = TextEditingController();
      _controllers['Key Skills'] = TextEditingController();
      _controllers['Goals'] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.document.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ..._controllers.keys.map((key) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _controllers[key],
                    decoration: InputDecoration(
                      labelText: key,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter $key';
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final prompt = _buildPrompt();
                    final result = await ApiService.generateText(prompt);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(result: result),
                      ),
                    );
                  }
                },
                child: Text('Generate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildPrompt() {
    // Build the prompt based on the document type and form fields
    // This is a simplified example.
    if (widget.document.name == 'Cover Letter') {
      return 'Create a professional cover letter for a Computer Science student named ${_controllers['Full Name']!.text}. He\'s applying for a ${_controllers['Role Applying For']!.text} internship at ${_controllers['Company Name']!.text}. His skills are ${_controllers['Key Skills']!.text}. He wants to express his passion for building real-world apps and learning in a fast-paced team.';
    }
    return '';
  }
}
