import 'package:closet_craft_project/features/closet/provider/closet_provider.dart';
import 'package:closet_craft_project/features/recommendation/model/gemini_response.dart';
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
    Future.microtask(() {
      context
          .read<RecommendationProvider>()
          .chatWithGemini(widget.closetData, widget.weatherData);
    });
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
      body: Consumer<RecommendationProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Current outfit showcase
                Container(
                  height: MediaQuery.of(context).size.height * 0.55,
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
                  child: provider.loading
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                "assets/animation/outfit_loading.json",
                                height: 200,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                "Finding your perfect outfit...",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : provider.outfitResponse != null
                          ? OutfitCollage(
                              outfitResponse: provider.outfitResponse!)
                          : const Center(
                              child: Text("No outfit recommendations yet"),
                            ),
                ),

                // Outfit details section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: provider.loading
                      ? const SizedBox()
                      : provider.outfitResponse != null
                          ? OutfitDetails(
                              outfitResponse: provider.outfitResponse!)
                          : const SizedBox(),
                ),

                // Action buttons
                if (!provider.loading && provider.outfitResponse != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            // Regenerate outfit
                            provider.chatWithGemini(
                                widget.closetData, widget.weatherData);
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text("Try Again"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Save outfit
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Outfit saved to favorites!")),
                            );
                          },
                          icon: const Icon(Icons.favorite),
                          label: const Text("Save Outfit"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OutfitCollage extends StatelessWidget {
  final GeminiResponse outfitResponse;

  const OutfitCollage({Key? key, required this.outfitResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract outfit items
    final topwear = outfitResponse.response?.topwear;
    final bottomwear = outfitResponse.response?.bottomwear;
    final footwear = outfitResponse.response?.footwear;
    // final accessories = outfitResponse.response?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Perfect Match',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Top row: Topwear and Accessories
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            // Topwear
                            Expanded(
                              flex: 2,
                              child: _buildOutfitItem(
                                topwear?.image,
                                topwear?.cloth ?? "Top",
                                context,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Accessories (if available)
                            // if (accessories != null)
                            //   Expanded(
                            //     child: _buildOutfitItem(
                            //       accessories.image,
                            //       accessories.name ?? "Accessories",
                            //       context,
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Bottom row: Bottomwear and Footwear
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            // Bottomwear
                            Expanded(
                              flex: 2,
                              child: _buildOutfitItem(
                                bottomwear?.image,
                                bottomwear?.cloth ?? "Bottom",
                                context,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Footwear
                            Expanded(
                              child: _buildOutfitItem(
                                footwear?.image,
                                footwear?.cloth ?? "Shoes",
                                context,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOutfitItem(String? imageUrl, String name, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey.shade400,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class OutfitDetails extends StatelessWidget {
  final GeminiResponse outfitResponse;

  const OutfitDetails({Key? key, required this.outfitResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get outfit description or suggestion
    final description = outfitResponse.response?.notes ??
        "This outfit is perfect for today's weather and your style preferences!";

    final occasion = "Casual day";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Perfect for: $occasion",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.wb_sunny_outlined, size: 20, color: Colors.amber),
            const SizedBox(width: 8),
            Text(
              "Weather-appropriate outfit",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.style_outlined, size: 20, color: Colors.teal),
            const SizedBox(width: 8),
            Text(
              "Matches your style preferences",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
