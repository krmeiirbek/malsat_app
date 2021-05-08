class City {
  int id;
  String name;
  String slug;
  List<City> children;

  City({
    this.id,
    this.name,
    this.slug,
    this.children,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      children: List<City>.from(json['children'].map((x) => City.fromJson(x))),
    );
  }
}
