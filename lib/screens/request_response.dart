import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/request.dart';

class RequestResponseScreen extends StatefulWidget {
  final Request request;

  const RequestResponseScreen({super.key, required this.request});

  @override
  State<RequestResponseScreen> createState() => _RequestResponseScreenState();
}

class _RequestResponseScreenState extends State<RequestResponseScreen> {
  final TextEditingController _responseController = TextEditingController();

  @override
  void dispose() {
    _responseController.dispose();
    super.dispose();
  }

  void _sendResponse() {
    final text = _responseController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a response')));
      return;
    }

    // For now just show a confirmation. In a real app you'd call an API.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Response sent: $text')));
    _responseController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final req = widget.request;
    return Scaffold(
      appBar: AppBar(title: const Text('Respond to Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              req.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(req.description),
            const SizedBox(height: 12),
            Text(
              'Requested at: ${DateFormat.yMMMd().add_jm().format(req.dateTime.toLocal())}',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _responseController,
              decoration: const InputDecoration(
                labelText: 'Your response',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _sendResponse,
              child: const Text('Send Response'),
            ),
          ],
        ),
      ),
    );
  }
}
