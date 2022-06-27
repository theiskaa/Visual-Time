//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/vt_model.dart';

class TestVTModel extends VTModel {
  @override
  Map<String, dynamic> toJson() => {};

  @override
  copyWith() {}
}

void main() {
  late TestVTModel vtModel;

  setUpAll(() => vtModel = TestVTModel());

  test('test VTModel', () async {
    final vtModelToJson = vtModel.toJson();

    expect(vtModel.runtimeType, TestVTModel);
    expect(vtModelToJson, {});
  });
}
