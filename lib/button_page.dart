import 'package:flutter/material.dart';
import 'package:testing/Janmashtami.dart';
import 'package:testing/bhai_dooj.dart';
import 'package:testing/gangaur_katha.dart';
import 'package:testing/hariyali_teej.dart';
import 'package:testing/narasimha.dart';
import 'package:testing/pashupati_vrat.dart';
import 'package:testing/ram_shalaka.dart';
import 'package:testing/rishi_panchmi.dart';
import 'package:testing/shanivaar_vrat.dart';
import 'package:testing/sharad_purnima.dart';
import 'package:testing/sheetla_saptmi.dart';
import 'package:testing/shravan.dart';
import 'package:testing/shri_suktam.dart';
import 'package:testing/vaibhav_laxmi.dart';
import 'package:testing/vat_savitri_vrat.dart';
import 'chhath_puja.dart';
import 'dasha_mata.dart';
import 'govardhan_puja.dart';
import 'guruvar_vrat.dart';
import 'hartalika_teej.dart';
import 'holi_vrat.dart';
import 'kartik_purnima.dart';
import 'karwa_chauth.dart';
import 'mangalvar_vrat.dart';
import 'nag_panchmi.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  Color _themeColor = Colors.teal; // Default theme color

  final List<Map<String, dynamic>> screens = [
    {"title": "Hartalika Teej", "widget": HartalikaTeej()},
    {"title": "Karwa Chauth", "widget": KarwaChauth()},
    {"title": "Sheetla Saptmi", "widget": SheetlaSaptmi()},
    {"title": "Rishi Panchmi", "widget": RishiPanchmi()},
    {"title": "Vaibhav Laxmi", "widget": VaibhavLaxmi()},
    {"title": "Shri Suktam", "widget": ShriSuktam()},
    {"title": "Gangaur Katha", "widget": GangaurKatha()},
    {"title": "Vat Savitri Vrat", "widget": VatSavitriVrat()},
    {"title": "Dasha Mata Vrat", "widget": Dasha_mata()},
    {"title": "Chhath Puja", "widget": ChhathPuja()},
    {"title": "Janmashtami", "widget": Janmashtami()},
    {"title": "Hariyali Teej", "widget": HariyaliTeej()},
    {"title": "Shravan", "widget": Shravan()},
    {"title": "Bhai Dooj Vrat", "widget": BhaiDooj()},
    {"title": "Narasimha", "widget": Narasimha()},
    {"title": "Sharad Purnima", "widget": SharadPurnima()},
    {"title": "Shanivaar Vrat", "widget": ShanivaarVrat()},
    {"title": "Guruvaar Vrat", "widget": GuruvarVrat()},
    {"title": "Mangalvar Vrat", "widget": MangalvarVrat()},
    {"title": "Holi Vrat", "widget": HoliVrat()},
    {"title": "Kartik Purnima", "widget": KartikPurnima()},
    {"title": "Govardhan Puja", "widget": GovardhanPuja()},
    {"title": "Nag Panchmi", "widget": NagPanchmi()},
    {"title": "Pashupati Vrat", "widget": PashupatiVrat()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sahitya Pages",style: TextStyle(color: Colors.white),),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RamShalaka())
                );
              },
              child: Text("Ram",style: TextStyle(color: Colors.white),),
          ),

          IconButton(
              onPressed: (){
                _showColorSelectionDialog();
              },
              icon: Icon(Icons.color_lens_outlined,color: Colors.white,))
        ],
        backgroundColor: _themeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10,top: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.9, // Adjust button shape
          ),
          itemCount: screens.length + 1, // +1 for Theme Color Button
          itemBuilder: (context, index) {
            if (index < screens.length) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => screens[index]["widget"],
                    ),
                  );
                },
                child: Text(screens[index]["title"],style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _themeColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              );
            }
          },
        ),
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
}
