import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 0.0;

  void _submitFeedback(BuildContext context) async {
    String feedback = _feedbackController.text.trim();

    if (feedback.isNotEmpty && _rating > 0) {
      try {
        await FirebaseFirestore.instance.collection('feedback').add({
          'feedback': feedback,
          'rating': _rating,
          'timestamp': FieldValue.serverTimestamp(),
        });
        // Clear text field and reset rating after submitting feedback
        _feedbackController.clear();
        setState(() {
          _rating = 0.0;
        });
        // Show a confirmation dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Feedback Submitted'),
              content: Text('Thank you for your feedback!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        print('Error submitting feedback: $e');
        // Show an error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred while submitting feedback.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              backgroundColor: Color.fromARGB(220, 59, 206, 255),
              title: const Text(
                "Healthify",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body:Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children :
        [ Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Text(
                          'Rate your experience:',
                          style: TextStyle(fontSize: 16),
                        ),
                        RatingBar.builder(
                          initialRating: _rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 155, 224, 255),
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                        ),
              TextField(
                controller: _feedbackController,
                decoration: InputDecoration(
                  labelText: 'Enter your feedback',
                ),
                maxLines: null, // Allow multiple lines for feedback
              ),
              SizedBox(height: 20),
        
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitFeedback(context),
                child: Text('Submit Feedback'),
                 style: ElevatedButton.styleFrom(
                                                    foregroundColor: Colors.black87,
                                                    backgroundColor:
                                                        Color.fromARGB(255, 111, 210, 255),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(
                                                    7.5),
                                                    ),
                                                    ),
              ),
            ],
          ),
        ),
        ),
        ],
        ),
      ),
    );
  }
}
