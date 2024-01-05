import 'package:erg_diagnosis/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum ErgCustomFieldsType { type, numeric }

class ErgCustomFields extends StatefulWidget {
  const ErgCustomFields({
    required this.inputField,
    required this.title,
    required this.hintText,
    this.textEditingController,
    super.key,
  }) : type = null;
  const ErgCustomFields.type({
    super.key,
    required this.type,
    required this.title,
    required this.hintText,
    this.textEditingController,
  }) : inputField = null;

  final ErgCustomFieldsType? type;
  final Widget? inputField;
  final String title;
  final String hintText;
  final TextEditingController? textEditingController;

  @override
  State<ErgCustomFields> createState() => _ErgCustomFieldsState();
}

class _ErgCustomFieldsState extends State<ErgCustomFields> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    HomePageController homePageController = Get.find<HomePageController>();

    switch (widget.type) {
      case ErgCustomFieldsType.numeric:
        return ErgCustomFields(
            hintText: widget.hintText,
            inputField: ConstrainedBox(
              constraints: BoxConstraints(minWidth: w * 0.2, maxWidth: w * 0.3),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: TextField(
                  controller: widget.textEditingController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.4)),
                    alignLabelWithHint: true,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 13.sp),
                    focusColor: Colors.black,
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
            ),
            title: widget.title);
      case ErgCustomFieldsType.type:
        return ErgCustomFields(
          hintText: "Scotopic, Photopic, Maximum",
          inputField: DropdownButton<String>(
            alignment: AlignmentDirectional.centerEnd,
            hint: Text(
              widget.hintText,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10.sp,
              ),
            ),
            value: homePageController.selectedType.value == ""
                ? null
                : homePageController.selectedType.value,
            onChanged: (newValue) {
              homePageController.changeTypeValue(newValue);
              setState(() {});
            },
            items: homePageController.type.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(
                  type,
                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                ),
              );
            }).toList(),
          ),
          title: "Type",
        );

      default:
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            width: w * 0.6,
            height: h * 0.06,
            decoration: BoxDecoration(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Color.fromARGB(47, 0, 0, 0),
                    blurRadius: 1.5,
                    spreadRadius: 1.5,
                    blurStyle: BlurStyle.normal,
                    offset: Offset(0, 0))
              ],
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  widget.inputField!
                ],
              ),
            ),
          ),
        );
    }
  }
}
