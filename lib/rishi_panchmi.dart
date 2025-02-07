import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class RishiPanchmi extends StatefulWidget {
  const RishiPanchmi({super.key});

  @override
  State<RishiPanchmi> createState() => _RishiPanchmiState();
}

class _RishiPanchmiState extends State<RishiPanchmi> {
  int _currentIndex = 0;
  bool _isBlackBackground = false;
  final double _scaleIncrement = 0.1;
  bool _isAutoScrolling = false;
  double _scrollSpeed = 2.0;
  late Timer _scrollTimer;
  final ScrollController _scrollController = ScrollController();

  bool _isSliderVisible =
  false; // State variable to track visibility of the slider button
  double _textScaleFactor = 15.0; // Default font size
  bool _isEnglish = false; // State variable to track language
  Color _themeColor = Colors.purpleAccent; // Default theme color

  @override
  void dispose() {
    _scrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // Method to share content
  void _shareContent() {
    String contentToShare = 'hi';
    Share.share(contentToShare, subject: 'Check out this blog!');
  }

  // Method to show a SnackBar and copy content to clipboard
  void _showCopyMessage() {
    const snackBar = SnackBar(
      content: Text('Content copied!'),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _toggleAutoScroll() {
    setState(() {
      _isAutoScrolling = !_isAutoScrolling;

      if (_isAutoScrolling) {
        _scrollTimer =
            Timer.periodic(const Duration(milliseconds: 100), (timer) {
              if (_scrollController.position.pixels <
                  _scrollController.position.maxScrollExtent) {
                _scrollController.animateTo(
                  _scrollController.position.pixels + _scrollSpeed,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                );
              } else {
                _scrollController.jumpTo(0);
              }
            });
      } else {
        _scrollTimer.cancel();
      }
    });
  }

  void _onBottomNavTap(int index) {
    if (index != 5) {
      if (_isAutoScrolling) {
        _toggleAutoScroll();
      }
    }

    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _isBlackBackground = !_isBlackBackground;
      } else if (index == 1) {
        _textScaleFactor += _scaleIncrement;
      } else if (index == 2) {
        _textScaleFactor -= _scaleIncrement;
        if (_textScaleFactor < 0.1) {
          _textScaleFactor = 0.1;
        }
      } else if (index == 3) {
        _shareContent();
      } else if (index == 4) {
        _showCopyMessage();
      } else if (index == 5) {
        _toggleAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isBlackBackground ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _isBlackBackground ? Colors.black : _themeColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
            _isEnglish ? 'Rishi Panchami Vrat' : "ऋषि पंचमी की व्रत",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.translate, color: Colors.white),
            onPressed: () {
              setState(() {
                _isEnglish = !_isEnglish; // Toggle language
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.color_lens, color: Colors.white),
            onPressed: () {
              _showColorSelectionDialog(); // Show color selection dialog
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isBlackBackground
                    ? [Colors.black, Colors.grey]
                    : [_themeColor.withOpacity(0.5), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1),

                _buildSectionTitle(_isEnglish ?"What is Rishi Panchami Vrat" :"ऋषि पंचमी का व्रत क्या होता है" ),
                _buildSectionContent(_isEnglish
                    ?"Rishi Panchami is celebrated every year on Shukla Panchami of Bhadrapada month. Usually Rishi Panchami is celebrated two days after Hartalika Teej and one day after Ganesh Chaturthi."
                    :"हर साल भाद्रपद माह की शुक्ल पंचमी को ऋषि पंचमी मनाई जाती है। आमतौर पर ऋषि पंचमी हरतालिका तीज के दो दिन बाद और गणेश चतुर्थी के एक दिन बाद मनाई जाती है।"
                ),

                _buildSectionTitle(_isEnglish ?"Method of worship of Rishi Panchami" :"ऋषि पंचमी की पूजन विधि" ),
                _buildSectionContent(_isEnglish
                    ?"On the day of Rishi Panchami, after taking bath in the morning, wear clean and light yellow clothes. Panchamrit, flowers, sandalwood, incense sticks and various types of fruits and flowers are offered in the worship. During the worship, the aarti and mantras of the sages are recited and the Vrat Katha is heard. After this, the devotees keep Nirjala or fruit-eating fast and meditate on the Sapta Rishis along with God throughout the day."
                    :"ऋषि पंचमी के दिन सवेरे स्नानादि के बाद साफ-सुथरे और हल्के पीले रंग के वस्‍त्र पहनें .पूजा में पंचामृत, पुष्प, चंदन, धूप-दीप और विभिन्न प्रकार के फल-फूल अर्पित किए जाते हैं। पूजा के दौरान ऋषियों की आरती व मंत्रों का पाठ किया जाता है और व्रत कथा सुनी जाती है। इसके बाद श्रद्धालु निर्जला या फलाहार व्रत रखते हैं और दिनभर भगवान के साथ सप्त ऋषियों का ध्यान करते हैं"
                ),
                _buildBulletPoint(_isEnglish
                    ? "Clean the house and temple."
                    : "घर और मंदिर की सफ़ाई करें."
                ), _buildBulletPoint(_isEnglish
                    ? "Place the picture or idol of the Sapta Rishis on a wooden stand."
                    : "लकड़ी की चौकी पर सप्त ऋषियों की तस्वीर या मूर्ति रखें."
                ),_buildBulletPoint(_isEnglish
                    ? "Place a vessel filled with water along with the chowki."
                    : "चौकी के साथ जल से भरा कलश रखें."
                ),_buildBulletPoint(_isEnglish
                    ? "Offer incense, lamp, fruits, flowers, sweets, and naivedya."
                    : "धूप, दीप, फल, फूल, मिठाई, और नैवेद्य अर्पित करें."
                ),_buildBulletPoint(_isEnglish
                    ? "Apologize to the Sapta Rishis for your mistakes."
                    : "सप्त ऋषियों से अपनी गलतियों के लिए माफ़ी मांगें."
                ),_buildBulletPoint(_isEnglish
                    ? "Take a pledge to help others."
                    : "दूसरों की मदद करने का संकल्प लें."
                ),_buildBulletPoint(_isEnglish
                    ? "Perform the aarti of the Sapta Rishis."
                    : "सप्त ऋषियों की आरती उतारें."
                ),_buildBulletPoint(_isEnglish
                    ? "Listen to the Vrat Katha."
                    : "व्रत कथा सुनें."
                ),_buildBulletPoint(_isEnglish
                    ? "Distribute the bhog as prasad."
                    : "भोग को प्रसाद के रूप में वितरित करें."
                ),_buildBulletPoint(_isEnglish
                    ? "Take the blessings of the elders."
                    : "बड़े-बुज़ुर्गों का आशीर्वाद लें."
                ),


                _buildSectionTitle(_isEnglish ?"Puja Samagri for Rishi Panchami Vrat." :"ऋषि पंचमी के व्रत की पूजा सामग्री." ),
                _buildSectionContent(_isEnglish
                    ?"\n\n"
                    "\n\n"
                    "\n\n"
                    :"ऋषि पंचमी के दिन सुबह जल्दी उठकर स्नान करें और घर-मंदिर की सफ़ाई करें.\n\n"
                    "पूजा के लिए लकड़ी की चौकी पर लाल या पीला कपड़ा बिछाएं.\n\n"
                    "चौकी पर सप्तऋषि की तस्वीर स्थापित करें."
                ),

                _buildSectionTitle(_isEnglish ?"Rishi Panchami Vrat Udyaapan Vidhi" :"ऋषि पंचमी व्रत उद्यापन विधि" ),
                _buildSectionContent(_isEnglish
                    ?""
                    :""
                ),

                _buildSectionTitle(_isEnglish ?"" :"" ),
                _buildSectionContent(_isEnglish
                    ?""
                    :""
                ),


                _buildSectionContent(_isEnglish ?"" :"" ),
                _buildSectionContent(_isEnglish
                    ?""
                    :""
                ),

                
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_currentIndex == 5)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    "Adjust Scroll Speed",
                    style: TextStyle(
                        color: _isBlackBackground ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Slider(
                    value: _scrollSpeed,
                    activeColor: _isBlackBackground ? Colors.white : _themeColor,
                    inactiveColor: Colors.black.withOpacity(0.5),
                    min: 1.0,
                    max: 10.0,
                    divisions: 10,
                    label: _scrollSpeed.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _scrollSpeed = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onBottomNavTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.sunny,
                    color: _isBlackBackground ? Colors.black : _themeColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_increase_outlined,
                    color: _isBlackBackground ? Colors.black : _themeColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_decrease,
                    color: _isBlackBackground ? Colors.black : _themeColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.share_outlined,
                    color: _isBlackBackground ? Colors.black : _themeColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.save,
                    color: _isBlackBackground ? Colors.black : _themeColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.slideshow,
                    color: _isBlackBackground ? Colors.black : _themeColor),
                label: '',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showColorSelectionDialog() {
    Map<Color, String> colorMap = {
      Colors.red: "Red",
      Colors.green: "Green",
      Colors.blue: "Blue",
      Colors.yellow: "Yellow",
      Colors.purple: "Purple",
      Colors.deepOrange: "Orange",
      Colors.teal: "Teal",
      Colors.brown: "Brown",
      Colors.cyan: "Cyan",
      Colors.indigo: "Indigo",
      Colors.amber: "Amber",
      Colors.lime: "Lime",
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Theme Color"),
          content: Container(
            height: 400,
            width: double.maxFinite,
            child: GridView.count(
              crossAxisCount: 3,
              children: colorMap.entries.map((entry) {
                return _colorOption(entry.key, entry.value);
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _colorOption(Color color, String colorName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _themeColor = color; // Update the theme color
        });
        Navigator.of(context).pop(); // Close the dialog
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            colorName,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: _textScaleFactor,
          fontWeight: FontWeight.bold,
          color: _isBlackBackground ? Colors.white : _themeColor,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Card(
      elevation: 4,
      color: _isBlackBackground ? Colors.black : Colors.white,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Text(
          content,
          style: TextStyle(
            fontSize: _textScaleFactor,
            color: _isBlackBackground ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Column(
      children: [
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.check_circle,
                color: _isBlackBackground ? Colors.white : _themeColor,
                size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: _textScaleFactor,
                    color: _isBlackBackground ? Colors.white : Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}



// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// class RishiPanchmi extends StatefulWidget {
//   const RishiPanchmi({super.key});
//
//   @override
//   State<RishiPanchmi> createState() => _RishiPanchmiState();
// }
//
// class _RishiPanchmiState extends State<RishiPanchmi> {
//   int _currentIndex = 0;
//   bool _isBlackBackground = false;
//   final double _scaleIncrement = 0.1;
//   bool _isAutoScrolling = false;
//   double _scrollSpeed = 2.0;
//   late Timer _scrollTimer;
//   final ScrollController _scrollController = ScrollController();
//
//   bool _isSliderVisible =
//   false; // State variable to track visibility of the slider button
//   double _textScaleFactor = 15.0; // Default font size
//   bool _isEnglish = false; // State variable to track language
//   Color _themeColor = Colors.orangeAccent; // Default theme color
//
//   @override
//   void dispose() {
//     _scrollTimer.cancel();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   // Method to share content
//   void _shareContent() {
//     String contentToShare = 'hi';
//     Share.share(contentToShare, subject: 'Check out this blog!');
//   }
//
//   // Method to show a SnackBar and copy content to clipboard
//   void _showCopyMessage() {
//     const snackBar = SnackBar(
//       content: Text('Content copied!'),
//       duration: Duration(seconds: 2),
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
//
//   void _toggleAutoScroll() {
//     setState(() {
//       _isAutoScrolling = !_isAutoScrolling;
//
//       if (_isAutoScrolling) {
//         _scrollTimer =
//             Timer.periodic(const Duration(milliseconds: 100), (timer) {
//               if (_scrollController.position.pixels <
//                   _scrollController.position.maxScrollExtent) {
//                 _scrollController.animateTo(
//                   _scrollController.position.pixels + _scrollSpeed,
//                   duration: const Duration(milliseconds: 100),
//                   curve: Curves.linear,
//                 );
//               } else {
//                 _scrollController.jumpTo(0);
//               }
//             });
//       } else {
//         _scrollTimer.cancel();
//       }
//     });
//   }
//
//   void _onBottomNavTap(int index) {
//     if (index != 5) {
//       if (_isAutoScrolling) {
//         _toggleAutoScroll();
//       }
//     }
//
//     setState(() {
//       _currentIndex = index;
//
//       if (index == 0) {
//         _isBlackBackground = !_isBlackBackground;
//       } else if (index == 1) {
//         _textScaleFactor += _scaleIncrement;
//       } else if (index == 2) {
//         _textScaleFactor -= _scaleIncrement;
//         if (_textScaleFactor < 0.1) {
//           _textScaleFactor = 0.1;
//         }
//       } else if (index == 3) {
//         _shareContent();
//       } else if (index == 4) {
//         _showCopyMessage();
//       } else if (index == 5) {
//         _toggleAutoScroll();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: _isBlackBackground ? Colors.black : Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: _isBlackBackground ? Colors.black : _themeColor,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop(); // Navigate back
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: Text(
//           _isEnglish ? 'Sheetla Saptami Vrat' : "शीतला सप्तमी व्रत",
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.translate, color: Colors.white),
//             onPressed: () {
//               setState(() {
//                 _isEnglish = !_isEnglish; // Toggle language
//               });
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.color_lens, color: Colors.white),
//             onPressed: () {
//               _showColorSelectionDialog(); // Show color selection dialog
//             },
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           controller: _scrollController,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: _isBlackBackground
//                     ? [Colors.black, Colors.grey]
//                     : [_themeColor.withOpacity(0.5), Colors.white],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             padding: EdgeInsets.all(15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 1),
//
//                 _buildSectionTitle(_isEnglish ?"" :"" ),
//                 _buildSectionContent(_isEnglish
//                     ?""
//                     :""
//                  ),
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (_currentIndex == 5)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     "Adjust Scroll Speed",
//                     style: TextStyle(
//                         color: _isBlackBackground ? Colors.white : Colors.black,
//                         fontWeight: FontWeight.w500
//                     ),
//                   ),
//                   Slider(
//                     value: _scrollSpeed,
//                     activeColor: _isBlackBackground ? Colors.white : _themeColor,
//                     inactiveColor: Colors.black.withOpacity(0.5),
//                     min: 1.0,
//                     max: 10.0,
//                     divisions: 10,
//                     label: _scrollSpeed.round().toString(),
//                     onChanged: (double value) {
//                       setState(() {
//                         _scrollSpeed = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           BottomNavigationBar(
//             currentIndex: _currentIndex,
//             onTap: _onBottomNavTap,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.sunny,
//                     color: _isBlackBackground ? Colors.black : _themeColor),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.text_increase_outlined,
//                     color: _isBlackBackground ? Colors.black : _themeColor),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.text_decrease,
//                     color: _isBlackBackground ? Colors.black : _themeColor),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.share_outlined,
//                     color: _isBlackBackground ? Colors.black : _themeColor),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.save,
//                     color: _isBlackBackground ? Colors.black : _themeColor),
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.slideshow,
//                     color: _isBlackBackground ? Colors.black : _themeColor),
//                 label: '',
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showColorSelectionDialog() {
//     Map<Color, String> colorMap = {
//       Colors.red: "Red",
//       Colors.green: "Green",
//       Colors.blue: "Blue",
//       Colors.yellow: "Yellow",
//       Colors.purple: "Purple",
//       Colors.deepOrange: "Orange",
//       Colors.teal: "Teal",
//       Colors.brown: "Brown",
//       Colors.cyan: "Cyan",
//       Colors.indigo: "Indigo",
//       Colors.amber: "Amber",
//       Colors.lime: "Lime",
//     };
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Select Theme Color"),
//           content: Container(
//             height: 400,
//             width: double.maxFinite,
//             child: GridView.count(
//               crossAxisCount: 3,
//               children: colorMap.entries.map((entry) {
//                 return _colorOption(entry.key, entry.value);
//               }).toList(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _colorOption(Color color, String colorName) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _themeColor = color; // Update the theme color
//         });
//         Navigator.of(context).pop(); // Close the dialog
//       },
//       child: Container(
//         margin: EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             colorName,
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 5),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: _textScaleFactor,
//           fontWeight: FontWeight.bold,
//           color: _isBlackBackground ? Colors.white : _themeColor,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionContent(String content) {
//     return Card(
//       elevation: 4,
//       color: _isBlackBackground ? Colors.black : Colors.white,
//       margin: EdgeInsets.symmetric(vertical: 5),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//         child: Text(
//           content,
//           style: TextStyle(
//             fontSize: _textScaleFactor,
//             color: _isBlackBackground ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBulletPoint(String text) {
//     return Column(
//       children: [
//         SizedBox(height: 8),
//         Row(
//           children: [
//             Icon(Icons.check_circle,
//                 color: _isBlackBackground ? Colors.white : _themeColor,
//                 size: 20),
//             SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 text,
//                 style: TextStyle(
//                     fontSize: _textScaleFactor,
//                     color: _isBlackBackground ? Colors.white : Colors.black),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
