import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/dream.dart';
import '/screen/dream/detail_dream.dart';
import '/screen/dream/seach_dream.dart';
import '/screen/dream/widget/carousel.dart';
import '/screen/dream/widget/item_dream.dart';
import '/util/view_ex.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DreamScreen extends StatefulWidget {
  const DreamScreen({super.key});
  @override
  State<DreamScreen> createState() => _DreamScreenState();
}

class _DreamScreenState extends State<DreamScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BodyCustom(
      isShowBgImages: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 64.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    L.dreams.tr,
                    style: GlobalTextStyles.font18w700ColorBlack,
                  ),
                  GestureDetector(
                    onTap: () => tapAndCheckInternet(() {
                      Get.to(() => const SearchDreamScreen());
                    }),
                    child: SvgPicture.asset(
                      "assets/icons/ic_journal_search.svg",
                      width: 24.0,
                      height: 24.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const CarouselCustom(),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                L.dreamSymbols.tr,
                style: GlobalTextStyles.font16w600ColorBlack,
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  crossAxisCount: 2),
              itemCount: listDream.length,
              itemBuilder: (context, index) {
                Dream dream = listDream[index];
                return GestureDetector(
                  onTap: () => tapAndCheckInternet(() {
                    Get.to(() => DetailDreamScreen(dream: dream));
                  }),
                  child: ItemDreamCustom(dream: dream),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
