import 'package:flutter/material.dart';

class PlaygoundPage extends StatelessWidget {
  const PlaygoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the pasted background image at this path
    const assetPath = 'assets/images/bg.png';
    // Fallback network image (reasonable Mars habitat image)
    const fallbackUrl =
        'https://images.unsplash.com/photo-1549880338-65ddcdfd017b?auto=format&fit=crop&w=1200&q=80';
    //const fallbackUrl =
    // 'https://drive.google.com/file/d/13Ct-x0ac69BIIeAb_4rPmArtHlP-mh3k/view?usp=sharing';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Load the local bg.png asset; fall back to a network image if missing
          Image.asset(
            assetPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.network(
              fallbackUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.black87),
            ),
          ),

          // dim overlay for readability
          Container(color: Colors.black38),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black45,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        label: const Text('Close'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  Expanded(
                    child: Center(
                      child: Card(
                        color: Color.fromARGB(230, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 700),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  'Playgound',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'This is a playground page. Replace the asset at assets/images/bg.png with your pasted image to use it as the background.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
