import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/compontents/compontents.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';



class HomeScreen extends StatelessWidget {
  var scaffoldkey=GlobalKey<ScaffoldState>();
  var formkey=GlobalKey<FormState>();


  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();





  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (BuildContext context) => AppCubit()..CreateDatabase(),
        child: BlocConsumer<AppCubit,AppStates>
          (
            listener: (context, state) {

            },

            builder: (context, state) {
              AppCubit cubit = AppCubit.get(context);
              return Scaffold(
                key: scaffoldkey,
                appBar: AppBar(
                  title: Text("Todo app"
                  ),
                ),
                body: cubit.screens[cubit.currentIndex],
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (cubit.isBottomSheetShown) {
                      if (formkey.currentState!.validate()) {
                        cubit.InsertToDatabase(
                            title: titleController.text,
                            date: dateController.text,
                            time: timeController.text).then((value) {

                        });
                        Navigator.pop(context);
                       cubit.bottomsheeticon(isShow: false,icon: Icons.edit);
                      }
                    }
                    else {
                      scaffoldkey.currentState!.showBottomSheet(
                            (context) =>
                            Container(
                              color: Colors.grey[200],
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormText(
                                        controller: titleController,
                                        type: TextInputType.text,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'empty';
                                          }
                                          return null;
                                        },
                                        label: 'Task Title',
                                        prefix: Icons.title
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFormText(
                                        controller: timeController,
                                        type: TextInputType.datetime,
                                        onTap: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now()
                                          ).then((value) {
                                            timeController.text =
                                                value!.format(context)
                                                    .toString();
                                            print(value.format(context));
                                          }
                                          );
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'empty';
                                          }
                                          return null;
                                        },
                                        label: 'Time Title',
                                        prefix: Icons.watch_later
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultFormText(
                                      controller: dateController,
                                      type: TextInputType.datetime,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse(
                                              '2023-01-31'),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);

                                          print(
                                              DateFormat.yMMMd().format(value));
                                        });
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'empty';
                                        }
                                        return null;
                                      },
                                      label: 'Date Title',
                                      prefix: Icons.calendar_today,
                                    ),
                                  ],
                                ),
                              ),
                            ),


                      ).closed.then((value) {
                        cubit.bottomsheeticon(isShow: false,icon: Icons.edit);

                      });

                      cubit.bottomsheeticon(isShow: true,icon: Icons.add);
                    }
                    // InsertToDatabase();
                  },
                  child: Icon(
                    cubit.BottomIcon,

                  ),
                ),

                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.change(index);
                  },
                  items:
                  [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu),
                        label: "Tasks"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle),
                        label: "Done"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.archive),
                        label: "Archived"),


                  ],
                ),
              );
            }),
    );
  }
  Future<String> getName() async{
    return 'ahned ahg';
  }




}


