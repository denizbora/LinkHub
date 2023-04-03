import 'package:flutter/material.dart';

class StatWidget extends StatefulWidget {
  const StatWidget({Key? key, required this.bg, required this.icon, required this.stat, required this.title}) : super(key: key);
  final Color bg;
  final Icon icon;
  final String stat;
  final String title;

  @override
  State<StatWidget> createState() => _StatWidgetState();
}

class _StatWidgetState extends State<StatWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: widget.bg
          ),
          child: widget.icon,
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.stat,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
            Text(widget.title,style: const TextStyle(fontSize: 10,color: Colors.black38,fontWeight: FontWeight.w600))
          ],
        )
      ],
    );
  }
}
