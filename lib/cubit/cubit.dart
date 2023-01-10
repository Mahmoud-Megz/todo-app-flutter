import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/screens/archived_tasks/archived_tasks.dart';
import 'package:todo_app/screens/done_tasks/done_tasks.dart';
import 'package:todo_app/screens/new_tasks/new_tasks.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(AppInitState());
static AppCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;

  List <Widget> screens=

  [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks()
  ];


  void change(int index)
  {

      currentIndex=index;
      emit(AppChangeNavState());

  }

  late Database database;
  List <Map> newtasks=[];
  List <Map> donetasks=[];
  List <Map> archivedtasks=[];


  void CreateDatabase() {

     openDatabase(
      'todoapp11.db',
      version: 1,
      onCreate: (database,  version) async
      {
        print("database created");
        await database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT )').then((value) {
          print("table created");
        }).catchError((error)
        {
          print("error in create ${error.toString()}");

        });

      },
      onOpen: (database)
      {
        getDatabase(database);
        print("database opened");
      },
    ).then((value)
     {
      database =value;
      emit(AppCreateDB());
     });



  }

  Future InsertToDatabase(
      {required title,
        required time,
        required date,
      })async{
    return await database.transaction((txn) async {

      txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")').then((value)
      {
        print("$value inserted done");
        emit(AppInsertDB());
        getDatabase(database);
      }).catchError((error)
      {
        print("error in insretion ${error.toString()}");

      });

    });



  }
  void getDatabase(database) {
    newtasks=[];
    donetasks=[];
    archivedtasks=[];

    database.rawQuery('SELECT * FROM tasks').then((value)
    {


      value.forEach((element)
      {
        if(element['status'] == 'new')
          newtasks.add(element);
        else if(element['status'] == 'done')
          donetasks.add(element);
        else archivedtasks.add(element);
      });
      emit(AppGetDB());

    });


  }
  bool isBottomSheetShown= false;
  IconData BottomIcon = Icons.edit;

void bottomsheeticon({
  required bool isShow,
  required IconData icon
})
{
  isBottomSheetShown=isShow;
  BottomIcon=icon;
emit(AppOpenCloseBottomSheet());
}

void UpdateData({
  required String status,
  required int id,
}) async
{
   await database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id,]).then((value)
   {
     getDatabase(database);
     emit(AppUpdatetDB());
   }
   );

}



}













