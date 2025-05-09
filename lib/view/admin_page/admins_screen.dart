import 'package:flutter/material.dart';
import 'package:neuro_math/view/admin_page/widgets/students_number_widget.dart';
import 'package:neuro_math/view/auth/views/login/login.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // متغيرات لإنشاء حسابات
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // متغيرات لتخزين الأسئلة (تشمل السؤال والإجابة الصحيحة)
  List<Map<String, String>> questions = [];

  // متغيرات لإعداد الامتحان
  TextEditingController questionController = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  List<String> selectedStudents = [];
  List<String> allStudents = ['student1', 'student2', 'student3'];

  // بيانات الطلاب (مؤقتًا للتجربة)
  List<Map<String, dynamic>> studentData = [
    {
      "name": "student1",
      "correctAnswers": 5,
      "wrongAnswers": 2,
      "level": 15,
      "lastLogin": "2025-02-25 10:30"
    },
    {
      "name": "student2",
      "correctAnswers": 3,
      "wrongAnswers": 4,
      "level": 10,
      "lastLogin": "2025-02-26 12:45"
    },
    {
      "name": "student3",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },    {
      "name": "student4",
      "correctAnswers": 8,
      "wrongAnswers": 0,
      "level": 10,
      "lastLogin": "2025-02-27 08:20"
    },    {
      "name": "student5",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },    {
      "name": "student6",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },    {
      "name": "student7",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },    {
      "name": "student8",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },    {
      "name": "student9",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },
    {
      "name": "student10",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },
    {
      "name": "student11",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },
    {
      "name": "student12",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },
    {
      "name": "student13",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },
    {
      "name": "student14",
      "correctAnswers": 6,
      "wrongAnswers": 1,
      "level": 8,
      "lastLogin": "2025-02-27 08:20"
    },
  ];

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    questionController.dispose();
    correctAnswerController.dispose();
    timeController.dispose();
    super.dispose();
  }

  // دالة لإنشاء حساب طالب
  void createStudentAccount() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    if (username.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم إنشاء حساب للطالب: $username')),
      );
      usernameController.clear();
      passwordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال جميع البيانات')),
      );
    }
  }

  // دالة لإضافة سؤال مع الإجابة الصحيحة
  void addQuestion() {
    String question = questionController.text.trim();
    String correctAnswer = correctAnswerController.text.trim();
    if (question.isNotEmpty && correctAnswer.isNotEmpty) {
      setState(() {
        questions.add({"question": question, "correctAnswer": correctAnswer});
      });
      questionController.clear();
      correctAnswerController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال السؤال والإجابة الصحيحة')),
      );
    }
  }

  // دالة لحذف سؤال
  void deleteQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }

  // دالة لإرسال الامتحان مع الوقت المحدد
  void sendExam() {
    String time = timeController.text.trim();
    if (questions.isNotEmpty &&
        time.isNotEmpty &&
        selectedStudents.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال الامتحان بنجاح')),
      );
      timeController.clear();
      selectedStudents.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال جميع البيانات')),
      );
    }
  }

  // دالة لتسجيل الخروج
  void logout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("لوحة تحكم الأدمن"),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: logout,
                tooltip: "تسجيل الخروج"),
          ],
          bottom: const TabBar(
            tabs: [
              // Tab(icon: Icon(Icons.account_circle), text: "إنشاء حسابات"),
              Tab(icon: Icon(Icons.quiz), text: "إعداد امتحان"),
              Tab(icon: Icon(Icons.person), text: "بيانات الطلاب"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // تبويب إنشاء حسابات
            // SingleChildScrollView(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text("إنشاء حساب طالب",
            //             style: TextStyle(
            //                 fontSize: 20, fontWeight: FontWeight.bold)),
            //         const SizedBox(height: 10),
            //         TextField(
            //             controller: usernameController,
            //             decoration: const InputDecoration(
            //                 labelText: "اسم المستخدم",
            //                 border: OutlineInputBorder())
            //         ),
            //         const SizedBox(height: 10),
            //         TextField(
            //             controller: passwordController,
            //             decoration: const InputDecoration(
            //                 labelText: "كلمة المرور",
            //                 border: OutlineInputBorder()),
            //             obscureText: true),
            //         const SizedBox(height: 16),
            //         Center(
            //           child: ElevatedButton.icon(
            //             onPressed: createStudentAccount,
            //             icon: const Icon(Icons.add, color: Colors.black),
            //             label: const Text("إنشاء حساب",
            //                 style: TextStyle(color: Colors.black)),
            //             style: ElevatedButton.styleFrom(
            //                 backgroundColor: Colors.blue),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // تبويب إعداد الامتحان
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("إعداد امتحان",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextField(
                        controller: questionController,
                        decoration: const InputDecoration(
                            labelText: "أدخل سؤال",
                            border: OutlineInputBorder())),
                    const SizedBox(height: 10),
                    TextField(
                        controller: correctAnswerController,
                        decoration: const InputDecoration(
                            labelText: "الإجابة الصحيحة",
                            border: OutlineInputBorder())),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                        onPressed: addQuestion,
                        icon: const Icon(Icons.add),
                        label: const Text("إضافة سؤال")),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(questions[index]['question']!),
                            subtitle: Text(
                                "الإجابة الصحيحة: ${questions[index]['correctAnswer']}"),
                            trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteQuestion(index)),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                        controller: timeController,
                        decoration: const InputDecoration(
                            labelText: "الوقت بالدقائق",
                            border: OutlineInputBorder())),
                    const SizedBox(height: 10),
                    const Text("اختر الطلاب لإرسال الامتحان إليهم:"),
                    Card(
                      elevation: 2,
                      child: ExpansionTile(
                        title: const Text("أسماء الطلاب"),
                        children: allStudents.map((student) {
                          return CheckboxListTile(
                            title: Text(student),
                            value: selectedStudents.contains(student),
                            onChanged: (isChecked) {
                              setState(() {
                                isChecked!
                                    ? selectedStudents.add(student)
                                    : selectedStudents.remove(student);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                        onPressed: sendExam,
                        icon: const Icon(Icons.send),
                        label: const Text("إرسال الامتحان")),
                  ],
                ),
              ),
            ),
            // تبويب بيانات الطلاب
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StudentsNumberWidget(studentsNumber: studentData.length,),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: studentData.length,
                    itemBuilder: (context, index) {
                      final student = studentData[index];
                      return Container(
                        padding: EdgeInsetsDirectional.only(start: 18,top: 16,bottom: 16),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF000000).withOpacity(0.25),
                              offset: Offset(0, 4),
                              blurRadius: 4
                            )
                          ],
                          border: Border.all(
                            color: Color(0xFF9EA2A6),
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text("${student['name']}",
                              style: TextStyle(
                                fontSize: 15,
                                  fontWeight: FontWeight.w400,
                              )),
                            Text( " المستوى :${student['level']}",
                            textAlign: TextAlign.start,
                            ),
                            Text(
                                "عدد الإجابات الصحيحة: ${student['correctAnswers']}"),
                            Text(
                                "عدد الإجابات الخاطئة: ${student['wrongAnswers']}"),
                            Text("آخر تسجيل دخول: ${student['lastLogin']}"),
                          ],
                        ),

                      );
                      return Card(
                        child: ListTile(
                          title: Text(student['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "عدد الإجابات الصحيحة: ${student['correctAnswers']}"),
                              Text(
                                  "عدد الإجابات الخاطئة: ${student['wrongAnswers']}"),
                              Text("آخر تسجيل دخول: ${student['lastLogin']}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
