import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_managment/constant/color_path.dart';
import 'package:task_managment/constant/local-string.dart';
import 'package:task_managment/constant/other_constant.dart';
import 'package:task_managment/feature/controller/task_controller.dart';
import 'package:task_managment/share_component/custom_style.dart';
import 'package:task_managment/share_component/custom_widget/custom_button.dart';
import 'package:task_managment/share_component/custom_widget/custom_widgets.dart';
import 'package:task_managment/utils/ui/custom_loading.dart';

class Taskpage extends StatefulWidget {
  const Taskpage({super.key});

  @override
  State<Taskpage> createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  var selectedStatus;

  final TaskController _controller=Get.put(TaskController());

  List<String> statusList = ['true', 'false'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPath.kWhite,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _buildAppBar(),
      body: GetX<TaskController>(
        init: TaskController(),
        builder: (_) {
          _.taskList.sort((a, b) => b.id!.compareTo(a.id!),);
          return _.isLoaded.isTrue? CustomLoading.loadingScreen():

          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal:OtherConstant.kLargeTextSize,
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _.taskList.isEmpty?CustomWidgets.notAvailableContainer(
                      padding: EdgeInsets.symmetric( vertical: OtherConstant.kLargePadding*2),
                        icon: Icons.task,
                        context: context, title:LocalString.kThere_is_No_task,
                        subTitle:LocalString.kPressAdd ): Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: OtherConstant.kRegularRadius,
                              bottom: OtherConstant.kLargeTextSize,
                            ),
                            child: Text(
                              'All Task',
                              style: CustomStyle.kCustomTextStyle(
                                fontSize: OtherConstant.kLargeTextSize*1.5,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(height:OtherConstant.kRegularRadius),
                            shrinkWrap: true,
                            itemCount:_.taskList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {


                              return Container(
                                padding: EdgeInsets.symmetric( horizontal: OtherConstant.kRegularPadding, vertical:OtherConstant.kRegularPadding),
                                decoration: BoxDecoration(color: ColorPath.kLightPrimary, borderRadius: BorderRadius.circular(OtherConstant.kSmallIconSize)),
                                child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _.checkUpdate(index:index);
                                            });

                                          },
                                          padding: EdgeInsets.zero,
                                          icon: Icon(_.taskList[index].status=='true'?Icons.check_box : Icons.check_box_outline_blank, color: ColorPath.tdBlue),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${_.taskList[index].title}',
                                            style: TextStyle(
                                              fontSize:OtherConstant.kLargeTextSize,
                                              fontWeight: FontWeight.w600,
                                              color: ColorPath.tdBlack,
                                              decoration: _.taskList[index].status=='true' ? TextDecoration.lineThrough : null,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                color: ColorPath.tdRed.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(OtherConstant.kSmallRadius),
                                              ),
                                              child: IconButton(
                                                color: Colors.white,
                                                icon: Icon(
                                                  FeatherIcons.trash2,
                                                  color: ColorPath.tdRed,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                        builder: (context, setState) {
                                                          return AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(OtherConstant.kMediumTextSize)),
                                                            backgroundColor: Colors.white,
                                                            elevation: 0,
                                                            contentPadding: const EdgeInsets.all(0),
                                                            insetPadding: EdgeInsets.all(OtherConstant.kRegularRadius),
                                                            content: Container(
                                                              width: double.maxFinite,
                                                              padding: EdgeInsets.all(OtherConstant.kLargePadding),


                                                              decoration: CustomStyle.kCustomBoxDecoration(
                                                                color: Colors.white,
                                                                radius: BorderRadius.circular(OtherConstant.kMediumTextSize)
                                                              ),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    'Confirm delete',
                                                                    style: CustomStyle
                                                                        .kCustomTextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                  ),
                                                                  SizedBox(
                                                                    height: OtherConstant
                                                                        .kLargePadding,
                                                                  ),
                                                                  Text(LocalString.kDeleteAlert, style: CustomStyle.kCustomTextStyle()),
                                                                  SizedBox(height: OtherConstant.kLargePadding * 2),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child: CustomButton
                                                                            .kCustomElevatedButton(
                                                                            onPressed: () {
                                                                              Get.back();
                                                                            },
                                                                            padding: 10.sp,
                                                                            color:
                                                                            Colors.red,
                                                                            title:LocalString.kCancel,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w600),
                                                                      ),
                                                                      SizedBox(
                                                                        width: OtherConstant
                                                                            .kRegularPadding,
                                                                      ),
                                                                      Expanded(
                                                                        child: CustomButton.kCustomElevatedButton(
                                                                            onPressed: (){
                                                                              _.delete(id:_.taskList[index].id);
                                                                              Get.back();
                                                                            },
                                                                            title:LocalString.kOk,
                                                                            padding: 10.sp,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w600),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(width: OtherConstant.kRegularPadding,),
                                            Container(
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                color: Colors.green.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(OtherConstant.kSmallRadius),
                                              ),
                                              child: IconButton(
                                                color: Colors.white,
                                                icon: const Icon(
                                                  FeatherIcons.edit2,
                                                  color:  Colors.green,
                                                ),
                                                onPressed: () {
                                                  buildShowDialog(context, _, index).then((value){

                                                    _.titleController.clear();
                                                    _.descriptionController.clear();
                                                    _.statusController.clear();
                                                    selectedStatus=null;
                                                  });

                                                },
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: OtherConstant.kRegularPadding,top: OtherConstant.kRegularPadding),
                                      child: Text(
                                        _.taskList[index].description!,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          color: ColorPath.tdBlack,
                                          decoration: _.taskList[index].status=='true' ? TextDecoration.lineThrough : null,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: OtherConstant.kLargePadding,),

                                    CustomButton.kCustomElevatedButton(
                                      padding: OtherConstant.kRegularPadding,
                                      title:'View Details',
                                      color: ColorPath.kPrimaryColor,
                                      onPressed: (){
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          14.sp)),
                                                  backgroundColor: Colors.white,
                                                  elevation: 0,
                                                  contentPadding: const EdgeInsets.all(0),
                                                  insetPadding: EdgeInsets.all(10.sp),
                                                  content: Container(
                                                    width: double.maxFinite,
                                                    padding: EdgeInsets.all(
                                                        OtherConstant.kLargePadding),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            14.sp)),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text('${_.taskList[index].title}',style: CustomStyle.kCustomTextStyle(
                                                            fontSize:OtherConstant.kLargeTextSize,
                                                            fontWeight: FontWeight.w500
                                                        ),),
                                                        SizedBox(height: OtherConstant.kLargePadding,),

                                                        Text('${_.taskList[index].description}',style: CustomStyle.kCustomTextStyle(

                                                        ),),

                                                        SizedBox(height: OtherConstant.kLargePadding,),
                                                        CustomButton.kCustomElevatedButton(
                                                            padding:OtherConstant.kRegularPadding,
                                                            title:LocalString.kUpdate,
                                                            onPressed: (){
                                                              Get.back();
                                                              buildShowDialog(context, _, index).then((value){

                                                                _.titleController.clear();
                                                                _.descriptionController.clear();
                                                                _.statusController.clear();
                                                                selectedStatus=null;
                                                              });
                                                            }
                                                        )



                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      }
                                    )



                                  ],
                                ),
                              );

                            },
                          ),

                          SizedBox(height: OtherConstant.kLargePadding,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          );
        }
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.only(
            bottom:OtherConstant.kLargeTextSize,
            right: OtherConstant.kLargeTextSize,
          ),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14.sp)),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        contentPadding: EdgeInsets.all(0),
                        insetPadding: EdgeInsets.all(10.sp),
                        content: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.all(
                              OtherConstant.kLargePadding),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(14.sp)),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Your task',
                                  style: CustomStyle.kCustomTextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: OtherConstant.kLargePadding,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller:_controller.titleController,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(
                                            OtherConstant
                                                .kRegularPadding),
                                        hintText: 'Add title',
                                        border: InputBorder.none),
                                  ),
                                ),
                                SizedBox(
                                  height: OtherConstant.kLargePadding,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    controller: _controller.descriptionController,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(
                                            OtherConstant
                                                .kRegularPadding),
                                        hintText: 'Add description',
                                        border: InputBorder.none),
                                  ),
                                ),
                                SizedBox(
                                  height: OtherConstant.kLargePadding,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 10.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: DropdownButtonFormField(
                                    value: selectedStatus,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(
                                            OtherConstant
                                                .kRegularPadding),
                                        hintText: 'select an option',
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedStatus = value;
                                        _controller.statusController.text=selectedStatus;
                                      });
                                    },
                                    items: statusList
                                        .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.toString())))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: OtherConstant.kLargePadding,
                                ),
                                CustomButton.kCustomElevatedButton(
                                    onPressed: ()async{

                                      //  await  _controller.close();
                                      _controller.addTask().then((value) {
                                        Get.back();
                                      });

                                    },
                                    title: 'Add',
                                    fontWeight: FontWeight.w600)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ).then((value) {
                _controller.titleController.clear();
                _controller.descriptionController.clear();
                _controller.statusController.clear();
                selectedStatus=null;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: Size(60, 60),
              elevation: 10,
            ),
            child: Text(
              '+',
              style: CustomStyle.kCustomTextStyle(
                  fontSize: OtherConstant.kLargeTextSize*2
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context, TaskController _, int index) {
    return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                      builder: (context, setState) {
                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(OtherConstant.kMediumTextSize)),
                                                          backgroundColor: Colors.white,
                                                          elevation: 0,
                                                          contentPadding: const EdgeInsets.all(0),
                                                          insetPadding: EdgeInsets.all(OtherConstant.kRegularRadius),
                                                          content: Container(
                                                            width: double.maxFinite,
                                                            padding: EdgeInsets.all(OtherConstant.kLargePadding),
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                BorderRadius.circular(OtherConstant.kMediumTextSize)),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  LocalString.kUpdate,
                                                                  style: CustomStyle
                                                                      .kCustomTextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                                SizedBox(
                                                                  height: OtherConstant
                                                                      .kLargePadding,
                                                                ),
                                                                CustomWidgets.kCustomTextField(controller:_.titleController, hintText:_.taskList[index].title??'Update Title'),

                                                                // Container(
                                                                //   decoration: BoxDecoration(
                                                                //     color: Colors.white,
                                                                //     boxShadow:  [
                                                                //       BoxShadow(
                                                                //         color: Colors.grey,
                                                                //         offset: const Offset(0.0, 0.0),
                                                                //         blurRadius: OtherConstant.kRegularRadius,
                                                                //         spreadRadius: 0.0,
                                                                //       ),
                                                                //     ],
                                                                //     borderRadius:
                                                                //     BorderRadius.circular(OtherConstant.kRegularRadius),
                                                                //   ),
                                                                //   child: TextField(
                                                                //     controller:_.titleController,
                                                                //     decoration: InputDecoration(
                                                                //         contentPadding: EdgeInsets.all(
                                                                //             OtherConstant
                                                                //                 .kRegularPadding),
                                                                //         hintText:_.taskList[index].title??'Update Title',
                                                                //         border: InputBorder.none),
                                                                //   ),
                                                                // ),
                                                                SizedBox(
                                                                  height: OtherConstant.kLargePadding,
                                                                ),
                                                                CustomWidgets.kCustomTextField(controller:_.descriptionController, hintText:_.taskList[index].description?? 'Update description'),

                                                                // Container(
                                                                //   decoration: BoxDecoration(
                                                                //     color: Colors.white,
                                                                //     boxShadow:  [
                                                                //       BoxShadow(
                                                                //         color: Colors.grey,
                                                                //         offset: Offset(0.0, 0.0),
                                                                //         blurRadius:OtherConstant.kRegularRadius,
                                                                //         spreadRadius: 0.0,
                                                                //       ),
                                                                //     ],
                                                                //     borderRadius:
                                                                //     BorderRadius.circular(10),
                                                                //   ),
                                                                //   child: TextField(
                                                                //     controller: _.descriptionController,
                                                                //     decoration: InputDecoration(
                                                                //         contentPadding: EdgeInsets.all(
                                                                //             OtherConstant
                                                                //                 .kRegularPadding),
                                                                //         hintText:_.taskList[index].description?? 'Update description',
                                                                //         border: InputBorder.none),
                                                                //   ),
                                                                // ),
                                                                SizedBox(
                                                                  height: OtherConstant.kLargePadding,
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    boxShadow: const [
                                                                      BoxShadow(
                                                                        color: Colors.grey,
                                                                        offset: Offset(0.0, 0.0),
                                                                        blurRadius: 10.0,
                                                                        spreadRadius: 0.0,
                                                                      ),
                                                                    ],
                                                                    borderRadius:
                                                                    BorderRadius.circular(10),
                                                                  ),
                                                                  child: DropdownButtonFormField(
                                                                    value: selectedStatus,
                                                                    decoration: InputDecoration(
                                                                        contentPadding: EdgeInsets.all(
                                                                            OtherConstant
                                                                                .kRegularPadding),
                                                                        hintText: 'select an option',
                                                                        border: InputBorder.none),
                                                                    onChanged: (value) {
                                                                      setState(() {
                                                                        selectedStatus = value;
                                                                        _.statusController.text=selectedStatus;
                                                                      });
                                                                    },
                                                                    items: statusList
                                                                        .map((e) => DropdownMenuItem(
                                                                        value: e,
                                                                        child: Text(e.toString())))
                                                                        .toList(),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: OtherConstant.kLargePadding,
                                                                ),
                                                                CustomButton.kCustomElevatedButton(
                                                                    padding:OtherConstant.kRegularPadding,
                                                                    onPressed: (){

                                                                      _.updateTask(taskModel:_.taskList[index]).then((value) {

                                                                        Get.back();
                                                                      });

                                                                    },
                                                                    title: 'Save',
                                                                    fontWeight: FontWeight.w600)


                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorPath.kWhite,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: ColorPath.tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        ),
      ]),
    );
  }
}
