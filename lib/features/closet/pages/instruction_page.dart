import 'package:flutter/material.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('How to Use Re-Vastra'),
        backgroundColor: const Color.fromARGB(255, 9, 184, 200),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 9, 184, 200),
                    Color.fromARGB(255, 40, 184, 198),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome to Re-Vastra!',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Because your wardrobe deserves a personal assistant… and some sass.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Instructions Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildInstructionStep(
                    stepNumber: 1,
                    title: 'The Great Wardrobe Upload',
                    emoji: '👗',
                    items: [
                      'Grab your clothes (yes, even that neon sweater you swore you\'d wear "someday").',
                      'Snap, upload, or scan them into the app.',
                      'Voilà! Your closet is now digitized—think of it as your own Bollywood-style makeover montage moment. 💃🎬',
                    ],
                    proTip:
                        'Pro tip: Don\'t be shy, your pajamas deserve screen time too.',
                  ),

                  const SizedBox(height: 24),

                  _buildInstructionStep(
                    stepNumber: 2,
                    title: 'Meet Your Digital Stylist',
                    emoji: '🎨',
                    items: [
                      'The app will study your fashion personality (it\'s judgment-free… mostly).',
                      'Outfits are suggested based on:',
                    ],
                    subItems: [
                      'Weather 🌦',
                      'Trends 🔥',
                      'Your mood (yes, we get that Mondays feel like sweatpants).',
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildInstructionStep(
                    stepNumber: 3,
                    title: 'Swipe Right on Fashion',
                    emoji: '🔄',
                    items: [
                      'Scroll through your suggested outfits.',
                      'Like it? Wear it.',
                      'Hate it? Swipe it away like spam invites.',
                      'Save your favorites so Re-Vastra remembers your style quirks.',
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildInstructionStep(
                    stepNumber: 4,
                    title: 'Fashion Meets Sustainability',
                    emoji: '♻',
                    items: [
                      'Mix and match from what you already own.',
                      'Track what you wear most, and what\'s been ghosting you (looking at you, sequined blazer).',
                      'Reduce fast fashion guilt—save the planet while slaying your OOTDs. 🌍✨',
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildInstructionStep(
                    stepNumber: 5,
                    title: 'Strut & Share',
                    emoji: '🎉',
                    items: [
                      'Snap your outfit of the day.',
                      'Share with friends, family, or your "private archive" (we won\'t judge).',
                      'Watch your style game level up, one Re-Vastra day at a time.',
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Call to Action
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color.fromARGB(255, 9, 184, 200)
                              .withOpacity(0.1),
                          const Color.fromARGB(255, 40, 184, 198)
                              .withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color.fromARGB(255, 9, 184, 200)
                            .withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.rocket_launch,
                          color: Color.fromARGB(255, 9, 184, 200),
                          size: 32,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Ready to Transform Your Wardrobe?',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 9, 184, 200),
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start your fashion journey with Re-Vastra today!',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 9, 184, 200),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Let\'s Get Started!',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionStep({
    required int stepNumber,
    required String title,
    required String emoji,
    required List<String> items,
    String? proTip,
    List<String>? subItems,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 9, 184, 200),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '$stepNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 9, 184, 200),
                      ),
                    ),
                    Text(
                      emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Main Items
          ...items.map((item) => _buildInstructionItem(item)).toList(),

          // Sub Items (if any)
          if (subItems != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subItems
                    .map((subItem) =>
                        _buildInstructionItem(subItem, isSubItem: true))
                    .toList(),
              ),
            ),
          ],

          // Pro Tip (if any)
          if (proTip != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 9, 184, 200).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color:
                      const Color.fromARGB(255, 9, 184, 200).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: Color.fromARGB(255, 9, 184, 200),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      proTip,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 9, 184, 200),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String text, {bool isSubItem = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: isSubItem ? 4 : 6),
            width: isSubItem ? 4 : 6,
            height: isSubItem ? 4 : 6,
            decoration: BoxDecoration(
              color: isSubItem
                  ? Colors.grey.shade600
                  : const Color.fromARGB(255, 9, 184, 200),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isSubItem ? 13 : 14,
                height: 1.4,
                color: isSubItem ? Colors.grey.shade700 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
