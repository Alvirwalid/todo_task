

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:task_managment/constant/local-string.dart';
import 'package:task_managment/feature/controller/task_controller.dart';
import 'package:task_managment/feature/model/task_model.dart';

class MyDbHelper{


 static Future<Database>inItDb()async{

   var dbPath= await getDatabasesPath();

   var path =join(dbPath,LocalString.kTaskDatabase);

   return await openDatabase(path,version: 1, onCreate:_onCreate);
 }

 static Future _onCreate(Database db,int version)async{
   const sql= '''CREATE TABLE ${LocalString.kTaskTableName}(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT NOT NULL,description TEXT NOT NULL,status TEXT NOT NULL)''';
   await db.execute(sql);
 }

 static Future<int>createTask({required TaskModel taskModel})async{
   Database db=await MyDbHelper.inItDb();
   return await db.insert(LocalString.kTaskTableName, taskModel.toMap());

 }
 static Future<List<TaskModel>>readAllTask()async{
   Database db=await MyDbHelper.inItDb();

  var task=await db.query(LocalString.kTaskTableName);

  List<TaskModel>taskList= task.isNotEmpty? task.map((e)=>TaskModel.fromMap(e)).toList():[];

  print(['len',taskList.length]);

  return taskList;
 }


 static Future<int>updateTask({required TaskModel taskModel,title,des,status})async{

   Database db=await MyDbHelper.inItDb();

   String? title='Abir';
   String des= 'desssssssssssss';
   String status='true';

   print([title,des,status]);

   int count= await db.rawUpdate(
       'UPDATE ${LocalString.kTaskTableName} SET title = ?, description = ? , status = ? WHERE title = ?',
       ['$title', 'des','status', '${taskModel.title}']).then((value){


     Get.put(TaskController()).readAllTask();
     return value;

   });
   return count;







 }
 static Future<int>delete(int id)async{
   Database db=await MyDbHelper.inItDb();
   return await db.delete(LocalString.kTaskTableName,where:'id=?',whereArgs: [id]);
 }
}