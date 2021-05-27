import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malsat_app/components/review_component.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/models/review.dart';
import 'package:malsat_app/repositories/review_repository.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewScreen extends StatefulWidget {
  final Post post;
  final ReviewRepository reviewRepository;

  const ReviewScreen({
    Key key,
    @required this.post,
    @required this.reviewRepository,
  }) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rate = 0.0;
  TextEditingController _editingController = TextEditingController();
  List<Review> _listReview;
  List<Review> _listReviewByAuthor = [];
  bool _loading = false;
  double aveRate = 0.0;
  int sumOfRates = 0;

  @override
  void initState() {
    getReviews(widget.post.user.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: double.infinity,
                height: 350,
                color: Colors.blueGrey,
              ),
            ),
            Positioned(
              top: -380,
              left: -187,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset('assets/images/MALSAT.png'),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(36),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 18),
                        Text(
                          'Оставить отзыв',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36),
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: widget.post.user.image == null
                              ? AssetImage(
                                  "assets/images/nouser.png",
                                )
                              : NetworkImage(widget.post.user.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      widget.post.user.firstName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.black54,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Rate\n',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: aveRate.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black54,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmoothStarRating(
                          allowHalfRating: false,
                          rating: _rate,
                          onRated: (v) {
                            setState(() {
                              _rate = v;
                            });
                          },
                          starCount: 5,
                          size: 30,
                          isReadOnly: false,
                          color: Colors.lightBlueAccent.withOpacity(0.8),
                          borderColor: Colors.blue.withOpacity(0.5),
                        ),
                        (_rate?.toInt()) == 0
                            ? Icon(
                                Icons.done,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.done,
                                color: Colors.blue,
                              ),
                      ],
                    ),
                    SizedBox(height: 18),
                    if (_rate > 0)
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 15,
                                  offset: const Offset(0.0, 15.0),
                                  color: Colors.black.withAlpha(20),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _editingController,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Comment',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {
                              {
                                if (_editingController.text.trim() != "") {
                                  setState(() {
                                    _listReviewByAuthor.clear();
                                    addReview(
                                      _editingController.text,
                                      _rate.toInt().toString(),
                                      widget.post.user.id.toString(),
                                    );
                                    _editingController.clear();
                                    _rate = 0.0;
                                  });
                                }
                              }
                            },
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0),
                            ),
                            color: Color(0xFF00BF97),
                            child: Text(
                              'Оценить',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    Container(
                      child: _loading
                          ? Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                            )
                          : Container(
                              child: (_listReview?.length != null) &&
                                      (_listReviewByAuthor?.length != 0)
                                  ? Container(
                                      height: 170,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            ReviewComponent(
                                                review:
                                                    _listReviewByAuthor[index]),
                                        itemCount: _listReview
                                            .where((element) =>
                                                element.author ==
                                                widget.post.user.id)
                                            .length,
                                      ),
                                    )
                                  : Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Этот автор пока не получил ни одного отзыва.\nСтаньте первым, кто оценит его!',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
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
          ],
        ),
      ),
    );
  }

  Future<void> getReviews(String author) async {
    setState(() {
      _loading = true;
    });
    _listReview = await widget.reviewRepository?.getReviews(author);
    setState(() {
      _loading = false;
      _listReviewByAuthor.clear();
      sumOfRates = 0;
      aveRate = 0.0;
    });
    for (int i = 0; i < _listReview.length; i++) {
      if (_listReview[i].author == widget.post.user.id) {
        sumOfRates++;
        aveRate += _listReview[i].mark;
        _listReviewByAuthor.add(new Review(
          id: _listReview[i].id,
          comment: _listReview[i].comment,
          user: _listReview[i].user,
          author: _listReview[i].author,
          mark: _listReview[i].mark,
        ));
      }
    }
    setState(() {
      if (sumOfRates != 0) aveRate /= sumOfRates.toDouble();
    });
  }

  Future<void> addReview(String comment, String mark, String author) async {
    await widget.reviewRepository.addReview(comment, author, mark);
    setState(() {
      _loading = true;
    });
    _listReview = await widget.reviewRepository?.getReviews(author);
    setState(() {
      _loading = false;
      _listReviewByAuthor.clear();
      sumOfRates = 0;
      aveRate = 0.0;
    });
    for (int i = 0; i < _listReview.length; i++) {
      if (_listReview[i].author == widget.post.user.id) {
        sumOfRates++;
        aveRate += _listReview[i].mark;
        _listReviewByAuthor.add(new Review(
          id: _listReview[i].id,
          comment: _listReview[i].comment,
          user: _listReview[i].user,
          author: _listReview[i].author,
          mark: _listReview[i].mark,
        ));
      }
    }
    setState(() {
      if (sumOfRates != 0) aveRate /= sumOfRates.toDouble();
    });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 170);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
