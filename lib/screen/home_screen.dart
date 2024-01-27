import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insightwavenews/model/article_model.dart';
import 'package:insightwavenews/screen/view_all_news_screen.dart';
import 'package:insightwavenews/screen/article_viewing_screen.dart';
import 'package:insightwavenews/screen/category_news_screen.dart';
import 'package:insightwavenews/screen/search_screen.dart';
import 'package:insightwavenews/services/data.dart';
import 'package:insightwavenews/services/news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/catetory_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:insightwavenews/model/slider_model.dart';
import '../services/slider_data.dart';




class Home extends StatefulWidget {
  const Home({Key? key}) :super(key : key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories= [];
  List<SliderModel> sliders=[];
  List<ArticleModel> articles =[];
  bool _loading = true;

  int activeIndex = 0;

  @override
  void initState() {
    categories= getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews()async{
    News newsclass= News();
    await newsclass.getNews();
    articles= newsclass.news;
    setState(() {
      _loading=false;

    });

}

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("InsightWave",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                ),
            Text("News",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
          actions: [
            IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> const SearchArticles()),);
                  }
               ),
               ]
             ),
              body: _loading? const Center(
                  child: CircularProgressIndicator()):
              SingleChildScrollView(
                 child: Column(
                   children: [
                     SizedBox(
                       height: 80,
                       child: ListView.builder(
                         shrinkWrap: true,
                         scrollDirection: Axis.horizontal,
                         itemCount: categories.length,
                         itemBuilder: (context, index){
                           return CategoryTile(
                             image: categories[index].image,
                             categoryName: categories[index].categoryName,
                           );
                           },
                       ),
                     ),
                     const SizedBox(
                       height: 20,
                     ),Padding(
                       padding: const EdgeInsets.only(left:10.0, right:10.0 ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text("Breaking News",
                             style:TextStyle(color:Colors.black,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 18.0),
                           ),
                           GestureDetector(
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> const AllNews(news: "Breaking")));
                             },
                             child: const Text("View All",
                               style:TextStyle(color:Colors.red,
                                   fontWeight: FontWeight.w500,
                                   fontSize: 16.0
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(
                         height: 30
                     ),
                     CarouselSlider.builder(
                       itemCount: sliders.length,
                       itemBuilder: (context, index, realIndex ) {
                         if (sliders.isNotEmpty && index < sliders.length) {
                           String? res = sliders[index].urlToImage;
                           String? res1 = sliders[index].title;
                           return bulidImage(res!, index, res1!);
                         } else {
                           return Container();
                         }
                       },
                         options: CarouselOptions(
                         height: 200,
                         autoPlay: true,
                         enlargeCenterPage: true,
                         enlargeStrategy: CenterPageEnlargeStrategy.height,
                         onPageChanged: (index, reason){
                           setState(() {
                             activeIndex= index;
                           });
                         }
                     ),
                     ),
                     const SizedBox(height: 30),
                     Center(child: bulidIndicator(),),
                     const SizedBox(
                         height: 20
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left:10.0, right:10.0 ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text(
                             "Trending News",
                             style:TextStyle(color:Colors.black,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 18.0
                             ),
                           ),
                           GestureDetector(
                             onTap: () {
                               Navigator.push(context,
                                   MaterialPageRoute(builder: (context)=> const AllNews(news: "Trending")));
                             },
                             child : const Text(
                               "View All",
                               style:TextStyle(
                                   color:Colors.red,
                                   fontWeight: FontWeight.w500,
                                   fontSize: 16.0
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(height: 10,),
                     ListView.builder(
                       shrinkWrap: true,
                       physics: const ClampingScrollPhysics(),
                       itemCount: articles.length,
                       itemBuilder: (context, index) {
                         return BlogTile(
                           url: articles[index].url!,
                           desc: articles[index].description!,
                           imageUrl: articles[index].urlToImage!,
                           title: articles[index].title!,

                         );
                       },
                     )
                   ],
                 ),
              ),


    );
  }


  Widget bulidImage(String image, int index, String name)=>Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
          children: [
            ClipRRect(

              borderRadius:BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 250,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                imageUrl: image,
              ),
            ),
            Container(
              height: 250,
              padding: const EdgeInsets.only(left: 10.0),
              margin: const EdgeInsets.only(top: 120.0),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color:Colors.black26,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Text(
                name,
                maxLines: 2,
                style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
              ),
            )
          ]
      )
  );
  Widget bulidIndicator()=> AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: 5,
    effect: const SlideEffect(dotWidth: 13, dotHeight: 13, activeDotColor: Colors.red),
  );

}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  const CategoryTile({super.key, this.categoryName,this.image});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: (){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryName)));
    },
     child: Container(
         margin: const EdgeInsets.only(right: 16),
         child: Stack(
          children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child :Image.asset(
              image,
              width: 120,
              height: 70,
              fit: BoxFit.cover,

            ),
          ),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(6),
              color: Colors.black26,

            ),
            child: Center(
              child: Text(
                categoryName,
                style: const TextStyle(color: Colors.white,
                    fontSize: 14,
                    fontWeight : FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );

  }

}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  const BlogTile({Key? key, required this.desc, required this.imageUrl, required this.title,required this.url}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl:url )));
      },
      child: Container(
       margin: const EdgeInsets.only(bottom: 10.0),
       child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0 ),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child :Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      imageUrl : imageUrl,
                      height:100,
                      width:100,
                      fit:BoxFit.cover),
                ),
                const SizedBox(width: 8.0),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/ 1.7,

                      child: Text(
                        title,
                        maxLines: 2,
                        style:const TextStyle(
                            color:Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.0),
                      ),
                    ),
                    const SizedBox(height: 7.0),

                    SizedBox(
                      width: MediaQuery.of(context).size.width/ 1.7,

                      child: Text(
                        desc,
                        maxLines: 3,
                        style:const TextStyle(
                            color:Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ),
      ),
      ),
    );
  }
}


