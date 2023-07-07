import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading; // it holds to show circular indicator when creat user
  const RoundButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child:
              loading // we use condition if loading then show circular indicator other text
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : Text(
                      title,
                      style: const TextStyle(color: Colors.white),
                    ),
        ),
      ),
    );
  }
}
