// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class RateUsScreen extends StatefulWidget {
//   @override
//   _RateUsScreenState createState() => _RateUsScreenState();
// }

// class _RateUsScreenState extends State<RateUsScreen> {
//   double rating = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Rate Us"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "How would you rate our app?",
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             RatingBar(
//               initialRating: rating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//               itemBuilder: (context, _) => Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               onRatingUpdate: (newRating) {
//                 setState(() {
//                   rating = newRating;
//                 });
//               }, ratingWidget: null,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (rating >= 4) {
//                   _showPositiveFeedbackDialog();
//                 } else {
//                   _showNegativeFeedbackDialog();
//                 }
//               },
//               child: Text("Submit"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showPositiveFeedbackDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Thank you!"),
//           content: Text("We're glad you love our app. Please consider leaving a review."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showNegativeFeedbackDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("We're sorry to hear that."),
//           content: Text("Please provide us with feedback on how we can improve."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:beatfusion/widgets/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateUsScreen extends StatefulWidget {
  const RateUsScreen({super.key});

  @override
  State<RateUsScreen> createState() => _RateUsScreenState();
}

class _RateUsScreenState extends State<RateUsScreen> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Rate Us"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "How would you rate our app?",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20,),
          RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _)=> Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (newRating){
              setState(() {
                rating = newRating;
              });
            }
          )
        ],
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Cancel'),),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
          // if (rating >= 4) {
          //   _showPositiveFeedbackDialog();
          // }else{
          //   _showNegativeFeedbackDialog();
          // }
        }, child: Text('Submit'),)
      ],
    );
  }

  // void _showPositiveFeedbackDialog(){
  //   showDialog(
  //     context: context, 
  //     builder: (BuildContext context){
  //       return AlertDialog(
  //         title: Text('Thank you'),
  //         content: Text("We're glad you love our app. Please consider leaving a review."),
  //         actions: [
  //           TextButton(
  //             onPressed: (){
  //               // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> SettingsScreen() ));
  //               Navigator.popUntil(context, ModalRoute.withName('/settings'));
  //             }, 
  //             child: Text("OK")
  //           )
  //         ],
  //       );
  //     }
  //   );
  // }

  // void _showNegativeFeedbackDialog(){
  //   showDialog(
  //     context: context, 
  //     builder: (BuildContext context){
  //       return AlertDialog(
  //         title: Text("We're sorry to hear that."),
  //         content: Text("Please provide us with feedback on how we can improve."),
  //         actions: [
  //           TextButton(
  //             onPressed: (){
  //               Navigator.of(context).pop();
  //             }, 
  //             child: Text("OK")
  //           )
  //         ],
  //       );
  //     }
  //   );
  // }
}