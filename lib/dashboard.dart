import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice_maker/controllers/category_controller.dart';
import 'package:invoice_maker/draftbd/pageone.dart';
import 'package:invoice_maker/pdftemplates/pdftemplate1.dart';
import 'package:invoice_maker/pdftemplates/pdftemplate2.dart';
import 'package:invoice_maker/routes/routes.dart';
import 'package:invoice_maker/screens/myshop_screen.dart';
import 'package:invoice_maker/utils/colors.dart';
import 'package:invoice_maker/widgets/drawer.dart';

import 'controllers/myshoplist_controller.dart';
import 'invoicecontrollers/address_controller.dart';
import 'invoicecontrollers/template_theme_controller.dart';
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
    categorycontroller.fetchcategorylist();
  }

  final categorycontroller = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    // Move screenHeight and screenWidth outside of build to avoid rebuilds
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      drawer: MyDrawer(),
      key: _scaffoldKey,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Container(
                height: 350,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(120),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.sort,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Mega Invoice Maker",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 90,
                        width: screenWidth,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.scaffoldColor.withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(
                                      8), // optional for rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.1), // soft shadow
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
                                        color: Colors.white,
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
                                        color: Colors.white,
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
                                  color:
                                      AppColors.scaffoldColor.withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(
                                      8), // optional for rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.1), // soft shadow
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
                                        color: Colors.white,
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
                                        color: Colors.white,
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
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 250,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: screenHeight * 0.550,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              SizedBox(
                                width: 10,
                              ),
                              MenuButton(
                                buttonName: "View all Invoice",
                                imagelink: "assets/icons/invoice.png",
                                onpressed: () {
                                  Get.to(() => AllInvoicesList());
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MenuButton(
                                buttonName: "Clients",
                                imagelink: "assets/icons/down-payment.png",
                                // onpressed: () async {
                                //   final data = await pdfTemplate1.generatePDF();
                                //   pdfTemplate1.savePdfFile("Inovice maker", data);
                                // },
                                onpressed: () {
                                  Get.toNamed(clientscreen);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              SizedBox(
                                width: 10,
                              ),
                              MenuButton(
                                buttonName: "Templates",
                                imagelink: "assets/icons/down-payment.png",
                                onpressed: () {
                                  Get.to(() => PdfTemplateScreen());
                                },
                              ),
                              SizedBox(
                                width: 10,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MenuButton(
                                buttonName: "Products",
                                imagelink: "assets/icons/down-payment.png",
                                onpressed: () {
                                  Get.toNamed(productscreen);
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MenuButton(
                                buttonName: "Settings",
                                imagelink: "assets/icons/down-payment.png",
                                onpressed: () {},
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MenuButton(
                                buttonName: "My Shop",
                                imagelink: "assets/icons/down-payment.png",
                                onpressed: () {
                                  Get.toNamed(myshopscreen);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Image.asset(
                  imagelink.toString(),
                  height: 35,
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Text(
                buttonName.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
