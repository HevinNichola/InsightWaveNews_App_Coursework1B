import 'package:flutter/material.dart';
import 'package:insightwavenews/model/search_model.dart';
import '../screen/article_viewing_screen.dart';


class SearchResults extends StatelessWidget {
  final List<SearchModel> searchResults;

  const SearchResults({required this.searchResults, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        key: ValueKey(searchResults.length),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return SearchResultItem(searchResult: searchResults[index]);
        },
      ),
    );
  }
}

class SearchResultItem extends StatelessWidget {
  final SearchModel searchResult;

  const SearchResultItem({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(blogUrl: searchResult.url!),
            ),
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                searchResult.urlToImage!,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              searchResult.title!,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              searchResult.description!,
              maxLines: 3,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
        );
    }
}