import 'package:flutter/material.dart';
import 'package:malsat_app/models/comment.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/comment_repository.dart';

class CommentComponent extends StatefulWidget {
  final Comment comment;
  final User currentUser;
  final CommentRepository commentRepository;
  final VoidCallback deletePress;
  final VoidCallback updatePress;
  final VoidCallback otvetPress;

  const CommentComponent({
    Key key,
    @required this.comment,
    @required this.currentUser,
    @required this.commentRepository,
    @required this.deletePress,
    @required this.updatePress,
    @required this.otvetPress,
  }) : super(key: key);

  @override
  _CommentComponentState createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: widget.comment.user.image == null
                      ? AssetImage(
                          "assets/images/nouser.png",
                        )
                      : NetworkImage(widget.comment.user.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: widget.comment.user.firstName,
                        style: const TextStyle(
                          color: Color(0xff4A564A),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: ' ' + widget.comment.comment,
                            style: const TextStyle(
                              color: Color(0xff4A564A),
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4A564A),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: widget.otvetPress,
                          child: Text(
                            'Ответить',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xffA4A4A4),
                            ),
                          ),
                        ),
                        if (widget.comment.user.id == widget.currentUser.id)
                          InkWell(
                            onTap: widget.deletePress,
                            child: Text(
                              'Удалить',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xffA4A4A4),
                              ),
                            ),
                          ),
                        if (widget.comment.user.id == widget.currentUser.id)
                          InkWell(
                            onTap: widget.updatePress,
                            child: Text(
                              'Редактировать',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xffA4A4A4),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
