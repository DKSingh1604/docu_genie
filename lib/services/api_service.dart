import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey =
      'AIzaSyAY2RP73FHkPzOUu4l3US6u8a6xbEj88No'; // Replace with your API key
  static const String _apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey';

  static Future<String> generateText(String prompt,
      {bool jsonOutput = false}) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          if (jsonOutput)
            'generationConfig': {'response_mime_type': 'application/json'},
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // Check for safety rejection, which comes as a 200 OK but with no candidates
        if (jsonResponse['candidates'] == null ||
            (jsonResponse['candidates'] as List).isEmpty) {
          final rejectionReason = jsonResponse['promptFeedback']
                  ?['blockReason'] ??
              'No candidate returned from API';
          throw Exception(
              'Request was rejected by the API: $rejectionReason. Please modify your input.');
        }
        return jsonResponse['candidates'][0]['content']['parts'][0]['text'];
      } else {
        // Try to parse a more specific error message from the API response
        String errorMessage = 'An unknown error occurred.';
        try {
          final errorResponse = jsonDecode(response.body);
          errorMessage = errorResponse['error']['message'];
        } catch (e) {
          // Fallback if error response is not valid JSON
          errorMessage = response.body;
        }
        throw Exception('Failed to generate text: $errorMessage');
      }
    } on SocketException {
      // Handle specific network errors
      throw Exception(
          'No Internet connection. Please check your network and try again.');
    } catch (e) {
      // Re-throw other exceptions to be handled by the UI
      rethrow;
    }
  }
}
