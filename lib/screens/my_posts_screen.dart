import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malsat_app/components/favorite_post_card.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';

class MyPostsScreen extends StatefulWidget {
  final List<Post> listPosts;
  final User currentUser;
  final CommentRepository commentRepository;
  final AuthRepository authRepository;
  final bool isMyPost;
  final List<City> listCities;
  final List<Category> listCategories;
  final PostRepository postRepository;
  final String isPost;

  const MyPostsScreen({
    Key key,
    @required this.listPosts,
    @required this.currentUser,
    @required this.commentRepository,
    @required this.authRepository,
    this.isMyPost = false,
    @required this.listCities,
    @required this.listCategories,
    @required this.postRepository,
    @required this.isPost,
  }) : super(key: key);

  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  List<Post> listPost1;
  bool _loading = false;

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
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
                              child: Image(
                                image: AssetImage("assets/images/MALSAT.png"),
                              ),
                            ),
                            Spacer(
                              flex: 3,
                            ),
                          ],
                        ),
                        // SizedBox(height: 20),
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
                                  'Мои объявления',
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
                            Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: listPost1?.length == null
                                  ? SizedBox()
                                  : ListView.builder(
                                      itemCount: listPost1?.length,
                                      itemBuilder: (context, index) =>
                                          FavoritePostCard(
                                        isMyPost: widget.isMyPost,
                                        authRepository: widget.authRepository,
                                        commentRepository:
                                            widget.commentRepository,
                                        currentUser: widget.currentUser,
                                        post: listPost1[index],
                                        postRepository: widget.postRepository,
                                        listCategories: widget.listCategories,
                                        listCities: widget.listCities,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ),/
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> getPosts() async {
    setState(() {
      _loading = true;
    });
    if (widget.isPost == "Active")
      listPost1 = await widget.postRepository.getMyActivePosts();
    if (widget.isPost == "MyPost")
      listPost1 = await widget.authRepository
          .getPostsByUser(widget.currentUser.id.toString());
    if (widget.isPost == "Proverka")
      listPost1 = await widget.postRepository.getMyCheckingPosts();
    if (widget.isPost == "Hidden")
      listPost1 = await widget.postRepository.getMyHiddenPosts();
    setState(() {
      _loading = false;
    });
  }
}
