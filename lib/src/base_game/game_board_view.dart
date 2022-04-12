import 'dart:ui';

import 'package:c4ai/src/base_game/game_board_service.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';

class GameBoardView extends StatelessWidget {
  GameBoardView({Key? key}) : super(key: key);

  static const routeName = '/';

  final GameBoardService gameBoardService = GameBoardService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('c4ai'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              gameBoardService.printBoard(),
              style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()], fontSize: 90),
            )));
  }
}
