import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_math/bloc/universal_state.dart';

class UniversalStateCubit<T> extends Cubit<UniversalState<T>> {
  UniversalStateCubit() : super(const UniversalState.initial());

  void setInitial() => emit(const UniversalState.initial());
  void setLoading() => emit(const UniversalState.loading());
  void setSuccess(T data) => emit(UniversalState.success(data));
  void setFailure(String error) => emit(UniversalState.failure(error));
}