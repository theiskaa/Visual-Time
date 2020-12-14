import 'package:timevisualer/core/model/occurrence_model.dart';

class TaskModel {
  String name;
  List<Occurrence> occurrence;

  TaskModel(String taskName) {
    this.name = taskName;
    this.occurrence = [];
  }

  void setTaskName(String taskName) {
    this.name = taskName;
  }

  String getTaskName() {
    return this.name;
  }

  void removeOccurenceForDayID(int dayID) {
    for (Occurrence occurrence in this.occurrence) {
      if (occurrence.dPerWeek.contains(dayID)) {
        occurrence.dPerWeek.remove(dayID);
      }
    }
  }

  void createOccurence(
      List<int> dPerWeek, List<DateTime> time, bool repeatOccurrence) {
    for (Occurrence occurrence in this.occurrence) {
      if (occurrence.dPerWeek.contains(occurrence)) {
        //
      } else {
        //
      }
    }
    this.occurrence.add(Occurrence(dPerWeek, time, repeatOccurrence));
  }
}

// class TaskModel {
//   String name;
//   List<Occurrence> occurrence;

//   TaskModel(String name) {
//     this.name = name;
//     occurrence = [];
//   }

//   String getTaskName() {
//     return this.name;
//   }

//   void setTaskName(String taskname) {
//     this.name = taskname;
//   }

//   void removeOccurence(int dayID) {
//     for (Occurrence occurrence in this.occurrence) {
//       if (occurrence.dPerWeek.contains(dayID)) {
//         occurrence.dPerWeek.remove(dayID);
//       }
//     }
//   }

//   void addOccurrence(
//     List<int> dPerWeek,
//     List<DateTime> time,
//     bool repeatOccurrence,
//   )
//   {
//     for (Occurrence occurrence in this.occurrence) {
//       if (occurrence.dPerWeek.contains(this.occurrence)) {
//         print("======= Don't add new occurence so return just null =======");
//       } else {
//         print("======= It's Already Had =======");
//       }
//     }
//     this.occurrence.add(Occurrence(dPerWeek, time, repeatOccurrence));
//   }

// }
