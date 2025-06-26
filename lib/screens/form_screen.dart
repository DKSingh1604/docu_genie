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
  bool _isLoading = false;

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
    } else if (widget.document.name == 'Internship Email') {
      _controllers['Your Full Name'] = TextEditingController();
      _controllers['Your Major/Field of Study'] = TextEditingController();
      _controllers['Your University/College'] = TextEditingController();
      _controllers['Your Graduation Year'] = TextEditingController();
      _controllers['Company Name'] = TextEditingController();
      _controllers["Recipient's Name (Optional)"] = TextEditingController();
      _controllers["Recipient's Title (Optional)"] = TextEditingController();
      _controllers['Internship Position/Role'] = TextEditingController();
      _controllers['Key Skills (comma-separated)'] = TextEditingController();
      _controllers['Relevant Experience/Projects (Optional)'] =
          TextEditingController();
      _controllers['How You Discovered the Opening'] = TextEditingController();
      _controllers['Tone (e.g., Professional, Enthusiastic)'] =
          TextEditingController();
      _controllers['Specific Points to Mention (Optional)'] =
          TextEditingController();
    } else if (widget.document.name == 'SOP') {
      _controllers['Your Full Name'] = TextEditingController();
      _controllers['University Name'] = TextEditingController();
      _controllers['Program/Course Name'] = TextEditingController();
      _controllers['Country of University (Optional)'] =
          TextEditingController();
      _controllers['Undergraduate University & Major'] =
          TextEditingController();
      _controllers['Graduation Year'] = TextEditingController();
      _controllers['Key Academic Achievements/Honors (Optional)'] =
          TextEditingController();
      _controllers['Favorite/Most Relevant Courses'] = TextEditingController();
      _controllers['Relevant Work Experience (Optional)'] =
          TextEditingController();
      _controllers['Research Projects/Papers (Optional)'] =
          TextEditingController();
      _controllers['Why This Program?'] = TextEditingController();
      _controllers['Why This University?'] = TextEditingController();
      _controllers['Short-Term Career Goals'] = TextEditingController();
      _controllers['Long-Term Career Goals'] = TextEditingController();
      _controllers['Key Skills (Technical & Soft)'] = TextEditingController();
      _controllers['What Makes You a Strong Candidate?'] =
          TextEditingController();
      _controllers['Tone (e.g., Formal, Ambitious)'] = TextEditingController();
      _controllers['Specific Points to Emphasize (Optional)'] =
          TextEditingController();
    } else if (widget.document.name == 'Legal Template') {
      _controllers['Document Title'] = TextEditingController();
      _controllers['Parties Involved (e.g., Party A, Party B)'] =
          TextEditingController();
      _controllers['Agreement Date'] = TextEditingController();
      _controllers[
              'Key Clauses (comma-separated, e.g., Confidentiality, Termination)'] =
          TextEditingController();
      _controllers['Jurisdiction (e.g., State of California)'] =
          TextEditingController();
    }
  }

  void _handleGenerate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final prompt = _buildPrompt();
        final isJson = widget.document.name == 'Legal Template';
        final result =
            await ApiService.generateText(prompt, jsonOutput: isJson);

        if (!mounted) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(result: result),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        print(
          e.toString().replaceFirst('Exception: ', ''),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceFirst('Exception: ', ''),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.document.name),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: _controllers.keys.map((key) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _controllers[key],
                        decoration: InputDecoration(
                          labelText: key,
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            if (key.contains('(Optional)')) {
                              return null;
                            }
                            return 'Please enter $key';
                          }
                          return null;
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    backgroundColor: _isLoading
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                  ),
                  onPressed: _isLoading ? null : _handleGenerate,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Generate', style: TextStyle(fontSize: 16)),
                ),
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
    } else if (widget.document.name == 'Internship Email') {
      final recipientName = _controllers["Recipient's Name (Optional)"]!.text;
      final recipientTitle = _controllers["Recipient's Title (Optional)"]!.text;
      final experience =
          _controllers['Relevant Experience/Projects (Optional)']!.text;
      final specificPoints =
          _controllers['Specific Points to Mention (Optional)']!.text;

      final salutation = recipientName.isNotEmpty
          ? 'Dear ${recipientTitle.isNotEmpty ? '$recipientTitle ' : ''}$recipientName,'
          : 'Dear Hiring Team,';

      var prompt = '''
Generate a professional and compelling internship application email with the following details:

- **Applicant's Name:** ${_controllers['Your Full Name']!.text}
- **Applicant's Major:** ${_controllers['Your Major/Field of Study']!.text}
- **Applicant's University:** ${_controllers['Your University/College']!.text}
- **Applicant's Graduation Year:** ${_controllers['Your Graduation Year']!.text}

- **Company Name:** ${_controllers['Company Name']!.text}
- **Internship Position:** ${_controllers['Internship Position/Role']!.text}
- **How the opening was discovered:** ${_controllers['How You Discovered the Opening']!.text}

- **Key Skills:** ${_controllers['Key Skills (comma-separated)']!.text}
- **Desired Tone:** ${_controllers['Tone (e.g., Professional, Enthusiastic)']!.text}

**Email Content Instructions:**
1.  Start with the salutation: "$salutation".
2.  In the opening, mention the position they are applying for and where they saw the opening.
3.  In the body, highlight the applicant's key skills and connect them to the internship requirements.
''';
      if (experience.isNotEmpty) {
        prompt +=
            '4. Mention their relevant experience or projects: $experience.\n';
      }
      if (specificPoints.isNotEmpty) {
        prompt += '5. Include these specific points: $specificPoints.\n';
      }
      prompt +=
          '6. Conclude with a strong call to action and a professional closing.\n';
      return prompt;
    } else if (widget.document.name == 'Statement of Purpose') {
      // Helper to build sections only if the corresponding controller has text.
      String buildSection(String title, String key) {
        final text = _controllers[key]!.text;
        return text.isNotEmpty ? '- **$title:** $text\n' : '';
      }

      var prompt = '''
Generate a comprehensive and persuasive Statement of Purpose (SOP) based on the following detailed information. The SOP should be well-structured, coherent, and tailored to the specific program and university.

### **Applicant Profile**
- **Full Name:** ${_controllers['Your Full Name']!.text}
- **Applying to:** ${_controllers['Program/Course Name']!.text} at ${_controllers['University Name']!.text}
${buildSection('Country of University', 'Country of University (Optional)')}
### **Academic Background**
- **Undergraduate Degree:** ${_controllers['Undergraduate University & Major']!.text}
- **Graduation Year:** ${_controllers['Graduation Year']!.text}
- **Favorite/Most Relevant Courses:** ${_controllers['Favorite/Most Relevant Courses']!.text}
${buildSection('Key Academic Achievements/Honors', 'Key Academic Achievements/Honors (Optional)')}
### **Professional & Research Experience**
${buildSection('Relevant Work Experience', 'Relevant Work Experience (Optional)')}
${buildSection('Research Projects/Papers', 'Research Projects/Papers (Optional)')}
### **Motivations & Aspirations**
- **Why This Program?:** ${_controllers['Why This Program']!.text}
- **Why This University?:** ${_controllers['Why This University']!.text}
- **Short-Term Career Goals:** ${_controllers['Short-Term Career Goals']!.text}
- **Long-Term Career Goals:** ${_controllers['Long-Term Career Goals']!.text}

### **Skills & Candidacy**
- **Key Skills (Technical & Soft):** ${_controllers['Key Skills (Technical & Soft)']!.text}
- **Unique Strengths as a Candidate:** ${_controllers['What Makes You a Strong Candidate?']!.text}

### **Tone & Style**
- **Desired Tone:** ${_controllers['Tone (e.g., Formal, Ambitious)']!.text}
${buildSection('Specific Points to Emphasize', 'Specific Points to Emphasize (Optional)')}
**Instructions for the AI:**
1.  Create a compelling narrative that connects the applicant's academic background, experiences, and skills with their future goals.
2.  Clearly articulate why the applicant is a strong fit for the specific program and university.
3.  Structure the SOP with a clear introduction, body paragraphs detailing their journey and motivations, and a strong conclusion that summarizes their candidacy.
4.  Maintain the specified tone throughout the document.
''';
      return prompt;
    } else if (widget.document.name == 'Legal Template') {
      return '''
Generate a formal legal template in JSON format with the following details. The JSON object should have keys like "title", "parties", "agreement_date", "clauses", and "jurisdiction". Each clause in the "clauses" array should be an object with "title" and "content" keys.

- **Document Title:** ${_controllers['Document Title']!.text}
- **Parties Involved:** ${_controllers['Parties Involved (e.g., Party A, Party B)']!.text}
- **Agreement Date:** ${_controllers['Agreement Date']!.text}
- **Key Clauses:** ${_controllers['Key Clauses (comma-separated, e.g., Confidentiality, Termination)']!.text}
- **Jurisdiction:** ${_controllers['Jurisdiction (e.g., State of California)']!.text}
''';
    }
    return '';
  }
}
