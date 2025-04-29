import 'dart:convert';
import 'dart:developer';

import 'package:closet_craft_project/features/recommendation/model/gemini_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendationProvider with ChangeNotifier {
  static const geminiKey = "";
  final List<Map<String, dynamic>> chat = [];
  bool _loading = false;
  bool get loading => _loading;

  String _errorMessage = '';

  // void _handleSubmitted(String text) {
  //   if (text.trim().isEmpty) return;

  //   _textController.clear();
  //   setState(() {
  // geminiApi.chat.add({
  //   "role": "user",
  //   "parts": [
  //     {"text": text},
  //   ],
  // });
  //     geminiApi.messages.add(ChatMessage(request: text, isUser: true));
  //     geminiApi.chatWithGemini();
  //     // Simulated bot response (you'd replace this with actual API call)
  //     // _simulateBotResponse(text);
  //   });

  //   _focusNode.unfocus(); // or requestfocus
  // }

  Future<GeminiResponse?> chatWithGemini(
      String closetData, String weatherData) async {
    _loading = true;
    notifyListeners();

    try {
      final res = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "system_instruction": {
            "parts": {
              "text":
                  '''You are a fashion advisor chatbot that helps assemble the best outfit combination.
                    The user will provide a list of clothing items categorized into:
                    Shirts
                    T-shirts
                    Pants
                    Footwear(named as shoe)

                    Closet Data is in this format
                     {
                      'cloth': cloth,
                      'image': imageUrl,
                      'color': color,
                      'weather': weather,
                      'fabric': fabric
                      }
                    Rules you must follow:
                     - Analyze all provided options carefully.
                     - Choose:
                    One topwear (either a shirt or a t-shirt — pick the best one overall from both categories).
                    One bottomwear (a pant).
                    One footwear.
                    Select items that best match together, considering: Style, Color Coordination, 
                    Season Appropriateness, Comfort, Occasion Suitability, and Trendiness.

                   - Output only a single JSON object with the following structure:
                   - When a user asks for a outfit, always respond in well-structured JSON format.

                  here is the example - 
                  "response": {
                    "topwear": {
                      "cloth": "shirt or t-shirt",
                      "description": "Short reason why this topwear was selected",
                      "image": "Image URL or placeholder",
                      "color": "blue",
                      "weather": "Best season to wear",
                      "fabric" : "cotton"
                    },
                    "bottomwear": {
                      // "name": "Selected Bottomwear Name",
                      "cloth": "Pant",
                      "description": "Short reason why this bottomwear was selected",
                      "image": "Image URL or placeholder",
                      "color": "blue",
                      "weather": "Best season to wear",
                      "fabric" : "cotton"
                    },
                    "footwear": {
                      // "name": "Selected Footwear Name",
                      "cloth": "Shoe",
                      "description": "Short reason why this footwear was selected",
                      "image": "Image URL or placeholder",
                      "color": "blue",
                      "weather": "Best season to wear",
                      "fabric" : "cotton"
                    },
                    "tips": [
                      "Add some more suggestion according to fashio expert"
                    ],
                    "notes": "Add any additional information into this"
                  },

                  Respond only with valid JSON. Do not include explanations or extra text outside the JSON.
                  Keep responses friendly, clear, and easy to understand for home cooks.
                  If a user requests a specific dish or ingredient, tailor the recipe accordingly.
                  ''',
            },
          },
          "contents": [
            {
              "role": "user",
              "parts": [
                {
                  "text": '''
                    I have the following items in my closet. Select the best outfit by picking:
                    - One topwear (choose from shirts and t-shirts)
                    - One bottomwear (pant)
                    - One footwear

                    Each clothing item has a cloth, image (if available), color, season, and fabric.

                    Please respond only with the final selected outfit in structured JSON with three sections: topwear, bottomwear, and footwear. Use only one item in each category.

                    Suggest according to my location weather: $weatherData
                    Here is my closet:
                    $closetData
                    
                  '''
                },
              ],
            },
          ],
        }),
      );

      if (res.statusCode == 200) {
        String val = jsonDecode(
          res.body,
        )['candidates'][0]['content']['parts'][0]['text'];

        final formatted = geminiResponseFromJson(
          val.substring(7, val.length - 3),
        );

        // chat.add({
        //   "role": "model",
        //   "parts": [
        //     {"text": val},
        //   ],
        // });
        log(formatted.toJson().toString());
        // _messages.add(ChatMessage(response: formatted, isUser: false));
        notifyListeners();
        return formatted;
        // return res.body;

        // return content;
      }
      // print('internal error');
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
