import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/core/utils/intl.dart';

import 'utils/logger.dart';

class VT {
  static final VT _singleton = VT._internal();

  final Map<String, dynamic> instances = {};

  factory VT() => _singleton;

  VT._internal() {
    Log.v('${runtimeType.toString()} instance created');
  }

  set intl(Intl intl) => instances['intl'] = intl;
  Intl get intl => instances['intl'];

  set localDbService(LocalDBService localDbService) =>
      instances['localDbService'] = localDbService;
  LocalDBService get localDbService => instances['localDbService'];
}
