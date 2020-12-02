import 'package:flutter_app/block/base/bloc_base.dart';
import 'package:flutter_app/block/model/user.dart';

class HomeBlock extends BlocBase {
  final UserLogin userLogin;

  HomeBlock(this.userLogin);

  UserLogin getUserData() => userLogin;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
