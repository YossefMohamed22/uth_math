import 'package:neuro_math/bloc/universal_bloc.dart';

class UniversalCubitFactory {
  final Map<Type, dynamic> _cubits = {};

  UniversalStateCubit<T> getCubit<T>() {
    if (!_cubits.containsKey(T)) {
      _cubits[T] = UniversalStateCubit<T>();
    }
    return _cubits[T] as UniversalStateCubit<T>;
  }
}