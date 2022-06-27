//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:vtime/core/model/day.dart';

import '../vt.dart';

// Standart week days list by [Day] class.
List<Day> weekDays(VT vt, context) {
  return <Day>[
    Day(
      title: vt.intl.of(context)?.fmt('monday') ?? 'M',
      name: 'Monday',
      dayIndex: 0,
    ),
    Day(
      title: vt.intl.of(context)?.fmt('tuesday') ?? 'T',
      name: 'Tuesday',
      dayIndex: 1,
    ),
    Day(
      title: vt.intl.of(context)?.fmt('wednesday') ?? 'W',
      name: 'Wednesday',
      dayIndex: 2,
    ),
    Day(
      title: vt.intl.of(context)?.fmt('thursday') ?? 'T',
      name: 'Thursday',
      dayIndex: 3,
    ),
    Day(
      title: vt.intl.of(context)?.fmt('friday') ?? 'F',
      name: 'Friday',
      dayIndex: 4,
    ),
    Day(
      title: vt.intl.of(context)?.fmt('saturday') ?? 'S',
      name: 'Saturday',
      dayIndex: 5,
    ),
    Day(
      title: vt.intl.of(context)?.fmt('sunday') ?? 'S',
      name: 'Sunday',
      dayIndex: 6,
    ),
  ];
}
