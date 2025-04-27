import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:neuro_math/core/bloc/universal_bloc.dart';
import 'dart:math';

class MultiOperationLogic {

  MultiOperationLogic(){
    shuffleNumbers();
    durationFastCubit.setSuccess(1);
  }


   List<String> numbers = List.generate(100, (index) => index.toString());
   List<int> userSelectNumbers = [];

  final UniversalCubit<String> resultCubit = UniversalCubit();
  final UniversalCubit<int> durationFastCubit = UniversalCubit<int>();

  final ScrollController scrollController = ScrollController();



  late final AnimationController animationController;


  void inCreaseSpeed(){
    var previousDuration = durationFastCubit.data!;
    if(previousDuration < 3){
      durationFastCubit.setSuccess(previousDuration+1);
    }
  }

  void updateResult(String selectedNumber){
    final String currentValue = resultCubit.data!;
    resultCubit.setSuccess("$currentValue$selectedNumber");
  }

  void initAnimationController(TickerProvider vsync) {
    animationController = AnimationController(
      duration: Duration(seconds: durationFastCubit.data!),
      vsync: vsync,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        animationController.forward();
      }
    });
  }

  void shuffleNumbers() {
    final random = Random();
    numbers.shuffle(random);
    userSelectNumbers = numbers.take(7).map((e) => int.parse(e)).toList();
  }




}