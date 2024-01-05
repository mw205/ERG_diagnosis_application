import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sklite/tree/tree.dart';

class HomePageController extends GetxController {
  List<String> images = [
    "assets/Images/mans_univ.png",
    "assets/Images/engineering.jpg",
    "assets/Images/biomedical.jpg",
  ];
  List<String> type = ["Scotopic", "Photopic", "Maximum"];
  RxString selectedType = "".obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController aWaveController = TextEditingController();
  TextEditingController bWaveController = TextEditingController();
  TextEditingController aWaveLatencyController = TextEditingController();
  TextEditingController bWaveLatencyController = TextEditingController();
  RxString result = "".obs;
  void makePrediction() async {
    DecisionTreeClassifier classifier = DecisionTreeClassifier.fromMap(
        await readJsonFile("assets/models/finalmodel.json"));
    List<double> x = [];
    if (selectedType.value == type[0]) {
      x.add(0);
    } else if (selectedType.value == type[0]) {
      x.add(1);
    } else {
      x.add(2);
    }
    if (ageController.text != "" ||
        selectedType.value == "" ||
        aWaveController.text != "" ||
        bWaveController.text != "" ||
        aWaveLatencyController.text != "" ||
        bWaveLatencyController.text != "") {
      x.add(double.parse(ageController.text));
      x.add(double.parse(aWaveController.text));
      x.add(double.parse(bWaveController.text));
      x.add(double.parse(aWaveLatencyController.text));
      x.add(double.parse(bWaveLatencyController.text));
      int prediction = (classifier.predict(x));
      Map<String, dynamic> classes =
          await readJsonFile("assets/models/classes.json");
      result.value = classes[prediction.toString()];
      update();
    }
  }

  String readFile(String path) {
    return File(path).readAsStringSync();
  }

  Future<Map<String, dynamic>> readJsonFile(String path) async {
    return json.decode(
      await rootBundle.loadString(path, cache: false),
    );
  }

  changeTypeValue(String? value) {
    selectedType.value = value!;
    update();
  }
}
