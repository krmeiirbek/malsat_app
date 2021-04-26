import 'package:flutter/material.dart';
import 'package:malsat_app/components/favorite_post_card.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            // color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Color(0xFFEA5E3C),
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Image(
                        image: AssetImage("assets/images/MALSAT.png"),
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
                // SizedBox(height: 20),
              ],
            ),
          ),
          // Expanded(
          // SingleChildScrollView(
          //   child:
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
                        'Избранное',
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
                    height:560,
                    // child: ListView.builder(
                    //   itemCount: 20,
                    //   itemBuilder: (context,index)=>
                    //       getFavorite(),
                    // ),
                  ),
                ],
              ),
            ),
          ),
          // ),/
          ),
        ],
      ),
    );
  }
}
