import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const CustomButton({this.text, this.onTap, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: RaisedButton(
        color: const Color(0xffbf283a),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        onPressed: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!isLoading)
              Text(text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            Opacity(
              opacity: isLoading ? 1 : 0,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ProgressBar(color: Colors.white),
              ),
            )
          ],
        ),
      )),
    ]);
  }
}
