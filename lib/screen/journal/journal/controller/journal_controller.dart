import 'dart:io';
import 'package:intl/intl.dart'; // Import thư viện intl
import '/model/journal.dart';
import '/services/database_hepler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalController extends GetxController {
  RxBool isLoad = true.obs;
  RxList<Journal> listJournal = <Journal>[].obs;
  RxList<Map<String, Map<String, List<Journal>>>> listJournalSearch =
      <Map<String, Map<String, List<Journal>>>>[].obs;
  RxList<Map<String, Map<String, List<Journal>>>> listJournalNew =
      <Map<String, Map<String, List<Journal>>>>[].obs;
      
  void filterJournal(String val) {
    List<Journal> listTemp = [];
    for (var element in listJournal) {
      if (element.title.toLowerCase().contains(val.toLowerCase())) {
        listTemp.add(element);
      }
    }
    List<Map<String, Map<String, List<Journal>>>> resultList = [];
    if (val.isEmpty) {
      listJournalSearch.value = resultList;
    } else {
      Map<String, Map<String, List<Journal>>> groupedData = {};
      for (var journal in listTemp) {
        DateTime date = DateTime.parse(journal.date);

        // Lấy key cho tháng và ngày
        String monthKey =
            "${date.year}-${date.month.toString().padLeft(2, '0')}";
        String dayKey = date.day.toString().padLeft(2, '0');

        if (!groupedData.containsKey(monthKey)) {
          groupedData[monthKey] = {};
        }
        if (!groupedData[monthKey]!.containsKey(dayKey)) {
          groupedData[monthKey]![dayKey] = [];
        }

        groupedData[monthKey]![dayKey]?.add(journal);
      }

      groupedData.forEach((month, daysMap) {
        // Chuyển đổi monthKey sang định dạng "MMMM, yyyy"
        DateTime parsedMonth =
            DateTime.parse("$month-01"); // Thêm ngày đầu tiên để parse DateTime
        String formattedMonth = DateFormat('MMMM, yyyy').format(parsedMonth);

        resultList
            .add({formattedMonth: daysMap}); // Thay month bằng formattedMonth
      });

      listJournalSearch.value = resultList;

      // In kết quả
      for (var monthData in resultList) {
        monthData.forEach((month, days) {
          debugPrint("Tháng: $month");
          days.forEach((day, journalList) {
            debugPrint("  Ngày: $day");
            for (var journal in journalList) {
              debugPrint(
                  "    id: ${journal.id}, title: ${journal.title}, description: ${journal.description}");
            }
          });
        });
      }
    }
  }

  void loadData() {
    DatabaseHelper().queryAllRows().then(
      (value) {
        listJournal.value = value
            .map(
              (e) => Journal.fromMap(e),
            )
            .toList();

        for (var element in listJournal) {
          debugPrint(
              "id ${element.id} title ${element.title} des ${element.description} mood ${element.mood} voice_path ${element.voicePath} time ${element.date}");
        }
      },
    );
  }

  void insertJournal(Journal journal) {
    DatabaseHelper().insertJournal(journal.toMap()).whenComplete(
      () {
        loadDataAndGroupByMonthAndDay();
        loadData();
        Get.back();
      },
    );
  }

  void editJournal(Journal journal) {
    DatabaseHelper().updateJournal(journal.toMap()).whenComplete(
      () {
        debugPrint("update Journal Success");

        debugPrint("${journal.id} ${journal.title}");
        loadDataAndGroupByMonthAndDay();
        loadData();
        Get.back();
      },
    );
  }

  Future<void> deleteJournal(Journal journal) async {
    final file = File(journal.voicePath);
    if (await file.exists()) {
      try {
        await file.delete();
        DatabaseHelper().deleteJournal(journal.id!).whenComplete(
          () {
            loadData();
            loadDataAndGroupByMonthAndDay();
            Get.back();
          },
        );
      } catch (e) {
        debugPrint('Có lỗi khi xóa file: $e');
      }
    } else {
      debugPrint('File không tồn tại');
      DatabaseHelper().deleteJournal(journal.id!).whenComplete(
        () {
          loadData();
          loadDataAndGroupByMonthAndDay();
          Get.back();
        },
      );
    }
  }

  void loadDataAndGroupByMonthAndDay() async {
    await DatabaseHelper().queryAllRows().then((value) {
      // Chuyển đổi dữ liệu thành danh sách các đối tượng Journal
      List<Journal> journals = value.map((e) => Journal.fromMap(e)).toList();

      // Tạo danh sách cuối cùng để trả về
      List<Map<String, Map<String, List<Journal>>>> resultList = [];

      // Map để nhóm theo tháng
      Map<String, Map<String, List<Journal>>> groupedData = {};

      // Map để đếm số lượng nhật ký theo tháng
      Map<String, int> monthlyJournalCount = {};

      // Nhóm các bản ghi theo tháng và ngày
      for (var journal in journals) {
        // Chuyển date từ chuỗi sang đối tượng DateTime
        DateTime date = DateTime.parse(journal.date);

        // Lấy key cho tháng và ngày
        String monthKey =
            "${date.year}-${date.month.toString().padLeft(2, '0')}";
        String dayKey = date.day.toString().padLeft(2, '0');

        // Nếu chưa có tháng này trong map, thì tạo mới
        if (!groupedData.containsKey(monthKey)) {
          groupedData[monthKey] = {};
          monthlyJournalCount[monthKey] =
              0; // Khởi tạo số lượng nhật ký cho tháng
        }

        // Nếu chưa có ngày này trong map tháng, thì tạo mới
        if (!groupedData[monthKey]!.containsKey(dayKey)) {
          groupedData[monthKey]![dayKey] = [];
        }

        // Thêm bản ghi vào đúng ngày và tháng
        groupedData[monthKey]![dayKey]?.add(journal);

        // Tăng số lượng nhật ký cho tháng
        monthlyJournalCount[monthKey] =
            (monthlyJournalCount[monthKey] ?? 0) + 1;
      }

      // Chuyển map thành danh sách và sắp xếp theo tháng giảm dần
      var sortedGroupedData =
          Map<String, Map<String, List<Journal>>>.fromEntries(
        groupedData.entries.toList()
          // Sắp xếp tháng giảm dần
          ..sort((a, b) => b.key.compareTo(a.key)),
      );

      // Sắp xếp ngày trong từng tháng theo thứ tự giảm dần và chuyển định dạng tháng
      sortedGroupedData.forEach((month, daysMap) {
        // Chuyển đổi monthKey sang định dạng "MMMM, yyyy"
        DateTime parsedMonth = DateTime.parse("$month-01");
        String formattedMonth = DateFormat('MMMM, yyyy').format(parsedMonth);

        var sortedDaysMap = Map<String, List<Journal>>.fromEntries(
          daysMap.entries.toList()
            // Sắp xếp ngày giảm dần
            ..sort((a, b) => int.parse(b.key).compareTo(int.parse(a.key))),
        );

        resultList.add({formattedMonth: sortedDaysMap});
      });

      listJournalNew.value = resultList;

      isLoad.value = false;
    });
  }
}
