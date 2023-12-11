import 'package:chessboard_problem/utils/global_functions.dart';
import 'package:chessboard_problem/utils/global_keys.dart';
import 'package:chessboard_problem/widgets/global_widgets.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

class WhatPage extends StatelessWidget {
  WhatPage({super.key});

  List<List<int>> cols = [
    [1, 3, 5, 7],
    [2, 3, 6, 7],
    [4, 5, 6, 7],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text('WHAT to flip'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: ListView(
          children: [
            FlexibleBoard(
              boardWidget(
                context,
                isClickable: false,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Divider(),

            SelectableText(
              '• Get current board state.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            // START Current board state
            Expandable(
              firstChild: Padding(
                padding: const EdgeInsets.all(12),
                child: Text('How to get it'),
              ),
              secondChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //Columns
                    SelectableText(
                      '1. Calculate sum of heads for following column indices : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    for (List<int> c in cols) ...{
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int c in c) ...{
                                      SelectableText(
                                          'Column index [$c] : ${countSingleColumn(c)} heads'),
                                    },
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 300,
                                      maxWidth: 300,
                                    ),
                                    child: BoardWithHighlight(
                                      context,
                                      colToHighlight: c,
                                      highlightColor: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SelectableText(
                              'Total : ${countCols(c)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SelectableText(
                                'Is it odd ? ${countCols(c) % 2 == 0 ? 'No (0)' : 'Yes (1)'}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(5),
                      ),
                    },
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    //Columns
                    SelectableText(
                      '2. Calculate sum of heads for following Row indices : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    for (List<int> c in cols) ...{
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(10),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    for (int c in c) ...{
                                      SelectableText(
                                          'Row index [$c] : ${countSingleRow(c)} heads'),
                                    },
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 300,
                                      maxWidth: 300,
                                    ),
                                    child: BoardWithHighlight(
                                      context,
                                      rowToHighlight: c,
                                      highlightColor: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SelectableText(
                              'Total : ${countRows(c)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SelectableText(
                              'Is it odd ? ${countRows(c) % 2 == 0 ? 'No (0)' : 'Yes (1)'}',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                      ),
                    },

                    SelectableText(
                      '3. Lay down the Yes/No answers from Top to bottom being from right to left.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    Row(
                      children: [
                        SelectableText(
                          currentBoardBinary().substring(
                              0, (currentBoardBinary().length / 2).toInt()),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SelectableText(
                          currentBoardBinary().substring(
                              (currentBoardBinary().length / 2).toInt()),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SelectableText(
                  currentBoardBinary()
                      .substring(0, (currentBoardBinary().length / 2).toInt()),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SelectableText(
                  currentBoardBinary()
                      .substring((currentBoardBinary().length / 2).toInt()),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            SelectableText(
              'This is current state for above board.',
            ),

            // END Current board state

            SizedBox(
              height: 20,
            ),

            SelectableText(
              '• Key is placed at cell index ${keyHere.value}, convert it to binary since its our target : ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                SelectableText(
                  decimalToBinaryOfLength6(keyHere.value).substring(
                      0,
                      (decimalToBinaryOfLength6(keyHere.value).length / 2)
                          .toInt()),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SelectableText(
                  decimalToBinaryOfLength6(keyHere.value).substring(
                      (decimalToBinaryOfLength6(keyHere.value).length / 2)
                          .toInt()),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            SelectableText(
              '• Perform an XOR for the two binary numbers found.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SelectableText(
                ' (XOR : place both numbers on top of each other, compare them bit by bit (number by number), different numbers result in 1 and same numbers result in 0)'),

            SizedBox(
              height: 10,
            ),

            //BoardState in binary
            Row(
              children: [
                SelectableText(
                  currentBoardBinary()
                      .substring(0, (currentBoardBinary().length / 2).toInt()),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SelectableText(
                  currentBoardBinary()
                      .substring((currentBoardBinary().length / 2).toInt()),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            //Key in binary
            Row(
              children: [
                SelectableText(
                  decimalToBinaryOfLength6(keyHere.value).substring(
                      0,
                      (decimalToBinaryOfLength6(keyHere.value).length / 2)
                          .toInt()),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SelectableText(
                  decimalToBinaryOfLength6(keyHere.value).substring(
                      (decimalToBinaryOfLength6(keyHere.value).length / 2)
                          .toInt()),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            SelectableText(
              '____________',
            ),

            SelectableText(
              '${xorBinaryStrings(currentBoardBinary(), decimalToBinaryOfLength6(keyHere.value))}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SelectableText(
              '• Convert (${xorBinaryStrings(currentBoardBinary(), decimalToBinaryOfLength6(keyHere.value))}) to decimal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(
              '${binaryStringToDecimal(xorBinaryStrings(currentBoardBinary(), decimalToBinaryOfLength6(keyHere.value)))}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SelectableText(
              '• That is the cell which to flip.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(
              height: 20,
            ),
            FlexibleBoard(
              BoardWithHighlight(
                context,
                cellToHighlight: chessboardPositionFromDecimal(
                    binaryStringToDecimal(xorBinaryStrings(currentBoardBinary(),
                        decimalToBinaryOfLength6(keyHere.value)))),
              ),
              width: 300,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
