import 'package:get/get.dart';


class User {
  String name;
  int counter;

  User({this.counter=0,this.name=''});
}

class UserCounter extends GetxController {
  final user = User().obs;

  updateCount(int count) {
    user.update((val) {
      val.counter = count;
    });
  }

  updateName(String name) {
    user.update((val) {
      val.name = name;
    });
  }
}