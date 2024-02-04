import 'package:flutter/material.dart';

class SingleNoteWidget extends StatelessWidget {
  final String? title;
  final String? body;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const SingleNoteWidget(
      {super.key,
      this.title,
      this.body,
      this.onTap,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.blue.shade900, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade100,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                body!,
                style: TextStyle(
                  color: Colors.blue.shade100,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ));
  }
}
