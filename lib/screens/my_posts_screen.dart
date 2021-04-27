import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malsat_app/components/favorite_post_card.dart';

class MyPostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              // color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFFEA5E3C),
                            size: 30,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Image(
                          image: AssetImage("assets/images/MALSAT.png"),
                        ),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                  // SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child:
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 5),
                          Text(
                            'Мои объявления',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A564A)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height:MediaQuery.of(context).size.height*0.8,
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context,index)=>
                              FavoritePostCard(
                                image: 'assets/images/card.png',
                                title: 'Продам быка',
                                date: '23.04.2021',
                                price: '200000 тг',
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ),/
            ),
          ],
        ),
      ),
    );
  }
}