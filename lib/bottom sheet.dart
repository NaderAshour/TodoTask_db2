import 'package:flutter/material.dart';
import 'package:todolast/database.dart';
import 'package:todolast/main.dart';
import 'package:todolast/todomodal.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  DateTime? chooseDate;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController Datecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (String name) {
                  setState(() {
                    name = namecontroller.text;
                  });
                },
                controller: namecontroller,
                decoration:
                    InputDecoration(hintText: 'Task Name', labelText: 'Todo'),
              ),
              TextField(
                onTap: () async {
                  chooseDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      Duration(days: 30),
                    ),
                  );
                  Datecontroller.text = chooseDate.toString();
                },
                onChanged: (String date) {
                  setState(() {
                    date = Datecontroller.text;
                  });
                },
                controller: Datecontroller,
                decoration: InputDecoration(
                  hintText: 'No Due Date',
                  labelText: 'Time',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'cancel',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      DbHelper.instance.addtodo(TodoDetails(
                          name: namecontroller.text,
                          date: chooseDate!.millisecondsSinceEpoch,
                          isChecked: false));

                      print(todo);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'save',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
