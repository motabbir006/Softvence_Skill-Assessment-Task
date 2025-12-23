import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/onboard_title_section.dart';
import '../../common_widget/onboard_video_section.dart';
import '../../constants/const_items.dart';
import '../location/location_page.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff082257),
      body: Column(
        children: [
          Onboard_video_section(img: "assets/images/img1.png",),

          Onboarding_title_scetion(
            text1: AllConstants.onboard_title3,
            text2: AllConstants.onboard_subtitle3,
            onTap: (){
              Get.to(()=>LocationPage());
            },
          )
        ],
      ),

    );
  }
}



