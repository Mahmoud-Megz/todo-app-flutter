import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/compontents/compontents.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';



class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state) {
          var tasks =AppCubit.get(context).archivedtasks;
          return ListView.separated(
              itemBuilder: (context, index) => buildtaskitem(tasks[index],context),
              separatorBuilder: (context, index) => SizedBox(height: 20,),
              itemCount: tasks.length);
        }
    );


  }
}
