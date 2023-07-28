import 'package:flutter/material.dart';

class AutocompleteTextField extends StatefulWidget {
  @override
  _AutocompleteTextFieldState createState() => _AutocompleteTextFieldState();
}

class _AutocompleteTextFieldState extends State<AutocompleteTextField> {
  final textController = TextEditingController();
  final List<String> suggestionsList = ['Volleyball', 'Cricket', 'Basketball',
    'Football',"Skating", "Badminton","Boxing","Swimming"];
  List<String> filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      final input = textController.text;
      filteredSuggestions = suggestionsList
          .where((suggestion) =>
          suggestion.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Search',
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: filteredSuggestions.length,
              itemBuilder: (context, index) {
                final suggestion = filteredSuggestions[index];
                return ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    setState(() {
                      textController.text = suggestion;
                      filteredSuggestions.clear();
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
