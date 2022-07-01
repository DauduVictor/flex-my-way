// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flex_my_way/util/util.dart';
// import 'package:get/get.dart';
// import '../controllers/user-controller.dart';
// import '../networking/flex-datasource.dart';
//
// class ReusablePendingInviteButton extends StatelessWidget {
//
//   final String? invites;
//
//   ReusablePendingInviteButton({
//     Key? key,
//     this.invites
//   }) : super(key: key);
//
//   /// calling the user controller [UserController]
//   final UserController userController = Get.find<UserController>();
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Column(
//       children: [
//         Container(
//           width: SizeConfig.screenWidth,
//           padding: const EdgeInsets.fromLTRB(32, 28, 5, 28),
//           decoration: BoxDecoration(
//             color: whiteColor,
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         style: textTheme.bodyText2!,
//                         children: [
//                           TextSpan(
//                             text: '#12345678',
//                             style: textTheme.bodyText1!.copyWith(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const TextSpan(
//                             text: ' wants in.',
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       'Afro Nation Festival',
//                       style: textTheme.bodyText2!.copyWith(
//                         fontSize: 14,
//                         color: neutralColor.withOpacity(0.7),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: TextButton(
//                       onPressed: () {
//                         print(userController.invitesList);
//                         print(invites);
//                         userController.invitesList.removeAt(int.parse(invites!));
//                         print(userController.invitesList);
//                         // userController.update();
//                         // print(userController.invitesList);
//                         // acceptAttendee('', []);
//                       },
//                       child: const Icon(
//                         Icons.check,
//                         color: greenColor,
//                         size: 25,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 4),
//                   SizedBox(
//                     width: 50,
//                     height: 50,
//                     child: TextButton(
//                       onPressed: () {
//                         print(userController.invitesList);
//                         print(invites);
//                         userController.invitesList.removeAt(int.parse(invites!));
//                         print(userController.invitesList);
//                         // rejectAttendee('', []);
//                       },
//                       child: const Icon(
//                         Icons.close,
//                         color: errorColor,
//                         size: 25,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         const  SizedBox(height: 15),
//       ],
//     );
//   }
// }
//
// /// Function to make api POST request
// /// To accept attendee
// void acceptAttendee(String flexCode, List<String>? participants) async {
//   Map<String, dynamic> body = {
//     'participants': participants
//   };
//   var api = FlexDataSource();
//   await api.acceptAttendee(flexCode, body).then((flex) {
//     /// update the controller here
//   }).catchError((e){
//     log(e);
//     Functions.showMessage(e);
//   });
// }
//
// /// Function to make api POST request
// /// To reject attendee
// void rejectAttendee(String flexCode, List<String> participants) async {
//   Map<String, dynamic> body = {
//     'participants': participants
//   };
//   var api = FlexDataSource();
//   await api.rejectAttendee(flexCode, body).then((flex) {
//     /// update the controller here
//   }).catchError((e){
//     log(e);
//     Functions.showMessage(e);
//   });
// }