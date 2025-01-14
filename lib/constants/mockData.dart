import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://44579175-e66a-493c-a58d-47adc2d3e0b3.mock.pstmn.io/';


List<Map<String, dynamic>> historyData = [];

Future<void> fetchHistoryData() async {
  final url =
      '${baseUrl}/history?start=2025-01-01&end=2025-01-31';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    historyData = List<Map<String, dynamic>>.from(data);
  }
}


const staticData = {
  "drinking": [
    {
      "type": "tile",
      "title": "이번 달 음주 일수",
      "value": "13",
      "icon": "assets/calender.svg",
      "unit": "일",
    },
    {
      "type": "tile",
      "title": "최다 음주량",
      "value": "3",
      "icon": "assets/peek.svg",
      "unit": "잔",
    },
    {
      "type": "tile",
      "title": "평균 알콜 농도",
      "value": "0.08",
      "icon": "assets/drinking.svg",
      "unit": "%",
    },
    {
      "type": "customGraph",
      "title": "평균 알콜 농도",
      "value": "0.08",
      "icon": "assets/customGraph.svg",
    },
    {
      "type": "calendar",
      "title": "술 일지",
      "value": [
        {"date": "2025-01-01", "value": "1"},
        {"date": "2025-01-04", "value": "2"},
        {"date": "2025-01-05", "value": "3"},
        {"date": "2025-01-09", "value": "1"},
        {"date": "2025-01-12", "value": "2"},
        {"date": "2025-01-13", "value": "3"},
        {"date": "2025-01-14", "value": "1"},
        {"date": "2025-01-21", "value": "2"},
        {"date": "2025-01-27", "value": "2"},
      ]
    }
  ],
  "odor": [
    //   입, 발, 겨드랑이 악취 농도
    {
      "type": "tile",
      "title": "입 악취 농도",
      "value": "0.08",
      "icon": "assets/mouth.svg",
      "unit": "ppm",
    },
    {
      "type": "tile",
      "title": "발 악취 농도",
      "value": "0.08",
      "icon": "assets/foot.svg",
      "unit": "ppm",
    },
    {
      "type": "tile",
      "title": "겨드랑이 악취 농도",
      "value": "0.08",
      "icon": "assets/armpit.svg",
      "unit": "ppm",
    }
  ]
};

// const historyData = [
//   {
//     "date": "2025-01-15",
//     "measurements": [
//       {
//         "type": "drinking",
//         "value": "0.08",
//         "level": "1",
//         "dateTime": "2025-01-15 12:00:00"
//       },
//       {
//         "type": "odor",
//         "subType": "mouth",
//         "value": "3.0",
//         "level": "4",
//         "dateTime": "2025-01-15 13:10:00"
//       },
//       {
//         "type": "odor",
//         "subType": "foot",
//         "value": "5.0",
//         "level": "2",
//         "dateTime": "2025-01-15 16:24:00"
//       }
//     ]
//   },
//   {
//     "date": "2025-01-14",
//     "measurements": [
//       {
//         "type": "drinking",
//         "value": "0.08",
//         "level": "1",
//         "dateTime": "2025-01-14 12:00:00"
//       },
//       {
//         "type": "odor",
//         "subType": "mouth",
//         "value": "3.0",
//         "level": "4",
//         "dateTime": "2025-01-14 11:10:00"
//       },
//       {
//         "type": "odor",
//         "subType": "foot",
//         "value": "5.0",
//         "level": "2",
//         "dateTime": "2025-01-14 16:24:00"
//       }
//     ]
//   }
// ];
