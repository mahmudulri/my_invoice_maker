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
import 'screens/new_invoice.dart';
import 'screens/home_screen.dart';
import 'screens/pdf_template_screen.dart';
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
            "Smart Invoice Generator",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MenuButton(
                buttonName: "Create Invoice",
                imagelink: "assets/icons/new-invoice.png",
                onpressed: () {
                  Get.to(() => MakeNewScreen());
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MenuButton(
                buttonName: "View all Invoice",
                imagelink: "assets/icons/invoice.png",
                onpressed: () {
                  Get.to(() => AllInvoicesList());
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MenuButton(
                buttonName: "My clients",
                imagelink: "assets/icons/clients.png",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MenuButton(
                buttonName: "Due list",
                imagelink: "assets/icons/down-payment.png",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MenuButton(
                buttonName: "PDF 1",
                imagelink: "assets/icons/down-payment.png",
                // onpressed: () async {
                //   final data = await pdfTemplate1.generatePDF();
                //   pdfTemplate1.savePdfFile("Inovice maker", data);
                // },
                onpressed: () async {
                  final data = await pdfTemplate1.generatePDF();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfPreviewScreen(pdfBytes: data),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MenuButton(
                buttonName: "PDF 2",
                imagelink: "assets/icons/down-payment.png",
                // onpressed: () async {
                //   final data = await pdfTemplate2.generatePDF();
                //   pdfTemplate2.savePdfFile("Inovice maker", data);
                // },
                onpressed: () async {
                  final data = await pdfTemplate2.generatePDF();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfPreviewScreen(pdfBytes: data),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: MenuButton(
                buttonName: "PDF Template",
                imagelink: "assets/icons/down-payment.png",
                onpressed: () {
                  Get.to(() => PdfTemplateScreen());
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
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
        height: 50,
        width: screenWidth,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  imagelink.toString(),
                  height: 50,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                buttonName.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
