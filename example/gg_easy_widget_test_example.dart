// @license
// Copyright (c) 2019 - 2021 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gg_easy_widget_test/gg_easy_widget_test.dart';

final subwidgetFrame = Rect.fromLTWH(10, 20, 30, 40);

// #############################################################################

/// This is the sample widget we will test using GgEasyWidgetTest
class SampleWidget extends StatefulWidget {
  SampleWidget({required Key key}) : super(key: key);

  @override
  _SampleWidgetState createState() => _SampleWidgetState();
}

// .............................................................................
/// This is the state of the sample widget we will test using GgEasyWidgetTest
class _SampleWidgetState extends State<SampleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: subwidgetFrame.width,
      height: subwidgetFrame.height,
    );
  }
}

// #############################################################################
main() {
  group('GgEasyWidgetTest', () {
    // .........................................................................
    testWidgets('should provide information about an widget under test',
        (WidgetTester tester) async {
      // ......................................
      // Create a widget containing a subwidget
      final sampleWidgetKey = GlobalKey(debugLabel: 'sampleWidgetKey');
      final sampleWidget = SampleWidget(key: sampleWidgetKey);

      final widget = Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          child: Stack(
            children: [
              Positioned(
                left: subwidgetFrame.left,
                top: subwidgetFrame.top,
                child: sampleWidget,
              )
            ],
          ),
        ),
      );

      // ......................
      // Instantiate the widget
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // .................................
      // Create a finder for the subwidget
      final sampleWidgetFinder = find.byKey(sampleWidgetKey);

      // .........................................
      // Create a GgEasyWidgetTest for the subwidget
      final ggEasyWidgetTest = GgEasyWidgetTest(sampleWidgetFinder, tester);

      // ..................................
      // Width and height should be correct
      expect(ggEasyWidgetTest.width, subwidgetFrame.width);
      expect(ggEasyWidgetTest.height, subwidgetFrame.height);

      // ..............................
      // Render box should be delivered
      expect(ggEasyWidgetTest.renderBox, isInstanceOf<RenderBox>());

      // ..............................
      // The element should be delivered
      expect(ggEasyWidgetTest.element, isInstanceOf<Element>());

      // ......................................
      // The absolute frame should be delivered
      expect(ggEasyWidgetTest.absoluteFrame, subwidgetFrame);

      // ..............................
      // The widget should be delivered
      expect(ggEasyWidgetTest.widget, sampleWidget);

      // .............................
      // The state should be delivered
      expect(ggEasyWidgetTest.state, isInstanceOf<_SampleWidgetState>());
    });
  });
}
