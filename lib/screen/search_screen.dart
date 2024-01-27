import 'package:flutter/material.dart';
import '../model/search_model.dart';
import '../services/search_news.dart';
import '../widget/search_result.dart';

class SearchArticles extends StatefulWidget {
  const SearchArticles({super.key});

  @override
  State<SearchArticles> createState() => _SearchArticlesState();
}

class _SearchArticlesState extends State<SearchArticles> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchModel> searchResults = [];
  SearchNews searchNews = SearchNews();

  void _performSearch() async {
    searchResults.clear();
    String searchTerm = _searchController.text;
    await searchNews.searchNewsByName(searchTerm);

    setState(() {
      searchResults = searchNews.news;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Search",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              Text("News",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search the Related news...',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: _performSearch,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SearchResults(searchResults: searchResults),
              ),
            ],
        ),
     );
    }
}