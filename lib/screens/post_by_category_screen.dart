import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/components/favorite_post_card.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/repositories/repositories.dart';
import 'package:malsat_app/repositories/review_repository.dart';

class PostsByCategoryScreen extends StatefulWidget {
  final List<Post> listPosts;
  final Category category;
  final PostRepository postRepository;
  final CommentRepository commentRepository;
  final User currentUser;
  final AuthRepository authRepository;
  final List<City> listCities;
  final List<Category> listCategories;
  final ReviewRepository reviewRepository;

  const PostsByCategoryScreen({
    Key key,
    @required this.listPosts,
    this.category,
    this.postRepository,
    this.commentRepository,
    this.currentUser,
    this.authRepository,
    @required this.listCities,
    @required this.listCategories,
    @required this.reviewRepository,
  }) : super(key: key);

  @override
  _PostsByCategoryScreenState createState() => _PostsByCategoryScreenState();
}

class _PostsByCategoryScreenState extends State<PostsByCategoryScreen> {
  List<dynamic> listPosts1;

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state is AuthenticationLoading
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0xFFEA5E3C),
                                      size: 30,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                Container(
                                  height: 30,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: InkWell(
                                    onTap: () {
                                      print(listPosts1);
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/MALSAT.png"),
                                    ),
                                  ),
                                ),
                                Spacer(
                                  flex: 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
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
                                      widget.category.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4A564A),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: listPosts1?.length != null
                                      ? ListView.builder(
                                          itemCount: listPosts1.length,
                                          itemBuilder: (context, index) =>
                                              FavoritePostCard(
                                            authRepository:
                                                widget.authRepository,
                                            post: listPosts1[index],
                                            commentRepository:
                                                widget.commentRepository,
                                            currentUser: widget.currentUser,
                                            listCategories:
                                                widget.listCategories,
                                            listCities: widget.listCities,
                                            postRepository:
                                                widget.postRepository,
                                            reviewRepository:
                                                widget.reviewRepository,
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                              ],
                            ),
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

  Future<void> getPosts() async {
    listPosts1 =
        await widget.postRepository.getAllPostsWithCategory(widget.category.id);
    setState(() {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(GetPostsByCity(cityId: widget.category.id));
    });
  }
}
