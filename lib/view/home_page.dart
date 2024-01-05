import 'package:erg_diagnosis/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'erg_custom_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<String> type = ["Scotopic", "Photopic", "Maximum"];
  // String? selectedType = "";
  // TextEditingController ageController = TextEditingController();
  // TextEditingController aWaveController = TextEditingController();
  // TextEditingController bWaveController = TextEditingController();
  // TextEditingController aWaveLatencyController = TextEditingController();
  // TextEditingController bWaveLatencyController = TextEditingController();
  // String? result = "";
  // void makePrediction() async {
  //   DecisionTreeClassifier classifier = DecisionTreeClassifier.fromMap(
  //       await readJsonFile("assets/models/finalmodel.json"));
  //   List<double> x = [];
  //   if (selectedType == type[0]) {
  //     x.add(0);
  //   } else if (selectedType == type[0]) {
  //     x.add(1);
  //   } else {
  //     x.add(2);
  //   }
  //   if (ageController.text != "" ||
  //       selectedType == "" ||
  //       aWaveController.text != "" ||
  //       bWaveController.text != "" ||
  //       aWaveLatencyController.text != "" ||
  //       bWaveLatencyController.text != "") {
  //     x.add(double.parse(ageController.text));
  //     x.add(double.parse(aWaveController.text));
  //     x.add(double.parse(bWaveController.text));
  //     x.add(double.parse(aWaveLatencyController.text));
  //     x.add(double.parse(bWaveLatencyController.text));
  //     int prediction = (classifier.predict(x));

  //     Map<String, dynamic> classes =
  //         await readJsonFile("assets/models/classes.json");
  //     result = classes[prediction.toString()];
  //     setState(() {});
  //   }
  // }

  // String readFile(String path) {
  //   return File(path).readAsStringSync();
  // }

  // Future<Map<String, dynamic>> readJsonFile(String path) async {
  //   return json.decode(
  //     await rootBundle.loadString(path, cache: false),
  //   );
  // }

  // changeTypeValue(String? value) {
  //   selectedType = value!;
  //   result = "";
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    HomePageController controller = Get.find<HomePageController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 2.5,
        shadowColor: Colors.black,
        title: Text(
          "ERG_diagnosis",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: w * 0.32,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(
                          "assets/images/mans_univ.png",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.32,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset("assets/images/engineering.png"),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.32,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset("assets/images/biomedical.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.065,
              ),
              SizedBox(
                height: h * 0.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/erg_device.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        width: w * 0.35,
                        height: h * 0.43,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GetBuilder(
                          init: controller,
                          builder: (controller) => ErgCustomFields.type(
                            type: ErgCustomFieldsType.type,
                            title: "Type",
                            hintText: controller.type.join(" ,"),
                          ),
                        ),
                        ErgCustomFields.type(
                            title: "Age",
                            hintText: "age",
                            type: ErgCustomFieldsType.numeric,
                            textEditingController: controller.ageController),
                        ErgCustomFields.type(
                            title: "A Wave",
                            hintText: "(µ V)",
                            type: ErgCustomFieldsType.numeric,
                            textEditingController: controller.aWaveController),
                        ErgCustomFields.type(
                          title: "B wave",
                          hintText: "(µ V)",
                          type: ErgCustomFieldsType.numeric,
                          textEditingController: controller.bWaveController,
                        ),
                        ErgCustomFields.type(
                            title: "A wave latency",
                            hintText: "(ms)",
                            type: ErgCustomFieldsType.numeric,
                            textEditingController:
                                controller.aWaveLatencyController),
                        ErgCustomFields.type(
                            title: "B Wave latency",
                            hintText: "(ms)",
                            type: ErgCustomFieldsType.numeric,
                            textEditingController:
                                controller.bWaveLatencyController),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.makePrediction();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                  width: w * 0.25,
                  height: h * 0.05,
                  child: Center(
                    child: Text(
                      "Diagnosis",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              GetBuilder(
                init: controller,
                builder: (controller) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Container(
                    width: w * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromARGB(47, 0, 0, 0),
                          blurRadius: 1.5,
                          spreadRadius: 1.5,
                          blurStyle: BlurStyle.normal,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Text(
                        controller.result.value,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
