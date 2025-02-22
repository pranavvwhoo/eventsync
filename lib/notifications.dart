import 'package:flutter/material.dart';
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF325372),
        title: Text('Notifications',style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 20,),),
      ),
      body: Center(
        child: Text('Notifications Screen'),
      ),
    );
  }
}