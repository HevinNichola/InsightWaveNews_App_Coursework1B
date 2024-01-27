import 'package:cached_network_image/cached_network_image.dart';
import'package:flutter/material.dart';

import '../model/article_model.dart';
import '../model/slider_model.dart';
import '../services/news.dart';
import '../services/slider_data.dart';
import 'package:insightwavenews/screen/article_viewing_screen.dart';

class AllNews extends StatefulWidget {
  final String news;
  const AllNews({Key? key, required this.news}) : super(key:key);


  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders=[];
  List<ArticleModel> articles =[];

  @override
  void initState() {

    getSlider();
    getNews();
    super.initState();
  }


  getNews()async{
    News newsclass= News();
    await newsclass.getNews();
    articles= newsclass.news;
    setState(() {

    });

  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
         text: TextSpan(
          children:[
          TextSpan(
           text: widget.news,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text: " News",
              style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
        ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
         margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
          shrinkWrap: true,
           physics: const ClampingScrollPhysics(),
          itemCount: widget.news=="Breaking"? sliders.length: articles.length,
           itemBuilder: (context, index) {
            return AllNewsSection(
            images: widget.news=="Breaking"? sliders[index].urlToImage!: articles[index].urlToImage!,
            desc:  widget.news=="Breaking"? sliders[index].description!: articles[index].description!,
            title: widget.news=="Breaking"? sliders[index].title!: articles[index].title!,
            url: widget.news=="Breaking"? sliders[index].url!: articles[index].url!,

          );
        },
      )),
    );
  }
}

class AllNewsSection extends StatelessWidget {
   final String images, desc, title, url;
  const AllNewsSection({Key? key, required this.images, required this.desc, required this.title, required this.url}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
        },
        child: Column(
            children :[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:CachedNetworkImage(
                  imageUrl: images,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(title,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(desc,
                maxLines: 3,),
              const SizedBox(height: 5.0,)

            ])
    );
  }
}
