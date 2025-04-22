import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuro_math/view/home/home_logic.dart';
import 'package:neuro_math/view/multi_operation_page/multi_operations_page.dart';

import '../divided.dart';
import '../marathon.dart';
import '../multiplied.dart';
import '../sprint_page/sprint.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }



  final HomeLogic logic = HomeLogic();



  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // قائمة الصور والصفحات
    final List<Map<String, dynamic>> items = [
      {
        'image': 'assets/plus-minus.png',
        'page': const Marathon(),
      },
      {
        'image': 'assets/multiplication.png',
        'page': const Multiplied(),
      },
      {
        'image': 'assets/division.png',
        'page': const Divided(),
      },
      {
        'image': 'assets/math.png',
        // 'page': const Sprint(),
        'page': const MultiOperationsPage(),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(
        children: [
          SizedBox(height: kToolbarHeight-10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  logic.showStudentDataBottomSheet(context);
                },
                child: Image.asset(
                  "assets/user_icon.png",
                  width: 25, height: 25,
                ),
              ),
              SizedBox(width: 16,),
            ],
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: screenWidth * 0.13,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : const AssetImage('assets/login-avatar_12123009.png')
                            as ImageProvider,
                    child: _imageFile == null
                        ? Icon(
                            Icons.camera_alt,
                            size: screenWidth * 0.1,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Hi, Your Name",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Choose the type of calculation",
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenHeight * 0.02,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: screenHeight * 0.015,
                crossAxisSpacing: screenWidth * 0.015,
                childAspectRatio: 1,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildButton(
                  context,
                  items[index]['image'],
                  items[index]['page'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String imagePath, Widget page) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 5,
        child: Container(
          width: screenWidth * 0.11,
          height: screenHeight * 0.084,
          margin: EdgeInsets.all(screenWidth * 0.03),
          padding: EdgeInsets.all(screenWidth * 0.1),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
