import 'dart:math';

import 'package:chessboard_problem/pages/page_problem.dart';
import 'package:chessboard_problem/pages/page_what.dart';
import 'package:chessboard_problem/pages/page_where.dart';
import 'package:chessboard_problem/utils/global_functions.dart';
import 'package:chessboard_problem/utils/global_keys.dart';
import 'package:chessboard_problem/widgets/dialog_import_export.dart';
import 'package:chessboard_problem/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatelessWidget {
  //Status text.
  static RxString status = ''.obs;

  // Added to have a checkbox that can enable/disable auto key finder.
  // not used since didn't like the idea later.
  static RxBool autoFindKey = true.obs;

  //status background color
  static Color statusColor = Colors.blue;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(
        title: const Text('Impossible Chess'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Get.defaultDialog(
                title: 'Whats there to do',
                middleText: ('- Click to flip coin.'
                    '\n- Right click (or Long press) to place key.'
                    '\n- Click [What to flip for key] to know the answer'
                    '\n- Click [Where is key] to know where the key was placed.'
                    '\n\n- If you dont know what the heck is this for, click [PROBLEM] for the explanation.'
                    '\n\n- If you wish to know how its done, click [WHAT!?] or [WHERE!?].'),
                middleTextStyle: const TextStyle(),
              );
            },
            tooltip: 'What to do',
          ),
          IconButton(
            icon: const Icon(Icons.import_export),
            onPressed: () {
              ExportImport.showDialog();
            },
            tooltip: 'Export/Import',
          ),
          IconButton(
            icon: const Icon(Icons.deselect),
            onPressed: () {
              keyHere.value = -1;
              flipHere.value = -1;
            },
            tooltip: 'De select',
          ),
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              reset();

              statusColor = Colors.blue;
              status.value = '';
              flipHere.value = -1;
              keyHere.value = -1;
            },
            tooltip: 'Reset',
          ),
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              randomBoard();
            },
            tooltip: 'Random Board',
          ),
        ],
      ),
      body: whereToPlaceThem(
        context,
        boardWidget(context),
        Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withAlpha(10),
                  ),
                  child: Wrap(
                    runSpacing: 5,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (keyHere.value == -1) {
                              statusColor = Colors.red;
                              status.value = 'Key not placed.'
                                  '\nRight click (or Long press) a cell to place it.';

                              return;
                            }

                            findWhatToFlip();
                          },
                          child: const Text('What to flip for key')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            findTheKey();
                          },
                          child: const Text('Where is the key')),
                      /* Obx(() {
                        return ConstrainedBox(
                          constraints: BoxConstraints.tightFor(width: 200),
                          child: CheckboxListTile(
                            value: autoFindKey.value,
                            title: Text('Auto find key'),
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (value) {
                              autoFindKey.value = value!;
                            },
                          ),
                        );
                      }),*/
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return Opacity(
                    opacity: status.value.isNotEmpty ? 1 : 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        status.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withAlpha(10),
                  ),
                  child: Wrap(
                    runSpacing: 5,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.to(const ProblemPage());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.question_mark,
                                color: Colors.white,
                                size: 18,
                              ),
                              Text(
                                'PROBLEM',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (keyHere.value == -1) {
                              statusColor = Colors.red;

                              status.value = 'Key not placed.'
                                  '\nRight click (or Long press) a cell to place it.';

                              Get.snackbar(
                                'Key not placed',
                                'Right click (or Long press) a cell to place it.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                borderRadius: 20,
                                animationDuration: 100.milliseconds,
                                duration: 3000.milliseconds,
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                overlayBlur: 1,
                              );

                              return;
                            }

                            Get.to(WhatPage());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.question_mark,
                                color: Colors.white,
                                size: 18,
                              ),
                              Text(
                                'WHAT!?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            Get.to(WherePage());
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.question_mark,
                                color: Colors.white,
                                size: 18,
                              ),
                              Text(
                                'WHERE!?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        launchUrl(Uri.parse('https://github.com/H4zh4n/'),
                            mode: LaunchMode.externalApplication);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/github.svg',
                              color: Colors.black,
                              height: 32,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            const Text('Hazhan Jalal'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget whereToPlaceThem(BuildContext context, Widget top, Widget bottom) {
    //print(MediaQuery.of(context).size.width.toString());

    if (MediaQuery.of(context).size.width > 800) {
      return Row(
        children: [
          top,
          Flexible(child: bottom),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
              constraints: BoxConstraints.loose(const Size.fromHeight(550)),
              child: top),
          Flexible(
            child: bottom,
          ),
        ],
      );
    }
  }

  static void findWhatToFlip() {
    if (keyHere.value == -1) {
      statusColor = Colors.red;
      status.value = 'Key not placed.'
          '\nRight click (or Long press) a cell to place it.';

      return;
    }

    String xor = xorBinaryStrings(
        currentBoardBinary(), decimalToBinaryOfLength6(keyHere.value));

    int flip = binaryStringToDecimal(xor);

    List<int> fli = chessboardPositionFromDecimal(flip);

    /*print('cur = ${currentBoardBinary()}');
    print('target = ${decimalToBinaryOfLength6(keyHere.value)}');
    print('xor = ${xor}');
    print('flip = ${flip}');
    print('fli = ${fli}');*/

    flipHere.value = chessboardPositionToDecimal(fli[0], fli[1]);

    statusColor = Colors.blue;
    status.value =
        'Flip the cell at index [${flipHere.value}].\n\nRow index ${fli[0]}, Column index ${fli[1]}';
  }

  void findTheKey() {
    int key = binaryStringToDecimal(currentBoardBinary());
    List<int> rowCol = chessboardPositionFromDecimal(key);

    keyHere.value = key;

    statusColor = Colors.blue;
    status.value =
        'Based on current board, key is at index [${key}].\n\nRow index ${rowCol[0]}, Column index ${rowCol[1]}';
  }

  static void reset() {
    for (int r = 0; r < board.length; r++) {
      for (int c = 0; c < board[r].length; c++) {
        board[r][c] = 0;
      }
    }

    board.refresh();
  }

  void randomBoard() {
    keyHere.value = -1;
    flipHere.value = -1;

    for (int r = 0; r < board.length; r++) {
      for (int c = 0; c < board[r].length; c++) {
        board[r][c] = Random().nextInt(2);
      }
    }

    board.refresh();

    findWhatToFlip();
  }

  void printTable() {
    for (int r = 0; r < board.length; r++) {
      print('${board[r]}');
    }
  }
}
