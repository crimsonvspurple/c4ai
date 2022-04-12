# c4ai

A game of `Connect 4`.

The idea is an AI who can play a game of `Connect 4` against another AI (namely, itself) or human.

## Demo

Live Demo: [c4ai on EminenceRED](https://c4ai.eminence.red)

Alternatively, build yourself:
 
- git pull
- open with IDEA / Android Studio
- Start (with **Flutter SDK** `2.10.4+`)

## Goals

 - Search `game tree`
 - `Minimax` with `α-β pruning`
 - `Evaluation function` to evaluate `goodness` of board state
 - `Early stopping` mechanism to abort search based on `evaluation function`

## Tech

- Flutter for UI
- Dart for core engine
- Target Platforms: `Web`, `iOS`, `Android`

## Localization

Localization: `lib/src/localization` | [Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
