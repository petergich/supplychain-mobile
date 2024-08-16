import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),),
      foregroundColor: Colors.white,
      backgroundColor: Colors.brown,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
