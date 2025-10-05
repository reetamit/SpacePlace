import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/request.dart';
import 'request_response.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Request> requests = List<Request>.generate(
    20,
    (i) => Request(
      title: 'Request ${i + 1}',
      description: 'This is a description for request ${i + 1}.',
      dateTime: DateTime.now().subtract(Duration(minutes: i * 7)),
    ),
  );

  String _formatDateTime(DateTime dt) {
    final df = DateFormat('hh:mm a\ndd/MM/yyyy');
    return df.format(dt.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Requests')),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        itemCount: requests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final req = requests[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RequestResponseScreen(request: req),
                ),
              );
            },
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          req.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          req.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatDateTime(req.dateTime),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
