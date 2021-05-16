import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/components/home_category_icon_button.dart';
import 'package:malsat_app/components/home_post_card.dart';
import 'package:malsat_app/components/material_button.dart';
import 'package:malsat_app/constants/category_icons.dart';
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/repositories/post_respository.dart';
import 'package:malsat_app/screens/filter_by_city.dart';

class HomeScreen extends StatefulWidget {
  final List<dynamic> loadedPostsApprovedNotHidden;
  final List<dynamic> listBookmarks;
  final List<dynamic> listCities;
  final List<dynamic> listPostsByCity;
  final AuthRepository authRepository;
  final PostRepository postRepository;

  HomeScreen({
    this.loadedPostsApprovedNotHidden,
    this.listBookmarks,
    this.authRepository,
    this.listCities,
    this.postRepository,
    this.listPostsByCity,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> icons = [
    CategoryIcon.birds,
    CategoryIcon.horse,
    CategoryIcon.camel,
    CategoryIcon.cow,
    CategoryIcon.ram,
  ];

  bool isCategory = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
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
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F1F1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextFormField(
                        controller: _searchController,
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
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(SearchPost(
                                          keyWord: _searchController.text));
                                });
                              },
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Color(0xFF4A564A).withOpacity(0.4),
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Категории",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4A564A),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isCategory = !isCategory;
                            });
                          },
                          child: Text(
                            "смотреть все",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff565656),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isCategory)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CategoryButton(
                                icon: icons[0],
                                press: () {
                                  setState(() {});
                                }),
                            SizedBox(width: 18),
                            CategoryButton(icon: icons[1], press: () {}),
                            SizedBox(width: 18),
                            CategoryButton(icon: icons[2], press: () {}),
                            SizedBox(width: 18),
                            CategoryButton(icon: icons[3], press: () {}),
                            SizedBox(width: 18),
                            CategoryButton(icon: icons[4], press: () {}),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Button1(
                              text: "Фильтры",
                              press: () {
                                setState(() {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(
                                    OpenScreen(openScreen: 1),
                                  );
                                });
                              }),
                          SizedBox(width: 20),
                          Button1(
                              text: "Все объявлений",
                              press: () {
                                setState(() {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LoggedIn(token: ACCESS_TOKEN));
                                });
                              }),
                          SizedBox(width: 20),
                          Button1(
                              text: "Весь Казахстан",
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FilterByCity(
                                              listCities: widget.listCities,
                                              postRepository:
                                                  widget.postRepository,
                                              listPostsByCity:
                                                  widget.listPostsByCity,
                                            )));
                              }),
                          // Icon(icons[1]),
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
                          children: List.generate(
                            widget.loadedPostsApprovedNotHidden.length,
                            (index) => HomePostCard(
                              post: widget.loadedPostsApprovedNotHidden[index],
                              listBookmarks: widget.listBookmarks,
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
        );
      },
    );
  }
}
