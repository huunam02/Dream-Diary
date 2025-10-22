import '/lang/l.dart';

const String token = "b2d015b3-1b81-4d50-ac5b-4390a1f25ec5e";
const String headerUrl =
    "https://firebasestorage.googleapis.com/v0/b/icheckin-1db02.appspot.com/o/DreamDiary%2F";
const String footerUrl = "?alt=media&token=$token";

class Dream {
  String title;
  String description;
  String image120x120;
  String image156x156;
  String image360x352;
  String imageCarousel;
  Dream({
    required this.title,
    required this.description,
    required this.image120x120,
    required this.image156x156,
    required this.image360x352,
    required this.imageCarousel,
  });
}

List<Dream> listDream = [
  Dream(
      title: L.title1,
      description: L.dreamDes1,
      image120x120: "${headerUrl}dream120x120_1.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_1.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_1.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_1.png$footerUrl"),
  Dream(
      title: L.title2,
      description: L.dreamDes2,
      image120x120: "${headerUrl}dream120x120_2.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_2.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_2.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_2.png$footerUrl"),
  Dream(
      title: L.title3,
      description: L.dreamDes3,
      image120x120: "${headerUrl}dream120x120_3.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_3.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_3.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_3.png$footerUrl"),
  Dream(
      title: L.title4,
      description: L.dreamDes4,
      image120x120: "${headerUrl}dream120x120_4.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_4.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_4.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_4.png$footerUrl"),
  Dream(
      title: L.title5,
      description: L.dreamDes5,
      image120x120: "${headerUrl}dream120x120_5.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_5.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_5.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_5.png$footerUrl"),
  Dream(
      title: L.title6,
      description: L.dreamDes6,
      image120x120: "${headerUrl}dream120x120_6.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_6.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_6.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_6.png$footerUrl"),
  Dream(
      title: L.title7,
      description: L.dreamDes7,
      image120x120: "${headerUrl}dream120x120_7.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_7.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_7.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_7.png$footerUrl"),
  Dream(
      title: L.title8,
      description: L.dreamDes8,
      image120x120: "${headerUrl}dream120x120_8.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_8.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_8.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_8.png$footerUrl"),
  Dream(
      title: L.title9,
      description: L.dreamDes9,
      image120x120: "${headerUrl}dream120x120_9.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_9.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_9.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_9.png$footerUrl"),
  Dream(
      title: L.title10,
      description: L.dreamDes10,
      image120x120: "${headerUrl}dream120x120_10.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_10.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_10.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_10.png$footerUrl"),
  Dream(
      title: L.title11,
      description: L.dreamDes11,
      image120x120: "${headerUrl}dream120x120_11.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_11.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_11.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_11.png$footerUrl"),
  Dream(
      title: L.title12,
      description: L.dreamDes12,
      image120x120: "${headerUrl}dream120x120_12.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_12.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_12.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_12.png$footerUrl"),
  Dream(
      title: L.title13,
      description: L.dreamDes13,
      image120x120: "${headerUrl}dream120x120_13.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_13.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_13.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_13.png$footerUrl"),
  Dream(
      title: L.title14,
      description: L.dreamDes14,
      image120x120: "${headerUrl}dream120x120_14.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_14.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_14.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_14.png$footerUrl"),
  Dream(
      title: L.title15,
      description: L.dreamDes15,
      image120x120: "${headerUrl}dream120x120_15.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_15.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_15.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_15.png$footerUrl"),
  Dream(
      title: L.title16,
      description: L.dreamDes16,
      image120x120: "${headerUrl}dream120x120_16.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_16.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_16.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_16.png$footerUrl"),
  Dream(
      title: L.title17,
      description: L.dreamDes17,
      image120x120: "${headerUrl}dream120x120_17.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_17.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_17.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_17.png$footerUrl"),
  Dream(
      title: L.title18,
      description: L.dreamDes18,
      image120x120: "${headerUrl}dream120x120_18.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_18.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_18.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_18.png$footerUrl"),
  Dream(
      title: L.title19,
      description: L.dreamDes19,
      image120x120: "${headerUrl}dream120x120_19.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_19.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_19.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_19.png$footerUrl"),
  Dream(
      title: L.title20,
      description: L.dreamDes20,
      image120x120: "${headerUrl}dream120x120_20.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_20.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_20.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_20.png$footerUrl"),
  Dream(
      title: L.title21,
      description: L.dreamDes21,
      image120x120: "${headerUrl}dream120x120_21.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_21.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_21.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_21.png$footerUrl"),
  Dream(
      title: L.title22,
      description: L.dreamDes22,
      image120x120: "${headerUrl}dream120x120_22.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_22.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_22.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_22.png$footerUrl"),
  Dream(
      title: L.title23,
      description: L.dreamDes23,
      image120x120: "${headerUrl}dream120x120_23.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_23.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_23.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_23.png$footerUrl"),
  Dream(
      title: L.title24,
      description: L.dreamDes24,
      image120x120: "${headerUrl}dream120x120_24.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_24.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_24.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_24.png$footerUrl"),
  Dream(
      title: L.title25,
      description: L.dreamDes25,
      image120x120: "${headerUrl}dream120x120_25.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_25.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_25.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_25.png$footerUrl"),
  Dream(
      title: L.title26,
      description: L.dreamDes26,
      image120x120: "${headerUrl}dream120x120_26.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_26.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_26.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_26.png$footerUrl"),
  Dream(
      title: L.title27,
      description: L.dreamDes27,
      image120x120: "${headerUrl}dream120x120_27.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_27.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_27.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_27.png$footerUrl"),
  Dream(
      title: L.title28,
      description: L.dreamDes28,
      image120x120: "${headerUrl}dream120x120_28.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_28.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_28.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_28.png$footerUrl"),
  Dream(
      title: L.title29,
      description: L.dreamDes29,
      image120x120: "${headerUrl}dream120x120_29.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_29.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_29.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_29.png$footerUrl"),
  // Dream(
  //     title: "Fall from above",
  //     description: """""",
  //     image120x120: "${headerUrl}dream120x120_30.png${footerUrl}",
  //     image156x156: "${headerUrl}dream156x156_30.png${footerUrl}",
  //     image360x352: "${headerUrl}dream360x352_30.png${footerUrl}",
  //     imageCarousel: "${headerUrl}carousel_30.png${footerUrl}"),
  Dream(
      title: L.title30,
      description: L.dreamDes30,
      image120x120: "${headerUrl}dream120x120_31.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_31.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_31.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_31.png$footerUrl"),
  Dream(
      title: L.title31,
      description: L.dreamDes31,
      image120x120: "${headerUrl}dream120x120_32.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_32.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_32.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_32.png$footerUrl"),
  Dream(
      title: L.title32,
      description: L.dreamDes32,
      image120x120: "${headerUrl}dream120x120_33.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_33.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_33.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_33.png$footerUrl"),
  Dream(
      title: L.title33,
      description: L.dreamDes33,
      image120x120: "${headerUrl}dream120x120_34.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_34.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_34.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_34.png$footerUrl"),
  Dream(
      title: L.title34,
      description: L.dreamDes33,
      image120x120: "${headerUrl}dream120x120_35.png$footerUrl",
      image156x156: "${headerUrl}dream156x156_35.png$footerUrl",
      image360x352: "${headerUrl}dream360x352_35.png$footerUrl",
      imageCarousel: "${headerUrl}carousel_35.png$footerUrl"),
];
