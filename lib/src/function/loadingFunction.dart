import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingUtils {
  static double _progress = 0.4;
  static Timer? _timer;

  static void showLoadingWithProgress(BuildContext context) {
    _progress = 0;
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (Timer timer) {
        EasyLoading.showProgress(
          _progress,
          status: '${(_progress * 100).toStringAsFixed(0)}%',
        );
        _progress += 0.03;

        if (_progress >= 1) {
          timer.cancel();
          EasyLoading.dismiss();
        }
      },
    );
  }
}
