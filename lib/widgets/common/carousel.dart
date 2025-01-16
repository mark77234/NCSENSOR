import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel(
      {super.key,
      required this.builder,
      required this.length,
      required this.height});

  final Widget Function(BuildContext, int) builder;
  final int length;
  final double height;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  //random color list
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
  ];

  int position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.height),
          child: PageView.builder(
            itemCount: widget.length,
            itemBuilder: widget.builder,
            onPageChanged: (index) {
              setState(() {
                position = index;
              });
            },
          ),
        ),
        SizedBox(
          height: 15,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => myCircle(index),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: widget.length,
          ),
        ),
      ],
    );
  }

  Widget myCircle(int p) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: position == p ? colors[p] : Colors.grey.shade300,
      ),
    );
  }
}
