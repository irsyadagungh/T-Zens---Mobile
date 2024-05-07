import 'package:flutter/material.dart';
import 'package:tzens/app/modules/add/controllers/add_controller.dart';
import 'package:tzens/app/utils/widget/Form_Widget.dart';

class DynamicFormTwoField extends StatelessWidget {
  const DynamicFormTwoField({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.textEditingController1,
    required this.textEditingController2,
    required this.increment,
    required this.decrement,
    required this.iconField1,
    required this.iconField2,
  });

  final AddController controller;
  final int itemCount;
  final List<TextEditingController> textEditingController1;
  final List<TextEditingController> textEditingController2;
  final Function() increment;
  final Function() decrement;
  final Icon iconField1;
  final Icon iconField2;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (ctx, index) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: FormText(
                    icon: iconField1,
                    hintText: "Contact Name",
                    controller: textEditingController1[index],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: FormText(
                    icon: iconField2,
                    hintText: "Contact Phone",
                    controller: textEditingController2[index],
                  ),
                ),
                index < 1
                    ? IconButton(
                        color: Colors.black,
                        onPressed: () {
                          textEditingController1.add(TextEditingController());
                          textEditingController2.add(TextEditingController());
                          increment();
                          controller.update();
                          print(controller.totalContact.value);
                        },
                        icon: Icon(Icons.add),
                      )
                    : IconButton(
                        color: Colors.red,
                        onPressed: () {
                          textEditingController1[index].clear();
                          textEditingController2[index].clear();
                          textEditingController1[index].dispose();
                          textEditingController2[index].dispose();
                          textEditingController1.removeAt(index);
                          textEditingController2.removeAt(index);
                          decrement();
                          controller.update();
                          print(controller.totalContact.value);
                        },
                        icon: Icon(Icons.delete),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}