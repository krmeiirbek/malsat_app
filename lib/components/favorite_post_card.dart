import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malsat_app/constants/custom_icons.dart';

class FavoritePostCard extends StatefulWidget {
  final String image;
  final String title;
  final String date;
  final String price;

  const FavoritePostCard({
    Key key,
    @required this.image,
    @required this.title,
    @required this.date,
    @required this.price,
  }) : super(key: key);

  @override
  _FavoritePostCardState createState() => _FavoritePostCardState();
}

class _FavoritePostCardState extends State<FavoritePostCard> {
  bool inFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Image.asset(
                  widget.image,
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
                        widget.title,
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
                        style:
                            TextStyle(color: Color(0xFFB5B5B5), fontSize: 12),
                      ),
                      Text(
                        widget.price,
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
    );
  }
}
