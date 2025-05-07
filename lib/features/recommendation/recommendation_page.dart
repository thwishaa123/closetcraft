import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/features/recommendation/provider/recommendation_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OutfitRecommendationScreen extends StatefulWidget {
  const OutfitRecommendationScreen(
      {super.key, required this.closetData, required this.weatherData});

  final String closetData;
  final String weatherData;

  @override
  State<OutfitRecommendationScreen> createState() =>
      _OutfitRecommendationScreenState();
}

class _OutfitRecommendationScreenState
    extends State<OutfitRecommendationScreen> {
  @override
  void initState() {
    // Future.microtask(() {
    //   context
    //       .read<RecommendationProvider>()
    //       .chatWithGemini(widget.closetData, widget.weatherData);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Style Match',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Current outfit showcase
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Lottie.asset(
              "assets/animation/outfit_loading.json",
            ),
            // child: ListenableBuilder(
            //     listenable: context.read<RecommendationProvider>(),
            //     builder: (context, _) {
            //       var provider = context.read<RecommendationProvider>();
            //       if (provider.loading) {
            //         return Lottie.asset(
            //           "assets/animation/outfit_loading.json",
            //         );
            //       }
            //       if (!provider.loading && provider.outfitResponse != null) {
            //         return Image.network(
            //             provider.outfitResponse!.response!.topwear!.image!);
            //       }
            //       return Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text(
            //             'Your Perfect Match',
            //             style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           const SizedBox(height: 16),
            //         ],
            //       );
            //     }),
          ),
        ],
      ),
    );
  }
}
