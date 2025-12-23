import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Onboarding_title_scetion extends StatelessWidget {

  final String text1;
  final String text2;
  final VoidCallback onTap;
  Onboarding_title_scetion({
    super.key, required this.text1, required this.text2, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.r),
      child: Column(
        spacing: 10,
        children: [
          Text(text1,style:
          TextStyle(color: Colors.white,letterSpacing: .2,fontSize: 30.sp,fontWeight: FontWeight.bold),),
          SizedBox(height: 5.h,),
          Text(text2,style:
          TextStyle(color: Colors.white,fontSize: 14.sp),),
          SizedBox(height: 55.h,),
          ElevatedButton(
              onPressed: onTap,
              style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(328.w, 56.h)),
                  backgroundColor: WidgetStatePropertyAll(Color(0xff5200FF)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(69.r)
                  ))


              ),
              child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.bold),))


        ],
      ),
    );
  }
}
