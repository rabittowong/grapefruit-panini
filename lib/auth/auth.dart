import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  String? _currentUid = '6KUm3fbL8wZXT3feYZ4XjEJj21W9';

  String? getCurrentUid() {
    return _currentUid;
  }
}
