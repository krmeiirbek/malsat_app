import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/components/comment_component.dart';
import 'package:malsat_app/constants/custom_icons.dart';
import 'package:malsat_app/constants/social_networks_icons.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/comment.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/repositories/repositories.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;

import 'my_posts_screen.dart';

class DetailPost extends StatefulWidget {
  final Post post;
  final List<dynamic> listBookmarks;
  final CommentRepository commentRepository;
  final AuthRepository authRepository;
  final PostRepository postRepository;
  final User currentUser;
  final List<Category> listCategories;
  final List<City> listCities;

  const DetailPost({
    Key key,
    this.post,
    this.listBookmarks,
    @required this.commentRepository,
    @required this.currentUser,
    @required this.authRepository,
    @required this.postRepository,
    @required this.listCategories,
    @required this.listCities,
  })  : assert(commentRepository != null),
        super(key: key);

  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  bool inFavorite = false;
  bool _loading = false;
  bool _start = true;
  bool sendPost = true;
  List<Comment> _listComments;
  List<Comment> _listCommentsByPost = [];
  List<Post> userPosts;
  int updateCommentId;

  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    getPosts();
    getComments();
    if (widget.listBookmarks != null)
      for (int i = 0; i < widget.listBookmarks.length; i++) {
        if (widget.listBookmarks[i].post.id == widget.post.id) {
          inFavorite = true;
          break;
        }
      }
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: new AppBar(
        title: Image.asset("assets/images/MALSAT.png", height: 14, width: 84),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFF7836D),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Image.network(
                    '${widget.post.getImage()}',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 17, 20, 0),
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 19),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Color(0xFFF3F3F3), width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${widget.post.categories.name}',
                                style: TextStyle(
                                  color: Color(0xFF4A564A).withOpacity(0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              InkWell(
                                child: Icon(
                                  Custom.heart_empty,
                                  size: 16,
                                  color: !inFavorite
                                      ? Color.fromRGBO(74, 86, 74, 0.4)
                                      : Colors.red,
                                ),
                                onTap: () {
                                  setState(() {
                                    inFavorite = !inFavorite;
                                    if (!inFavorite)
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(UpdateBookMarks(
                                              postId: widget.post.id));
                                    else
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(UpdateBookMarks(
                                              postId: widget.post.id,
                                              inBookmarks: false));
                                  });
                                },
                              ),
                            ],
                          ),
                          Text(
                            '${widget.post.title}',
                            style: TextStyle(
                              color: Color(0xffEA5E3C),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                                child: Text(
                              '${widget.post.price}',
                              style: TextStyle(
                                color: Color(0xff555555),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            )),
                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${widget.post.cities.name} | Добавлено: 13 марта 2021',
                              style: TextStyle(
                                color: Color(0xff9A9A9A).withOpacity(0.8),
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 33),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: [
                                Ink(
                                  width: 0.5,
                                  height: 37,
                                  color: Color(0xff9A9A9A),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Обмен',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    widget.post.exchange
                                        ? Text(
                                            'Да',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        : Text(
                                            'Нет',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Ink(
                                  width: 0.5,
                                  height: 37,
                                  color: Color(0xff9A9A9A),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Доставка',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    widget.post.delivery
                                        ? Text(
                                            'Да',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        : Text(
                                            'Нет',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Ink(
                                  width: 0.5,
                                  height: 37,
                                  color: Color(0xff9A9A9A),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Договорная',
                                      style: TextStyle(
                                        color: Color(0xff9A9A9A),
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    widget.post.auction
                                        ? Text(
                                            'Да',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        : Text(
                                            'Нет',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.post.halal != null) SizedBox(height: 50),
                    if (widget.post.halal != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Сертификат',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4A564A),
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Проверено',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff87C440),
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset('assets/icons/category/halal.svg'),
                        ],
                      ),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                      decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                      ),
                      child: ListTile(
                        title: Text(
                          'Описание',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff4A564A),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            SizedBox(height: 15),
                            Text(
                              '${widget.post.description}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Color(0xff4A564A).withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 110,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.15),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xffC5C5C5),
                              ),
                              image: DecorationImage(
                                image: widget.post.user.image != null
                                    ? NetworkImage(widget.post.user.image)
                                    : AssetImage(
                                        'assets/images/avatar.png',
                                      ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 3),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MyPostsScreen(
                                                  commentRepository:
                                                      widget.commentRepository,
                                                  currentUser:
                                                      widget.currentUser,
                                                  listPosts: userPosts,
                                                  postRepository:
                                                      widget.postRepository,
                                                  authRepository:
                                                      widget.authRepository,
                                                  listCategories:
                                                      widget.listCategories,
                                                  listCities: widget.listCities,
                                                  isPost: 'MyPost',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Автор объявления',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff9A9A9A),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          '${widget.post.user.firstName}',
                                          style: TextStyle(
                                            color: Color(0xff4A564A),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                _start
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            _start = !_start;
                                          });
                                        },
                                        child: Text(
                                          'Оставить отзыв',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff828282),
                                          ),
                                        ),
                                      )
                                    : SmoothStarRating(
                                        allowHalfRating: false,
                                        onRated: (v) {},
                                        starCount: 5,
                                        size: 30,
                                        isReadOnly: false,
                                        color: Colors.yellowAccent
                                            .withOpacity(0.8),
                                        borderColor: Colors.yellowAccent
                                            .withOpacity(0.5),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        title: Text(
                          'Комментарии',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff4A564A),
                          ),
                        ),
                        subtitle: Container(
                          child: Column(
                            children: [
                              SizedBox(height: 25),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mode_comment_outlined,
                                          color: Color(0xffC8C8C8),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Опубликовать комментарий",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff828282),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: sendPost ? 2 : 1,
                                          child: Container(
                                            height: 40,
                                            color: Color(0xffD9D9D9)
                                                .withOpacity(0.48),
                                            child: TextField(
                                              controller: _commentController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText:
                                                    "Добавить коммента.....",
                                                hintStyle: TextStyle(
                                                  color: Color(0xffA4A4A4),
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: sendPost
                                              ? InkWell(
                                                  onTap: () {
                                                    if (_commentController.text
                                                            .trim() !=
                                                        "") {
                                                      setState(() {
                                                        _listCommentsByPost
                                                            .clear();
                                                        addComment(
                                                            _commentController
                                                                .text);
                                                      });
                                                      _commentController
                                                          .clear();
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    color: Color(0xff00BF97)
                                                        .withOpacity(0.5),
                                                    child: Center(
                                                      child: Text(
                                                        'Отправить',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (_commentController.text
                                                              .trim() !=
                                                              "") {
                                                            setState(() {
                                                              _listCommentsByPost
                                                                  .clear();
                                                              updateComment(
                                                                  _commentController
                                                                      .text,updateCommentId.toString());
                                                            });
                                                            _commentController
                                                                .clear();
                                                            sendPost = true;
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          color: Color(
                                                                  0xff00BF97)
                                                              .withOpacity(0.5),
                                                          child: Center(
                                                            child: Text(
                                                              'Отправить',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _commentController
                                                                .clear();
                                                            sendPost = true;
                                                            updateCommentId = 0;
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          color: Colors
                                                              .redAccent
                                                              .withOpacity(0.5),
                                                          child: Center(
                                                            child: Text(
                                                              'Отменить',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                child: _loading
                                    ? Container(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      )
                                    : Container(
                                        child: (_listComments?.length !=
                                                    null) &&
                                                (_listCommentsByPost?.length !=
                                                    0)
                                            ? Container(
                                                height: 170,
                                                child: ListView.builder(
                                                  itemBuilder:
                                                      (context, index) =>
                                                          CommentComponent(
                                                    comment:
                                                        _listCommentsByPost[
                                                            index],
                                                    currentUser:
                                                        widget.currentUser,
                                                    deletePress: () {
                                                      setState(() {
                                                        deleteComment(
                                                            _listCommentsByPost[
                                                                    index]
                                                                .id
                                                                .toString());
                                                      });
                                                    },
                                                    commentRepository: widget
                                                        .commentRepository,
                                                    updatePress: () {
                                                      setState(() {
                                                        _commentController
                                                                .text =
                                                            _listCommentsByPost[
                                                                    index]
                                                                .comment;
                                                        sendPost = false;
                                                        updateCommentId = _listCommentsByPost[index].id;
                                                      });
                                                    },
                                                  ),
                                                  itemCount: _listComments
                                                      .where((element) =>
                                                          element.postId ==
                                                          widget.post.id)
                                                      .length,
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Этот автор пока не получил ни одного отзыва.\nСтаньте первым, кто оценит его!',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xff4A564A)
                                                        .withOpacity(0.7),
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 57),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Color(0xff828282), width: 1.5),
                        ),
                      ),
                      child: Text(
                        'Все объявления автора',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff828282),
                        ),
                      ),
                    ),
                    SizedBox(height: 27),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Container(
                                  width: 160,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          launch("https://www.facebook.com");
                                        },
                                        child: Icon(
                                          SocialNetworks.facebook_official,
                                          color: Color(0xff828282),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launch("https://www.twitter.com");
                                        },
                                        child: Icon(
                                          SocialNetworks.twitter,
                                          color: Color(0xff828282),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launch("https://www.instagram.com");
                                        },
                                        child: Icon(
                                          SocialNetworks.instagram,
                                          color: Color(0xff828282),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launch("https://www.google.com");
                                        },
                                        child: Icon(
                                          SocialNetworks.google,
                                          color: Color(0xff828282),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launch("https://www.telegram.com");
                                        },
                                        child: Icon(
                                          SocialNetworks.telegram,
                                          color: Color(0xff828282),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 14),
                                Text(
                                  '${widget.post.views == null ? 0 : widget.post.views} просмотра объявления',
                                  style: TextStyle(
                                    color: Color(0xff828282),
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    side: BorderSide(
                                      color: Color(0xffEAEAEA),
                                      width: 2,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await http.post(
                                        Uri.parse(
                                            "http://api.malsat.kz/api/phone/"),
                                        body: {
                                          "post": "${widget.post.id}",
                                        });
                                    FlutterPhoneDirectCaller.callNumber(
                                        "${widget.post.user.phone}");
                                  },
                                  child: Text(
                                    'ПОЗВОНИТЬ'.toUpperCase(),
                                    style: TextStyle(
                                      color: Color(0xff4A564A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    side: BorderSide(
                                      color: Color(0xffEAEAEA),
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    'Сообщение'.toUpperCase(),
                                    style: TextStyle(
                                      color: Color(0xff4A564A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 37),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> getPosts() async {
    setState(() {
      _loading = true;
    });
    userPosts = await widget.authRepository
        .getPostsByUser(widget.post.user.id.toString());
    setState(() {
      _loading = false;
    });
  }

  Future<void> getComments() async {
    setState(() {
      _loading = true;
    });
    _listComments = await widget.commentRepository?.getComment1();
    setState(() {
      _loading = false;
    });
    for (int i = 0; i < _listComments.length; i++) {
      if (_listComments[i].postId == widget.post.id) {
        _listCommentsByPost.add(new Comment(
          id: _listComments[i].id,
          comment: _listComments[i].comment,
          user: _listComments[i].user,
          postId: _listComments[i].postId,
        ));
      }
    }
  }

  Future<void> addComment(String comment) async {
    await widget.commentRepository
        .addComment(comment, widget.post.id.toString());
    setState(() {
      _loading = true;
    });
    _listComments = await widget.commentRepository?.getComment1();
    setState(() {
      _loading = false;
      _listCommentsByPost.clear();
    });
    for (int i = 0; i < _listComments.length; i++) {
      if (_listComments[i].postId == widget.post.id) {
        _listCommentsByPost.add(new Comment(
          id: _listComments[i].id,
          comment: _listComments[i].comment,
          user: _listComments[i].user,
          postId: _listComments[i].postId,
        ));
      }
    }
  }

  Future<void> deleteComment(String commentId) async {
    await widget.commentRepository.deleteComment(commentId);
    setState(() {
      _loading = true;
    });
    _listComments = await widget.commentRepository?.getComment1();
    setState(() {
      _loading = false;
      _listCommentsByPost.clear();
    });
    for (int i = 0; i < _listComments.length; i++) {
      if (_listComments[i].postId == widget.post.id) {
        _listCommentsByPost.add(new Comment(
          id: _listComments[i].id,
          comment: _listComments[i].comment,
          user: _listComments[i].user,
          postId: _listComments[i].postId,
        ));
      }
    }
  }

  Future<void> updateComment(String comment,String commentId ) async {
    await widget.commentRepository.updateComment(comment,commentId);
    setState(() {
      _loading = true;
    });
    _listComments = await widget.commentRepository?.getComment1();
    setState(() {
      _loading = false;
      _listCommentsByPost.clear();
    });
    for (int i = 0; i < _listComments.length; i++) {
      if (_listComments[i].postId == widget.post.id) {
        _listCommentsByPost.add(new Comment(
          id: _listComments[i].id,
          comment: _listComments[i].comment,
          user: _listComments[i].user,
          postId: _listComments[i].postId,
        ));
      }
    }
  }
}
