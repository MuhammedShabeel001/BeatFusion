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
        title: const Text("Rate Us"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
            const Text(
              "How would you rate our app?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20,),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _)=> const Icon(
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
        }, child: const Text('Cancel'),),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text('Submit'),)
      ],
    );
  }
}