import 'package:flutter/material.dart';
import 'add_component_page.dart';
import 'playgound.dart';

class ThreeDViewPage extends StatefulWidget {
  const ThreeDViewPage({super.key});

  @override
  State<ThreeDViewPage> createState() => _ThreeDViewPageState();
}

class _ThreeDViewPageState extends State<ThreeDViewPage> {
  final List<String> _types = ['Lunar', 'Martian', 'Space'];
  String _selected = 'Lunar';

  final List<String> _components = [
    'Structural elements',
    'Life support systems',
    'Power systems',
    'Food systems',
    'Protection and safety systems',
    'Communication and data systems',
    'Internal arrangement',
  ];

  final Set<String> _selectedComponents = {};
  // structural sub-options state
  final Map<String, bool> _structuralDetails = {
    'Pressure Shell': false,
    'Airlocks': false,
    'Hatches': false,
  };

  Future<void> _showAddComponentDialog() async {
    final result = await Navigator.of(
      context,
    ).push<String>(MaterialPageRoute(builder: (_) => const AddComponentPage()));
    if (!mounted) return;
    if (result == null) return;
    final name = result.trim();
    if (name.isEmpty) return;
    if (_components.contains(name)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Component already exists')));
      return;
    }
    setState(() {
      _components.add(name);
      _selectedComponents.add(name);
    });
  }

  // _onCreatePressed removed: Create button now navigates directly to PlaygoundPage

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 800;

    Widget sidebarContent = SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'Build components',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ..._components.map((c) {
            // Replace the plain checkbox for Structural elements with an ExpansionTile
            if (c == 'Structural elements') {
              final structuralSelected = _structuralDetails.values.any(
                (v) => v,
              );
              return ExpansionTile(
                title: Text(
                  c,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                initiallyExpanded: false,
                trailing: Checkbox(
                  value: structuralSelected,
                  onChanged: (v) => setState(() {
                    // toggle all sub-options
                    _structuralDetails.updateAll((key, value) => v == true);
                    // sync parent selection
                    if (v == true) {
                      _selectedComponents.add(c);
                    } else {
                      _selectedComponents.remove(c);
                    }
                  }),
                ),
                children: _structuralDetails.keys.map((sub) {
                  return CheckboxListTile(
                    value: _structuralDetails[sub],
                    title: Text(sub),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (v) => setState(() {
                      _structuralDetails[sub] = v == true;
                      // ensure parent is represented in selected components when any child is selected
                      if (_structuralDetails.values.any((val) => val)) {
                        _selectedComponents.add(c);
                      } else {
                        _selectedComponents.remove(c);
                      }
                    }),
                  );
                }).toList(),
              );
            }

            final selected = _selectedComponents.contains(c);
            return CheckboxListTile(
              value: selected,
              title: Text(c),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (v) => setState(() {
                if (v == true) {
                  _selectedComponents.add(c);
                } else {
                  _selectedComponents.remove(c);
                }
              }),
            );
          }),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showAddComponentDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Add component'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => setState(() {
                    _selectedComponents.clear();
                    // also clear structural sub-options
                    _structuralDetails.updateAll((key, value) => false);
                  }),
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear Content'),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    Widget mainContent = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Select habitat type',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selected,
            items: _types
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (v) => setState(() => _selected = v ?? _selected),
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.threed_rotation,
                    size: 72,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '3D view placeholder',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Selected habitat: $_selected',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: _selectedComponents.isEmpty
                        ? [const Chip(label: Text('No components added'))]
                        : _selectedComponents
                              .map((c) => Chip(label: Text(c)))
                              .toList(),
                  ),
                  const SizedBox(height: 12),
                  //const Text(
                  //  'This is a placeholder for the 3D habitat builder. Replace with a proper 3D renderer (SceneKit/Scene3D, Flutter Unity, or WebGL via a WebView).',
                  //  textAlign: TextAlign.center,
                  //),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PlaygoundPage()),
                  ),
                  child: const Text('Create and view in 3D'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back'),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('3D view of your habitats')),
      drawer: isWide ? null : Drawer(child: sidebarContent),
      body: isWide
          ? Row(
              children: [
                Container(
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: sidebarContent,
                ),
                Expanded(child: mainContent),
              ],
            )
          : mainContent,
    );
  }
}
