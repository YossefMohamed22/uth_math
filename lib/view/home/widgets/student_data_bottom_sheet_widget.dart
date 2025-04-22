
import 'package:flutter/material.dart';

class StudentDataBottomSheetWidget extends StatelessWidget {
  const StudentDataBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> studentData = {
      "trainerName":"ياسين",
      "student":"محمد",
      "parent":"عمر محمود ياسر",
      "birthDate":"2018-2-8",
      "level":"100",
    };


    return Container(
      height: MediaQuery.of(context).size.height*0.4,
      decoration: BoxDecoration(
        color: Colors.white,
     borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF9EA2A6),
                          ),
                        shape: BoxShape.circle
                      ),
                      child: Icon(Icons.clear,size: 18,color: Colors.black,)),
                ),
                SizedBox(width: 16,)
              ],
            ),
            SizedBox(height: 15,),
            _buildContainer("إسم المدرب : ${studentData["trainerName"]}"),
            _buildContainer("اسم الطالب : ${studentData["student"]}"),
            _buildContainer("إسم الوالد : ${studentData["parent"]}"),
            _buildContainer("تاريخ الميلاد : ${studentData["birthDate"]}"),
            _buildContainer("المستوى : ${studentData["level"]}",isLastItem: true),
          ],
        ),
      ),
    );
  }

  Container _buildContainer(String text,{bool isLastItem = false}) {
    return Container(
          padding: EdgeInsets.symmetric(vertical: 7,horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                  color: isLastItem
                      ?Colors.black
                      :Colors.transparent,
                  width: 0.5
              ),
              top:_borderSide() ,
              left: _borderSide(),
              right: _borderSide(),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 16,)
            ],
          ),
        );
  }

  BorderSide _borderSide() {
    return BorderSide(
                color: Colors.black,
                width: 0.5
            );
  }
}
