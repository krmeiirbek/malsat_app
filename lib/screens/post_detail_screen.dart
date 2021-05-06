import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malsat_app/constants/custom_icons.dart';
import 'package:malsat_app/models/post.dart';

class DetailPost extends StatelessWidget {
  final Post post;

  const DetailPost({Key key, this.post}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/images/card_big.png",
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
                            '${post.categories.name}',
                            style: TextStyle(
                              color: Color(0xFF4A564A).withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(
                            Custom.heart_empty,
                            color: Color(0xff4A564A).withOpacity(0.3),
                            size: 19,
                          )
                        ],
                      ),
                      Text(
                        '${post.title}',
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                            child: Text(
                          '${post.price}',
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
                          '${post.cities.name} | Добавлено: 13 марта 2021',
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
                                post.exchange
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
                                post.delivery
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
                                post.auction
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
                          '${post.description}',
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
                            image: post.user.image != null
                                ? NetworkImage(post.user.image)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 3),
                                    Text(
                                      'Автор объявления',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff9A9A9A),
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      '${post.user.firstName}',
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
                            Text(
                              'Оставить отзыв',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff828282),
                              ),
                            )
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
                  child: Text(
                    'Этот автор пока не получил ни одного отзыва.\nСтаньте первым, кто оценит его!',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff4A564A).withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 57),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xff828282), width: 1.5),
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
                                  Icon(
                                    Icons.wallet_giftcard,
                                    color: Color(0xff828282),
                                  ),
                                  Icon(
                                    Icons.wallet_giftcard,
                                    color: Color(0xff828282),
                                  ),
                                  Icon(
                                    Icons.wallet_giftcard,
                                    color: Color(0xff828282),
                                  ),
                                  Icon(
                                    Icons.wallet_giftcard,
                                    color: Color(0xff828282),
                                  ),
                                  Icon(
                                    Icons.wallet_giftcard,
                                    color: Color(0xff828282),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 14),
                            Text(
                              '${post.views} просмотра объявления',
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
                              onPressed: () {},
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
      ),
    );
  }
}
