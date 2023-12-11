import 'global_keys.dart';
import 'dart:math' as math;

String currentBoardBinary() {
  int one = countOne();
  int two = countTwo();
  int three = countThree();
  int four = countFour();
  int five = countFive();
  int six = countSix();

  String boardBinary = '$six$five$four$three$two$one';

  return boardBinary;
}

String xorBinaryStrings(String binary1, String binary2) {
  String xorString = "";
  for (int i = 0; i < binary1.length; i++) {
    int bit1 = int.parse(binary1[i]);
    int bit2 = int.parse(binary2[i]);
    int xorBit = bit1 ^ bit2;
    xorString += xorBit.toString();
  }

  return xorString;
}

int countOne() {
  return countCols([1, 3, 5, 7]) % 2;
}

int countTwo() {
  return countCols([2, 3, 6, 7]) % 2;
}

int countThree() {
  return countCols([4, 5, 6, 7]) % 2;
}

int countCols(List<int> columns) {
  int sum = 0;

  for (int col in columns) {
    sum += countSingleColumn(col);
  }

  //print('for ${columns.toString()} = $sum');
  return sum;
}

int countSingleColumn(int col) {
  int sum = 0;

  for (int row = 0; row < board.length; row++) {
    sum += board[row][col];
  }
  return sum;
}

int countFour() {
  return countRows([1, 3, 5, 7]) % 2;
}

int countFive() {
  return countRows([2, 3, 6, 7]) % 2;
}

int countSix() {
  return countRows([4, 5, 6, 7]) % 2;
}

int countRows(List<int> rows) {
  int sum = 0;
  for (int r in rows) {
    sum += countSingleRow(r);
  }

  //print('for ${rows.toString()} = $sum');
  return sum;
}

int countSingleRow(int r) {
  int sum = 0;
  for (int c = 0; c < board.length; c++) {
    sum += board[r][c];
  }

  return sum;
}

String chessBoardPositionToBinary(int row, int column) {
  int decimal = row * 8 + column;
  return decimalToBinaryOfLength6(decimal);
}

String decimalToBinaryOfLength6(int decimal) {
  String binary = "";
  for (int i = 5; i >= 0; i--) {
    int remainder = decimal % 2;
    binary = remainder.toString() + binary;
    decimal = decimal ~/ 2;
  }
  while (binary.length < 6) {
    binary = "0$binary";
  }
  return binary;
}

int binaryStringToDecimal(String binary) {
  int decimal = 0;
  int index = 0;
  for (int i = binary.length - 1; i >= 0; i--) {
    int bit = int.parse(binary[i]);

    decimal += (bit * math.pow(2, index++)) as int;
  }
  return decimal;
}

List<int> chessboardPositionFromDecimal(int decimal) {
  int row = decimal ~/ board.length;
  int column = decimal % board.length;
  return [row, column];
}

int chessboardPositionToDecimal(int row, int column) {
  return row * board.length + column;
}

String reverseString(String string) {
  String reversedString = "";
  for (int i = string.length - 1; i >= 0; i--) {
    reversedString += string[i];
  }
  return reversedString;
}
