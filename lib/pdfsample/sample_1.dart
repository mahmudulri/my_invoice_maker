import 'package:flutter/material.dart';

class Sample1 extends StatelessWidget {
  const Sample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Container(
            height: 40,
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "INVOICE",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "INVOICE",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "INVOICE",
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 40,
            width: double.maxFinite,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
