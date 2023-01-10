import 'package:flutter/material.dart';
import 'package:todo_app/cubit/cubit.dart';



Widget defaultFormText({
  required TextEditingController controller,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validator,
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onTap: () {
    onTap!();
  },
  obscureText: isPassword,
  onChanged: (value) {
    onChanged!(value);
  },
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
        onPressed: () {
          suffixClicked!();
        },
        icon: Icon(suffix),
      )
          : null,
      border: OutlineInputBorder()),
);
Widget buildtaskitem(Map model ,context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar
          (
          radius: 40.0,
          child: Text("${model['time']}"),

        ),
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${model['title']}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              Text(
                "${model['date']}", style: TextStyle(color: Colors.grey[500]),),
            ],
          ),


        ),
        SizedBox(
          width: 40,
        ),
        IconButton(
            onPressed: ()
            {
              AppCubit.get(context).UpdateData(status: 'done', id: model['id']);
            },
            icon: Icon
              (
                Icons.check_box
            )
        ),
        IconButton(
            onPressed: ()
            {
              AppCubit.get(context).UpdateData(status: 'archive', id: model['id']);
            },
            icon: Icon
              (
                Icons.archive
            )
        ),

      ],
    ),
  );
}