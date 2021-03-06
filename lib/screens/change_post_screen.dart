import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/repositories/post_repository.dart';

class ChangePostScreen extends StatefulWidget {
  final List<City> listCities;
  final List<Category> listCategories;
  final PostRepository postRepository;
  final Post post;

  const ChangePostScreen({
    Key key,
    this.listCities,
    this.listCategories,
    this.postRepository,
    this.post,
  }) : super(key: key);

  @override
  _ChangePostScreenState createState() =>
      _ChangePostScreenState(listCities: listCities);
}

class _ChangePostScreenState extends State<ChangePostScreen> {
  final List<dynamic> listCities;
  List<dynamic> cities;

  _ChangePostScreenState({this.listCities});

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  bool auction = false;
  bool exchange = false;
  bool delivery = true;

  String selectedCategoryName;
  int selectedCategoryId;
  String selectedCity;
  int selectedCityId;

  List<String> _imageFiles = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _titleController.text = widget.post.title;
    selectedCategoryId = widget.post.categories.id;
    selectedCityId = widget.post.cities.id;
    _descriptionController.text = widget.post.description;
    _priceController.text = widget.post.price.toString();
    auction = widget.post.auction;
    exchange = widget.post.exchange;
    delivery = widget.post.delivery;
    cities = listCities;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        height: 30,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Image(
                          image: AssetImage("assets/images/MALSAT.png"),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '?????????? ????????????????????',
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '??????????????????*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff4A564A),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F1F1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: '?????????????? ??????????????????',
                            hintStyle: TextStyle(
                              color: Color(0xFF4A564A).withOpacity(0.4),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 29),
                      Text(
                        '??????????????????*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff4A564A),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        child: DropdownButtonFormField(
                          hint: Text(widget.post.categories.name),
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xffA8A8A8),
                            size: 15,
                          ),
                          onChanged: (newValue) {
                            selectedCategoryId = newValue.id;
                          },
                          items: widget.listCategories
                              .map(
                                (valueItem) => DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem.name),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            '????????????????*',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xff4A564A),
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            '(?????????????? 20 ????????????????)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffB2B2B2),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F1F1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Container(
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: 6,
                            decoration: InputDecoration(
                              hintText:
                                  '???????????????????? ???? ???????????????????????? ?????????????? ?????? ????????????. ',
                              hintStyle: TextStyle(
                                color: Color(0xffB2B2B2),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF3F3F3),
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '????????*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xff4A564A),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Color(0xFFB2B2B2),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffF3F3F3),
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '???????????????????? ????????',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A564A),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              CupertinoSwitch(
                                value: auction,
                                onChanged: (value) {
                                  setState(() {
                                    auction = value;
                                  });
                                },
                                activeColor: Color(0xff4CD964),
                                trackColor: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '??????????',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A564A),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              CupertinoSwitch(
                                value: exchange,
                                onChanged: (value) {
                                  setState(() {
                                    exchange = value;
                                  });
                                },
                                trackColor: Colors.white,
                                activeColor: Color(0xff4CD964),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '???????????????? ????????????????',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff4A564A),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              CupertinoSwitch(
                                value: delivery,
                                onChanged: (value) {
                                  setState(() {
                                    delivery = value;
                                  });
                                },
                                activeColor: Color(0xff4CD964),
                                trackColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Text(
                        '???????????????? ????????????????????',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4A564A),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '???????????????????? ?? ???????????????????????? ???????????????? ???? 5 ?????? ???????????? ????????????????',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color(0xffB2B2B2),
                        ),
                      ),
                      SizedBox(height: 25),
                      imagesThatAdded(),
                      SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff00BF97),
                            minimumSize: Size(double.infinity, 45)),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '???????????????? ????????',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        '????????????????????????????',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4A564A),
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '????????????',
                            style: TextStyle(
                              color: Color(0xffD2D2D2),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                            child: DropdownButtonFormField(
                              hint: Text(
                                widget.post.cities.name,
                                style: TextStyle(
                                  color: Color(0xFFEA5E3C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              isExpanded: true,
                              // value: selectedCity,
                              icon: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCity = null;
                                    selectedCityId = null;
                                  });
                                },
                                child: Icon(
                                  Icons.cancel_outlined,
                                  color: Color(0xff4A564A),
                                  size: 20,
                                ),
                              ),
                              onChanged: (newValue) {
                                selectedCityId = newValue.id;
                              },
                              items: cities
                                  .map(
                                    (valueItem) => DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem.name),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 25),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff00BF97),
                                minimumSize: Size(double.infinity, 45)),
                            onPressed: () async {
                              print(widget.post.id);
                              bool added =
                                  await widget.postRepository.updatePost(
                                citiesId: '$selectedCityId',
                                description: '${_descriptionController.text}',
                                categoriesId: '$selectedCategoryId',
                                price: '${_priceController.text}',
                                title: '${_titleController.text}',
                                auction: auction ? 'True' : 'False',
                                delivery: delivery ? 'True' : 'False',
                                exchange: exchange ? 'True' : 'False',
                                postId: widget.post.id.toString(),
                              );
                              if (added) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Post Updated'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                setState(() {
                                  Navigator.pop(context);
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '????????????????????',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imagesThatAdded() {
    return _imageFiles.length == 0
        ? SizedBox()
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _imageFiles.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 80,
                    color: Colors.grey,
                    child: Stack(
                      children: [
                        Image(
                          image: FileImage(File(_imageFiles[index])),
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _imageFiles.removeAt(index);
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Choose photo",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera,
                  color: Colors.black,
                ),
                label: Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                label: Text(
                  "Gallery",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFiles.add(pickedFile.path);
    });
  }
}
