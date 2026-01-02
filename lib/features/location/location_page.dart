import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../network/network_location.dart';
import '../home_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff082257),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:17.r,vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10.h,
            children: [
              SizedBox(height: 60.h,),
              Text("Welcome! Your Smart Travel Alarm",style:
              TextStyle(color: Colors.white,letterSpacing: .6,fontSize: 30.sp,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.r),
                child: Text("Stay on schedule and enjoy every moment of your journey."
                  ,style: TextStyle(color: Colors.white,fontSize: 16.sp),textAlign: TextAlign.center,),
              ),
              SizedBox(height: 50.h,),
              Image.asset("assets/images/cover_image.png",width: 305.w,height: 215.h,alignment: Alignment.center ,),
              SizedBox(height: 50.h,),
              ElevatedButton(
                  onPressed: () async {
                    Position? pos = await getCurrentLocation();
                    print("Lat: ${pos?.latitude}, Lng: ${pos?.longitude}");
                    if (pos != null) {
                      Get.back(result: "Lat: ${pos.latitude.toStringAsFixed(4)}, Lng: ${pos.longitude.toStringAsFixed(4)}");
                    } else {
                      Get.snackbar(
                        "Error", 
                        "Could not fetch location. Please enable location services and permissions.",
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },

                  style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(328.w, 56.h)),
                      side: WidgetStatePropertyAll(BorderSide(color: Colors.white)),
                      backgroundColor:WidgetStatePropertyAll( Colors.transparent),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r)
                      ))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Use Current Location",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.bold),),
                      SizedBox(width: 8.w,),
                      Icon(Icons.location_on_outlined, color: Colors.white, size: 24.sp),
                    ],
                  )),
              SizedBox(height: 16.h,),
              ElevatedButton(
                  onPressed: (){
                    Get.to(()=>HomePage());
                  },
                  style: ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(328.w, 56.h)),
                      backgroundColor: WidgetStatePropertyAll(Color(0xff5200FF)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r)
                      ))
                  ),
                  child: Text("Home",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      ),

    );
  }
}
