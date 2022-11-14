import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fmbp/data/global/export_global.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:fmbp/presentation/screens/inspection/checklist_todo/index.dart';

import '../../../models/export_model.dart';
import 'index.dart';
import 'record_trip.dart';

final todo = <ToDoList>[];

class BodyToDo extends StatefulWidget {
  final TodoController _todoController;
  const BodyToDo(this._todoController, {Key? key}) : super(key: key);

  @override
  State<BodyToDo> createState() => _BodyToDoState();
}

class _BodyToDoState extends State<BodyToDo> {
  late Future<dynamic> futureToDo;
  final TripController _tripController = TripController();
  final TodoController _todoController = TodoController();
  @override
  void initState() {
    super.initState();
    futureToDo = widget._todoController.getTodoTrip();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureToDo,
      builder: (context, snapshot) {
        if (globalUser.getStaffID == 0) {
          return EmptyWidget(text: "you_not_driver".tr().toUpperCase());
        } else {
          if (snapshot.hasData) {
            return todo.isEmpty
                ? const EmptyWidget(text: "no_data")
                : ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: todo.length,
                    itemBuilder: (context, index) {
                      // Lấy danh sách ngược lại theo todo mới nhâts
                      // int index = todo.length - 1 - index;
                      //============================================
                      return todo.isEmpty
                          ? const EmptyWidget(text: "no_data")
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                              child: CardCustom(
                                  widget: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.015),
                                child: Column(
                                  children: [
                                    buildBookNo(
                                      index,
                                      context,
                                      _tripController,
                                      _todoController,
                                    ),
                                    const HeightSpacer(height: 0.007),
                                    buildCustumerName(index),
                                    const HeightSpacer(height: 0.007),
                                    buildPhone(index),
                                    const HeightSpacer(height: 0.007),
                                    buildFrom(context, index),
                                    const HeightSpacer(height: 0.007),
                                    buildTo(context, index),
                                    const HeightSpacer(height: 0.007),
                                    todo[index].bookAccept == null
                                        ? DefaultButton(
                                            color: textRed,
                                            text: "Accept".tr(),
                                            press: () async {
                                              globalAccept.setBrid =
                                                  todo[index].brId;
                                              String bookNo =
                                                  todo[index].bookNo.toString();
                                              var fleetId = int.parse(
                                                  todo[index]
                                                      .fleetId
                                                      .toString());
                                              var response = await widget
                                                  ._todoController
                                                  .acceptTrip(bookNo, fleetId);
                                              if (response.statusCode == 200) {
                                                setState(() {
                                                  widget._todoController
                                                      .getTodoTrip();
                                                });
                                                showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            SuccessFull(
                                                                text:
                                                                    "accept_success"
                                                                        .tr()))
                                                    .whenComplete(() =>
                                                        Navigator.pushNamed(
                                                            context,
                                                            ToDoListScreen
                                                                .routeName));
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        DialogError(
                                                            widget: Text(
                                                                "accept_fail"
                                                                    .tr())));
                                              }
                                            },
                                          )
                                        : todo[index].isPickUp == 1
                                            ? pickupedButton()
                                            : DefaultButton(
                                                color: defaultColor,
                                                text: "pickup".toUpperCase(),
                                                press: () async {
                                                  globalPickUp.setBrid =
                                                      todo[index].brId;
                                                  await widget._todoController
                                                      .updatePickUp()
                                                      .whenComplete(() {
                                                    widget._todoController
                                                        .getTodoTrip();
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          const SuccessFull(
                                                              text:
                                                                  "Successfull"),
                                                    ).whenComplete(() =>
                                                        Navigator.pushNamed(
                                                            context,
                                                            ToDoListScreen
                                                                .routeName));
                                                  });
                                                },
                                              ),
                                  ],
                                ),
                              )),
                            );
                    },
                  );
          }
        }
        return const LoadingNoBox(color: defaultColor);
      },
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: bgDrawerColor,
    primary: textDarkBlue,
    // minimumSize: const Size(88, 36),
    // padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
  final ButtonStyle pickupedStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.grey,
    primary: Colors.grey,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
  DateFormat dateFormat() => DateFormat('dd/MM/yyyy');

  Widget buildBookNo(
    int index,
    BuildContext context,
    TripController tripController,
    TodoController todoController,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            todo[index].bookNo.toString(),
            style: const TextStyle(
              color: textRed,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: todo[index].isPickUp != 1
              ? Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.005,
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            globalInspection.setBookNo =
                                todo[index].bookNo.toString();
                            Navigator.pushNamed(
                                context, CheckListWithTodoScreen.routeName);
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 0,
                                child: IconCustom(
                                  iConURL: "assets/icon/check_list.png",
                                  size: 20,
                                ),
                              ),
                              // WidthSpacer(width: 0.02),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  "check_list".tr(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.005,
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            globalInspection.setBookNo =
                                todo[index].bookNo.toString();
                            Navigator.pushNamed(
                                context, CheckListWithTodoScreen.routeName);
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 0,
                                child: IconCustom(
                                  iConURL: "assets/icon/check_list.png",
                                  size: 20,
                                ),
                              ),
                              // WidthSpacer(width: 0.02),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  "check_list".tr(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.005,
                        ),
                        child: ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SaveTrip(
                                    toDoList: todo[index],
                                    tripController,
                                    todoController,
                                  ),
                                ));
                          },
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 0,
                                child: IconCustom(
                                  iConURL: "assets/icon/check_list.png",
                                  size: 20,
                                ),
                              ),
                              // WidthSpacer(width: 0.02),
                              Expanded(
                                flex: 8,
                                child: Text(
                                  "trip_record".tr(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        // Expanded(
        //   flex: 6,
        //   child: todo[index].isPickUp != 1
        //       ? Row(
        //           children: [
        //             Expanded(
        //               flex: 4,
        //               child: Container(
        //                 color: Colors.red,
        //               ),
        //             ),
        //             Expanded(
        //               flex: 4,
        //               child: Container(
        //                 color: Colors.red,
        //               ),
        //             ),
        //             // ElevatedButton(
        //             //   style: raisedButtonStyle,
        //             //   onPressed: () {
        //             //     globalInspection.setBookNo =
        //             //         todo[index].bookNo.toString();
        //             //     Navigator.pushNamed(
        //             //         context, CheckListWithTodoScreen.routeName);
        //             //   },
        //             //   child: Row(
        //             //     children: [
        //             //       // const Expanded(
        //             //       //   flex: 2,
        //             //       //   child: IconCustom(
        //             //       //     iConURL: "assets/icon/check_list.png",
        //             //       //     size: 20,
        //             //       //   ),
        //             //       // ),
        //             //       // // const PaddingRowText(),
        //             //       // Expanded(
        //             //       //   flex: 8,
        //             //       //   child: Text(
        //             //       //     "check_list".tr(),
        //             //       //     style: const TextStyle(color: Colors.white),
        //             //       //   ),
        //             //       // ),
        //             //     ],
        //             //   ),
        //             // ),
        //           ],
        //         )
        //       : Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             ElevatedButton(
        //               style: raisedButtonStyle,
        //               onPressed: () {
        //                 globalInspection.setBookNo =
        //                     todo[index].bookNo.toString();
        //                 Navigator.pushNamed(
        //                     context, CheckListWithTodoScreen.routeName);
        //               },
        //               child: Row(
        //                 children: [
        //                   const IconCustom(
        //                     iConURL: "assets/icon/check_list.png",
        //                     size: 20,
        //                   ),
        //                   const PaddingRowText(),
        //                   Text(
        //                     "check_list".tr(),
        //                     style: const TextStyle(color: Colors.white),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             ElevatedButton(
        //               style: raisedButtonStyle,
        //               onPressed: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (context) => SaveTrip(
        //                         toDoList: todo[index],
        //                         tripController,
        //                         todoController,
        //                       ),
        //                     ));
        //               },
        //               child: Row(
        //                 children: [
        //                   const IconCustom(
        //                     iConURL: "assets/icon/location_to.png",
        //                     size: 20,
        //                   ),
        //                   const PaddingRowText(),
        //                   Text(
        //                     "trip_record".tr(),
        //                     style: const TextStyle(color: Colors.white),
        //                   ),
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        // ),
      ],
    );
  }

  Widget buildCustumerName(int index) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: IconCustom(iConURL: "assets/icon/avt.png", size: 30),
        ),
        Expanded(
          flex: 9,
          child: Text(
            todo[index].customerName.toString(),
            style: styleDefaultText,
          ),
        ),
      ],
    );
  }

  Widget buildPhone(int index) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: IconCustom(iConURL: "assets/icon/phone.png", size: 30),
        ),
        Expanded(
          flex: 9,
          child: Text(
            todo[index].mobileNo.toString(),
            style: styleDefaultText,
          ),
        ),
      ],
    );
  }

  Widget buildFrom(BuildContext context, int index) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              const Expanded(
                flex: 3,
                child: IconCustom(
                    iConURL: "assets/icon/navbar_calendar.png", size: 30),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  dateFormat().format(DateTime.fromMicrosecondsSinceEpoch(
                          todo[index].pickupTime! * 1000)
                      .add(const Duration(hours: -7))),
                  style: styleDefaultText,
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: IconCustom(
                    iConURL: "assets/icon/location_from.png", size: 30),
              ),
              Expanded(
                flex: 8,
                child: todo[index].pickUpPlaceDetail == ""
                    ? Text(
                        todo[index].pickUpPlace.toString(),
                        style: styleDefaultText,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo[index].pickUpPlace.toString(),
                            style: styleDefaultText,
                          ),
                          Text(
                            todo[index].pickUpPlaceDetail.toString(),
                            // style: styleDefaultText,
                          )
                        ],
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTo(BuildContext context, int index) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              const Expanded(
                flex: 3,
                child: IconCustom(
                    iConURL: "assets/icon/navbar_calendar.png", size: 30),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  dateFormat().format(DateTime.fromMicrosecondsSinceEpoch(
                          todo[index].returnTime! * 1000)
                      .add(const Duration(hours: -7))),
                  style: styleDefaultText,
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: IconCustom(
                    iConURL: "assets/icon/location_to.png", size: 30),
              ),
              Expanded(
                flex: 8,
                child: todo[index].returnPlaceDetail == ""
                    ? Text(
                        todo[index].returnPlace.toString(),
                        style: styleDefaultText,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo[index].returnPlace.toString(),
                            style: styleDefaultText,
                          ),
                          Text(
                            todo[index].returnPlaceDetail.toString(),
                            // style: styleDefaultText,
                          )
                        ],
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget pickupedButton() {
    return ElevatedButton(
      style: pickupedStyle,
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const IconCustom(iConURL: "assets/icon/done.png", size: 30),
            const HeightSpacer(height: 0.01),
            Text(
              "pickUped".tr().toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                color: textDarkBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaddingRowText extends StatelessWidget {
  const PaddingRowText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width * 0.02);
  }
}
