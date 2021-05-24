import 'package:flutter/material.dart';
import 'package:malsat_app/components/favorite_post_card.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/repositories/repositories.dart';

class FavoritesScreen extends StatefulWidget {
  final List<dynamic> listBookmarks;
  final User currentUser;
  final CommentRepository commentRepository;
  final AuthRepository authRepository;
  final List<City> listCities;
  final List<Category> listCategories;
  final PostRepository postRepository;

  const FavoritesScreen({
    Key key,
    this.listBookmarks,
    this.currentUser,
    this.commentRepository,
    this.authRepository,
    @required this.listCities,
    @required this.listCategories,
    @required this.postRepository,
  }) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    InkWell(
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Color(0xFFEA5E3C),
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Spacer(
                      flex: 2,
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
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F1F1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск объявлений',
                      hintStyle: TextStyle(
                        color: Color(0xFF4A564A).withOpacity(0.4),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF4A564A).withOpacity(0.4),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
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
                        'Избранное',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A564A)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                        child: widget.listBookmarks.isNotEmpty
                            ? ListView.builder(
                                itemCount: widget.listBookmarks.length,
                                itemBuilder: (context, index) =>
                                    FavoritePostCard(
                                  authRepository: widget.authRepository,
                                  post: widget.listBookmarks[index].post,
                                  commentRepository: widget.commentRepository,
                                  currentUser: widget.currentUser,
                                  postRepository: widget.postRepository,
                                  listCategories: widget.listCategories,
                                  listCities: widget.listCities,
                                ),
                              )
                            : Center(
                                child: Text('У вас нет избранные посты'),
                              )),
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
