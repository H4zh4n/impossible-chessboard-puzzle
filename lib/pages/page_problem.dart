import 'package:chessboard_problem/utils/Utils.dart';
import 'package:chessboard_problem/widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ProblemPage extends StatelessWidget {
  const ProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text('Problem Explained'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            SelectableText(
              'The impossible chessboard puzzle is a mathematical puzzle in which a prisoner is shown a chessboard with 64 coins, each of which is showing either heads or tails. The prisoner is then allowed to flip one coin, and then another prisoner enters the room and must try to guess which square the warden hid the key under.'
              '\n\n'
              'Imagine that below board is the board presented to you, and you must flip ONE COIN ONLY so that the prisoner who enters after you knows where the key is. \n'
              'which coin would you choose ?',
            ),
            SizedBox(
              height: 20,
            ),
            FlexibleBoard(
              boardWidget(context, isClickable: false, showKeyAndFlip: false),
            ),
            SizedBox(
              height: 20,
            ),
            SelectableText(
              'If still unclear, watch the amazing 3Blue1Brown video on the topic :',
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                launchUrl(
                    Uri.parse('https://www.youtube.com/watch?v=wTJI_WuZSwE'),
                    mode: LaunchMode.externalApplication);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withAlpha(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/3b1b.jpg'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'The impossible chessboard puzzle',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
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
          ],
        ),
      ),
    );
  }
}
