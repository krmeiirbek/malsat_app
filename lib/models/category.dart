class Category{
  int id;
  String name;
  String slug;
  List<Category> children;

  Category({
    this.id,
    this.name,
    this.slug,
    this.children,
  });
}