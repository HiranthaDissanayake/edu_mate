import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edu_mate/service/database.dart'; // Ensure this import is correct
import 'package:edu_mate/Admin/ProfileScreen.dart'; // Ensure this import is correct

class PopupMoreStudent extends StatelessWidget {
  final String id;
  final String collection; // Add collection parameter if needed
  const PopupMoreStudent({
    super.key,
    required this.id,
    required this.collection, // Add collection parameter if needed
  });

  // Renamed method to showPopup
  void showPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      id: id,
                      collection: collection,
                    ),
                  ));
                },
                child: Text(
                  'Profile',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await DatabaseMethods()
                      .deleteStudent(id); // Ensure this method exists
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Delete',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Call the showPopup method to display the bottom sheet
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () => showPopup(context),
    );
  }
}
