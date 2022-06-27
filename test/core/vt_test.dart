//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/core/utils/intl.dart';
import 'package:vtime/core/vt.dart';

void main() {
  VT? vt;

  setUpAll(() => vt = VT());

  group('VT', () {
    test('is a singleton', () {
      expect(vt.hashCode, VT().hashCode);
    });

    test('has expected default property values', () {
      expect(vt, isA<VT>());
      expect(vt?.instances.isEmpty, true);
      expect(vt.runtimeType, VT);
    });

    test('has expected property and preference setting behavior', () {
      vt?.intl = Intl();
      vt?.localDbService = LocalDBService();

      expect(vt?.instances.isNotEmpty, true);
      expect(vt?.localDbService, isNotNull);
      expect(vt?.intl, isNotNull);
    });
  });
}
