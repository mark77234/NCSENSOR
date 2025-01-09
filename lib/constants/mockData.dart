const staticData = {
  "drinking": [
    {
      "type": "tile",
      "title": "이번 달 음주 일수",
      "value": "12",
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
      "icon": "assets/beer.svg",
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

const historyData = [
  {
    "date": "2024-01-15",
    "measurements": [
      {"type": "drinking", "value": "0.08", "level": "1"},
      {"type": "odor", "subType": "foot", "value": "5.0", "level": "2"}
    ]
  },
  {
    "date": "2024-01-14",
    "measurements": [
      {"type": "odor", "subType": "mouth", "value": "3.0", "level": "4"},
      {"type": "drinking", "value": "0.2", "level": "2"}
    ]
  }
];
