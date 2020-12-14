class Occurrence {
  List<int> dPerWeek;
  List<DateTime> time;
  bool repeatOccurrence = false;

  Occurrence(List<int> dPerWeek, List<DateTime> time, bool repeatOccurrence) {
    this.dPerWeek = dPerWeek;
    this.time = time;
    this.repeatOccurrence = repeatOccurrence;
  }
}
