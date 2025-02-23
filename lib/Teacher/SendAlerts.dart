import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sendalerts extends StatefulWidget {
  const Sendalerts({super.key});

  @override
  State<Sendalerts> createState() => _SendalertsState();
}

class _SendalertsState extends State<Sendalerts> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to generate the alert ID and send the alert
  void sendAlert() async {
    String message = messageController.text.trim();

    if (message.isNotEmpty) {
      try {
        // Get the last alert document to determine the next ID
        QuerySnapshot alertsSnapshot = await _firestore.collection('Alerts').get();
        int alertCount = alertsSnapshot.size;

        // Generate the next alert ID (Alert_ID_001, Alert_ID_002, ...)
        String alertId = 'Alert_ID_${(alertCount + 1).toString().padLeft(3, '0')}';

        // Save the alert to Firestore
        await _firestore.collection('Alerts').doc(alertId).set({
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Alert sent successfully!')));

        // Clear the message input
        messageController.clear();
      } catch (e) {
        // Handle any errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to send alert: $e')));
      }
    } else {
      // If message is empty, show a prompt
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please type a message')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C2C88), Color(0xFF0B0B22)],
            stops: [0.15, 0.4],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(125), bottomLeft: Radius.circular(65)),
                gradient: LinearGradient(
                  colors: [Color(0xFF010127), Color(0xFF0B0C61)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Text(
                      'Send Alerts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Text("      "),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Container(
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF080B2E),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        'Message',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        minLines: 8,
                        decoration: InputDecoration(
                          fillColor: Color(0xFF26284A),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: "Type message here",
                          hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 97, 97, 97),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          height: 40,
                          width: 140,
                          child: ElevatedButton(
                            onPressed: sendAlert,
                            child: Text(
                              'Send',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3A2AE0),
                            ),
                          ),
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
