import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malsat_app/pages/home_page.dart';
import 'package:malsat_app/screens/posts_by_category.dart';

class SearchCategoryCompanent extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback press;

  const SearchCategoryCompanent({
    Key key,
    @required this.text,
    @required this.press,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: this.icon,
              progressIndicatorBuilder: (context, url, _) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(
              text,
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
                    builder: (context) => PostByCategory(),
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
}
