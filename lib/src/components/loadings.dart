import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:socio_univ/src/components/styles.dart';

Widget floatingLoading() {
  return Container(
    color: Colors.black.withOpacity(0.7),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white, size: 30),
          DefaultTextStyle(
              style: kDefaultTextStyle(), child: const Text("Loading..."))
        ],
      ),
    ),
  );
}
