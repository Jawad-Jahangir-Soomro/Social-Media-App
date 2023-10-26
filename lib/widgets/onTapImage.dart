import 'package:flutter/material.dart';

class OnTapImage extends StatefulWidget {
  final snap;
  const OnTapImage({Key? key, required this.snap}) : super(key: key);

  @override
  State<OnTapImage> createState() => _OnTapImageState();
}

class _OnTapImageState extends State<OnTapImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Expanded(
            child: Row(
              children: [
                const SizedBox(width: 10,),
                Expanded(child: CircleAvatar(radius: 40,backgroundImage: NetworkImage(widget.snap['profImage'],),)),
              ],
            ),
          ),
          title: Text(widget.snap['username']),
        ),
        body: Center(
          child: Image(
            image: NetworkImage(widget.snap["postUrl"],),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

