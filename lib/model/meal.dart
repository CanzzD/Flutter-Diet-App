class Meal {
  final String mealTime, name, imagePath, kiloCalories, timeTaken;

  Meal({
    required this.mealTime,
    required this.name,
    required this.imagePath,
    required this.kiloCalories,
    required this.timeTaken,
  });
}

final meals = [
  Meal(
    mealTime:"Kahvalti",
    name:"Tost",
    kiloCalories:"243",
    timeTaken:"10:00",
    imagePath: "images/soup.png",
  ),
  Meal(
    mealTime:"Öğlen Yemeği",
    name:"Makarna",
    kiloCalories:"203",
    timeTaken:"14:30",
    imagePath: "images/soup.png",
  ),
  Meal(
    mealTime:"Akşam Yemeği",
    name:"Çorba",
    kiloCalories:"143",
    timeTaken:"19:00",
    imagePath: "images/soup.png",
  ),
];