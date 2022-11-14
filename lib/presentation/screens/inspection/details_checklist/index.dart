import 'package:flutter/material.dart';
import 'package:fmbp/presentation/export_presentation.dart';
import 'package:grouped_list/grouped_list.dart';

final listCheckListDetails = [];

class CheckListDetailScreen extends StatefulWidget {
  const CheckListDetailScreen({Key? key, required this.clId}) : super(key: key);
  final int clId;

  @override
  State<CheckListDetailScreen> createState() => _CheckListDetailScreenState();
}

class _CheckListDetailScreenState extends State<CheckListDetailScreen> {
  final InspectionController _inspectionController = InspectionController();
  late Future<dynamic> futureList;
  @override
  void initState() {
    futureList = _inspectionController.getCheckListDetail(widget.clId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clId.toString()),
      ),
      body: FutureBuilder(
        future: futureList,
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                flex: 0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text("Fleet Desc"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Seq No"),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text("Inspection Item"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Inspection Value"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Result"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Comment"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Edit"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GroupedListView<dynamic, String>(
                  elements: listCheckListDetails,
                  groupBy: (element) => element['groupDesc'],
                  itemComparator: (element1, element2) =>
                      element1['groupDesc'].compareTo(element2['groupDesc']),
                  groupSeparatorBuilder: (String value) => Text(
                    value,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  order: GroupedListOrder.DESC,
                  itemBuilder: (context, element) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(element["equipmentCode"].toString()),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(element["seqNo"].toString()),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(element["inspectionItem"].toString()),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(element["inspectionValue"].toString()),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(element["comment"].toString()),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(element["comment"].toString()),
                        ),
                        const Expanded(
                          flex: 1,
                          child: IconCustom(
                              iConURL: "assets/icon/edit.png", size: 25),
                        ),
                      ],
                    );
                    // return Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(element["equipmentCode"].toString()),
                    //     Text(element["seqNo"].toString()),
                    //     Text(element["inspectionItem"].toString()),
                    //     Text(element["inspectionValue"].toString()),
                    //     Text(element["result"].toString()),
                    //     Text(element["comment"].toString()),
                    //   ],
                    // );
                  },
                ),
              )
            ],
          );
          // if (snapshot.hasData) {
          //   return GroupedListView<dynamic, String>(
          //     elements: listCheckListDetails,
          //     groupBy: (element) => element['groupDesc'],
          //     itemComparator: (element1, element2) =>
          //         element1['groupDesc'].compareTo(element2['groupDesc']),
          //     groupSeparatorBuilder: (String value) => Text(
          //       value,
          //       textAlign: TextAlign.left,
          //       style:
          //           const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //     ),
          //     order: GroupedListOrder.DESC,
          //     itemBuilder: (context, element) {
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(element["inspectionItem"]),
          //         ],
          //       );
          //     },
          //   );
          // }
          // return GroupedListView<dynamic, String>(
          //   elements: listCheckListDetails,
          //   groupBy: (element) => element['groupDesc'],
          //   itemComparator: (element1, element2) =>
          //       element1['groupDesc'].compareTo(element2['groupDesc']),
          //   groupSeparatorBuilder: (String value) => Text(
          //     value,
          //     textAlign: TextAlign.left,
          //     style: styleDefaultText,
          //   ),
          //   order: GroupedListOrder.DESC,
          //   itemBuilder: (context, element) {
          //     // return Table(
          //     //   border: TableBorder.all(),
          //     //   children: [
          //     //     TableRow(
          //     //       children: [
          //     //         Text(element["equipmentCode"].toString()),
          //     //         Text(element["seqNo"].toString()),
          //     //         Text(element["inspectionItem"].toString()),
          //     //         Text(element["inspectionValue"].toString()),
          //     //         Text(element["result"].toString()),
          //     //         Text(element["comment"].toString()),
          //     //       ],
          //     //     ),
          //     //   ],
          //     // );
          //     return Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         // Text("Fleet Desc"),
          //         // Text(element["inspectionItem"]),
          //         // Text(element["seqNo"].toString()),
          //       ],
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
