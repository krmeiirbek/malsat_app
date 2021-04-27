import 'package:flutter/material.dart';
import 'package:malsat_app/constants/custom_icons.dart';

class HomePostCard extends StatefulWidget {
  final String image;
  final String title;
  final String date;
  final String price;

  const HomePostCard({
    Key key,
    @required this.image,
    @required this.title,
    @required this.date,
    @required this.price,
  }) : super(key: key);

  @override
  _HomePostCardState createState() => _HomePostCardState();
}

class _HomePostCardState extends State<HomePostCard> {
  bool inFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.title,
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
                            print('er');
                            setState(() {
                              inFavorite = !inFavorite;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.date,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFFB5B5B5),
                            fontSize: 8,
                          ),
                        ),
                        Text(
                          widget.price,
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
    );
  }
}
