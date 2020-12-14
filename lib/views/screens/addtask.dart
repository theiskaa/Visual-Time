import 'package:flutter/material.dart';
import 'package:timevisualer/views/widgets/components/create_button.dart';
import 'package:timevisualer/views/widgets/components/custom_appbar.dart';
import 'package:timevisualer/views/widgets/components/custom_checkbox.dart';
import 'package:timevisualer/views/widgets/components/custom_textfield.dart';
import 'package:timevisualer/views/widgets/components/settime_button.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final fromKey = GlobalKey<FormState>();
  String taskTitle = "";
  List<int> days = [];
  Future<TimeOfDay> timeDayTo;
  Future<TimeOfDay> timeDayFrom;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;

  void createTask() async {
    for (int day in days) {
      print(day);
    }
    DateTime now = DateTime.now();
    DateTime startTime;
    DateTime endTime;

    await timeDayFrom.then(
      (value) => startTime = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        value.hour,
        value.minute,
      ),
    );

    await timeDayTo.then(
      (value) => endTime = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        value.hour,
        value.minute,
      ),
    );

    List<DateTime> times = [];
    times.add(startTime);
    times.add(endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildCustomAppBar(context),
      body: buildBody(),
      bottomNavigationBar: builBottomCreateButton(),
    );
  }

  CreateButton builBottomCreateButton() => CreateButton(
        title: "Create Task",
        onTap: () {
          if (fromKey.currentState.validate()) {
            if (this.days.length > 0 &&
                this.timeDayFrom != null &&
                this.timeDayTo != null) {
// So do something
// Create task method and navigator to context
            }
          }
        },
      );

  CustomAppBar buildCustomAppBar(BuildContext context) {
    return CustomAppBar(
      title: "Create Visual",
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Form(
          key: fromKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              buildTitleField(),
              SizedBox(height: 50),
              buildChecksBody(),
              SizedBox(height: 50),
              buildSetTimesBody(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildSetTimesBody() {
    return Column(
      children: [
        buildTitleText("Set times:"),
        SizedBox(height: 23),
        buildButtons()
      ],
    );
  }

  Column buildButtons() {
    return Column(
      children: [
        SetTimeButton(
          title: "Set start time",
          time: "12:23 PM",
          textColor: Colors.white,
          backgorundColor: Colors.black,
          borderColor: Colors.black,
          onTap: () {
            timeDayFrom = showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
          },
        ),
        SizedBox(height: 15),
        SetTimeButton(
          title: "Set end time",
          time: "18:00 PM",
          textColor: Colors.black,
          backgorundColor: Colors.transparent,
          borderColor: Colors.black,
          onTap: () {
            timeDayTo = showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
          },
        ),
      ],
    );
  }

  Column buildChecksBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTitleText("Choise Days:"),
        SizedBox(height: 23),
        firstCheckList(),
        SizedBox(height: 10),
        buildSeccondCheckList(),
      ],
    );
  }

  Widget buildTitleText(String title) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "$title",
        style: TextStyle(
          color: Colors.black,
          fontSize: 23,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Row buildSeccondCheckList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ///
        ///
        ///
        CustomCheckBox(
          title: "Friday",
          val: friday,
          onChanged: (val) {
            if (!this.days.contains(4)) {
              this.days.add(4);
            } else {
              this.days.remove(4);
            }
            setState(() {
              friday = val;
            });
          },
        ),

        ///
        ///
        ///
        CustomCheckBox(
          title: "Saturday",
          val: saturday,
          onChanged: (val) {
            if (!this.days.contains(5)) {
              this.days.add(5);
            } else {
              this.days.remove(5);
            }
            setState(() {
              saturday = val;
            });
          },
        ),

        ///
        ///
        ///
        CustomCheckBox(
          title: "Sunday",
          val: sunday,
          onChanged: (val) {
            if (!this.days.contains(6)) {
              this.days.add(6);
            } else {
              this.days.remove(6);
            }
            setState(() {
              sunday = val;
            });
          },
        ),
      ],
    );
  }

  Row firstCheckList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ///
        ///
        ///
        CustomCheckBox(
          title: "Monday",
          val: monday,
          onChanged: (val) {
            if (!this.days.contains(0)) {
              this.days.add(0);
            } else {
              this.days.remove(0);
            }
            setState(() {
              monday = val;
            });
          },
        ),

        ///
        ///
        ///
        CustomCheckBox(
          title: "Tuesday",
          val: tuesday,
          onChanged: (val) {
            if (!this.days.contains(1)) {
              this.days.add(1);
            } else {
              this.days.remove(1);
            }
            setState(() {
              tuesday = val;
            });
          },
        ),

        ///
        ///
        ///
        CustomCheckBox(
          title: "Wednesday",
          val: wednesday,
          onChanged: (val) {
            if (!this.days.contains(2)) {
              this.days.add(2);
            } else {
              this.days.remove(2);
            }
            setState(() {
              wednesday = val;
            });
          },
        ),

        ///
        ///
        ///
        CustomCheckBox(
          title: "Thursday",
          val: thursday,
          onChanged: (val) {
            if (!this.days.contains(3)) {
              this.days.add(3);
            } else {
              this.days.remove(3);
            }
            setState(() {
              thursday = val;
            });
          },
        ),
      ],
    );
  }

  Widget buildTitleField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        hint: "Title",
        lineCount: 1,
        validation: (val) {
          if (val.isEmpty) {
            return "Please type something";
          }
        },
        onChanged: (val) {
          setState(() {
            taskTitle = val;
          });
        },
      ),
    );
  }
}
