import 'package:flutter/material.dart';
import 'package:resizable_widget/resizable_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resizable Widget Example',
      theme: ThemeData.dark(),
      home: const MyPage(),
    );
  }
}


class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var textDirection = TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    final rtl = textDirection == TextDirection.rtl;
    return Scaffold(
      appBar: AppBar(
        title: Text('Resizable Widget Example (${rtl? 'Right-to-Left' : 'Left-to-Right'})'),
        actions: [
          IconButton(
            icon: Icon(rtl ? Icons.subdirectory_arrow_left : Icons.subdirectory_arrow_right),
            onPressed: () {
              setState(() => textDirection = rtl? TextDirection.ltr : TextDirection.rtl);
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: textDirection,
        child: ResizableWidget(
          isHorizontalSeparator: false,
          isDisabledSmartHide: false,
          separatorColor: Colors.white12,
          separatorSize: 4,
          onResized: _printResizeInfo,
          children: [
            Container(color: Colors.greenAccent),
            ResizableWidget(
              isHorizontalSeparator: true,
              separatorColor: Colors.blue,
              separatorSize: 10,
              children: [
                Container(color: Colors.greenAccent),
                ResizableWidget(
                  children: [
                    Container(color: Colors.greenAccent),
                    Container(color: Colors.yellowAccent),
                    Container(color: Colors.redAccent),
                  ],
                  percentages: const [0.2, 0.5, 0.3],
                ),
                Container(color: Colors.redAccent),
              ],
            ),
            Container(color: Colors.redAccent),
          ],
        ),
      ),
    );
  }

  void _printResizeInfo(List<WidgetSizeInfo> dataList) {
    // ignore: avoid_print
    print(dataList.map((x) => '(${x.size}, ${x.percentage}%)').join(", "));
  }
}
