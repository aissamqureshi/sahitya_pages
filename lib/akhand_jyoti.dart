import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'button_page.dart';

// class AkhandJyotiApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AkhandJyotiScreen(),
//     );
//   }
// }

class AkhandJyotiScreen extends StatefulWidget {
  @override
  _AkhandJyotiScreenState createState() => _AkhandJyotiScreenState();
}

// class _AkhandJyotiScreenState extends State<AkhandJyotiScreen> {
//   Duration remainingTime = Duration(hours: 24);
//   bool isButtonPressed = false;
//   bool showIntermediateImage = false;
//   Timer? timer;
//   int currentImageIndex = 0;
//   bool showDefaultImage = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadTimerState();
//   }
//
//   Future<void> _loadTimerState() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedRemainingTime = prefs.getInt('remainingTime') ?? 24 * 60 * 60;
//     final timerStarted = prefs.getBool('isTimerRunning') ?? false;
//
//     setState(() {
//       remainingTime = Duration(seconds: savedRemainingTime);
//       isButtonPressed = timerStarted;
//       showDefaultImage = !timerStarted;
//     });
//
//     if (timerStarted) {
//       startTimer(resume: true);
//     }
//   }
//
//   Future<void> _saveTimerState() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('remainingTime', remainingTime.inSeconds);
//     await prefs.setBool('isTimerRunning', isButtonPressed);
//   }
//
//   void startTimer({bool resume = false}) {
//     if (!resume) {
//       remainingTime = Duration(hours: 24);
//       currentImageIndex = 1;
//       showDefaultImage = false;
//     }
//
//     setState(() {
//       isButtonPressed = true;
//     });
//
//     timer = Timer.periodic(Duration(seconds: 1), (timer) async {
//       setState(() {
//         if (remainingTime > Duration.zero) {
//           remainingTime -= Duration(seconds: 1);
//           updateImageIndex();
//         } else {
//           timer.cancel();
//           isButtonPressed = false;
//           showIntermediateThenFinalImage(); // Show intermediate image on timer completion
//         }
//       });
//       await _saveTimerState();
//     });
//
//     // timer = Timer.periodic(Duration(seconds: 1), (timer) async {
//     //   setState(() {
//     //     if (remainingTime > Duration.zero) {
//     //       remainingTime -= Duration(seconds: 1);
//     //       updateImageIndex();
//     //     } else {
//     //       timer.cancel();
//     //       isButtonPressed = false;
//     //     }
//     //   });
//     //   await _saveTimerState();
//     // });
//   }
//
//   void stopTimer() async {
//     if (timer != null) {
//       timer!.cancel();
//     }
//     setState(() {
//       isButtonPressed = false;
//       showDefaultImage = true;
//       currentImageIndex = 0;
//     });
//     await _saveTimerState();
//   }
//
//   void updateImageIndex() {
//     int hoursElapsed = 24 - remainingTime.inHours;
//     if (hoursElapsed < 6) {
//       currentImageIndex = 1;
//     } else if (hoursElapsed < 12) {
//       currentImageIndex = 2;
//     } else if (hoursElapsed < 18) {
//       currentImageIndex = 3;
//     } else if (hoursElapsed == 18) {
//       currentImageIndex = 4;
//     } else if (hoursElapsed == 19) {
//       currentImageIndex = 5;
//     } else if (hoursElapsed == 20) {
//       currentImageIndex = 6;
//     } else if (hoursElapsed == 21) {
//       currentImageIndex = 7;
//     } else if (hoursElapsed == 22) {
//       currentImageIndex = 8;
//     } else if (hoursElapsed == 23) {
//       currentImageIndex = 9;
//     }
//   }
//
//   void increaseTime() {
//     setState(() {
//       if (remainingTime > Duration(hours: 1)) {
//         remainingTime -= Duration(hours: 1);
//         updateImageIndex();
//       }
//     });
//   }
//
//   void decreaseTime() {
//     setState(() {
//       if (remainingTime < Duration(hours: 24)) {
//         remainingTime += Duration(hours: 1);
//         updateImageIndex();
//       }
//     });
//   }
//
//   void increaseMinute() {
//     setState(() {
//       if (remainingTime > Duration(minutes: 1)) {
//         remainingTime -= Duration(minutes: 1);
//         updateImageIndex();
//       }
//     });
//   }
//
//   void decreaseMinute() {
//     setState(() {
//       if (remainingTime < Duration(days: 1)) {
//         remainingTime += Duration(minutes: 1);
//         updateImageIndex();
//       }
//     });
//   }
//
//   void showIntermediateThenFinalImage() {
//     setState(() {
//       showIntermediateImage = true;
//       showDefaultImage = false;
//     });
//
//     Timer(Duration(seconds: 5), () {
//       setState(() {
//         showIntermediateImage = false;
//         showDefaultImage = true;
//       });
//     });
//   }
//
//   // void showIntermediateThenFinalImage() {
//   //   setState(() {
//   //     showIntermediateImage = true;
//   //   });
//   //
//   //   Timer(Duration(seconds: 5), () {
//   //     setState(() {
//   //       showIntermediateImage = false;
//   //     });
//   //   });
//   // }
//
//   String formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String hours = twoDigits(duration.inHours);
//     String minutes = twoDigits(duration.inMinutes.remainder(60));
//     String seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$hours:$minutes:$seconds";
//   }
//
//   String getImageForCurrentIndex() {
//     // if (showIntermediateImage) {
//     //   return 'assets/images/intermediate_image.png';
//     // } else if (showDefaultImage) {
//     //   return 'assets/images/Diya.png';
//     // }
//
//     return 'assets/images/diya_animation_$currentImageIndex.gif';
//   }

class _AkhandJyotiScreenState extends State<AkhandJyotiScreen> {
  Duration remainingTime = Duration(hours: 24);
  bool isButtonPressed = false;
  bool showIntermediateImage = false;
  Timer? timer;
  int currentImageIndex = 1;
  bool showDefaultImage = true;
  List<bool> dayStatuses = List.generate(7, (index) => false); // Track status for 7 days
  int startButtonPressCount = 0; // Track the number of times the button is pressed

  // Calculate the total time in seconds
  static const int totalTimeInSeconds = 24 * 60 * 60; // 24 hours in seconds

  @override
  void initState() {
    super.initState();
    _loadTimerState();
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRemainingTime = prefs.getInt('remainingTime') ?? totalTimeInSeconds;
    final timerStarted = prefs.getBool('isTimerRunning') ?? false;
    final savedDayStatuses = prefs.getStringList('dayStatuses')?.map((e) => e == 'true').toList() ?? List.generate(7, (index) => false);
    final savedPressCount = prefs.getInt('startButtonPressCount') ?? 0;

    setState(() {
      remainingTime = Duration(seconds: savedRemainingTime);
      isButtonPressed = timerStarted;
      dayStatuses = savedDayStatuses;
      startButtonPressCount = savedPressCount;
      showDefaultImage = !timerStarted;
    });

    if (timerStarted) {
      startTimer(resume: true);
    }
  }

  Future<void> _saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('remainingTime', remainingTime.inSeconds);
    await prefs.setBool('isTimerRunning', isButtonPressed);
    await prefs.setStringList('dayStatuses', dayStatuses.map((e) => e.toString()).toList());
    // await prefs.setInt('startButtonPressCount', startButtonPressCount);
  }

  void startTimer({bool resume = false, bool isRestart = false}) {
    if (!resume) {
      remainingTime = Duration(hours: 24); // Reset the timer duration
      currentImageIndex = 1;
      showDefaultImage = false;
      updateDayStatus();

      // Increment the count only for fresh starts (not restarts)
      if (!isRestart) {
        setState(() {
          startButtonPressCount += 1;
        });
      }
    }

    setState(() {
      isButtonPressed = true;
    });

    // Start the timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        if (remainingTime > Duration.zero) {
          remainingTime -= Duration(seconds: 1);
          updateImageIndex();
        } else {
          timer.cancel();
          isButtonPressed = false;
          showIntermediateThenFinalImage();
        }
      });

      // Save the state
      await _saveTimerState();
    });
  }

  void restartTimer() {
    stopTimer(); // Cancel the current timer
    setState(() {
      remainingTime = Duration(hours: 24); // Reset the timer to 24 hours
      currentImageIndex = 1; // Reset the image index
      showDefaultImage = false; // Set the default image to false
    });
    startTimer(isRestart: true); // Start the timer with isRestart set to true
  }


  void stopTimer() async {
    if (timer != null) {
      timer!.cancel();
    }
    setState(() {
      isButtonPressed = false;
      showDefaultImage = true;
      currentImageIndex = 1;
    });
    await _saveTimerState();
  }

  void updateImageIndex() {
    int hoursElapsed = 24 - remainingTime.inHours;
    if (hoursElapsed < 6) {
      currentImageIndex = 1;
    } else if (hoursElapsed < 12) {
      currentImageIndex = 2;
    } else if (hoursElapsed < 18) {
      currentImageIndex = 3;
    } else if (hoursElapsed == 18) {
      currentImageIndex = 4;
    } else if (hoursElapsed == 19) {
      currentImageIndex = 5;
    } else if (hoursElapsed == 20) {
      currentImageIndex = 6;
    } else if (hoursElapsed == 21) {
      currentImageIndex = 7;
    } else if (hoursElapsed == 22) {
      currentImageIndex = 8;
    } else if (hoursElapsed == 23) {
      currentImageIndex = 9;
    }
  }

  void updateDayStatus() {
    final currentDay = DateTime.now().weekday - 1; // Monday is 1, so subtract 1 to make it 0-indexed
    setState(() {
      if (currentDay == 0) {
        // If it's Monday, reset all days
        dayStatuses = List.generate(7, (index) => false);
      }
      dayStatuses[currentDay] = true; // Light up the current day
    });
  }

  void increaseTime() {
    setState(() {
      if (remainingTime > Duration(hours: 1)) {
        remainingTime -= Duration(hours: 1);
        updateImageIndex();
      }
    });
  }

  void decreaseTime() {
    setState(() {
      if (remainingTime < Duration(hours: 24)) {
        remainingTime += Duration(hours: 1);
        updateImageIndex();
      }
    });
  }

  void increaseMinute() {
    setState(() {
      if (remainingTime > Duration(minutes: 1)) {
        remainingTime -= Duration(minutes: 1);
        updateImageIndex();
      }
    });
  }

  void decreaseMinute() {
    setState(() {
      if (remainingTime < Duration(days: 1)) {
        remainingTime += Duration(minutes: 1);
        updateImageIndex();
      }
    });
  }

  void showIntermediateThenFinalImage() {
    setState(() {
      showIntermediateImage = true;
      showDefaultImage = false;
    });

    Timer(Duration(seconds: 5), () {
      setState(() {
        showIntermediateImage = false;
        showDefaultImage = true;
      });
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  String getImageForCurrentIndex() {
    return 'assets/images/diya_animation_$currentImageIndex.gif';
  }



  @override
  Widget build(BuildContext context) {

    // Calculate the progress as a fraction of remaining time
    double progress = remainingTime.inSeconds / totalTimeInSeconds;

    // Interpolate colors based on remaining time
    Color currentColor = Color.lerp(Colors.green, Colors.red, 1 - progress)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text(
          "Akhand Jyoti",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  children: [
                    Container(
                      color: Colors.orange,
                      height: 20,
                      width: 3,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Longest continuous attendance",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.report_gmailerrorred_sharp,
                      color: Colors.orange,
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // 8 Din Section
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CountdownScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFF9E6D7), Color(0xFFFEBC01)], // Subtle gradient background
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15), // More rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20), // More padding for spacing
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Left Column for Text Information
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$startButtonPressCount \u0926\u093f\u0928",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(130, 44, 12, 1),
                                  ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: 220,
                                  child: Text(
                                    "\u092a\u093f\u091a\u0932\u0947 $startButtonPressCount \u0926\u093f\u0928\u094b\u0902 \u0938\u0947 \u0906\u092a\u0928\u0947 \u0938\u092e\u092f \u092a\u0930 \u0926\u0940\u092a\u0915 \u091c\u0932\u093e\u0924\u0947 \u0939\u0948\u0964",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(161, 51, 11, 1),
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: 220,
                                  child: Text(
                                    "आपके दिए में इतने समय बाद तेल ख़तम हो जाएगा",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),

                            // Right Column for Timer and Image Display
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isButtonPressed)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 6),
                                        child: Image.asset(
                                          getImageForCurrentIndex(),
                                          height: 100,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        formatDuration(remainingTime),
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),

                                    ],
                                  )
                                else if (showIntermediateImage)
                                  Padding(
                                    padding:  EdgeInsets.only(bottom: 48.0, right: 6),
                                    child: Image.asset(
                                      showIntermediateImage
                                          ? "assets/images/diya_smoke_3.gif" // Intermediate image
                                          : showDefaultImage
                                          ? "assets/images/Diya.png" // Default image
                                          : getImageForCurrentIndex(), // Timer-progress image
                                      height: 100,
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 48.0, right: 6),
                                    child: Image.asset("assets/images/Diya.png", height: 100),
                                  ),
                              ],
                            ),

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex:1,
                              child: LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(10),
                                value: progress,
                                minHeight: 15,
                                valueColor: AlwaysStoppedAnimation<Color>(currentColor),
                                backgroundColor: Colors.grey.shade300,
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            Expanded(
                              flex: 0,
                              child: IconButton(

                                  onPressed: () {
                                    restartTimer();
                                  },
                                  icon: Icon(Icons.restart_alt_sharp,color: Colors.red,size: 30,)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Start Stop Timer Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (isButtonPressed) {
                            // If the timer is running, stop and show intermediate image
                            isButtonPressed = false;
                            stopTimer();
                            showIntermediateThenFinalImage();
                          } else {
                            // Start the timer
                            isButtonPressed = true;
                            startTimer();
                          }
                        });
                      },
                      child: Text(
                        isButtonPressed ? "Stop Timer" : "Start Timer",
                        style: TextStyle(
                          color: isButtonPressed ? Colors.white : Colors.brown,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        isButtonPressed ? Colors.red : Colors.orange,
                        padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        restartTimer();
                      },
                      child: Text(
                        "Restart Timer",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                        EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 20),

                // HOURS Increase Decrease Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: increaseTime,
                      child: Text("-1 Hour"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: decreaseTime,
                      child: Text("+1 Hour"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // MINUTES Increase Decrease Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: increaseMinute,
                      child: Text("-1 Min"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: decreaseMinute,
                      child: Text("+1 Min"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Progress Indicator
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 1, left: 1),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              isButtonPressed
                                  ? 'आज दीपक जल चुका है'
                                  : 'आज दीपक नहीं जलाया गया है',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: Icon(
                                isButtonPressed ? Icons.check_circle : Icons.cancel,
                                color: isButtonPressed ? Colors.green : Colors.red,
                                size: 19,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 7),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(7, (index) {
                          // List of weekdays
                          List<String> weekdays = [
                            "Mon",
                            "Tue",
                            "Wed",
                            "Thu",
                            "Fri",
                            "Sat",
                            "Sun"
                          ];

                          return Column(
                            children: [
                              Container(
                                width: 40.0, // Set the desired width
                                height: 40.0, // Set the desired height
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle, // Makes the container circular
                                  image: DecorationImage(
                                    image: AssetImage(
                                      dayStatuses[index]
                                          ? 'assets/images/diya_animation_1.gif' // Active image for all days
                                          : 'assets/images/Diya.png', // Inactive image for all days
                                    ),
                                    fit: BoxFit.cover, // Ensures the image covers the entire container
                                  ),
                                ),
                              ),
                              Text(weekdays[index], style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400)), // Use the weekdays list here
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // People Section
                Row(
                  children: [
                    Container(
                      color: Colors.orange,
                      height: 20,
                      width: 3,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "People who have lit lamps daily till date",
                      
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.report_gmailerrorred_sharp,
                      color: Colors.orange,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                            child: Icon(Icons.person,size: 30,color: Colors.orangeAccent),
                            // backgroundImage: NetworkImage('https://s3-alpha-sig.figma.com/img/2203/d853/cb4fa82e4897cb5c086f17635b2f6cb8?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=baxs6YKoVrEQ71BJBV-9~Df~26qPmtNBcoMY1Nl4LzA7N31Aw6jM~tjI~hNJ3s-GimKNDRmPACoh7zzZOAthu6dJJDbxo8ovQ2oZQ0jf~4BeInYtOZeKO0qp0BrorLJn7HMxHsuIPyE5WSbs2Cae3V2JUGZ4zwzdy7RH4p78WMG~Nw1yh8PUsbLvgxJz2HnwJMkTyvuc26i8MJdRglrd0DblVJHolVb0z5D3dKZUQvk1db-JdE7-Ur-zuknvfJJlsXxeZV1GJPnSKWSNzZoESJsbIRYSTG3Ax2KcEJEhrOA14aluHFluhLkv1VSytTP3682IRufpD6fUNrFjQTzuRw__')
                        ),
                        CircleAvatar(
                          child: Icon(Icons.person_2,size: 30,color: Colors.orangeAccent),
                            // backgroundImage: NetworkImage('https://s3-alpha-sig.figma.com/img/016a/61fa/4126e7b329d1ef2bac018eab8370d34d?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=f4TPLN2tmb-fZSSxpynI7blaKtE-6IaZpRu~ebn9U4cOJV9de6VwVzjSTJIPjYxB11CTeqq8o~wMw3Lbk67lQgkB-e8pv9y7Ae3kBLr9SNZwhVtuXK4~8rFKPbx-SjZM4ZHffI~wwQbc4kE8kbj~ugw3XW3DS6qei6ds-HtfYlWGOLcXuvscjlhoomfMLKhrzSG3Wi0oSaXSVKyOObxVSGRRoI4M2XwG71mrd-JfmdGSyI09ZM7tFh7wJ0GhnRN0UHkGGCXguP5x7YbEcRCrvXbcmXJH~4jVjiHu9UWmSd6qqF~4O2QrVsG4OKXShc6p5t6iNVGI7mAF8oZAPEm9bg__')
                        ),
                        CircleAvatar(
                          child: Icon(Icons.person_3,size: 30,color: Colors.orangeAccent),
                            // backgroundImage: NetworkImage('https://s3-alpha-sig.figma.com/img/dfad/84e6/3f84762148b03f58bd678a82a540b2d1?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=BYbErDnoYHK1DYu4nnMG5vTHtDV5zyasmlx40g2Z72IISL~82KEDrq8COH~ZNV~zUhwVrBjQAehaA6IrU7qY0cOaF7jqlaUDNubiq2jEfxI8Y8MecCvHoi473~GNzrh4v9xaKjqn3EM703KUXyJzP760ut5SnzYs6f3OyOEi4RBUHZ0CDguCV1s9owHDKRf-vIixb7hOZFC2gl~lZjt2nPWigdn3kIhgG65bguGtIjeEevfVtDtRv7LUyZnGSI~1SCOqHE4ma0Gwq09x6iyRCiXnmjsrAqyO6~U61ojdTI8h8hTBUtdKGMoz20NZyMO~kOI2WWwfOQMCPq9hnZzGvw__')
                        ),
                        Spacer(),
                        Container(
                          width: 25.0, // Adjust the width as needed
                          height: 25.0, // Adjust the height as needed
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/diya.gif'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          "103K+",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Tasks Section
                Row(
                  children: [
                    Container(
                      color: Colors.orange,
                      height: 20,
                      width: 3,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Some task for you",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.report_gmailerrorred_sharp,
                      color: Colors.orange,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    TaskTile(
                      title: "Perform Aarti in the temple",
                      titles: 'Earn Punya',
                    ),
                    TaskTile(
                      title: "Light Diya every evening",
                      titles: 'Earn Punya',
                    ),
                    TaskTile(
                      title: "Donate to charity",
                      titles: 'Earn Punya',
                    ),
                    TaskTile(
                      title: "Meditate daily",
                      titles: 'Earn Punya',
                    ),
                    TaskTile(
                      title: "Practice gratitude",
                      titles: 'Earn Punya',
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Invite Section
                Row(
                  children: [
                    Container(
                      color: Colors.orange,
                      height: 20,
                      width: 3,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Invite your friends and family",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.report_gmailerrorred_sharp,
                      color: Colors.orange,
                    )
                  ],
                ),
                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Connect your friends and family with mahakal.com",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "For Every member you Earn Punya and your friends and family also earn punya",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FloatingActionButton(
                            backgroundColor: Colors.blueGrey.shade600,
                            onPressed: () async {
                              await Share.share('Check out this awesome Flutter package!');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Share it",
                                  style: TextStyle(fontSize: 19, color: Colors.white),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.share, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final String title;
  final String titles;

  TaskTile({required this.title, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          child: ListTile(
            leading: SizedBox(
                width: 70,
                child: Icon(Icons.local_fire_department,size: 50,color: Colors.orangeAccent),
                // child: Image.network(
                //   'https://s3-alpha-sig.figma.com/img/2f98/a619/3ddb43bfd8c921b157362025fd50e7ec?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qhthrFG8iJxyaKlCjBjSGiznk5vg6CvTxbMp8eGA16QBf1o0e7YH5Xm3ymyCgVDB9qsmO5A3R1icPDblNYoIJBTp0wySawWGGCQgQ3CqUuXmygmV2cjDaiQyHmIVdWmox~rLxdAVIaf8z-yxMomOSBAsPffSTsaF1gPxlXJxw1NvU6z0mddk-NdYq0c3DSbO5C56MJwJ1VZdVGRqUt7OgI0f7dk4AJXkpXnNbD5AniYqeK7N8CS1WKsuA6LtYoBNsixuxypoGm0gZv45N0tWbj~HwzTpIN5QofWCGp7gmOCs5Q-WsIrgTedLexE3PWQYQerjt7dFQkwii2bB7BaFeg__',
                // )
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ),
                Text(
                  titles,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Get Now",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
