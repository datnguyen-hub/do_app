import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../agency_customer/report/choose_time/widget/pick_date.dart';
import 'choose_time_controller.dart';
import 'widget/choose_compare.dart';

class ChooseTimeScreen extends StatefulWidget {
  final Function? callback;
  final bool? isCompare;
  ChooseTimeScreen({this.callback, this.isCompare});

  @override
  _ChooseTimeScreenState createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  ChooseTimeController? chooseTimeController;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime startDateCP = DateTime.now();
  DateTime endDateCP = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 5, vsync: this, initialIndex: 0);
    chooseTimeController =
        ChooseTimeController(isCompareInput: widget.isCompare);
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Row(
            children: [
              Text('Thời gian'),
              Spacer(),
              TextButton(
                onPressed: () {
                  if (chooseTimeController!.checkSelected) {
                    if (chooseTimeController!.checkSelectedCP) {
                      widget.callback!(
                        chooseTimeController!.fromDay.value,
                        chooseTimeController!.toDay.value,
                        chooseTimeController!.fromDayCP.value,
                        chooseTimeController!.toDayCP.value,
                        chooseTimeController!.isCompare.value,
                      );
                    } else {
                      chooseTimeController!.isCompare.value = false;
                      widget.callback!(
                        chooseTimeController!.fromDay.value,
                        chooseTimeController!.toDay.value,
                        chooseTimeController!.fromDayCP.value,
                        chooseTimeController!.toDayCP.value,
                        chooseTimeController!.isCompare.value,
                      );
                    }
                  }
                  Get.back();
                },
                child: Text(
                  'Lưu',
                  style: TextStyle(
                      fontSize: 16,
                      color:
                          Theme.of(context).primaryTextTheme.titleLarge!.color),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            onTap: (index){
              chooseTimeController!.autoChoose(index);
            },
            tabs: [
              Tab(text: "Ngày"),
              Tab(text: "Tuần"),
              Tab(text: "Tháng"),
              Tab(text: "Năm"),
              Tab(text: "Tuỳ chỉnh"),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: List<Widget>.generate(5, (int indexType) {
            chooseTimeController!.fromDay.value =
            chooseTimeController!
                .listFromDateDAY![0];
            chooseTimeController!.toDay.value =
            chooseTimeController!
                .listToDateDAY![0];
            chooseTimeController!.checkSelected = true;
            return SingleChildScrollView(
              child: indexType == 0
                  ? Obx(
                      () => Column(
                        children: [
                          ...List.generate(
                            2,
                            (index) => PickDate(
                              isChoose: chooseTimeController!.fromDay.value ==
                                          chooseTimeController!
                                              .listFromDateDAY![index] &&
                                      chooseTimeController!.toDay.value ==
                                          chooseTimeController!
                                              .listToDateDAY![index]
                                  ? true
                                  : false,
                              text: chooseTimeController!
                                  .listTextChooseDAY[index],
                              fromDate:
                                  chooseTimeController!.listFromDateDAY![index],
                              toDay:
                                  chooseTimeController!.listToDateDAY![index],
                              onReturn: (fromDate, toDay) {
                                chooseTimeController!
                                    .chooseDate(fromDate, toDay, indexType);
                              },
                            ),
                          ),
                          ChooseCompare(
                            isCompare: chooseTimeController!.isCompare.value,
                            onReturn: (v) {
                              chooseTimeController!.isCompare.value =
                                  !chooseTimeController!.isCompare.value;
                            },
                          ),
                          Obx(
                            () => chooseTimeController!.isCompare.value
                                ? Column(
                                    children: [
                                      ...List.generate(
                                        3,
                                        (index) => PickDate(
                                          isChoose: chooseTimeController!
                                                          .fromDayCP.value ==
                                                      chooseTimeController!
                                                              .listFromDateDAYCP[
                                                          index] &&
                                                  chooseTimeController!
                                                          .toDayCP.value ==
                                                      chooseTimeController!
                                                              .listToDateDAYCP[
                                                          index]
                                              ? true
                                              : false,
                                          text: chooseTimeController!
                                              .listTextChooseDAYCP[index],
                                          fromDate: chooseTimeController!
                                              .listFromDateDAYCP[index],
                                          toDay: chooseTimeController!
                                              .listToDateDAYCP[index],
                                          onReturn: (fromDate, toDay) {
                                            chooseTimeController!
                                                .chooseDateCP(fromDate, toDay);
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    )
                  : indexType == 1
                      ? Obx(
                          () => Column(
                            children: [
                              ...List.generate(
                                3,
                                (index) => PickDate(
                                  isChoose: chooseTimeController!
                                                  .fromDay.value ==
                                              chooseTimeController!
                                                  .listFromDateWEEK![index] &&
                                          chooseTimeController!.toDay.value ==
                                              chooseTimeController!
                                                  .listToDateWEEK![index]
                                      ? true
                                      : false,
                                  text: chooseTimeController!
                                      .listTextChooseWEEK[index],
                                  fromDate: chooseTimeController!
                                      .listFromDateWEEK![index],
                                  toDay: chooseTimeController!
                                      .listToDateWEEK![index],
                                  onReturn: (fromDate, toDay) {
                                    chooseTimeController!
                                        .chooseDate(fromDate, toDay, indexType);
                                  },
                                ),
                              ),
                              ChooseCompare(
                                isCompare:
                                    chooseTimeController!.isCompare.value,
                                onReturn: (v) {
                                  chooseTimeController!.isCompare.value =
                                      !chooseTimeController!.isCompare.value;
                                },
                              ),
                              Obx(
                                () => chooseTimeController!.isCompare.value
                                    ? Column(
                                        children: [
                                          ...List.generate(
                                            2,
                                            (index) => PickDate(
                                              isChoose: chooseTimeController!
                                                              .fromDayCP
                                                              .value ==
                                                          chooseTimeController!
                                                                  .listFromDateWEEKCP[
                                                              index] &&
                                                      chooseTimeController!
                                                              .toDayCP.value ==
                                                          chooseTimeController!
                                                                  .listToDateWEEKCP[
                                                              index]
                                                  ? true
                                                  : false,
                                              text: chooseTimeController!
                                                  .listTextChooseWEEKCP[index],
                                              fromDate: chooseTimeController!
                                                  .listFromDateWEEKCP[index],
                                              toDay: chooseTimeController!
                                                  .listToDateWEEKCP[index],
                                              onReturn: (fromDate, toDay) {
                                                chooseTimeController!
                                                    .chooseDateCP(
                                                        fromDate, toDay);
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        )
                      : indexType == 2
                          ? Obx(
                              () => Column(
                                children: [
                                  ...List.generate(
                                    3,
                                    (index) => PickDate(
                                      isChoose: chooseTimeController!
                                                      .fromDay.value ==
                                                  chooseTimeController!
                                                          .listFromDateMONTH![
                                                      index] &&
                                              chooseTimeController!
                                                      .toDay.value ==
                                                  chooseTimeController!
                                                      .listToDateMONTH![index]
                                          ? true
                                          : false,
                                      text: chooseTimeController!
                                          .listTextChooseMONTH![index],
                                      fromDate: chooseTimeController!
                                          .listFromDateMONTH![index],
                                      toDay: chooseTimeController!
                                          .listToDateMONTH![index],
                                      onReturn: (fromDate, toDay) {
                                        chooseTimeController!.chooseDate(
                                            fromDate, toDay, indexType);
                                      },
                                    ),
                                  ),
                                  ChooseCompare(
                                    isCompare:
                                        chooseTimeController!.isCompare.value,
                                    onReturn: (v) {
                                      chooseTimeController!.isCompare.value =
                                          !chooseTimeController!
                                              .isCompare.value;
                                    },
                                  ),
                                  Obx(
                                    () => chooseTimeController!.isCompare.value
                                        ? Column(
                                            children: [
                                              ...List.generate(
                                                2,
                                                (index) => PickDate(
                                                  isChoose: chooseTimeController!
                                                                  .fromDayCP
                                                                  .value ==
                                                              chooseTimeController!
                                                                      .listFromDateMONTHCP[
                                                                  index] &&
                                                          chooseTimeController!
                                                                  .toDayCP
                                                                  .value ==
                                                              chooseTimeController!
                                                                      .listToDateMONTHCP[
                                                                  index]
                                                      ? true
                                                      : false,
                                                  text: chooseTimeController!
                                                          .listTextChooseMONTHCP[
                                                      index],
                                                  fromDate: chooseTimeController!
                                                          .listFromDateMONTHCP[
                                                      index],
                                                  toDay: chooseTimeController!
                                                      .listToDateMONTHCP[index],
                                                  onReturn: (fromDate, toDay) {
                                                    chooseTimeController!
                                                        .chooseDateCP(
                                                            fromDate, toDay);
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  )
                                ],
                              ),
                            )
                          : indexType == 3
                              ? Obx(
                                  () => Column(
                                    children: [
                                      ...List.generate(
                                        2,
                                        (index) => PickDate(
                                          isChoose: chooseTimeController!
                                                          .fromDay.value ==
                                                      chooseTimeController!
                                                              .listFromDateYEAR![
                                                          index] &&
                                                  chooseTimeController!
                                                          .toDay.value ==
                                                      chooseTimeController!
                                                              .listToDateYEAR![
                                                          index]
                                              ? true
                                              : false,
                                          text: chooseTimeController!
                                              .listTextChooseYEAR![index],
                                          fromDate: chooseTimeController!
                                              .listFromDateYEAR![index],
                                          toDay: chooseTimeController!
                                              .listToDateYEAR![index],
                                          onReturn: (fromDate, toDay) {
                                            chooseTimeController!.chooseDate(
                                                fromDate, toDay, indexType);
                                          },
                                        ),
                                      ),
                                      ChooseCompare(
                                        isCompare: chooseTimeController!
                                            .isCompare.value,
                                        onReturn: (v) {
                                          chooseTimeController!
                                                  .isCompare.value =
                                              !chooseTimeController!
                                                  .isCompare.value;
                                        },
                                      ),
                                      Obx(
                                        () => chooseTimeController!
                                                .isCompare.value
                                            ? Column(
                                                children: [
                                                  ...List.generate(
                                                    1,
                                                    (index) => PickDate(
                                                      isChoose: chooseTimeController!
                                                                      .fromDayCP
                                                                      .value ==
                                                                  chooseTimeController!
                                                                          .listFromDateYEARCP[
                                                                      index] &&
                                                              chooseTimeController!
                                                                      .toDayCP
                                                                      .value ==
                                                                  chooseTimeController!
                                                                          .listToDateYEARCP[
                                                                      index]
                                                          ? true
                                                          : false,
                                                      text: chooseTimeController!
                                                              .listTextChooseYEARCP[
                                                          index],
                                                      fromDate:
                                                          chooseTimeController!
                                                                  .listFromDateYEARCP[
                                                              index],
                                                      toDay: chooseTimeController!
                                                              .listToDateYEARCP[
                                                          index],
                                                      onReturn:
                                                          (fromDate, toDay) {
                                                        chooseTimeController!
                                                            .chooseDateCP(
                                                                fromDate,
                                                                toDay);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  ),
                                )
                              : indexType == 4
                                  ? Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                      width: Get.width * 0.9,
                                                      height: Get.height * 0.5,
                                                      child: SfDateRangePicker(
                                                        onCancel: () {
                                                          Get.back();
                                                        },
                                                        onSubmit: (v) {
                                                          chooseTimeController!
                                                              .onOkChooseTime(
                                                                  startDate,
                                                                  endDate);
                                                        },
                                                        showActionButtons: true,
                                                        onSelectionChanged:
                                                            chooseRangeTime,
                                                        selectionMode:
                                                            DateRangePickerSelectionMode
                                                                .range,
                                                        initialSelectedRange:
                                                            PickerDateRange(
                                                          chooseTimeController!
                                                              .fromDateOption
                                                              .value,
                                                          chooseTimeController!
                                                              .toDateOption
                                                              .value,
                                                        ),
                                                        maxDate: DateTime.now(),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: [
                                                Obx(
                                                  () => Text(
                                                      "Ngày bắt đầu và kết thúc: ${SahaDateUtils().getDDMM(chooseTimeController!.fromDateOption.value)} đến ${SahaDateUtils().getDDMM(chooseTimeController!.toDateOption.value)}"),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.check,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => ChooseCompare(
                                            isCompare: chooseTimeController!
                                                .isCompare.value,
                                            onReturn: (v) {
                                              chooseTimeController!
                                                      .isCompare.value =
                                                  !chooseTimeController!
                                                      .isCompare.value;
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                      width: Get.width * 0.9,
                                                      height: Get.height * 0.5,
                                                      child: SfDateRangePicker(
                                                        onCancel: () {
                                                          Get.back();
                                                        },
                                                        onSubmit: (v) {
                                                          chooseTimeController!
                                                              .onOkChooseTimeCP(
                                                                  startDateCP,
                                                                  endDateCP);
                                                        },
                                                        showActionButtons: true,
                                                        onSelectionChanged:
                                                            chooseRangeTimeCP,
                                                        selectionMode:
                                                            DateRangePickerSelectionMode
                                                                .range,
                                                        initialSelectedRange:
                                                            PickerDateRange(
                                                          chooseTimeController!
                                                              .fromDateOptionCP
                                                              .value,
                                                          chooseTimeController!
                                                              .toDateOptionCP
                                                              .value,
                                                        ),
                                                        maxDate: DateTime.now(),
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Obx(
                                            () => chooseTimeController!
                                                    .isCompare.value
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Row(
                                                      children: [
                                                        Obx(
                                                          () => Text(
                                                              "Thời gian: ${SahaDateUtils().getDDMM(chooseTimeController!.fromDateOptionCP.value)} đến ${SahaDateUtils().getDDMM(chooseTimeController!.toDateOptionCP.value)}"),
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          Icons.check,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                      ],
                                    )
                                  : Container(),
            );
          }),
        ),
      ),
    );
  }

  void chooseRangeTime(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDate = args.value.startDate;
      endDate = args.value.endDate ?? args.value.startDate;
    }
  }

  void chooseRangeTimeCP(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      startDateCP = args.value.startDate;
      endDateCP = args.value.endDate ?? args.value.startDate;
    }
  }
}
