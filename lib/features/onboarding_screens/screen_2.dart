import 'package:alarm_clock/features/onboarding_screens/screen_3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/onboard_title_section.dart';
import '../../common_widget/onboard_video_section.dart';
import '../../constants/const_items.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff082257),
      body: Column(
        children: [
          Onboard_video_section(img: "assets/images/img2.png",),

          Onboarding_title_scetion(
            text1: AllConstants.onboard_title2,
            text2: AllConstants.onboard_subtitle2,
            onTap: (){
              Get.to(()=>Screen3());
            },
          )
        ],
      ),

    );
  }
}



