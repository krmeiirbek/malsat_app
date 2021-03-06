import 'package:flutter/material.dart';
import 'package:malsat_app/components/search_category_conpanent.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/repositories/repositories.dart';
import 'package:malsat_app/repositories/review_repository.dart';

class SearchScreen extends StatefulWidget {
  final List<dynamic> listCategories;
  final PostRepository postRepository;
  final User currentUser;
  final CommentRepository commentRepository;
  final AuthRepository authRepository;
  final List<City> listCities;
  final List<Category> listCategories1;
  final ReviewRepository reviewRepository;

  const SearchScreen({
    Key key,
    this.listCategories,
    this.postRepository,
    this.currentUser,
    this.commentRepository,
    this.authRepository,
    @required this.listCities,
    @required this.listCategories1,
    @required this.reviewRepository,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(
                      flex: 3,
                    ),
                    Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Image(
                        image: AssetImage("assets/images/MALSAT.png"),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '?????? ??????????????????',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF888888)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 5),
                      Text(
                        '??????????????????',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A564A)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: widget.listCategories.length,
                        itemBuilder: (context, index) =>
                            SearchCategoryCompanent(
                          authRepository: widget.authRepository,
                          press: () {},
                          category: widget.listCategories[index],
                          postRepository: widget.postRepository,
                          commentRepository: widget.commentRepository,
                          currentUser: widget.currentUser,
                          listCategories: widget.listCategories1,
                          listCities: widget.listCities,
                          reviewRepository: widget.reviewRepository,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
