import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/constants/custom_icons.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/screens/post_detail_screen.dart';

class FavoritePostCard extends StatefulWidget {
  final Post post;
  final User currentUser;
  final CommentRepository commentRepository;

  const FavoritePostCard({
    Key key,
    @required this.post,
    this.currentUser,
    this.commentRepository,
  }) : super(key: key);

  @override
  _FavoritePostCardState createState() => _FavoritePostCardState();
}

class _FavoritePostCardState extends State<FavoritePostCard> {
  bool inFavorite = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPost(
                  commentRepository: widget.commentRepository,
                  currentUser: widget.currentUser,
                  post: widget.post,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: Image.network(
                        widget.post.getImage(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.post.title,
                              style: TextStyle(
                                color: Color(0xFFEA5E3C),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 30,
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
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(UpdateBookMarks(
                                          postId: widget.post.id,
                                          inBookmarks: false,
                                          openScreen: 3));
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.post.date.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xFFB5B5B5), fontSize: 12),
                            ),
                            Text(
                              widget.post.price.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF6C6C6C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
