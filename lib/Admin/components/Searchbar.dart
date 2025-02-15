import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  final String hintText;
  const Searchbar({super.key, required this.hintText});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  // Use SearchController instead of TextEditingController
  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onTap: () {
        controller.openView();
      },
      onChanged: (_) {
        controller.openView();
      },
      leading: const Icon(Icons.search),
      hintText: widget.hintText,
    );
  }
}
