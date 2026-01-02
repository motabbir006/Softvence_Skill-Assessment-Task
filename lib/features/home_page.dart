import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'location/location_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isOn = false;
  List<bool> switchValues = List.generate(5, (index) => false);

  List<TimeOfDay> alarmTimes = List.generate(5, (index) => const TimeOfDay(hour: 19, minute: 10)); // Default 7:10 PM

  Future<void> _selectTime(int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: alarmTimes[index],
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff5200FF),
              onPrimary: Colors.white,
              surface: Color(0xff0B0024),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xff082257),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != alarmTimes[index]) {
      setState(() {
        alarmTimes[index] = picked;
      });
    }
  }



  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        shape: CircleBorder(),


        backgroundColor: Color(0xff5200FF),
        child: Icon(Icons.add,color: Colors.white,size: 24,),
      ),


      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff082257),
              Color(0xff0B0024),
            ],
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.h,
            children: [
              SizedBox(height: 50.h,),
              Text("Selected Location",style: TextStyle(color: Colors.white,fontSize: 20.sp,letterSpacing: .6,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              TextFormField(
                controller: locationController,
                readOnly: true, // Prevent keyboard from opening
                onTap: () async {
                   final result = await Get.to(() => LocationPage());
                   if (result != null) {
                     setState(() {
                       locationController.text = result.toString();
                     });
                   }
                },
                decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(.05),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                    ),
                    hintText: "Add your location",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(.3),fontSize: 14.sp),
                    prefixIcon: Icon(Icons.location_on_outlined, color: Colors.white.withOpacity(0.7), size: 20.sp,),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20.h),
              Text("Alarms",style: TextStyle(color: Colors.white,fontSize: 20.sp,letterSpacing: .6,fontWeight: FontWeight.w600),textAlign: TextAlign.left,),
              Expanded(
                child: ListView.builder(
                    itemCount: switchValues.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Container(
                          width: double.infinity,
                          height: 80.h, // Increased height
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.05), // Matches input field
                              borderRadius: BorderRadius.circular(30.r)

                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => _selectTime(index),
                                  child: Text(
                                    alarmTimes[index].format(context),
                                    style: TextStyle(color: Colors.white,fontSize: 20.sp, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("Fri 21 Mar 2025",style: TextStyle(color: Colors.white.withOpacity(.5),fontSize: 12.sp, fontWeight: FontWeight.w500)),
                                    SizedBox(width: 12.w,),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Switch(
                                        value: switchValues[index],
                                
                                        onChanged: (value) {
                                          setState(() {
                                            switchValues[index] = value;
                                          });
                                        },
                                        activeColor: Colors.white,
                                        activeTrackColor: Color(0xff5200FF),
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.white.withOpacity(0.1),
                                        trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                                      ),
                                    )
                                
                                
                                  ],
                                )
                                
                                
                              ],
                            ),
                          ),
                        ),
                      );

                    }),
              )


            ],
          ),
        ),
      ),

    );
  }
}
