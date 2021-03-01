// @license
// Copyright (c) 2019 - 2021 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this repository.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Retrive helpful information to test a widget
/// - [T] is the type of the widget under test
/// - [S] is the type of the widget's state
class GgEasyWidgetTest<T extends Widget, S extends State> {
  // ...........................................................................
  /// The constructor
  /// - [finder] The finder yielding the widget to be tested
  /// - [tester] The tester for testing the widget
  GgEasyWidgetTest(this.finder, this.tester) {
    expect(finder, findsOneWidget);
    expect(element, isNotNull);
  }

  // ...........................................................................
  /// The used tester.
  final WidgetTester tester;

  // ...........................................................................
  /// The used finder
  final Finder finder;

  // ...........................................................................
  /// The width of the widget to be tested
  double get width => renderBox.size.width;

  // ...........................................................................
  /// The height of the widget to be tested
  double get height => renderBox.size.height;

  // ...........................................................................
  /// The render box of the widget
  RenderBox get renderBox => (element.renderObject as RenderBox);

  // ...........................................................................
  /// The Element of the tested widget
  Element get element => tester.firstElement(finder);

  // ...........................................................................
  /// The absolute frame of the tested widget
  Rect get absoluteFrame {
    final offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  // ...........................................................................
  /// The widget instance under test
  T get widget => tester.widget(finder);

  // ...........................................................................
  /// The state of the widget under test
  S get state => tester.state(finder);

  // ...........................................................................
  /// Apply a mouse click or a touch to the widget
  press() async {
    final gesture = await tester.press(finder);
    await tester.pumpAndSettle();
    await gesture.up();
    await tester.pumpAndSettle();
  }
}
