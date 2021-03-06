import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/components/search_post_by_city.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/repositories/review_repository.dart';
import 'package:malsat_app/screens/posts_by_city_screen.dart';

class FilterByCity extends StatefulWidget {
  final List<dynamic> listCities;
  final List<dynamic> listPostsByCity;
  final PostRepository postRepository;
  final CommentRepository commentRepository;
  final User currentUser;
  final AuthRepository authRepository;
  final List<City> listCities1;
  final List<Category> listCategories;
  final ReviewRepository reviewRepository;

  const FilterByCity({
    Key key,
    @required this.listCities,
    this.postRepository,
    this.listPostsByCity,
    this.commentRepository,
    this.currentUser,
    this.authRepository,
    @required this.listCities1,
    @required this.listCategories,
    @required this.reviewRepository,
  }) : super(key: key);

  @override
  _FilterByCityState createState() => _FilterByCityState();
}

class _FilterByCityState extends State<FilterByCity> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
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
                            '?????? city',
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
                              'Cities',
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
                              itemCount: widget.listCities.length,
                              itemBuilder: (context, index) => SearchPostByCity(
                                text: widget.listCities[index].name,
                                press: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PostsByCityScreen(
                                          authRepository: widget.authRepository,
                                          commentRepository:
                                              widget.commentRepository,
                                          currentUser: widget.currentUser,
                                          postRepository: widget.postRepository,
                                          listPosts: widget.listPostsByCity,
                                          city: widget.listCities[index],
                                          listCategories: widget.listCategories,
                                          listCities: widget.listCities1,
                                          reviewRepository:
                                              widget.reviewRepository,
                                        ),
                                      ),
                                    );
                                  });
                                },
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
          ),
        );
      },
    );
  }
}
