import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxBool isShow = true.obs;

  void setShow(bool val) {
    isShow.value = val;
  }
}
