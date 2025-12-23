import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../features/home_page.dart';

class Onboard_video_section extends StatelessWidget {


  final String img;
  const Onboard_video_section({
    super.key, required this.img,
  });



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 360.w,
          height: 429.h,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(32.r),
              image: DecorationImage(image: AssetImage(img))
          ),


        ),
        Positioned(
          top: 33,
          right: 20,
          child: TextButton(
              onPressed: (){
                Get.to(()=>HomePage());
              },
              child: Text("Skip",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.bold),)),
        ),

      ],
    );
  }
}