import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  final List<dynamic> listCities;
  final List<dynamic> listCategories;

  const CreatePostScreen({Key key, this.listCities, this.listCategories}) : super(key: key);
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = true;

  String dropValue;
  String dropValue2;

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
                      'Новое объявление',
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
                      'Заголовок*',
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
                        decoration: InputDecoration(
                          hintText: 'Введите заголовок',
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
                      'Категория*',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xff4A564A),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: DropdownButton(
                        hint: Text('Categories'),
                        isExpanded: true,
                        value: dropValue,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xffA8A8A8),
                          size: 15,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropValue = newValue;
                          });
                        },
                        items: widget.listCategories
                            .map(
                              (valueItem) => DropdownMenuItem(
                                value: valueItem.name,
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
                          'Описание*',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff4A564A),
                          ),
                        ),
                        SizedBox(width: 7),
                        Text(
                          '(минимум 20 символов)',
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
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText:
                                'Расскажите об особенностях питомца или товара. ',
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
                      'Цена*',
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
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                              'Договорная цена',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff4A564A),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            CupertinoSwitch(
                              value: isSwitched1,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched1 = value;
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
                              'Обмен',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff4A564A),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            CupertinoSwitch(
                              value: isSwitched2,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched2 = value;
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
                              'Возможна доставка',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff4A564A),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            CupertinoSwitch(
                              value: isSwitched3,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched3 = value;
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
                      'Добавьте фотографии',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4A564A),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Объявления с фотографиями получают до 5 раз больше откликов',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffB2B2B2),
                      ),
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff00BF97),
                          minimumSize: Size(double.infinity, 45)),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Добавить фото',
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
                      'Местоположение',
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
                          'Регион',
                          style: TextStyle(
                            color: Color(0xffD2D2D2),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          child: DropdownButton(
                            hint: Text(
                              'Выбрать',
                              style: TextStyle(
                                color: Color(0xFFEA5E3C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            isExpanded: true,
                            value: dropValue2,
                            icon: InkWell(
                              onTap: () {
                                setState(() {
                                  dropValue2 = null;
                                });
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Color(0xff4A564A),
                                size: 20,
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                dropValue2 = newValue;
                              });
                            },
                            items: widget.listCities
                                .map(
                                  (valueItem) => DropdownMenuItem(
                                    value: valueItem.name,
                                    child: Text(valueItem.name),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Адрес',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4A564A),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextField(
                            maxLength: 70,
                            decoration: InputDecoration(
                              hintText: 'Не более 70 знаков',
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff00BF97),
                              minimumSize: Size(double.infinity, 45)),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Продолжить',
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
    );
  }
}
