import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class APIs {
  static const String _apiKey = 'AIzaSyBzeCdf1xQqgpaYFmd7U_0fBPzd7nymJFY';
  static const String _hfApiKey = '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';

  static Future<String> generateContent(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$_apiKey'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return 'something went wrong';
      }
    } catch (e) {
      print('Exception caught: $e');
      return 'something went wrong';
    }
  }

  static Future<String> generateImage(String prompt) async {
    try {
      print('Sending request to Hugging Face API...');
      final response = await http.post(
        Uri.parse(
            'https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-2'),
        headers: {
          'Authorization': 'Bearer $_hfApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'inputs': prompt,
        }),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          // Check if the response is JSON (error message)
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse['error'] != null) {
            print('API Error: ${jsonResponse['error']}');
            return '';
          }
        } catch (e) {
          // If not JSON, then it's binary image data (success case)
          final bytes = response.bodyBytes;
          final base64Image = base64Encode(bytes);
          print(
              'Successfully generated image. Base64 length: ${base64Image.length}');
          return 'data:image/jpeg;base64,$base64Image';
        }
      } else if (response.statusCode == 503) {
        // Model is loading
        print('Model is loading. Please try again in a few seconds.');
        Get.snackbar(
          'Please Wait',
          'AI Model is loading. Please try again in a few seconds.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        return '';
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return '';
      }
      return '';
    } catch (e) {
      print('Exception caught in generateImage: $e');
      return '';
    }
  }
}
