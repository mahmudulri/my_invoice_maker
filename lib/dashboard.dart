import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/draftbd/pageone.dart';
import 'package:invoice_maker/pdftemplates/pdftemplate1.dart';
import 'package:invoice_maker/pdftemplates/pdftemplate2.dart';
import 'package:invoice_maker/utils/colors.dart';
import 'package:invoice_maker/widgets/drawer.dart';

import 'controllers/address_controller.dart';
import 'controllers/template_theme_controller.dart';
import 'screens/create_invoice_screen.dart';
import 'screens/new_invoice.dart';
import 'screens/home_screen.dart';
import 'screens/pdf_template_screen.dart';
import 'screens/pdfpageview.dart';
import 'screens/pdtview_screen.dart';
import 'screens/sample_screen.dart';
import 'screens/view_all_invoice.dart';

class DashBoard extends StatefulWidget {
  DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final BusinessAddressController businessAddressController =
      Get.put(BusinessAddressController());
  final box = GetStorage();

  final PdfTemplate1 pdfTemplate1 = PdfTemplate1();
  final PdfTemplate2 pdfTemplate2 = PdfTemplate2();

  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    // checkData();
    super.initState();
  }

  // checkData() async {
  //   await GetStorage.init(); // Ensure GetStorage is initialized
  //   if (box.read("businessNameController") == null) {
  //     print("No data");
  //   } else {
  //     print("Has data");
  //     businessAddressController.businessNameController.text =
  //         box.read("businessNameController");
  //     businessAddressController.address1Controller.text =
  //         box.read("address1Controller");
  //     businessAddressController.address2Controller.text =
  //         box.read("address2Controller");
  //     businessAddressController.phoneNumberController.text =
  //         box.read("phoneNumberController");
  //     businessAddressController.websiteController.text =
  //         box.read("websiteController");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Move screenHeight and screenWidth outside of build to avoid rebuilds
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffecf0f1),
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(
            Icons.sort,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xffecf0f1),
        title: GestureDetector(
          onTap: () {
            print(box.read("businessNameController").toString());
            // checkData();
          },
          child: Text(
            "Mega Invoice Generator",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 120,
                width: screenWidth,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              8), // optional for rounded corners
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // soft shadow
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 5), // vertical shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Unpaid",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "0.00 tk",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              8), // optional for rounded corners
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // soft shadow
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 5), // vertical shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Overdue",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "0.00 tk",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuButton(
                    buttonName: "Create Invoice",
                    imagelink: "assets/icons/new-invoice.png",
                    // onpressed: () {
                    //   Get.to(() => CreateInvoiceScreen());
                    // },
                    onpressed: () {
                      Get.to(() => CreateInvoiceScreen());
                    },
                  ),
                  MenuButton(
                    buttonName: "View all Invoice",
                    imagelink: "assets/icons/invoice.png",
                    onpressed: () {
                      Get.to(() => AllInvoicesList());
                    },
                  ),
                  MenuButton(
                    buttonName: "Clients",
                    imagelink: "assets/icons/down-payment.png",
                    // onpressed: () async {
                    //   final data = await pdfTemplate1.generatePDF();
                    //   pdfTemplate1.savePdfFile("Inovice maker", data);
                    // },
                    onpressed: () async {},
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuButton(
                    buttonName: "PDF",
                    imagelink: "assets/icons/down-payment.png",
                    onpressed: () async {
                      final data = await pdfTemplate1.generatePDF();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PdfPreviewScreen(pdfBytes: data),
                        ),
                      );
                    },
                  ),
                  MenuButton(
                    buttonName: "PDF Template",
                    imagelink: "assets/icons/down-payment.png",
                    onpressed: () {
                      Get.to(() => PdfTemplateScreen());
                    },
                  ),
                  MenuButton(
                    buttonName: "Template pageview",
                    imagelink: "assets/icons/down-payment.png",
                    onpressed: () {
                      Get.to(() => Pdfpageview());
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MenuButton(
                    buttonName: "Items",
                    imagelink: "assets/icons/down-payment.png",
                    onpressed: () async {},
                  ),
                  MenuButton(
                    buttonName: "Settings",
                    imagelink: "assets/icons/down-payment.png",
                    onpressed: () {},
                  ),
                  MenuButton(
                    buttonName: "Stafs",
                    imagelink: "assets/icons/down-payment.png",
                    onpressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  MenuButton({
    super.key,
    this.buttonName,
    this.imagelink,
    this.onpressed,
  });

  final String? buttonName;
  final String? imagelink;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: 110,
        width: 100,
        decoration: BoxDecoration(
          color: AppColors.defaultTextColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  imagelink.toString(),
                  height: 40,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                buttonName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
