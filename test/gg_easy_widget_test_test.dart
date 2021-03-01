// @license
// Copyright (c) 2019 - 2021 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gg_easy_widget_test/gg_easy_widget_test.dart';

// #############################################################################
final subwidgetFrame = Rect.fromLTWH(10, 20, 30, 40);

// #############################################################################
class SubWidget extends StatefulWidget {
  SubWidget({required Key key}) : super(key: key);

  @override
  _SubWidgetState createState() => _SubWidgetState();
}

class _SubWidgetState extends State<SubWidget> {
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
    // #########################################################################

    testWidgets('should provide information about an sub widget under test',
        (WidgetTester tester) async {
      // ......................................
      // Create a widget containing a subwidget
      final subWidgetKey = GlobalKey(debugLabel: 'subWidgetKey');
      final subWidget = SubWidget(key: subWidgetKey);

      final widget = Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          child: Stack(
            children: [
              Positioned(
                left: subwidgetFrame.left,
                top: subwidgetFrame.top,
                child: subWidget,
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
      final subWidgetFinder = find.byKey(subWidgetKey);

      // .........................................
      // Create a GgEasyWidgetTest for the subwidget
      final subGgEasyWidgetTest = GgEasyWidgetTest(subWidgetFinder, tester);

      // ..................................
      // Width and height should be correct
      expect(subGgEasyWidgetTest.width, subwidgetFrame.width);
      expect(subGgEasyWidgetTest.height, subwidgetFrame.height);

      // ..............................
      // Render box should be delivered
      expect(subGgEasyWidgetTest.renderBox, isInstanceOf<RenderBox>());

      // ..............................
      // The element should be delivered
      expect(subGgEasyWidgetTest.element, isInstanceOf<Element>());

      // ......................................
      // The absolute frame should be delivered
      expect(subGgEasyWidgetTest.absoluteFrame, subwidgetFrame);

      // ..............................
      // The widget should be delivered
      expect(subGgEasyWidgetTest.widget, subWidget);

      // .............................
      // The state should be delivered
      expect(subGgEasyWidgetTest.state, isInstanceOf<_SubWidgetState>());
    });
  });
}
