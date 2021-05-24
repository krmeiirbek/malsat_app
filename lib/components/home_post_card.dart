import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/constants/custom_icons.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/bookmark_repository.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/screens/post_detail_screen.dart';

class HomePostCard extends StatefulWidget {
  final Post post;
  final List<dynamic> listBookmarks;
  final BookmarkRepository bookmarkRepository;
  final CommentRepository commentRepository;
  final User currentUser;

  const HomePostCard({
    Key key,
    this.post,
    this.listBookmarks,
    this.bookmarkRepository,
    @required this.commentRepository,
    @required this.currentUser,
  })  : assert(commentRepository != null),
        super(key: key);

  @override
  _HomePostCardState createState() => _HomePostCardState();
}

class _HomePostCardState extends State<HomePostCard> {
  bool inFavorite = false;

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPost(
                  post: widget.post,
                  listBookmarks: widget.listBookmarks,
                  commentRepository: widget.commentRepository,
                  currentUser: widget.currentUser,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
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
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.network(
                          widget.post.getImage(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.post.date.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFFB5B5B5),
                                  fontSize: 8,
                                ),
                              ),
                              Text(
                                '${widget.post.price}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF6C6C6C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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
