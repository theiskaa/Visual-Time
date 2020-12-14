import 'package:flutter/material.dart';
import 'package:timevisualer/views/screens/addtask.dart';
import 'package:timevisualer/views/widgets/components/custom_appbar.dart';
import 'package:timevisualer/views/widgets/components/custom_fab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Time Visualer",),
      floatingActionButton: buildCustomFAB(context),
      body: buildBody(),
    );
  }

  Center buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        ],
      ),
    );
  }

  CustomFAB buildCustomFAB(BuildContext context) {
    return CustomFAB(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTaskScreen(),
        ),
      ),
    );
  }
}
