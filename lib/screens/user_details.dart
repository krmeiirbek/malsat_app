import 'package:flutter/material.dart';
import 'package:malsat_app/models/user.dart';

class UserDetailsScreen extends StatelessWidget {
  final User currentUser;

  const UserDetailsScreen({Key key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFEA5E3C),
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Контактные данные',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: currentUser.image == null
                        ? AssetImage(
                            "assets/images/nouser.png",
                          )
                        : NetworkImage(currentUser.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: Text('Имя: ')),
                  Expanded(flex: 2,child: Text(currentUser.firstName)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: Text('Email: ')),
                  Expanded(flex: 2,child: Text(currentUser.email)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: Text('Phone: ')),
                  Expanded(flex: 2,child: Text(currentUser.phone)),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: Text('City: ')),
                  Expanded(flex: 2,child: currentUser.city !=null ? Text(currentUser.city.name) : Text('')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
