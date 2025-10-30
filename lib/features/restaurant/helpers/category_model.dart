class CategoryModel {
  String imagePath;
  String name;

  CategoryModel({required this.name})
    : imagePath = "assets/images/categories/${name.toLowerCase()}.png";
}
