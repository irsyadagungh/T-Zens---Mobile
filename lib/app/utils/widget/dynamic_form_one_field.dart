import 'package:flutter/material.dart';
import 'package:tzens/app/modules/add/controllers/add_controller.dart';
import 'package:tzens/app/utils/widget/Form_Widget.dart';

class DynamicFormOneField extends StatelessWidget {
  const DynamicFormOneField({
    super.key,
    required this.name,
    required this.controller,
    required this.itemCount,
    required this.nameController,
    required this.onPressedTrue,
    required this.icon,
  });

  final controller;
  final int itemCount;
  final List<TextEditingController> nameController;
  final Function() onPressedTrue;
  final String name;
  final Icon icon;

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
                    icon: icon,
                    hintText: name,
                    controller: nameController[index],
                  ),
                ),
                index < 1
                    ? IconButton(
                        color: Colors.black,
                        onPressed: onPressedTrue,
                        icon: Icon(Icons.add),
                      )
                    : IconButton(
                        color: Colors.red,
                        onPressed: () {
                          nameController[index].clear();
                          nameController[index].dispose();
                          nameController.removeAt(index);
                          controller.benefitDecrement();
                          controller.update();
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
