import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSearchBar extends StatefulWidget {
  // Constructor for CustomSearchBar widget.
  // 'super.key' should be 'this.key' to initialize the key parameter.
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  // Text controller for the search input field.
  final TextEditingController _searchController = TextEditingController();

  // List to store search history.
  final List<String> _searchHistory = [];

  // Flag to track if the search bar is clicked.
  bool _isSearchBarClicked = false;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory(); // Load search history when the widget initializes.
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the text controller.
    super.dispose();
  }

  // Function to load saved search history from SharedPreferences.
  Future<void> _loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('searchHistory');
    if (history != null) {
      setState(() {
        _searchHistory.addAll(history);
      });
    }
  }

  // Function to save search history to SharedPreferences.
  Future<void> _saveSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', _searchHistory);
  }

  // Function to handle when a search is performed.
  void _onSearch(String query) {
    if (query.isNotEmpty) {
      if (!_searchHistory.contains(query)) {
        if (_searchHistory.length >= 5) {
          _searchHistory.removeAt(0);
        }
        _searchHistory.add(query);
        _saveSearchHistory(); // Save the updated search history.
      }
      // Implement your search logic here.
    }
  }

  // Function to remove a search history item.
  void _removeSearchHistoryItem(int index) {
    setState(() {
      _searchHistory.removeAt(index);
      _saveSearchHistory(); // Save the updated search history after removal.
    });
  }

  // Function to track if the search bar is active or not.
  void _onSearchBarFocusChanged(bool isFocused) {
    setState(() {
      _isSearchBarClicked = isFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                      letterSpacing: 2,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onChanged: _onSearch,
                  onFieldSubmitted: (value) {
                    _onSearch(value);
                    _onSearchBarFocusChanged(false);
                    FocusScope.of(context).unfocus();// to hide the keyboard

                  },
                  onTap: () {
                    _onSearchBarFocusChanged(true);
                  },
                  focusNode: _isSearchBarClicked
                      ? FocusNode()
                      : null, // Prevent keyboard from showing if not focused
                ),
              ),
            ),
            if (!_isSearchBarClicked)
              Expanded(
                child: ListView.builder(
                  itemCount: _searchHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_searchHistory[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => _removeSearchHistoryItem(index),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
        if (_isSearchBarClicked)
          Positioned(
            top: 75.0,
            left: 15.0,
            right: 15.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: _searchHistory.length * 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Additional widgets can be added here for search results.
                ],
              ),
            ),
          ),
      ],
    );
  }
}
