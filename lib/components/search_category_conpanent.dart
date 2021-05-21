import 'package:flutter/material.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/screens/post_by_category_screen.dart';

class SearchCategoryCompanent extends StatelessWidget {
  final VoidCallback press;
  final Category category;
  final PostRepository postRepository;

  const SearchCategoryCompanent({
    Key key,
    @required this.press,
    @required this.category,
    @required this.postRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListTile(
            leading: Image.network(this.getIcon()),
            title: Text(
              category.name,
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostsByCategoryScreen(listPosts: [],category: category,postRepository: postRepository,),
                  ),
                );
              },
              icon: Icon(Icons.chevron_right),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  String getIcon() {
    String url = this.category.image;
    if (url == null) {
      url =
          'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png';
    }
    print(url);
    return url;
  }
}
