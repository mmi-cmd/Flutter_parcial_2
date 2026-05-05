import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorProvider extends Notifier<int> {
  @override
  int build() {
    //estado inicial
    return 0;
  }

  void changeValue(int value) {
    //alterar comportamiento inicial
    state = value;
  }

}
  final colorChange = NotifierProvider<ColorProvider, int>((){
    return ColorProvider();
  });
