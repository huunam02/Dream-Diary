import '/config/global_color.dart';
import '/config/global_text_style.dart';
import '/model/dream.dart';
import '/screen/dream/detail_dream.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import thư viện


class CarouselCustom extends StatefulWidget {
  const CarouselCustom({super.key});

  @override
  State<CarouselCustom> createState() => _CarouselCustomState();
}

class _CarouselCustomState extends State<CarouselCustom> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<int> _listIndexDream = [0, 1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: h * 0.24,
          width: double.infinity,
          child: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 296 / 168,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: List.generate(
              _listIndexDream.length,
              (index) {
                Dream dream = listDream[_listIndexDream[index]];
                return GestureDetector(
                  onTap: () => Get.to(() => DetailDreamScreen(dream: dream)),
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                          child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image.asset(
                                listDream[_listIndexDream[index]].imageCarousel,
                                fit: BoxFit.cover,
                                width: 1000.0),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AspectRatio(
                          aspectRatio: 296 / 72,
                          child: Container(
                            alignment: const Alignment(0, 0.5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Color(0xFF1D2949),
                                  Color(0x00141B32),
                                ],
                              ),
                            ),
                            child: Text(
                              listDream[_listIndexDream[index]].title.tr,
                              style: GlobalTextStyles.font16w600ColorBlack,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        SmoothPageIndicator(
          controller: PageController(initialPage: _current),
          count: _listIndexDream.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6.0,
            dotWidth: 6.0,
            activeDotColor: GlobalColors.linearPrimary2.colors.last,
            dotColor: Colors.black.withOpacity(0.12),
            expansionFactor: 3.0,
          ),
          onDotClicked: (index) {
            _controller.animateToPage(index);
          },
        ),
      ],
    );
  }
}
