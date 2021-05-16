import 'package:flutter/material.dart';

class SearchPostByCity extends StatefulWidget {
  final String text;
  final VoidCallback press;

  const SearchPostByCity({
    Key key,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  @override
  _SearchPostByCityState createState() => _SearchPostByCityState();
}

class _SearchPostByCityState extends State<SearchPostByCity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListTile(
            title: Text(
              widget.text,
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              onPressed: widget.press,
              icon: Icon(Icons.chevron_right),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
