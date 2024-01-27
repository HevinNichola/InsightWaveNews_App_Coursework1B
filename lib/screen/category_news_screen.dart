import "package:cached_network_image/cached_network_image.dart";
import"package:flutter/material.dart";
import "package:insightwavenews/model/show_category.dart";
import "package:insightwavenews/screen/article_viewing_screen.dart";
import "package:insightwavenews/services/show_category_news.dart";

class CategoryNews extends StatefulWidget {
  final String name;
  const CategoryNews({Key? key, required this.name}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

enum SortOption {
  byDate,
  byTitle,
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;
  SortOption _currentSortOption = SortOption.byDate;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    _sortArticles(showCategoryNews.categories);
    setState(() {
      categories = showCategoryNews.categories;
      _sortArticles(categories);
      _loading = false;
    });
  }

  void _sortArticles(List<ShowCategoryModel> articles) {
    switch (_currentSortOption) {
      case SortOption.byDate:
        articles.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
        break;
      case SortOption.byTitle:
        articles.sort((a, b) => a.title!.compareTo(b.title!));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<SortOption>(
                  value: _currentSortOption,
                  items: SortOption.values.map((option) {
                    return DropdownMenuItem<SortOption>(
                      value: option,
                      child: Text(option.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (newSortOption) {
                    setState(() {
                      _currentSortOption = newSortOption!;

                      _sortArticles(categories);
                    });
                  },
                ),
              ],
            ),
            _loading
                ? const CircularProgressIndicator()
                : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                  return ShowCategory(
                    images: categories[index].urlToImage!,
                    desc: categories[index].description!,
                    title: categories[index].title!,
                    url: categories[index].url!,
                    date: categories[index].publishedAt!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
 final String images, desc, title, url, date;

  const ShowCategory(
      {required this.images,
        required this.desc,
        required this.title,
        required this.url,
        required this.date,
       Key? key,}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
        },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: images,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  desc,
                  maxLines: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    date,
                    style: const TextStyle(
                        color: Colors.blueGrey),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
        );
  }
}