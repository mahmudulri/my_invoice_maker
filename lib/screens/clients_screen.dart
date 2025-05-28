import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/controllers/add_client_controller.dart';
import 'package:invoice_maker/controllers/clinetlist_controller.dart';
import 'package:invoice_maker/utils/colors.dart';
import 'package:invoice_maker/widgets/custom_text.dart';

import '../invoicecontrollers/billto_controller.dart';
import '../widgets/default_button.dart';

class ClientsScreen extends StatefulWidget {
  ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final clientListController = Get.find<ClinetlistController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clientListController.finallist.clear();
    clientListController.initialpage = 1;
    clientListController.fetchclients();
  }

  final BilltoController billtoController = Get.put(BilltoController());

  final ScrollController scrollController = ScrollController();

  // Future<void> refresh() async {
  //   final int totalPages =
  //       clientListController.allClientList.value.pagination!.totalPages ?? 0;

  //   final int currentPage = clientListController.initialpage;

  //   // Prevent loading more pages if we've reached the last page
  //   if (currentPage >= totalPages) {
  //     print(
  //         "End..........................................End.....................");
  //     return;
  //   }

  //   // Check if the scroll position is at the bottom
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     clientListController.initialpage++;

  //     // Prevent fetching if the next page exceeds total pages
  //     if (clientListController.initialpage <= totalPages) {
  //       print("Load More...................");
  //       clientListController.fetchclients();
  //     } else {
  //       clientListController.initialpage =
  //           totalPages; // Reset to the last valid page
  //       print("Already on the last page");
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF1F3FF),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Color(0xffF1F3FF),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            KText(
              text: "Client List",
              fontSize: 22,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(0.0),
                      content: ClientaddBox(),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              width: screenWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search by name or phone",
                          hintStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      size: 35,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Obx(
                  () => clientListController.isLoading.value == false
                      ? ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: clientListController.finallist.length,
                          itemBuilder: (context, index) {
                            final client =
                                clientListController.finallist[index];
                            return GestureDetector(
                              onTap: () {
                                // billtoController.nameController.text =
                                //     client.name.toString();
                                // billtoController.phoneNumberController.text =
                                //     client.phoneNumber.toString();
                                // billtoController.address1Controller.text =
                                //     client.address.toString();
                                // Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ), // smoother curve
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.1), // soft shadow
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: Offset(
                                          0, 2), // subtle vertical shadow
                                    ),
                                  ],
                                ),
                                width: screenWidth,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              KText(
                                                text: "Name : ",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              KText(
                                                text: client.name.toString(),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              KText(
                                                text: "Phone Number : ",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              KText(
                                                text: client.phoneNumber
                                                    .toString(),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              KText(
                                                text: "Address : ",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              KText(
                                                text: client.address.toString(),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.edit),
                                            Divider(),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      content: Container(
                                                        height: 220,
                                                        width: screenWidth,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            KText(
                                                              text:
                                                                  "Do you want to Delete ?",
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        DefaultButton(
                                                                      buttonName:
                                                                          "No",
                                                                      mycolor:
                                                                          Colors
                                                                              .grey,
                                                                      onpressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        DefaultButton(
                                                                      buttonName:
                                                                          "Yes",
                                                                      mycolor:
                                                                          AppColors
                                                                              .primaryColor,
                                                                      onpressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red.shade300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                if (clientListController
                        .allClientList.value.pagination!.currentPage ==
                    clientListController
                        .allClientList.value.pagination!.totalPages) {
                  Fluttertoast.showToast(
                      msg: "No more more data",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  clientListController.initialpage++;
                  clientListController.fetchclients();
                }
              },
              child: Container(
                height: 50,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Obx(
                    () => Text(
                      clientListController.isLoading.value == false
                          ? "Load More"
                          : "Loading",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class ClientaddBox extends StatelessWidget {
  ClientaddBox({super.key});

  final AddClientController addClientController = AddClientController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "Add New Client",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: addClientController.nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Client Name",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: addClientController.phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Client Phone Number",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: addClientController.addressController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Client Address",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  child: Text("Close"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (addClientController.nameController.text.isNotEmpty &&
                        addClientController.phoneController.text.isNotEmpty &&
                        addClientController.addressController.text.isNotEmpty) {
                      addClientController.addclient();
                      print("Filled All");
                    } else {
                      print("add data");
                    }
                  },
                  child: Obx(
                    () => Text(addClientController.isLoading.value == false
                        ? "Add Now"
                        : "Please wait"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
