import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [];

  final ScrollController _sc = ScrollController();
  final TextEditingController _tc = TextEditingController();
  final FocusNode _fn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('What ToDoo')
      ),
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(

                  child: Scrollbar(
                    controller: _sc,
                    child: SingleChildScrollView(
                      controller: _sc,
                      child: Column(
                        children: [
                          for (Todo todo in todos)
                            ListTile(
                              leading: Text(todo.id.toString()),
                              title: Text(todo.details, style: const TextStyle(fontSize: 18), ),
                              subtitle: Text(todo.created.toString()),
                              trailing: SizedBox(
                                child: Wrap(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        editTodo(todo.details, todo.id);
                                      },
                                    ),

                                    IconButton(
                                      icon: const Icon(CupertinoIcons.delete),
                                      onPressed: () {
                                        removeToDo(todo.id);
                                      },
                                    ),
                                  ],
                                ),

                              ),
                            )
                        ],
                      ),
                    ),
                  )),
              TextFormField(
                controller: _tc,
                focusNode: _fn,
                maxLines: 5,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  prefix: IconButton(
                    icon: const Icon(Icons.cancel ,color: Colors.black,),
                    onPressed: () {
                      _fn.unfocus();
                    },
                  ),
                  suffix: IconButton(
                    icon: const Icon(Icons.chevron_right_rounded ,color: Colors.black,),
                    onPressed: () {
                      addTodo(_tc.text);
                      _tc.text = '';
                      _fn.unfocus();
                    },
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addTodo(String details){
    int index = 0;
    if ( todos.isEmpty) {
      index = 0;
    } else {
      index = todos.last.id + 1;
    }
    
    if (mounted) {
      setState(() {
        todos.add(Todo(details: details, id: index));
      });
    }
  }

  removeToDo(int id){
    if (todos.isNotEmpty){

      for (int i = 0; i < todos.length; i++){
        if( id == todos[i].id){
         todos.removeAt(i);
         setState(() {

         });
        }
      }
    }

  }

  editTodo(String details, int index){
    _tc.text = details;
    showDialog( context: context, barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: TextFormField(
          controller: _tc,
        ),
        actions:[
          TextButton(
            onPressed:(){
              if (todos.isNotEmpty){
                for (int i = 0; i < todos.length; i++){
                  if (index == todos[i].id){
                    setState(() {
                      todos[i].details = _tc.text;
                      _tc.text = ''; });
                  }
                }
              }
              Navigator.of(context).pop();
            },
            child: const Text('Save Edit'),
          )
        ],
      ),
    );
  }
}


class Todo {
  String details;
  late DateTime created;
  int id;

  Todo({this.details = '', DateTime? created, this.id = 0}) {
    created == null ? this.created = DateTime.now() : this.created = created;
  }
}

