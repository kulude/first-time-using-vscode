import 'package:flutter/material.dart';

class ExperimentScreen extends StatefulWidget {
  const ExperimentScreen({super.key});

  @override
  State<ExperimentScreen> createState() => _ExperimentScreenState();
}

class _ExperimentScreenState extends State<ExperimentScreen> {
  String _string = 'tae';

  final TextEditingController _controller = TextEditingController();

  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    _string = 'tea';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Experiment Screen')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a drink',
                    ),
                    onSubmitted: (_) {
                      setState(() {
                        _string = _controller.text;
                      });
                    },
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'tea') {
                      setState(() {
                        _string = value;
                        _controller.text = value;
                      });
                    } else if (value == 'coffee') {
                      setState(() {
                        _string = value;
                        _controller.text = value;
                      }); // Do something for coffee
                    } else if (value == 'juice') {
                      setState(() {
                        _string = value;
                        _controller.text = value;
                      }); // Do something for juice
                    } else if (value == 'soda') {
                      setState(() {
                        _string = value;
                        _controller.text = value;
                      }); // Do something for soda
                    } else if (value == 'water') {
                      setState(() {
                        _string = value;
                        _controller.text = value;
                      }); // Do something for water
                    }
                  },
                  initialValue: _string,
                  itemBuilder: (ctx) {
                    return [
                      PopupMenuItem<String>(value: 'tea', child: Text('Tea')),
                      PopupMenuItem<String>(
                        value: 'coffee',
                        child: Text('Coffee'),
                      ),
                      PopupMenuItem<String>(
                        value: 'juice',
                        child: Text('Juice'),
                      ),
                      PopupMenuItem<String>(value: 'soda', child: Text('Soda')),
                      PopupMenuItem<String>(
                        value: 'water',
                        child: Text('Water'),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text.rich(
            TextSpan(
              text: 'Selected drink: ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: _string,
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Stack(
            children: [
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset localPosition = renderBox.globalToLocal(
                    details.globalPosition,
                  );
                  setState(() {
                    _tapPosition = localPosition;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: Text(
                      'Tap anywhere',
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ),
                ),
              ),
              if (_tapPosition != null)
                Positioned(
                  left: _tapPosition!.dx - 0,
                  top: _tapPosition!.dy - 250,
                  child: Text(
                    'Tap Position: ${_tapPosition!.dx.toStringAsFixed(2)}, ${_tapPosition!.dy.toStringAsFixed(2)}',
                  ),
                ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  _insertTextAtCursor('more water, more food ');
                },
                child: Text('more water, more food'),
              ),
              OutlinedButton(
                onPressed: () {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset position = renderBox.localToGlobal(Offset.zero);
                  _showMenu(context, position);
                },
                child: Text('show options menu'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _insertTextAtCursor(String newText) {
    final text = _controller.text;
    final selection = _controller.selection;

    if (!selection.isValid) return;

    final newTextValue = text.replaceRange(
      selection.start,
      selection.end,
      newText,
    );

    final newCursorPosition = selection.start + newText.length;

    _controller.value = TextEditingValue(
      text: newTextValue,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }

  void _showMenu(BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
      items: [
        PopupMenuItem<String>(value: 'Option 1', child: Text('Option 1')),
        PopupMenuItem<String>(value: 'Option 2', child: Text('Option 2')),
        PopupMenuItem<String>(value: 'Option 3', child: Text('Option 3')),
      ],
    ).then((value) {
      if (value != null) {
        // Handle the selected value
        print('Selected: $value');
      }
    });
  }
}
