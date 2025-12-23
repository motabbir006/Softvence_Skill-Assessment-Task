import 'package:alarm_clock/features/onboarding_screens/screen_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/onboard_title_section.dart';
import '../../common_widget/onboard_video_section.dart';
import '../../constants/const_items.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff082257),
      body: Column(
        children: [
          Onboard_video_section(img: "assets/images/img1.png"),

          Onboarding_title_scetion(
            text1: AllConstants.onboard_title1,
            text2: AllConstants.onboard_subtitle1,
            onTap: (){
              Get.to(()=>Screen2());
            },
          )
        ],
      ),

    );
  }
}



