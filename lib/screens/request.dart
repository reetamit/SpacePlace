import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final List<String> _types = ['Heath Care', 'Tutoring', 'Cleaning'];
  String _selectedType = 'Heath Care';
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _createRequest() {
    // Handle request creation logic here
    final type = _selectedType;
    final desc = _descController.text;
    // You can show a snackbar or dialog for confirmation
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Request Created: $type - $desc')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Create Request')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: _types
                  .map(
                    (type) => DropdownMenuItem(value: type, child: Text(type)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createRequest,
                child: Text('Create Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
