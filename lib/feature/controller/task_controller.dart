
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_managment/constant/local-string.dart';
import 'package:task_managment/feature/model/task_model.dart';
import 'package:task_managment/utils/service/my_db_helper.dart';


class TaskController extends GetxController{

  TextEditingController searchController=TextEditingController();
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  TextEditingController statusController=TextEditingController();
  RxList<TaskModel>taskList=RxList([]);
  RxBool isLoaded=RxBool(false);
 Future<void> addTask()async {
    isLoaded.value=true;
  TaskModel taskModel=TaskModel(
      title:titleController.text,
      description: descriptionController.text,
      status:statusController.text
  );

    MyDbHelper.createTask(
        taskModel:taskModel).then((value) {
      isLoaded.value=false;
      readAllTask() ;


    });
  }


   readAllTask()async{
    isLoaded.value=true;
    Database db=await MyDbHelper.inItDb();

   await db.query(LocalString.kTaskTableName).then((res) {

     isLoaded.value=false;

      taskList.value =  res.isNotEmpty? res.map((e)=>TaskModel.fromMap(e)).toList():[];


    });


  }
  search({searchKey})async{

    Database db=await MyDbHelper.inItDb();

    await db.query(LocalString.kTaskTableName ,where:'title=?',whereArgs:[searchKey]).then((res) {

      taskList.value =  res.isNotEmpty? res.map((e)=>TaskModel.fromMap(e)).toList():[];


    });


  }

   Future<int>updateTask({required TaskModel taskModel})async{
    Database db=await MyDbHelper.inItDb();
    int count= await db.rawUpdate(
        'UPDATE ${LocalString.kTaskTableName} SET title = ?, description = ? , status = ? WHERE id = ?',
        [(titleController.text), (descriptionController.text),(statusController.text), '${taskModel.id}']).then((value){

          readAllTask();
      return value;

    });
    return count;







  }

  Future<void> close() async{

    Database db= await MyDbHelper.inItDb();
    db.close();
  }
  delete({id})async{
    Database db=await MyDbHelper.inItDb();
     await db.delete(LocalString.kTaskTableName,where:'id=?',whereArgs: [id]).then((res){

       readAllTask();

     });
  }

  checkUpdate({index}){
    if(taskList[index].status=='false'){
      taskList[index].status='true';
    }else{
      taskList[index].status='false';
    }

  }
@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    readAllTask();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    statusController.clear();
    descriptionController.clear();
    titleController.clear();
    searchController.clear();



  }

}