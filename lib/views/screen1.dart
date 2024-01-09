import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task3/controller/controller.dart';
import 'package:task3/model/model.dart';



class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  DateTime _selectedDate = DateTime.now();
 
  List<NoteModel> _noteList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Notes",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Color.fromARGB(255, 68, 123, 71),
      ),
      backgroundColor: Color.fromARGB(255, 160, 200, 162),
      body: Column(
        children: [
          // Display your notes here
          Expanded(
            child: ListView.builder(
              itemCount: _noteList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_noteList[index].name),
                  subtitle: Text(_noteList[index].description),
                  trailing: Text(_noteList[index].date),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _showNoteModal,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showNoteModal() {
    nameController.clear();
    descriptionController.clear();
    _selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TextField(
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(_selectedDate),
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 68, 123, 71),
                    ),
                  ),
                  suffix: IconButton(
                    onPressed: _pickDate,
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const Text(
                'Title',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 68, 123, 71),
                    ),
                  ),
                ),
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 68, 123, 71),
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _submitNote,
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitNote() {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        _noteList.add(
          NoteModel(
            name: nameController.text.trim(),
            description: descriptionController.text.trim(),
            date: DateFormat('yyyy-MM-dd').format(_selectedDate),
          ),
        );
      });

      Navigator.pop(context);
    }
  }
}
