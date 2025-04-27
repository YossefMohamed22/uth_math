import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_math/core/bloc/universal_bloc.dart';
import 'package:neuro_math/core/injection/di.dart';
import 'package:neuro_math/view/admin_page/admins_screen.dart';
import 'package:neuro_math/view/home/home_page.dart';
import 'package:neuro_math/view/auth/views/login/login.dart';
import 'package:neuro_math/view/multi_operation_page/widgets/vertical_ticker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((_) {
   initInject();
    runApp(const Math());
  });

}

class Math extends StatelessWidget {
  const Math({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UniversalCubit<dynamic>()),
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
