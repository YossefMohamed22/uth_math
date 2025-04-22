import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_math/bloc/universal_bloc.dart';
import 'package:neuro_math/view/admin_page/admins_screen.dart';
import 'package:neuro_math/view/home/home_page.dart';
import 'package:neuro_math/view/login.dart';
import 'package:neuro_math/view/multi_operation_page/widgets/vertical_ticker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const Math());
  });
}

class Math extends StatelessWidget {
  const Math({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UniversalStateCubit<String>()),
        BlocProvider(create: (_) => UniversalStateCubit<int>()),
        BlocProvider(create: (_) => UniversalStateCubit<List<dynamic>>()),
        BlocProvider(create: (_) => UniversalStateCubit<Map<dynamic,dynamic>>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: VerticalTicker(),
        home: Login(),
        // home: AdminScreen(),
      ),
    );
  }
}
