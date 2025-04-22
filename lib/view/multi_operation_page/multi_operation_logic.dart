import 'package:flutter/animation.dart';
import 'package:neuro_math/bloc/universal_bloc.dart';

class MultiOperationLogic {

  final List<String> numbers = List.generate(10, (index) => index.toString());

  final UniversalStateCubit<String> resultCubit = UniversalStateCubit();

  final List<int> userSelectNumbers = [1,2,3,4,5,6,7,8,9];

  late final AnimationController animationController;


  void updateResult(String selectedNumber){
    final currentValue = resultCubit.state.maybeWhen(
      success: (data) => data as String? ?? "",
      orElse: () => "",
    );
    resultCubit.setSuccess("$currentValue$selectedNumber");
  }


  void initAnimationController(TickerProvider vsync) {
    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: vsync,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
        animationController.forward();
      }
    });
  }




}