import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isOn = false;
  List<bool> switchValues = List.generate(5, (index) => false);

  List<DateTime> alarmTimes =
  List.generate(5, (index) => DateTime.now());


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
            spacing: 10,
            children: [
              SizedBox(height: 50.h,),
              Text("Selected Location",style: TextStyle(color: Colors.white,fontSize: 20.sp,letterSpacing: .6,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              TextFormField(
                decoration: InputDecoration(
                    fillColor: Colors.purple.withOpacity(.15),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(61.r)

                    ),
                    hint: Text("Add your location",style: TextStyle(color: Colors.white.withOpacity(.3),fontSize: 16.sp)),
                    prefixIcon: ImageIcon(AssetImage("assets/images/lo.png",),size: 12.r,color: Colors.white ,)
                ),
              ),
              Text("Alarms",style: TextStyle(color: Colors.white,fontSize: 20.sp,letterSpacing: .6,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
              Expanded(
                child: ListView.builder(
                    itemCount: switchValues.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 328.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(.15),
                              borderRadius: BorderRadius.circular(89.r)

                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("7:10 pm",style: TextStyle(color: Colors.white,fontSize: 16.sp)),
                                Row(
                                  children: [
                                    Text(" Fri 21 Mar 2025",style: TextStyle(color: Colors.white.withOpacity(.3),fontSize: 20.sp)),
                                    SizedBox(width: 10.w,),
                                    Switch(
                                      value: switchValues[index],

                                      onChanged: (value) {
                                        setState(() {
                                          switchValues[index] = value;
                                        });
                                      },
                                      activeColor: Colors.white,
                                      activeTrackColor: Color(0xff5200FF),
                                      inactiveThumbColor: Colors.grey,
                                      inactiveTrackColor: Colors.black26,
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
