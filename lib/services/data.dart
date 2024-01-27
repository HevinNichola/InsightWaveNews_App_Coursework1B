import 'package:insightwavenews/model/catetory_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.image = "images/Business.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "images/Entertainment.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();


  categoryModel.categoryName = "General";
  categoryModel.image = "images/General.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();


  categoryModel.categoryName = "Health";
  categoryModel.image = "images/Health.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Politics";
  categoryModel.image = "images/Politics.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Science";
  categoryModel.image = "images/Science.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.image = "images/Sports.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();


  return category;

}
