import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../home_page.dart';
import 'admins_screen.dart';
import 'exam_screen.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/admin': (context) => const AdminScreen(),
        '/exam': (context) => const ExamPage(
              questions: [
                {"question": "5 + 3", "answer": "8"},
                {"question": "6 - 4", "answer": "2"},
                {"question": "1 - 4", "answer": "3"},
                {"question": "10 - 2", "answer": "8"}, // مثال لسؤال إضافي
              ],
              examTime: 120,
            ),
        '/main': (context) => const HomePage(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // المتغير الخاص باختيار نوع الحساب يدويًا
  String selectedRole = 'student'; // القيمة الافتراضية
  final List<String> roles = ['admin', 'student'];

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      String hashedPassword = hashPassword(password);
      String userRole = selectedRole;

      // محاكاة الاتصال بالـ API
      await Future.delayed(const Duration(seconds: 2));

      // للتحقق من الحسابات (مثال بسيط بدون قاعدة بيانات)
      if (userRole == "admin" &&
          username == "admin" &&
          hashedPassword == hashPassword("admin123")) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/admin');
      } else if (userRole == "student" &&
          username == "student" &&
          hashedPassword == hashPassword("student123")) {
        // مثال: الطالب لو عنده امتحان
        bool hasExam = true; // يمكنك تغيير القيمة لمحاكاة الحالة
        if (hasExam) {
          Navigator.pushReplacementNamed(context, '/exam');
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/main');
        }
      } else {
        showErrorMessage("اسم المستخدم أو كلمة المرور غير صحيحة.");
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "اسم المستخدم",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال اسم المستخدم";
                    } else if (value.contains(" ")) {
                      return "اسم المستخدم لا يجب أن يحتوي على مسافات";
                    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                      return "اسم المستخدم يجب أن يحتوي على أحرف أو أرقام فقط";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "كلمة المرور",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "الرجاء إدخال كلمة المرور";
                    } else if (value.length < 6) {
                      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  items: roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newRole) {
                    setState(() {
                      selectedRole = newRole!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "نوع الحساب",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("تسجيل الدخول"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
