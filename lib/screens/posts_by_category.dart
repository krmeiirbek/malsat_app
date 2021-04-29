import 'package:flutter/material.dart';
import 'package:malsat_app/components/home_post_card.dart';
import 'package:malsat_app/pages/home_page.dart';

class PostByCategory extends StatelessWidget {
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
          onPressed: () =>
            Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              color: Colors.white,
              child: Column(
                children: [
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
      ),
    );
  }
}
