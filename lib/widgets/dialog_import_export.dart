import 'package:chessboard_problem/pages/page_main.dart';
import 'package:chessboard_problem/utils/global_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExportImport {
  static void showDialog() {
    Get.dialog(
      barrierDismissible: true,
      Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
            maxHeight: 400,
          ),
          child: Column(
            children: [
              _dialogHeader(
                  title: 'Export/Import board', icon: Icons.import_export),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                        _exportImport(true);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.upload),
                            Text('Export'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        //Get.back();
                        _exportImport(false);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.download),
                            Text('Import'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _exportImport(bool isExport) async {
    String boardState = '';
    for (List<int> row in board) {
      for (int cell in row) {
        if (cell == 0) {
          boardState += 't\t';
        } else {
          boardState += 'h\t';
        }
      }

      boardState = boardState.trim() + '\n';
    }
    TextEditingController et =
        TextEditingController(text: isExport ? boardState.trim() : '');

    Get.dialog(
      barrierDismissible: true,
      Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
            maxHeight: 520,
          ),
          child: Column(
            children: [
              _dialogHeader(
                  title: isExport ? 'Export' : 'Import',
                  icon: isExport ? Icons.upload : Icons.download),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: TextFormField(
                          style: const TextStyle(
                            fontFamily: 'fascadia',
                          ),
                          textAlign: TextAlign.center,
                          readOnly: isExport,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: et,
                          maxLines: 8,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (isExport) {
                                await Clipboard.setData(
                                    ClipboardData(text: boardState.trim()));

                                Get.snackbar(
                                  'Copy success !',
                                  'Board was copied successfully !',
                                  isDismissible: true,
                                  duration: 2000.milliseconds,
                                  animationDuration: 100.milliseconds,
                                  dismissDirection: DismissDirection.horizontal,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                                Navigator.pop(Get.context!);
                              } else {
                                String data = et.text.toLowerCase();

                                data = data.replaceAll(RegExp(r'[^01th]'), '');

                                print('$data');

                                List<String> boardData = data.split('');

                                if (boardData.length > 0) {
                                  MainPage.reset();

                                  for (int index = 0;
                                      index < boardData.length &&
                                          index <
                                              board.length * board[0].length;
                                      index++) {
                                    if (index >
                                        board.length * board[0].length) {
                                      // We stop the process in-case the load list reaches a point where it
                                      // has more data than the row*col of our board.
                                      break;
                                    }

                                    int cellData = 0;
                                    if (boardData[index] == '0' ||
                                        boardData[index].toLowerCase() == 't' ||
                                        boardData[index].toLowerCase() == 'a') {
                                      cellData = 0;
                                    } else if (boardData[index] == '1' ||
                                        boardData[index].toLowerCase() == 'h' ||
                                        boardData[index].toLowerCase() == 'b') {
                                      cellData = 1;
                                    }

                                    final row = index ~/ board.length;
                                    final col = index % board[row].length;

                                    board[row][col] = cellData;
                                  }

                                  Get.snackbar(
                                    'Load success !',
                                    'Board was loaded successfully !',
                                    isDismissible: true,
                                    animationDuration: 100.milliseconds,
                                    duration: 2000.milliseconds,
                                    snackPosition: SnackPosition.BOTTOM,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );

                                  keyHere.value = -1;
                                  flipHere.value = -1;

                                  Navigator.pop(Get.context!);
                                  Navigator.pop(Get.context!);
                                } else {
                                  Get.snackbar(
                                    'No Data',
                                    'No data was typed in the textfield to load.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    borderRadius: 20,
                                    animationDuration: 100.milliseconds,
                                    duration: 3000.milliseconds,
                                    isDismissible: true,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    overlayBlur: 1,
                                  );
                                }
                              }
                            },
                            child: Text(isExport ? 'Copy' : 'Load'),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          !isExport
                              ? ElevatedButton(
                                  onPressed: () async {
                                    et.text = ((await Clipboard.getData(
                                                Clipboard.kTextPlain))
                                            as ClipboardData)
                                        .text
                                        .toString();
                                  },
                                  child: const Text('Paste'))
                              : const SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '0 or t = Tails\n1 or h = Heads${!isExport ? '\n\nAny characters beside those 4 will be removed upon clicking [load]' : ''}',
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _dialogHeader({
    required String title,
    required IconData icon,
    Color background = Colors.blue,
    Color foreground = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: foreground,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  color: foreground,
                ),
              ),
            ],
          ),
          IconButton(
              color: foreground,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
