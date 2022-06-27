//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter/material.dart';

import '../vt.dart';

abstract class VTStatelessWidget extends StatelessWidget {
  VTStatelessWidget({Key? key}) : super(key: key);
  final vt = VT();
}

abstract class VTStatefulWidget extends StatefulWidget {
  VTStatefulWidget({Key? key}) : super(key: key);
  final vt = VT();
}

abstract class VTState<B extends VTStatefulWidget> extends State<B> {
  final vt = VT();
}
