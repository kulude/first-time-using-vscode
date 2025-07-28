import 'package:flutter/material.dart';
import 'package:recipe_app/screens/experiment.dart';

// ignore: camel_case_types
enum Items { tea, cofee, juice, soda, water }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Items? selectedItems = Items.cofee;

  Widget _dropDownButtonNavigation() {
    return DropdownButton<Items>(
      value: selectedItems,
      onChanged: (value) {
        setState(() {
          selectedItems = value;
        });
      },
      items: Items.values.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item.toString().split('.').last),
        );
      }).toList(),
    );
  }

  List<String> allItems = ['Tea', 'Coffee', 'Juice', 'Soda', 'Water'];
  List<String> filteredItems = [];

  final TextEditingController _controller =
      TextEditingController(); // Controller to manage the search input
  // This controller is used to get the text input from the user for searching

  String searchQuery = '';

  void _fiterItems(String query) {
    setState(() {
      searchQuery = query;
      filteredItems = allItems.where((item) {
        return item.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Recipes')),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<Items>(
                itemBuilder: (context) {
                  return Items.values.map((item) {
                    return PopupMenuItem<Items>(
                      value: item,
                      child: Text(item.toString().split('.').last),
                    );
                  }).toList();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged:
                        _fiterItems, // this will do all the work of filtering
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    controller: _controller,
                  ),
                ),
                IconButton(
                  // the app can work without this button, but it adds functionality
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      setState(() {
                        searchQuery = _controller.text;
                        _fiterItems(_controller.text);
                      });
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ExperimentScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: Icon(Icons.home),
                  title: Text(filteredItems[index]),
                  onTap: () {
                    // You can show a dropdown or handle navigation here
                    showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(content: _dropDownButtonNavigation()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
