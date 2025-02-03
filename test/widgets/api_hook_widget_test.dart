import 'package:NCSensor/utils/api_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestWidget extends StatefulWidget {
  TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late final ApiHook<String> apiHook;

  @override
  void initState() {
    super.initState();
    apiHook = ApiHook<String>(
      apiCall: () async {
        await Future.delayed(Duration(seconds: 3));
        return 'Hello, World!';
      },
      debounceTime: Duration(milliseconds: 0),
    );
    apiHook.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = apiHook.state;
    print('state: $state');
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: state.isLoading
              ? Text("Loading...")
              : state.error != null
                  ? Text('Error: ${state.error}')
                  : Text('Data: ${state.data}'),
        ),
      ),
    );
  }
}

void main() {
  runApp(TestWidget());
  // testWidgets('ApiHook 위젯 테스트', (WidgetTester tester) async {
  //   await tester.pumpWidget(TestWidget());
  //
  //   // 초기 상태 확인
  //   // expect(find.text('Loading...'), findsOneWidget);
  //
  //   // API 호출 후 상태 확인
  //   await tester.pumpAndSettle();
  //   // expect(find.text('Data: Hello, World!'), findsOneWidget);
  // });
}
