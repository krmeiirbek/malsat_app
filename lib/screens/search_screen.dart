import 'package:flutter/material.dart';
import 'package:malsat_app/components/favorite_post_card.dart';
import 'package:malsat_app/components/search_category_conpanent.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(flex: 3,),
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(
                      'Все категории',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF888888)),
                    ),
                  ],
                ),
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
                          'Категории',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A564A)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height:MediaQuery.of(context).size.height*0.7,
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context,index)=>
                            SearchCategoryCompanent(
                              text: 'Продам быка',
                              press: (){},
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
    );
  }
}

