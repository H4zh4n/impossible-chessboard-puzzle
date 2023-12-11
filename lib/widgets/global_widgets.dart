import 'package:chessboard_problem/Extensions.dart';
import 'package:chessboard_problem/utils/global_functions.dart';
import 'package:chessboard_problem/utils/global_keys.dart';
import 'package:flutter/material.dart';
import 'package:chessboard_problem/pages/page_main.dart';
import 'package:get/get.dart';

Widget FlexibleBoard(
  Widget board, {
  double width = 400,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: width,
          ),
          child: board,
        ),
      ),
    ],
  );
}

/*static Widget getFlexibleBoard(
    BuildContext context, {
    double width = 400,
    bool isClickable = false,
    bool showKeyAndFlip = false,
    bool showLabels = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: width,
            ),
            child: MyApp.boardWidget(
              context,
              isClickable: isClickable,
              showKeyAndFlip: showKeyAndFlip,
            ),
          ),
        ),
      ],
    );
  }*/

Widget boardWidget(BuildContext context,
    {bool isClickable = true, bool showKeyAndFlip = true}) {
  return AspectRatio(
    aspectRatio: 1,
    child: Row(
      children: [
        for (int col = 0; col < board.length; col++) ...{
          Expanded(
            child: Column(
              children: [
                for (int row = 0; row < board.length; row++) ...{
                  Expanded(
                    child: GestureDetector(
                      onLongPress: () {
                        if (!isClickable) {
                          return;
                        }

                        if (keyHere.value !=
                            chessboardPositionToDecimal(row, col)) {
                          keyHere.value = chessboardPositionToDecimal(row, col);

                          if (MainPage.autoFindKey.value) {
                            MainPage.findWhatToFlip();
                          }
                        } else {
                          keyHere.value = -1;
                          flipHere.value = -1;
                        }
                      },
                      onSecondaryTap: () {
                        if (!isClickable) {
                          return;
                        }

                        if (keyHere.value !=
                            chessboardPositionToDecimal(row, col)) {
                          keyHere.value = chessboardPositionToDecimal(row, col);

                          if (MainPage.autoFindKey.value) {
                            MainPage.findWhatToFlip();
                          }
                        } else {
                          keyHere.value = -1;
                          flipHere.value = -1;
                        }

                        board.refresh();
                      },
                      onTap: () {
                        if (!isClickable) {
                          return;
                        }

                        if (board[row][col] == 0) {
                          board[row][col] = 1;
                        } else {
                          board[row][col] = 0;
                        }

                        /* if (flip_controlers.isNotEmpty && isClickable) {
                          print('flipping...');
                          //  flip_controlers[row * board.length + col].flip();
                        }*/

                        //print('$row, $col = ${board[row][col]}');

                        if (chessboardPositionToDecimal(row, col) ==
                            flipHere.value) {
                          keyHere.value = -1;
                          flipHere.value = -1;
                        }

                        board.refresh();

                        if (keyHere.value != -1 && MainPage.autoFindKey.value) {
                          MainPage.findWhatToFlip();
                        }
                      },
                      child: Obx(() {
                        return Container(
                          color: (keyHere.value != -1 &&
                                      keyHere.value == flipHere.value &&
                                      keyHere.value ==
                                          chessboardPositionToDecimal(
                                              row, col)) &&
                                  showKeyAndFlip
                              ? Colors.blue.withOpacity(0.50)
                              : keyHere.value ==
                                          chessboardPositionToDecimal(
                                              row, col) &&
                                      showKeyAndFlip
                                  ? Colors.red.withOpacity(0.50)
                                  : flipHere.value ==
                                              chessboardPositionToDecimal(
                                                  row, col) &&
                                          showKeyAndFlip
                                      ? Colors.green.withOpacity(0.50)
                                      : (row % 2 != col % 2)
                                          ? '#383838'.toColor()
                                          : '#E8E8E8'.toColor(),
                          child: Center(
                            child: Obx(() {
                              return coinHead(row, col);
                            }),
                          ),
                        );
                      }),
                    ),
                  ),
                }
              ],
            ),
          ),
        },
      ],
    ),
  );
}

Widget coinHead(int row, int col) {
  return Container(
    padding: EdgeInsets.all(5),
    child: CircleAvatar(
      backgroundColor: board[row][col] == 0 ? Colors.red : Colors.orangeAccent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          board[row][col] == 0 ? 'T' : 'H',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget coinTails(int row, int col) {
  return Container(
    padding: EdgeInsets.all(5),
    child: CircleAvatar(
      backgroundColor: board[row][col] == 1 ? Colors.red : Colors.orangeAccent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          board[row][col] == 1 ? 'T' : 'H',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget BoardWithHighlight(
  BuildContext context, {
  List<int>? cellToHighlight,
  List<int>? colToHighlight,
  List<int>? rowToHighlight,
  Color? highlightColor,
}) {
  if (highlightColor == null) {
    highlightColor = Colors.green.withOpacity(0.85);
  }

  return AspectRatio(
    aspectRatio: 1,
    child: Row(
      children: [
        for (int col = 0; col < board.length; col++) ...{
          Expanded(
            child: Column(
              children: [
                for (int row = 0; row < board.length; row++) ...{
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        color: ((colToHighlight != null &&
                                    colToHighlight.contains(col)) ||
                                (rowToHighlight != null &&
                                    rowToHighlight.contains(row)) ||
                                (cellToHighlight != null &&
                                    cellToHighlight[0] == row &&
                                    cellToHighlight[1] == col))
                            ? highlightColor
                            : (row % 2 != col % 2)
                                ? '#383838'.toColor()
                                : '#E8E8E8'.toColor(),
                        child: Center(
                          child: Obx(() {
                            return Container(
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                backgroundColor: board[row][col] == 0
                                    ? Colors.red
                                    : Colors.orangeAccent,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    board[row][col] == 0 ? '' : '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                }
              ],
            ),
          ),
        },
      ],
    ),
  );
}
