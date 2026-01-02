import 'package:alarm_clock/features/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import '../../constants/const_items.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}



class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  late List<VideoPlayerController?> _videoControllers;
  int _currentIndex = 0;

  final List<String> _videoPaths = [
    'assets/videos/onboarding_1.mp4',
    'assets/videos/onboarding_2.mp4',
    'assets/videos/onboarding_3.mp4',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _videoControllers = List.generate(_videoPaths.length, (_) => null);
    _initializeVideos();
  }

  void _initializeVideos() {
    for (int i = 0; i < _videoPaths.length; i++) {
      _initVideoAtIndex(i);
    }
  }

  Future<void> _initVideoAtIndex(int index) async {
    final controller = VideoPlayerController.asset(_videoPaths[index]);
    _videoControllers[index] = controller;

    try {
      await controller.initialize();
      controller.setLooping(false); // Disable looping for auto-advance
      controller.setVolume(1.0); // User might want sound? Original code had mute. Keeping mute for now as safest or enabling if they asked? "video kai add korecho" implies visual. Let's keep mute to be safe or maybe user wants sound? "Mobile Video with sound" was filename. Let's enable sound? No, usually onboarding is silent. Sticking to mute but focusing on logic.
      // Wait, filename had "with sound". User said "video loop akare ghurse".
      // I will set volume to 0 for now to avoid blasting.
      controller.setVolume(0.0);
      
      // Add listener for video completion
      controller.addListener(() {
        if (controller.value.isInitialized && 
            controller.value.position >= controller.value.duration) {
             // Use a post frame callback or ensure we don't call setState during build if that happens
             // But simplest is to check if it's the current video playing
             if (_currentIndex == index) {
               _onNext();
             }
        }
      });

      if (index == 0) {
        controller.play();
      }
      
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint("Error initializing video $index: $e");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  void _onNext() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Play next video logic is handled in onPageChanged
    } else {
      Get.off(() => const HomePage());
    }
  }

  void _onSkip() {
    Get.off(() => const HomePage());
  }

  void _handlePageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Pause previous video
    if (index > 0) {
       _videoControllers[index - 1]?.pause();
       _videoControllers[index - 1]?.seekTo(Duration.zero);
    }
    if (index < _videoControllers.length - 1) {
       _videoControllers[index + 1]?.pause(); // precautionary
    }
    
    // Play current video
    _videoControllers[index]?.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF082257), // Deep blue from original screen_1
      body: Column(
        children: [
          // Top Video Section
          // Top Video Section
          Expanded(
            flex: 6, 
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.r),
                    bottomRight: Radius.circular(32.r),
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _videoPaths.length,
                    onPageChanged: _handlePageChange,
                    itemBuilder: (context, index) {
                      final controller = _videoControllers[index];
                      if (controller == null || !controller.value.isInitialized) {
                        return Container(
                          color: Colors.black,
                          child: const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          ),
                        );
                      }
                      return SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: controller.value.size.width,
                            height: controller.value.size.height,
                            child: VideoPlayer(controller),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Skip Button Positioned on top of video
                Positioned(
                  top: 50.h,
                  right: 20.w,
                  child: TextButton(
                    onPressed: _onSkip,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Content Section
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        _getTitle(_currentIndex),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        _getSubtitle(_currentIndex),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 15.sp,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  
                  // Navigation Row (Next Button + Indicator)
                  // But user said "next button er opore indicator" (indicator ABOVE next button)
                  Column(
                    children: [
                      // Indicator
                      Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 3,
                          effect: WormEffect( // Switched to WormEffect as simpler "goal" style
                            activeDotColor: Colors.white,
                            dotColor: Colors.white.withOpacity(0.2),
                            dotHeight: 10.h,
                            dotWidth: 10.w,
                            spacing: 8.w,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 30.h),

                      // Next Button
                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: _onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5D30E9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0: return AllConstants.onboard_title1;
      case 1: return AllConstants.onboard_title2;
      case 2: return AllConstants.onboard_title3;
      default: return "";
    }
  }

  String _getSubtitle(int index) {
    switch (index) {
      case 0: return AllConstants.onboard_subtitle1;
      case 1: return AllConstants.onboard_subtitle2;
      case 2: return AllConstants.onboard_subtitle3;
      default: return "";
    }
  }
}
