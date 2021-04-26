import 'package:flutter/material.dart';
import 'package:malsat_app/components/home_post_card.dart';
import 'package:malsat_app/components/material_button.dart';
import 'package:malsat_app/constants/custom_icons.dart';

class HomeScreen extends StatelessWidget {
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
                SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F1F1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Поиск объявлений',
                      hintStyle: TextStyle(
                        color: Color(0xFF4A564A).withOpacity(0.4),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF4A564A).withOpacity(0.4),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Button1(text: "Фильтры", press: () {}),
                      SizedBox(width: 20),
                      Button1(text: "Все объявлений", press: () {}),
                      SizedBox(width: 20),
                      Button1(text: "Весь Казахстан", press: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
              child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        HomePostCard(
                          image: 'assets/images/card.png',
                          title: 'Продам быка',
                          date: '23.04.2021',
                          price: '200000 тг',
                        ),
                        HomePostCard(
                          image: 'assets/images/card.png',
                          title: 'Продам быка',
                          date: '23.04.2021',
                          price: '200000 тг',
                        ),
                        HomePostCard(
                          image: 'assets/images/card.png',
                          title: 'Продам быка',
                          date: '23.04.2021',
                          price: '200000 тг',
                        ),
                        HomePostCard(
                          image: 'assets/images/card.png',
                          title: 'Продам быка',
                          date: '23.04.2021',
                          price: '200000 тг',
                        ),
                        HomePostCard(
                          image: 'assets/images/card.png',
                          title: 'Продам быка',
                          date: '23.04.2021',
                          price: '200000 тг',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
