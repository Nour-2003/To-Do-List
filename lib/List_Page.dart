import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/sqflite.dart';

class List_page extends StatefulWidget {
  @override
  State<List_page> createState() => _List_pageState();
}

class _List_pageState extends State<List_page> {
  List<Map<String, dynamic>> _journals = [];
  bool _isloading = true;

  void _refreshJournals() async {
    final data = await Sqflite_Helper.getItems();
    setState(() {
      _journals = data;
      _isloading = false;
    });
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _addItem() async {
    await Sqflite_Helper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals();
    print("...number of items ${_journals.length}");
  }

  Future<void> _updateItem(int id) async {
    await Sqflite_Helper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }
  Future<void> _deleteItem(int id) async {
    await Sqflite_Helper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sucessfully deleted a journal")),);
_refreshJournals();
  }
  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: 'Description'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (id == null) {
                          await _addItem();
                        }
                        if (id != null) {
                          await _updateItem(id);
                        }
                        _titleController.text = '';
                        _descriptionController.text = '';
                        Navigator.of(context).pop();
                      },
                      child: Text(id == null ? "Create New" : "Update"))
                ],
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    print("...number of items ${_journals.length}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("SQL"),
      ),
      backgroundColor: Colors.indigoAccent,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => _showForm(null),
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 35,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.builder(
          itemCount: _journals.length,
          itemBuilder: (context, index) => Card(
                color: Colors.white,
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_journals[index]['title']),
                  subtitle: Text(
                    _journals[index]['description'],
                  ),
                  trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () =>
                                  _showForm(_journals[index]['id']),
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () => _deleteItem(_journals[index]['id']), icon: Icon(Icons.delete))
                        ],
                      )),
                ),
              )),
    );
  }
}
