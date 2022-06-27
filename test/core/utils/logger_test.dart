//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart' as logger;
import 'package:vtime/core/utils/logger.dart';

void main() {
  group('Log', () {
    test('has expected default property values', () {
      expect(Log.log, isA<logger.Logger>());
      expect(Log.logNoStack, isA<logger.Logger>());
      expect(Log.level, isNull);
      expect(Log.v, Log.logNoStack.v);
      expect(Log.d, Log.logNoStack.d);
      expect(Log.i, Log.logNoStack.i);
      expect(Log.w, Log.log.w);
      expect(Log.e, Log.log.e);
      expect(Log.c, Log.log.wtf);

      expect(Log.getLevel(), logger.Level.verbose);

      const levels = [
        'verbose',
        'debug',
        'info',
        'warning',
        'error',
        'critical'
      ];

      levels.asMap().forEach((index, level) {
        Log.level = level;

        expect(Log.getLevel(), logger.Level.values[index]);
      });

      Log.level = 'unsupported-level';

      expect(Log.getLevel(), logger.Level.verbose);
    });
  });
}
