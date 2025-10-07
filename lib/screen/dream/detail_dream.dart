import 'dart:math';
import 'dart:ui';
import '/config/global_text_style.dart';
import '/lang/l.dart';
import '/model/dream.dart';
import '/screen/dream/widget/item_random_dream.dart';
import '/util/view_ex.dart';
import '/widget/body_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class DetailDreamScreen extends StatefulWidget {
  const DetailDreamScreen({super.key, required this.dream});
  final Dream dream;

  @override
  State<DetailDreamScreen> createState() => _DetailDreamScreenState();
}

class _DetailDreamScreenState extends State<DetailDreamScreen> {
  List<int> listIndexDreamRd = [];

  @override
  void initState() {
    super.initState();
    randomList();
  }

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BodyCustom(
          isShowBgImages: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 360 / 352,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 360 / 320,
                          child: Image.asset(
                            widget.dream.image360x352,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, -0.66),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () => tapAndCheckInternet(() {
                                          Get.back();
                                        }),
                                    child: SvgPicture.asset(
                                        "assets/icons/ic_journal_back.svg")),
                                GestureDetector(
                                    onTap: () {
                                      tapAndCheckInternet(() async {
                                        await Share.share(
                                            '${widget.dream.title.tr}\n${widget.dream.description.tr}');
                                      });
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/ic_share.svg"))
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: w * 0.777777777,
                            child: AspectRatio(
                              aspectRatio: 280 / 72,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    16.0), // Đặt bo tròn cho Container
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 20.0,
                                      sigmaY: 20.0), // Điều chỉnh mức độ blur
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0x61304372), // Màu nền
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Text(
                                      widget.dream.title.tr,
                                      style:
                                          GlobalTextStyles.font16w600ColorBlack,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        L.interpretation.tr,
                        style: GlobalTextStyles.font16w600ColorBlack,
                      ),
                      Text(
                        widget.dream.description.tr,
                        style: GlobalTextStyles.font14w400ColorBlack,
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xFF2D3156),
                      ),
                      Text(
                        L.otherSymbol.tr,
                        style: GlobalTextStyles.font16w600ColorBlack,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 149.0,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: listIndexDreamRd.length,
                    itemBuilder: (context, index) {
                      Dream dream = listDream[listIndexDreamRd[index]];
                      return GestureDetector(
                          onTap: () {
                            tapAndCheckInternet(() {
                  
                              Get.back();
                              Get.to(DetailDreamScreen(dream: dream));
                            });
                          },
                          child: ItemRandomDreamCustom(dream: dream));
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  void randomList() {
    final random = Random();
    int maxNumber = 33;
    int count = 10;
    List<int> numbers = List.generate(maxNumber + 1, (index) => index);
    numbers.shuffle(random);
    List<int> randomNumbers = numbers.take(count).toList();
    setState(() {
      listIndexDreamRd = randomNumbers;
    });
  }
}
