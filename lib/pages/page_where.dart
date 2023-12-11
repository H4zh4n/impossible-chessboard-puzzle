import 'package:chessboard_problem/utils/global_functions.dart';
import 'package:chessboard_problem/widgets/global_widgets.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

class WherePage extends StatelessWidget {
  WherePage({super.key});

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
        title: Text('WHERE is the key'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: ListView(
          children: [
            FlexibleBoard(
              boardWidget(context, isClickable: false, showKeyAndFlip: false),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SelectableText(
              '• Same as WHAT page, Get current board state.',
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

            SizedBox(
              height: 20,
            ),

            SelectableText(
              '• Convert the board state (${currentBoardBinary()}) to decimal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(
              '${binaryStringToDecimal(currentBoardBinary())}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SelectableText(
              '• That is the cell which has the key under it.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            FlexibleBoard(
              BoardWithHighlight(
                context,
                cellToHighlight: chessboardPositionFromDecimal(
                    binaryStringToDecimal(currentBoardBinary())),
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
