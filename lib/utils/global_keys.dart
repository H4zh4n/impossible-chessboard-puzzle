import 'package:get/get.dart';

RxList<List<int>> board = [
  [0, 0, 1, 1, 0, 0, 1, 1],
  [0, 1, 1, 0, 0, 0, 1, 0],
  [0, 0, 1, 1, 0, 0, 0, 1],
  [0, 1, 1, 0, 0, 0, 1, 0],
  [0, 0, 1, 0, 0, 0, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 0],
  [0, 0, 1, 1, 1, 0, 1, 0],
  [0, 0, 1, 0, 1, 0, 0, 1],
].obs;

RxInt keyHere = (11).obs;
RxInt flipHere = (-1).obs;
