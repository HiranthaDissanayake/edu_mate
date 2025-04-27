import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_mate/service/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:edu_mate/service/database_methods.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  List<Map<String, dynamic>> sections = []; // Stores title & descriptions for all content sections
  bool isLoading = true;

  Future<void> getPrivacyPolicy() async {
    try {
      DocumentSnapshot<Object?> privacyStream =
          await DatabaseMethods().fetchPrivacyPolicy();

      Map<String, dynamic>? data = privacyStream.data() as Map<String, dynamic>?;

      if (data != null) {
        List<Map<String, dynamic>> tempSections = [];

        // Iterate through content, content1, content2, ..., content10
        for (int i = 0; i <= 15; i++) {
          String key = i == 0 ? "content" : "content$i"; // First one is "content", others are "content1", "content2"...

          if (data.containsKey(key)) {
            Map<String, dynamic>? contentData = data[key];

            if (contentData != null) {
              String title = contentData["title"] ?? "";
              List<dynamic>? descList = contentData["description"];
              List<String> descriptions =
                  descList?.map((item) => item.toString()).toList() ?? [];

              tempSections.add({"title": title, "descriptions": descriptions});
            }
          }
        }

        setState(() {
          sections = tempSections;
        });
      }
    } catch (e) {
      AppLogger().e("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back), color: Colors.white,),
        backgroundColor: Color(0xFF13134C),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF13134C),
              Color(0xFF13134C),
              Color(0xFF2D2DB2),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      "Privacy Policy",
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: sections.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sections[index]["title"],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              for (String description
                                  in sections[index]["descriptions"])
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    description,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}