import 'package:flutter/material.dart';
import 'latest_news.dart';
import 'three_d_view.dart';
import 'build_with_ai.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  Widget _buildButton(BuildContext context, String title, IconData icon) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
        onPressed: () {
          if (title == 'Latest News') {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => LatestNewsScreen()));
            return;
          }
          if (title == 'Build your own') {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ThreeDViewPage()));
            return;
          }
          if (title == 'Build with AI') {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const BuildWithAIPage()));
            return;
          }

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => _ExploreDetailScreen(title: title),
            ),
          );
        },
        icon: Icon(icon, size: 20),
        label: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Explore')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildButton(context, 'Build your own', Icons.threed_rotation),
              const SizedBox(height: 12),
              _buildButton(context, 'Build with AI', Icons.threed_rotation),
              const SizedBox(height: 12),
              _buildButton(context, 'Explore Habitat Components', Icons.park),
              const SizedBox(height: 12),
              _buildButton(context, 'Specifications', Icons.list_alt),
              const SizedBox(height: 12),
              _buildButton(context, 'Latest News', Icons.article),
              const SizedBox(height: 12),
              Expanded(child: Container()),
              Text(
                'Tap any button to view details',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExploreDetailScreen extends StatelessWidget {
  final String title;

  const _ExploreDetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              //const Text(
              //  'This is a placeholder screen. Replace with real content (news feed, specifications, 3D viewer, etc.)',
              //  textAlign: TextAlign.center,
              //),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
