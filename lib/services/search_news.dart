import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insightwavenews/model/search_model.dart';

class SearchNews{
  List<SearchModel> news = [];

  Future<void> searchNewsByName(String articleName)async{
    String url= "https://newsapi.org/v2/everything?q=$articleName&apiKey=96c63cca800340fb83512f3ec9c0ea6a";

    var response= await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);

    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          SearchModel searchModel= SearchModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          news.add(searchModel);
        }
      }
      );
    }
    }
}
