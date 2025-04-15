import 'package:flutter/material.dart';

import 'custom_color.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const CustomAppbar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: CustomColors.screenColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 05, right: 08, left: 05),
        child: Text(
          text,
          style: TextStyle(
              color: CustomColors.blackColor,
              fontSize: 25,
              fontFamily: 'PoppinsMedium'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
