// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'auth_controller.dart';

// class SignInScreen extends StatelessWidget {
//   final AuthController authController = Get.put(AuthController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign In')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Your normal login fields here

//             SizedBox(height: 30),
//             ElevatedButton.icon(
//               icon: Icon(Icons.fingerprint),
//               label: Text('Login with Fingerprint'),
//               onPressed: () async {
//                 bool success = await authController.authenticateWithBiometrics();
//                 if (success) {
//                   Get.snackbar('Success', 'Fingerprint Authenticated!');
//                   // Navigate to Home Screen or Dashboard
//                 } else {
//                   Get.snackbar('Failed', 'Authentication Failed');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
