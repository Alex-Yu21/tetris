import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.title, required this.result});
  final String title;
  final Widget result;

  @override
  Widget build(BuildContext context) {
    // TODO dynamic size
    double height = 100;
    double width = 140;
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(color: Theme.of(context).primaryColor, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: height * 0.35,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
            ),
            Divider(
              height: 1,
              thickness: 4,
              color: Theme.of(context).primaryColor,
            ),
            Expanded(child: Center(child: result)),
          ],
        ),
      ),
    );
  }
}
