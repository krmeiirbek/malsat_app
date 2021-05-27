import 'package:flutter/material.dart';
import 'package:malsat_app/models/review.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewComponent extends StatefulWidget {
  final Review review;

  const ReviewComponent({
    Key key,
    @required this.review,
  }) : super(key: key);

  @override
  _ReviewComponentState createState() => _ReviewComponentState();
}

class _ReviewComponentState extends State<ReviewComponent> {
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
                  image: widget.review.user.image == null
                      ? AssetImage(
                          "assets/images/nouser.png",
                        )
                      : NetworkImage('http://api.malsat.kz'+widget.review.user.image),
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
                        text: widget.review.user.firstName,
                        style: const TextStyle(
                          color: Color(0xff4A564A),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: ' ' + widget.review.comment,
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
                    SmoothStarRating(
                      allowHalfRating: false,
                      isReadOnly: true,
                      onRated: (v) {},
                      rating: widget.review.mark.toDouble(),
                      starCount: 5,
                      size: 30,
                      color: Colors.yellowAccent.withOpacity(0.8),
                      borderColor: Colors.yellow,
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
