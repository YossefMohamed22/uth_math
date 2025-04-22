import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuro_math/view/home/widgets/student_data_bottom_sheet_widget.dart';

class HomeLogic {


  void showStudentDataBottomSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StudentDataBottomSheetWidget();
      },
    );
  }


}