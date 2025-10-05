import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({super.key});

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  final String feedUrl = 'https://www.nasa.gov/rss/dyn/breaking_news.rss';
  RssFeed? _feed;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchFeed();
  }

  Future<void> _fetchFeed() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final resp = await http.get(Uri.parse(feedUrl));
      if (resp.statusCode == 200) {
        final feed = RssFeed.parse(resp.body);
        setState(() => _feed = feed);
      } else {
        setState(() => _error = 'Failed to load feed: ${resp.statusCode}');
      }
    } catch (e) {
      setState(() => _error = 'Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _openLink(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cannot open link')));
    }
  }

  String? _extractImageFromHtml(String? html) {
    if (html == null) return null;
    final imgRegex = RegExp(r'<img[^>]+src="([^"]+)"', caseSensitive: false);
    final match = imgRegex.firstMatch(html);
    return match != null ? match.group(1) : null;
  }

  String _stripHtmlIfNeeded(String html) {
    final tagRegex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return html.replaceAll(tagRegex, ' ').replaceAll(RegExp(r'\s+'), ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest News')),
      body: RefreshIndicator(
        onRefresh: _fetchFeed,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            : _feed == null
            ? ListView(
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text('No items'),
                    ),
                  ),
                ],
              )
            : ListView.separated(
                padding: const EdgeInsets.all(12.0),
                itemCount: _feed!.items?.length ?? 0,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = _feed!.items![index];
                  final pub = item.pubDate != null
                      ? DateFormat.yMMMd().add_jm().format(
                          item.pubDate!.toLocal(),
                        )
                      : '';

                  String? imageUrl = item.enclosure?.url;
                  if (imageUrl == null || imageUrl.isEmpty) {
                    imageUrl = _extractImageFromHtml(item.description);
                  }

                  final snippet = _stripHtmlIfNeeded(
                    item.description ?? '',
                  ).trim();

                  return ListTile(
                    leading: imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              imageUrl,
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          )
                        : SizedBox(
                            width: 48,
                            height: 48,
                            child: Icon(Icons.public, color: Colors.grey[700]),
                          ),
                    title: Text(item.title ?? ''),
                    subtitle: Text(
                      snippet,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      pub,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    isThreeLine: true,
                    onTap: () => _openLink(item.link),
                  );
                },
              ),
      ),
    );
  }
}
