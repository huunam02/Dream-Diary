import '/lang/l.dart';
import '/model/mood.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoodController extends GetxController {
  RxList<Mood> listMoodSearch = <Mood>[].obs;
  RxList<Mood> listMood = <Mood>[].obs;
  RxList<int> listMoodSelected = <int>[].obs;
  RxBool isSearch = false.obs;
  RxBool isSelected = false.obs;
  void filter(String val) {
    if (val.isEmpty) {
      isSearch.value = false;
    } else {
      isSearch.value = true;
      List<Mood> listTemp = [];

      for (var element in listMood) {
        if (element.title.toLowerCase().contains(val.toLowerCase())) {
          listTemp.add(element);
        }
      }
      for (var element in listTemp) {
        debugPrint("${element.title}: ${element.isSelected}");
      }
      listMoodSearch.value = listTemp;
    }
  }

  void checkSelected() {
    for (Mood mood in listMood) {
      if (mood.isSelected) {
        isSelected.value = true;
        return;
      }
      isSelected.value = false;
    }
  }

  void selectedMood(Mood mood) {
    int index = listMood.indexWhere((element) => element.title == mood.title);
    if (index != -1) {
      listMood[index].isSelected = !listMood[index].isSelected;
      listMood.refresh();
    }
  }

  void checkMoodSelected() {
    if (listMoodSelected.isNotEmpty) {
      for (int i in listMoodSelected) {
        listMood[i].isSelected = true;
      }
    }
  }

  void setlistMoodSelected() {
    List<int> listTemp = [];
    for (int i = 0; i < listMood.length; i++) {
      if (listMood[i].isSelected) {
        listTemp.add(i);
      }
    }
    if (listTemp.isNotEmpty) {
      listMoodSelected.value = listTemp;
      isSearch.value = false;
      Get.back();
    }
  }

  void clearData() {
    listMoodSearch.value = <Mood>[];
    for (var element in listMood) {
      element.isSelected = false;
    }
    listMoodSelected.value = <int>[];
    Get.back();
  }

  void initData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listMood.isNotEmpty) {
        listMood.clear();
      }
      for (Mood mood in listMoodData) {
        listMood.add(Mood(title: mood.title.tr, isSelected: false));
      }
      checkMoodSelected();
    });
  }
}

List<Mood> listMoodData = [
  Mood(title: L.mood1, isSelected: false),
  Mood(title: L.mood2, isSelected: false),
  Mood(title: L.mood3, isSelected: false),
  Mood(title: L.mood4, isSelected: false),
  Mood(title: L.mood5, isSelected: false),
  Mood(title: L.mood6, isSelected: false),
  Mood(title: L.mood7, isSelected: false),
  Mood(title: L.mood8, isSelected: false),
  Mood(title: L.mood9, isSelected: false),
  Mood(title: L.mood10, isSelected: false),
  Mood(title: L.mood11, isSelected: false),
  Mood(title: L.mood12, isSelected: false),
  Mood(title: L.mood13, isSelected: false),
  Mood(title: L.mood14, isSelected: false),
  Mood(title: L.mood15, isSelected: false),
  Mood(title: L.mood16, isSelected: false),
  Mood(title: L.mood17, isSelected: false),
  Mood(title: L.mood18, isSelected: false),
  Mood(title: L.mood19, isSelected: false),
  Mood(title: L.mood20, isSelected: false),
  Mood(title: L.mood21, isSelected: false),
  Mood(title: L.mood22, isSelected: false),
  Mood(title: L.mood23, isSelected: false),
  Mood(title: L.mood24, isSelected: false),
  Mood(title: L.mood25, isSelected: false),
  Mood(title: L.mood26, isSelected: false),
  Mood(title: L.mood27, isSelected: false),
  Mood(title: L.mood28, isSelected: false),
  Mood(title: L.mood29, isSelected: false),
  Mood(title: L.mood30, isSelected: false),
  Mood(title: L.mood31, isSelected: false),
  Mood(title: L.mood32, isSelected: false),
  Mood(title: L.mood33, isSelected: false),
  Mood(title: L.mood34, isSelected: false),
  Mood(title: L.mood35, isSelected: false),
  Mood(title: L.mood36, isSelected: false),
  Mood(title: L.mood37, isSelected: false),
  Mood(title: L.mood38, isSelected: false),
  Mood(title: L.mood39, isSelected: false),
  Mood(title: L.mood40, isSelected: false),
  Mood(title: L.mood41, isSelected: false),
  Mood(title: L.mood42, isSelected: false),
  Mood(title: L.mood43, isSelected: false),
  Mood(title: L.mood44, isSelected: false),
  Mood(title: L.mood45, isSelected: false),
  Mood(title: L.mood46, isSelected: false),
  Mood(title: L.mood47, isSelected: false),
  Mood(title: L.mood48, isSelected: false),
  Mood(title: L.mood49, isSelected: false),
  Mood(title: L.mood50, isSelected: false),
];
