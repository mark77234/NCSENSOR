import 'package:NCSensor/utils/api_hook.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  late final ApiHook<String> apiHook;
  String value = 'Hello, World!';

  @override
  void initState() {
    super.initState();
    apiHook = ApiHook<String>(
      apiCall: (param) async {
        await Future.delayed(Duration(seconds: 5));
        return param.toString();
      },
      params: {'test': value},
    );
    apiHook.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = apiHook.state;
    apiHook.updateParams(
        {'test': value}); // 하위 위젯에서 변경할시 didUpdateWidget로 호출하는게 낫긴함

    print('state: $state');
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            state.isLoading
                ? Text("Loading...")
                : state.error != null
                    ? Text('Error: ${state.error}')
                    : Text('Data: ${state.data}'),
            TextField(
              onChanged: (text) {
                setState(() {
                  value = text;
                });
              },
            ),
            // Text('입력값: $value'),
            ElevatedButton(
              onPressed: () {
                state.reFetch();
              },
              child: Text('다시 불러오기'),
            )
          ],
        )),
      ),
    );
  }
}
