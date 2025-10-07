import '/model/dream.dart';
import 'package:get/get.dart';

class DreamController extends GetxController {
  RxList<Dream> listDreamSearh = <Dream>[].obs;

  void filterDream(String value) {
    listDreamSearh.value = <Dream>[];
    if (value.isEmpty) {
      listDreamSearh.value = <Dream>[];
    } else {
      for (var element in listDream) {
        if (element.title.toLowerCase().contains(value.toLowerCase())) {
          listDreamSearh.add(element);
        }
      }
    }
  }
}
