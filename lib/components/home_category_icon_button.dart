import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback press;

  const CategoryButton({
    Key key,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xffF3F3F3).withOpacity(0.8)
              : Colors.transparent,
          border: Border.all(color: Color(0xffF3F3F3)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(widget.icon)
      ),
    );
  }
}
