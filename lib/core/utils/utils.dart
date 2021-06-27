import 'package:vtime/core/model/day.dart';

import '../vt.dart';

// Standart week days list by [Day] class.
List<Day> weekDays(VT vt, context) {
  return <Day>[
    Day(title: vt.intl.of(context)?.fmt('monday') ?? 'M', name: 'Monday'),
    Day(title: vt.intl.of(context)?.fmt('tuesday') ?? 'T', name: 'Tuesday'),
    Day(title: vt.intl.of(context)?.fmt('wednesday') ?? 'W', name: 'Wednesday'),
    Day(title: vt.intl.of(context)?.fmt('thursday') ?? 'T', name: 'Thursday'),
    Day(title: vt.intl.of(context)?.fmt('friday') ?? 'F', name: 'Friday'),
    Day(title: vt.intl.of(context)?.fmt('saturday') ?? 'S', name: 'Saturday'),
    Day(title: vt.intl.of(context)?.fmt('sunday') ?? 'S', name: 'Sunday'),
  ];
}
