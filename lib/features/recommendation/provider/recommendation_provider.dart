import 'dart:convert';
import 'dart:developer';

import 'package:closet_craft_project/features/recommendation/model/gemini_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendationProvider with ChangeNotifier {
  static const geminiKey = "AIzaSyD54Ex6trGgnYAfHLVwQbTqeMm5XnyH-Fc";
  // final List<Map<String, dynamic>> chat = [];
  bool _loading = false;
  bool get loading => _loading;

  String _errorMessage = '';

  GeminiResponse? _outfitResponse;
  GeminiResponse? get outfitResponse => _outfitResponse;

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
      List<Map<String, dynamic>> closetData, String weatherData) async {
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
                    Shoe

                    Closet Data is in this format
                     {
                      'id': id for each cloth
                      'cloth': cloth,
                      'color': color,
                      'weather': weather,
                      'fabric': fabric
                      }
                    Rules you must follow:
                     - Analyze all provided options carefully.
                     - Choose:
                    One topwear (either a shirt or a t-shirt — pick the best one overall from both categories).
                    One bottomwear (a pant).
                    One footwear (a shoe)
                    Select items that best match together, considering: Style, Color Coordination, 
                    Season Appropriateness, Comfort, Occasion Suitability, and Trendiness.

                   - Output only a single JSON object with the following structure:
                   - When a user asks for a outfit, always respond in well-structured JSON format.

                  here is the example - 
                  "response": {
                    "topwear": {
                      "id": id for each cloth
                      "cloth": "shirt or t-shirt",
                      "description": "Short reason why this topwear was selected",
                      "color": "blue",
                      "weather": "Best season to wear",
                      "fabric" : "cotton"
                    },
                    "bottomwear": {
                      "id": id for each cloth
                      "cloth": "Pant",
                      "description": "Short reason why this bottomwear was selected,
                      "color": "blue",
                      "weather": "Best season to wear",
                      "fabric" : "cotton"
                    },
                    "footwear": {
                      "id": id for each cloth
                      "cloth": "Shoe",
                      "description": "Short reason why this footwear was selected",
                      "color": "blue",
                      "weather": "Best season to wear",
                      "fabric" : "cotton"
                    },
                    "tips": [
                      "Add some more suggestion according to fashion expert"
                    ],
                    "notes": "Add any additional information into this"
                  },

                  Respond only with valid JSON. Do not include explanations or extra text outside the JSON.
                  Keep responses friendly, clear, and easy to understand for users.
                  ''',
            },
          },
          "contents": [
            {
              "role": "user",
              "parts": [
                {
                  "text": '''
                    I have the following items in my closet.
                    Here is the closet Data in json format:
                    $closetData

                    Select the best outfit by cloth type variable from closetData:
                    - One topwear (choose from Shirt and Tshirt)
                    - One bottomwear (choosen from Pant cloth)
                    - One footwear (choosen from Shoe cloth)

                    Each clothing item has a id, cloth, color, weather(season), and fabric.
                    Suggest according to my location weather: $weatherData
                    Make sure respond with each variable id, cloth, weather and fabric

                    Please respond only with the final selected outfit in structured JSON with three sections: topwear, bottomwear, and footwear. Use only one item in each category.
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

        _outfitResponse = formatted;

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
      _errorMessage = e.toString();
      log(e.toString());
      return null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
