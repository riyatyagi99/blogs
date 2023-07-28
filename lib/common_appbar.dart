import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget? title;
  List<Widget>? actions;
  bool? centreTitle;
  double? toolbarHeight;
  final AppBar appBar;
  Color? bgColor;

  CommonAppBar({Key? key,
    this.title,
    this.actions,
    this.centreTitle,
    this.toolbarHeight,
    required this.appBar,
    this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions ?? [],
      centerTitle: centreTitle ?? true,
      toolbarHeight: toolbarHeight ?? 0.0,
      backgroundColor: bgColor ?? Colors.white,
    );
  }


  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);

}







