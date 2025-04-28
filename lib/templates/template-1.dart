import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/controllers/item_list_controller.dart';
import 'package:invoice_maker/utils/colors.dart';

class Template1Design extends StatelessWidget {
  String? businessName;
  String? businessAddress1;
  String? businessAddress2;
  String? businessPhone;
  String? businessWebsite;
  String? clientName;
  String? clientAddress1;
  String? clientAddress2;
  String? clientPhone;
  String? clientWebsite;
  String? date;
  String? invoiceNo;
  String? status;
  Template1Design({
    super.key,
    this.businessName,
    this.businessAddress1,
    this.businessAddress2,
    this.businessPhone,
    this.businessWebsite,
    this.clientName,
    this.clientAddress1,
    this.clientAddress2,
    this.clientPhone,
    this.clientWebsite,
    this.date,
    this.invoiceNo,
    this.status,
  });

  final ItemListController itemListController = Get.put(
    ItemListController(),
    permanent: true,
  );

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 5,
              color: Colors.red.shade700,
            ),
            bottom: BorderSide(
              width: 5,
              color: Colors.red.shade700,
            ),
          ),
        ),
        width: screenWidth,
        // color: Colors.cyan,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        businessName == null
                            ? "Business Name"
                            : businessName.toString(),
                        style: TextStyle(
                          color: AppColors.defaultTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            businessAddress1 == null
                                ? "Business Address"
                                : businessAddress1.toString(),
                            style: TextStyle(
                              color: AppColors.defaultTextColor,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            businessAddress2 == null
                                ? ""
                                : businessAddress2.toString(),
                            style: TextStyle(
                              color: AppColors.defaultTextColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        businessPhone == null
                            ? "Business Phone"
                            : businessPhone.toString(),
                        style: TextStyle(
                          color: AppColors.defaultTextColor,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        businessWebsite == null
                            ? "Website"
                            : businessWebsite.toString(),
                        style: TextStyle(
                          color: AppColors.defaultTextColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.red.shade100,
                    child: Text(
                      "Logo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade300,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "BILL TO-",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clientName == null
                                ? "Client Name"
                                : clientName.toString(),
                            style: TextStyle(
                              color: AppColors.defaultTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                clientAddress1 == null
                                    ? "Client Address"
                                    : clientAddress1.toString(),
                                style: TextStyle(
                                  color: AppColors.defaultTextColor,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                clientAddress2 == null
                                    ? ""
                                    : clientAddress2.toString(),
                                style: TextStyle(
                                  color: AppColors.defaultTextColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            clientPhone == null
                                ? "Client Phone"
                                : clientPhone.toString(),
                            style: TextStyle(
                              color: AppColors.defaultTextColor,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            clientWebsite == null
                                ? "Client Website"
                                : clientWebsite.toString(),
                            style: TextStyle(
                              color: AppColors.defaultTextColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      // color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "DATE : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                date == null
                                    ? "__ / __ / ____"
                                    : clientAddress1.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "INVOCE NO : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                invoiceNo == null
                                    ? "xx-xx-x"
                                    : clientAddress1.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "STATUS : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    status == null
                                        ? "Status"
                                        : status.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.red.shade300,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Text(
                                "Name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 2,
                            color: Colors.white,
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                "Qty",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 2,
                            color: Colors.white,
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "Unit P.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            thickness: 2,
                            color: Colors.white,
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "Total",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Obx(
                          () => itemListController.itemlist.isNotEmpty
                              ? ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 3);
                                  },
                                  itemCount: itemListController.itemlist.length,
                                  itemBuilder: (context, index) {
                                    double getTotalPrice() {
                                      double totalPrice = 0.0;

                                      for (var item
                                          in itemListController.itemlist) {
                                        double itemTotal = double.tryParse(
                                                item["total"].toString()) ??
                                            0.0;
                                        totalPrice += itemTotal;
                                      }

                                      return totalPrice;
                                    }

                                    final data =
                                        itemListController.itemlist[index];
                                    return Container(
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color: index % 2 == 1
                                            ? Colors.grey.shade50
                                            : Colors.red.shade50,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                data["name"],
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                data["quantity"],
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                data["unitprice"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                data["total"],
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    "No Items",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.grey,
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
            ],
          ),
        ),
      ),
    );
  }
}
