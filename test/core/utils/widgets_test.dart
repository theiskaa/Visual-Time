//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/core/vt.dart';

class TestStatelessWidget extends VTStatelessWidget {
  TestStatelessWidget({Key? key}) : super(key: key);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestStatefulWidget extends VTStatefulWidget {
  TestStatefulWidget({Key? key}) : super(key: key);
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestLomsaState extends VTStatefulWidget {
  TestLomsaState({Key? key}) : super(key: key);

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late VTStatelessWidget testStateless;
  late VTStatefulWidget testStatefull;
  late VTStatefulWidget testState;

  late VT vt;

  setUpAll(() {
    testStateless = TestStatelessWidget();
    testStatefull = TestStatefulWidget();
    testState = TestLomsaState();

    vt = VT();
  });

  test('Check if vt singleton exists', () async {
    expect(vt, testStateless.vt);
    expect(vt, testStatefull.vt);
    expect(vt, testState.vt);
  });
}
