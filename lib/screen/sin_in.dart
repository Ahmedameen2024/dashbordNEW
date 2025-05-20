// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controll/AuthController.dart';
// import 'package:flutter_application_1/controll/nav_controller.dart';
// import 'package:flutter_application_1/widget/my_button.dart';
// import 'package:get/get.dart';

// class SinIn extends StatefulWidget {
//   static const String sinInScreenRout = 'SinIn';

//   const SinIn({super.key});

//   @override
//   State<SinIn> createState() => _SinInState();
// }

// class _SinInState extends State<SinIn> {
//   final AuthController authController = Get.put(AuthController());
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   final NavController navController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Logo Image
//             SizedBox(
//               height: 100,
//               // child: Image.asset('images/كلية الطب .png'),
//             ),

//             // Space between the logo and the next fields
//             const SizedBox(
//               height: 50,
//             ),

//             // Email Field
//             TextField(
//               controller: usernameController,
//               keyboardType: TextInputType.emailAddress,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                 hintText: 'Enter your Email',
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.orange, width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.blue, width: 2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),

//             // Space between fields
//             const SizedBox(
//               height: 10,
//             ),

//             // Password Field
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                 hintText: 'Enter your password',
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.orange, width: 1),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.blue, width: 2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),

//             // Space between password field and button
//             const SizedBox(
//               height: 20,
//             ),

//             // Sign In Button
//             MyButton(
//               color: Colors.yellow[800]!,
//               titel: 'Sign In',
//               onpressed: () {
//                 // Call login function when pressed
//                 authController.login(
//                   usernameController.text,
//                   passwordController.text,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_application_1/controll/AuthController.dart';
import 'package:flutter_application_1/widget/my_button.dart';
import 'package:get/get.dart';

class SinIn extends StatefulWidget {
  static const String sinInScreenRout = 'SinIn';

  const SinIn({super.key});

  @override
  State<SinIn> createState() => _SinInState();
}

class _SinInState extends State<SinIn> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo (اختياري)
            const SizedBox(height: 100),
            // const Image(image: AssetImage('images/logo.png')),

            const SizedBox(height: 50),

            // Email or Username Field
            TextField(
              controller: usernameController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter your email or username',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Password Field
            TextField(
              controller: passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Sign In Button with loading
            Obx(() {
              return authController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : MyButton(
                      color: Colors.yellow[800]!,
                      titel: 'Sign In',
                      onpressed: () {
                        authController.login(
                          usernameController.text,
                          passwordController.text,
                        );
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}
