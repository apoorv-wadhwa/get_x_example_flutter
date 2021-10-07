import 'package:get/get.dart';

class Counter extends GetxController {
  int counter =0;

  void increment() {
    counter++;
    update();
  }
}