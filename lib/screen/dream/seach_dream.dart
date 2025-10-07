import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/dream.dart';
import '/screen/dream/controller/dream_controller.dart';
import '/screen/dream/detail_dream.dart';
import '/screen/dream/widget/item_dream.dart';
import '/util/view_ex.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchDreamScreen extends StatefulWidget {
  const SearchDreamScreen({super.key});

  @override
  State<SearchDreamScreen> createState() => _SearchDreamScreenState();
}

class _SearchDreamScreenState extends State<SearchDreamScreen> {
  final searchController = TextEditingController();
  final dreamCtl = Get.find<DreamController>();
  bool isFocus = false;
  final FocusNode searchFocusNode = FocusNode();
  @override
  void dispose() {
    dreamCtl.listDreamSearh.clear();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BodyCustom(
            isShowBgImages: true,
            edgeInsetsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
              SizedBox(
                height: 64.0,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        tapAndCheckInternet(() {
                          Get.back();
                        });
                      },
                      child: SvgPicture.asset(
                        "assets/icons/ic_journal_back.svg",
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 48,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D273E),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: TextField(
                          focusNode: searchFocusNode,
                          autofocus: false,
                          controller: searchController,
                          style: GlobalTextStyles.font14w400ColorBlack,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (value) {
                            dreamCtl.filterDream(value);
                          },
                          decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: L.search.tr,
                            hintStyle:
                                GlobalTextStyles.font14w400ColorBlackOp38,
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: SvgPicture.asset(
                                "assets/icons/ic_journal_search.svg",
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                tapAndCheckInternet(() {
                                  setState(() {
                                    searchController.text = "";
                                    dreamCtl.listDreamSearh.clear();
                                  });
                                });
                              },
                              child: SvgPicture.asset(
                                "assets/icons/ic_close.svg",
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Obx(() => dreamCtl.listDreamSearh.isNotEmpty
                      ? GridView.builder(
                          padding: const EdgeInsets.all(16.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 16.0,
                                  crossAxisSpacing: 16.0,
                                  crossAxisCount: 2),
                          itemCount: dreamCtl.listDreamSearh.length,
                          itemBuilder: (context, index) {
                            Dream dream = dreamCtl.listDreamSearh[index];
                            return GestureDetector(
                              onTap: () => tapAndCheckInternet(() {
                                searchFocusNode.unfocus();
                                FocusScope.of(context).unfocus();
                                Get.to(() => DetailDreamScreen(dream: dream));
                              }),
                              child: ItemDreamCustom(dream: dream),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "No search result",
                            style: GlobalTextStyles.font14w400ColorBlackOp38,
                          ),
                        )))
            ])));
  }
}
