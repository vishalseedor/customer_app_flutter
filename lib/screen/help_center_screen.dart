// import 'package:flutter/material.dart';
// import 'package:food_app/const/color_const.dart';
// import 'package:food_app/const/images.dart';

// class HelpCentreScreen extends StatelessWidget {
//   const HelpCentreScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         backgroundColor: CustomColor.orangecolor,
//         title: Text(
//           'Help Center',
//           style: TextStyle(
//               fontWeight: FontWeight.bold, color: CustomColor.whitecolor),
//         ),
//       ),
//       body: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text('Get quick customer  support by selecting your team'),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Image.asset(
//                     CustomImages.helpcenter,
//                     height: 60,
//                     width: 60,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(30),
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                   borderRadius: BorderRadius.zero,
//                 ))),
//                 child: Text(
//                   'Login to select an item',
//                   style: TextStyle(fontWeight: FontWeight.w900),
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'What issue are you facing?',
//                 style: TextStyle(fontWeight: FontWeight.w900),
//               ),
//             ),
//             Card(
//               elevation: 1,
//               child: ListTile(
//                 title: Text(
//                   'I want to track my order',
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 subtitle: Text(
//                   'Check order status & call the delivery agent',
//                   style: TextStyle(fontSize: 14),
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                   color: CustomColor.blackcolor,
//                 ),
//               ),
//             ),
//             Card(
//               elevation: 1,
//               child: ListTile(
//                 title: Text(
//                   'I want to manage my order',
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 subtitle: Text(
//                   'Cancel,change delivery date & address',
//                   style: TextStyle(fontSize: 14),
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                   color: CustomColor.blackcolor,
//                 ),
//               ),
//             ),
//             Card(
//               elevation: 1,
//               child: ListTile(
//                 title: Text(
//                   'I want help with returns & refunds',
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 subtitle: Text(
//                   'Manage and track home',
//                   style: TextStyle(fontSize: 14),
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                   color: CustomColor.blackcolor,
//                 ),
//               ),
//             ),
//             Card(
//               elevation: 1,
//               child: ListTile(
//                 title: Text(
//                   'I want help with other issues',
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 subtitle: Text(
//                   'Offer,payment,Flipkart Plus & all other issues',
//                   style: TextStyle(fontSize: 14),
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                   color: CustomColor.blackcolor,
//                 ),
//               ),
//             ),
//             Card(
//               elevation: 5,
//               child: ListTile(
//                 title: Text(
//                   'I want to contact the seller',
//                   style: TextStyle(color: CustomColor.blackcolor),
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                   color: CustomColor.blackcolor,
//                 ),
//               ),
//             ),
//             Card(
//               elevation: 5,
//               child: ListTile(
//                 title: Text(
//                   'Browse Help Topics',
//                   style: TextStyle(color: CustomColor.blackcolor),
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 16,
//                   color: CustomColor.blackcolor,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
