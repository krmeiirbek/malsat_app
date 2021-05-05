class Category {
  int id;
  String name;
  String slug;
  List<dynamic> children;

  Category({
    this.id,
    this.name,
    this.slug,
    this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      children: json['children'],
    );
  }
}
