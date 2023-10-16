import 'package:flutter/widgets.dart';

class EmptyWord extends StatelessWidget {
  const EmptyWord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: const Center(child: Text(" ")),
    );
  }
}