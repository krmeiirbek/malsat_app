import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/constants/custom_icons.dart';
import 'package:malsat_app/constants/social_networks_icons.dart';
import 'package:malsat_app/models/post.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;

class DetailPost extends StatefulWidget {
  final Post post;
  final List<dynamic> listBookmarks;

  const DetailPost({Key key, this.post, this.listBookmarks}) : super(key: key);

  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
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
}
