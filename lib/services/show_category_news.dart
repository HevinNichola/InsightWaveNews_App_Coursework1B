import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insightwavenews/model/show_category.dart';


class ShowCategoryNews{
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category) async {

    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=96c63cca800340fb83512f3ec9c0ea6a";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
            publishedAt: element["publishedAt"],

          );
          categories.add(categoryModel);
        }
      });
    }
  }
}

