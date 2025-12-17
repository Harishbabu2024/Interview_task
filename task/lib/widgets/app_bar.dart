import 'package:flutter/material.dart';
class AppNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool show_back_arrow;
  final VoidCallback? onTap;

  AppNavigationBar({
    Key? key,
    this.title,
    this.show_back_arrow = true,
    this.onTap,
  }) : super(key: key);

  @override
  _AppNavigationBarState createState() => _AppNavigationBarState();

  @override
  Size get preferredSize => Size.fromHeight(80);
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
         widget.title!,
        style: TextStyle(
          color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        ),
        maxLines: 5,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Colors.grey[300]!,
                width: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}