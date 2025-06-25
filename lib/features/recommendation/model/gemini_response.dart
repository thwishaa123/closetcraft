import 'dart:convert';

GeminiResponse geminiResponseFromJson(String str) =>
    GeminiResponse.fromJson(json.decode(str));

String geminiResponseToJson(GeminiResponse data) => json.encode(data.toJson());

class GeminiResponse {
  GeminiResponse({
    required this.response,
  });
  final Response? response;

  factory GeminiResponse.fromJson(Map<String, dynamic> json) {
    return GeminiResponse(
      response:
          json["response"] == null ? null : Response.fromJson(json["response"]),
    );
  }

  Map<String, dynamic> toJson() => {"response": response?.toJson()};
}

class Response {
  Response({
    required this.topwear,
    required this.bottomwear,
    required this.footwear,
    required this.tips,
    required this.notes,
  });

  final Wear? topwear;
  final Wear? bottomwear;
  final Wear? footwear;
  final List<String> tips;
  final String? notes;

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      topwear: json["topwear"] == null ? null : Wear.fromJson(json["topwear"]),
      bottomwear:
          json["bottomwear"] == null ? null : Wear.fromJson(json["bottomwear"]),
      footwear:
          json["footwear"] == null ? null : Wear.fromJson(json["footwear"]),
      tips: json["tips"] == null
          ? []
          : List<String>.from(json["tips"]!.map((x) => x)),
      notes: json["notes"],
    );
  }

  Map<String, dynamic> toJson() => {
        "topwear": topwear?.toJson(),
        "bottomwear": bottomwear?.toJson(),
        "footwear": footwear?.toJson(),
        "tips": tips.map((x) => x).toList(),
        "notes": notes,
      };
}

class Wear {
  Wear({
    required this.id,
    required this.cloth,
    required this.description,
    required this.color,
    required this.weather,
    required this.fabric,
  });
  final String? id;
  final String? cloth;
  final String? description;
  final String? color;
  final String? weather;
  final String? fabric;

  factory Wear.fromJson(Map<String, dynamic> json) {
    return Wear(
      id: json['id'],
      cloth: json["cloth"],
      description: json["description"],
      color: json["color"],
      weather: json["weather"],
      fabric: json["fabric"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cloth": cloth,
        "description": description,
        "color": color,
        "weather": weather,
        "fabric": fabric,
      };
}
