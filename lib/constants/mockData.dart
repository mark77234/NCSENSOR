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
    },
    {
      "type": "compareGraph",
      "list": [
        {
          "title": "입 냄새",
          "lastMonth": "3.2",
          "thisMonth": "1.7",
          "variationRate": "80",
        },
        {
          "title": "발 냄새",
          "lastMonth": "2.2",
          "thisMonth": "1.2",
          "variationRate": "45",
        },
        {
          "title": "겨드랑이 냄새",
          "lastMonth": "2.8",
          "thisMonth": "4.0",
          "variationRate": "80",
        },
      ]
    }
  ]
};

const historyData = [
  {
    "date": "2025-01-15",
    "measurements": [
      {
        "type": "drinking",
        "value": "0.08",
        "level": "1",
        "dateTime": "2025-01-15 12:00:00"
      },
      {
        "type": "odor",
        "subType": "mouth",
        "value": "3.0",
        "level": "4",
        "dateTime": "2025-01-15 13:10:00"
      },
      {
        "type": "odor",
        "subType": "foot",
        "value": "5.0",
        "level": "2",
        "dateTime": "2025-01-15 16:24:00"
      }
    ]
  },
  {
    "date": "2025-01-14",
    "measurements": [
      {
        "type": "drinking",
        "value": "0.08",
        "level": "1",
        "dateTime": "2025-01-14 12:00:00"
      },
      {
        "type": "odor",
        "subType": "mouth",
        "value": "3.0",
        "level": "4",
        "dateTime": "2025-01-14 11:10:00"
      },
      {
        "type": "odor",
        "subType": "foot",
        "value": "5.0",
        "level": "2",
        "dateTime": "2025-01-14 16:24:00"
      }
    ]
  }
];
