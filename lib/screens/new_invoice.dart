// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:invoice_maker/invoicecontrollers/address_controller.dart';
// import 'package:invoice_maker/invoicecontrollers/billto_controller.dart';
// import 'package:invoice_maker/new_address.dart';
// import 'package:invoice_maker/screens/new_client.dart';


// import '../invoicecontrollers/invoice_data_controller.dart';
// import '../invoicecontrollers/item_list_controller.dart';
// import 'new_items.dart';
// import '../widgets/drawer_button.dart';

// import 'update_item_screen.dart';

// class MakeNewScreen extends StatefulWidget {
//   MakeNewScreen({super.key});

//   @override
//   State<MakeNewScreen> createState() => _MakeNewScreenState();
// }

// class _MakeNewScreenState extends State<MakeNewScreen> {
//   final ItemListController itemListController = Get.put(
//     ItemListController(),
//     permanent: true,
//   );

//   final box = GetStorage();

//   TextEditingController nameController = TextEditingController();
//   TextEditingController quantityController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController comissionController = TextEditingController();
//   TextEditingController vatController = TextEditingController();

//   TextEditingController discountController = TextEditingController();
//   TextEditingController taxController = TextEditingController();

//   //................................................//
//   // TextEditingController fromController = TextEditingController();
//   // TextEditingController toController = TextEditingController();

//   final BusinessAddressController businessAddressController =
//       Get.put(BusinessAddressController(), permanent: true);

//   final BilltoController billtoController = Get.put(BilltoController());

//   final ClientAddressController clientAddressController =
//       Get.put(ClientAddressController());

//   final InvoiceDataController invoiceDataController =
//       Get.put(InvoiceDataController());

//   List statusList = [
//     "Unpaid",
//     "Paid",
//     "Due",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Color(0xffecf0f1),
//       appBar: AppBar(
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             // Navigator.pop(context);
//             Get.back();
//           },
//           child: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Color(0xffecf0f1),
//         elevation: 0.0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: () {},
//               child: Text(
//                 "invoice-25481",
//                 style: TextStyle(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.grey.shade500,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Text(
//                   "BDT-৳",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SizedBox(
//         height: screenHeight,
//         width: screenWidth,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               //......................................From & To box Start.......................//
//               Container(
//                 height: 100,
//                 width: screenWidth,
//                 decoration: BoxDecoration(
//                   color: Color(0xffecf0f1),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(5.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             Get.to(
//                               () => NewAddressScreen(),
//                             );
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 width: 1,
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(5.0),
//                               child: businessAddressController
//                                       .businessNameController.text.isNotEmpty
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           businessAddressController
//                                               .businessNameController.text,
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                         Text(
//                                           businessAddressController
//                                               .address1Controller.text,
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                         Text(
//                                           businessAddressController
//                                               .address2Controller.text,
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                         Text(
//                                           businessAddressController
//                                               .phoneNumberController.text,
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                         Text(
//                                           businessAddressController
//                                               .websiteController.text,
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   : Center(
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey.shade300,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: Icon(
//                                           Icons.add,
//                                           color: Colors.white,
//                                           size: 35,
//                                         ),
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 2,
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             Get.to(
//                               () => NewClientScreen(),
//                             );
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 width: 1,
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Obx(() {
//                                 if (billtoController
//                                     .nameText.value.isNotEmpty) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         billtoController.nameController.text,
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         billtoController
//                                             .address1Controller.text,
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         billtoController
//                                             .address2Controller.text,
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         billtoController
//                                             .phoneNumberController.text,
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         billtoController.websiteController.text,
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 } else {
//                                   return Center(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.grey.shade300,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Icon(
//                                         Icons.add,
//                                         color: Colors.white,
//                                         size: 35,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               }),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               Expanded(
//                 flex: 11,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 5, vertical: 3),
//                               child: Container(
//                                 height: 20,
//                                 width: screenWidth,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 4,
//                                       child: Center(
//                                         child: Text("Name"),
//                                       ),
//                                     ),
//                                     VerticalDivider(
//                                       thickness: 2,
//                                       color: Colors.white,
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Center(
//                                         child: Text("Qty"),
//                                       ),
//                                     ),
//                                     VerticalDivider(
//                                       thickness: 2,
//                                       color: Colors.white,
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Center(
//                                         child: Text("Unit P."),
//                                       ),
//                                     ),
//                                     VerticalDivider(
//                                       thickness: 2,
//                                       color: Colors.white,
//                                     ),
//                                     Expanded(
//                                       flex: 2,
//                                       child: Center(
//                                         child: Text(
//                                           "Total",
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 5, vertical: 2),
//                                 child: Obx(
//                                   () => itemListController.itemlist.isNotEmpty
//                                       ? ListView.separated(
//                                           separatorBuilder: (context, index) {
//                                             return SizedBox(height: 5);
//                                           },
//                                           itemCount: itemListController
//                                               .itemlist.length,
//                                           itemBuilder: (context, index) {
//                                             double getTotalPrice() {
//                                               double totalPrice = 0.0;

//                                               for (var item
//                                                   in itemListController
//                                                       .itemlist) {
//                                                 double itemTotal =
//                                                     double.tryParse(
//                                                             item["total"]
//                                                                 .toString()) ??
//                                                         0.0;
//                                                 totalPrice += itemTotal;
//                                               }

//                                               return totalPrice;
//                                             }

//                                             final data = itemListController
//                                                 .itemlist[index];
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 // Get.to(() => EditItemScreen(
//                                                 //     index: index));

//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return AlertDialog(
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                           15,
//                                                         ),
//                                                       ),
//                                                       contentPadding:
//                                                           EdgeInsets.all(0),
//                                                       content: ItemDialogBox(
//                                                         index: index,
//                                                       ),
//                                                     );
//                                                   },
//                                                 );
//                                               },
//                                               child: Container(
//                                                 height: 30,
//                                                 width: screenWidth,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   border: Border.all(
//                                                       width: 1,
//                                                       color:
//                                                           Colors.grey.shade300),
//                                                 ),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(horizontal: 5),
//                                                   child: Row(
//                                                     children: [
//                                                       Expanded(
//                                                         flex: 4,
//                                                         child: Text(
//                                                           data["name"],
//                                                           textAlign:
//                                                               TextAlign.start,
//                                                           style: TextStyle(
//                                                               fontSize: 12),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   right: 5),
//                                                           child: Text(
//                                                             data["quantity"],
//                                                             textAlign:
//                                                                 TextAlign.end,
//                                                             style: TextStyle(
//                                                                 fontSize: 12),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 2,
//                                                         child: Text(
//                                                           data["unitprice"],
//                                                           textAlign:
//                                                               TextAlign.end,
//                                                           style: TextStyle(
//                                                               fontSize: 12),
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         flex: 3,
//                                                         child: Text(
//                                                           data["total"],
//                                                           textAlign:
//                                                               TextAlign.end,
//                                                           style: TextStyle(
//                                                               fontSize: 12),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         )
//                                       : Center(
//                                           child: Text(
//                                             "No Items",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: 18,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 2,
//                     ),

//                     ///.............................................Item List End............................//
//                     // Container(
//                     //   height: 60,
//                     //   width: screenWidth,
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.green,
//                     //     image: DecorationImage(
//                     //       fit: BoxFit.cover,
//                     //       image: AssetImage(
//                     //         "assets/icons/bannerads.png",
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     SizedBox(
//                       height: 40,
//                       width: screenWidth,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     backgroundColor: Colors.transparent,
//                                     contentPadding: EdgeInsets.all(0.0),
//                                     content: Container(
//                                       height: 160,
//                                       width: screenWidth,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text("Apply your Discount in %"),
//                                             SizedBox(
//                                               height: 8,
//                                             ),
//                                             Container(
//                                               height: 50,
//                                               width: 100,
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.grey,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                   horizontal: 10,
//                                                   vertical: 8,
//                                                 ),
//                                                 child: TextField(
//                                                   onChanged: (value) {
//                                                     // Check if the input value is empty; if so, set discount to 0.0
//                                                     itemListController
//                                                         .discount = value
//                                                             .isEmpty
//                                                         ? 0.00
//                                                         : double.parse(value);
//                                                     itemListController
//                                                         .calculateTotalPrice();
//                                                   },
//                                                   controller:
//                                                       discountController,
//                                                   textAlign: TextAlign.center,
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   decoration: InputDecoration(
//                                                     border: InputBorder.none,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Container(
//                                                     height: 40,
//                                                     width: 100,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.grey,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10),
//                                                     ),
//                                                     child: Center(
//                                                       child: Text(
//                                                         "Cancel",
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.pop(context);
//                                                     // if (discountController
//                                                     //     .text.isNotEmpty) {
//                                                     //   itemListController
//                                                     //           .discount =
//                                                     //       double.parse(
//                                                     //           discountController
//                                                     //               .text);

//                                                     //   print(itemListController
//                                                     //       .discount
//                                                     //       .toString());
//                                                     //   itemListController
//                                                     //       .getTotalPrice();
//                                                     // } else {
//                                                     //   print("Add Data");
//                                                     // }
//                                                   },
//                                                   child: Container(
//                                                     height: 40,
//                                                     width: 100,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.green,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10),
//                                                     ),
//                                                     child: Center(
//                                                       child: Text(
//                                                         "OK",
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: Container(
//                               height: 35,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text("Discount-%"),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     backgroundColor: Colors.transparent,
//                                     contentPadding: EdgeInsets.all(0.0),
//                                     content: Container(
//                                       height: 160,
//                                       width: screenWidth,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text("Apply your vat in %"),
//                                             SizedBox(
//                                               height: 8,
//                                             ),
//                                             Container(
//                                               height: 50,
//                                               width: 100,
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.grey,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                   horizontal: 10,
//                                                   vertical: 8,
//                                                 ),
//                                                 child: TextField(
//                                                   onChanged: (value) {
//                                                     itemListController
//                                                         .tax = value
//                                                             .isEmpty
//                                                         ? 0.00
//                                                         : double.parse(value);
//                                                     itemListController
//                                                         .calculateTotalPrice();
//                                                   },
//                                                   controller: taxController,
//                                                   textAlign: TextAlign.center,
//                                                   keyboardType:
//                                                       TextInputType.number,
//                                                   decoration: InputDecoration(
//                                                     border: InputBorder.none,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Container(
//                                                     height: 40,
//                                                     width: 100,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.grey,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               10),
//                                                     ),
//                                                     child: Center(
//                                                       child: Text(
//                                                         "Cancel",
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   height: 40,
//                                                   width: 100,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.green,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                   ),
//                                                   child: Center(
//                                                     child: Text(
//                                                       "Apply",
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: Container(
//                               height: 35,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text("Tax-%"),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     backgroundColor: Colors.transparent,
//                                     contentPadding: EdgeInsets.all(0.0),
//                                     content: Container(
//                                       height: 150,
//                                       width: screenWidth,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: ListView.builder(
//                                           physics: BouncingScrollPhysics(),
//                                           itemCount: statusList.length,
//                                           itemBuilder: (context, index) {
//                                             return GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   invoiceDataController
//                                                           .invoiceStatus =
//                                                       statusList[index];
//                                                 });

//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 margin:
//                                                     EdgeInsets.only(bottom: 5),
//                                                 height: 40,
//                                                 width: screenWidth,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                     width: 1,
//                                                     color: Colors.grey.shade300,
//                                                   ),
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     statusList[index],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             child: Container(
//                               height: 35,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   invoiceDataController.invoiceStatus
//                                       .toString(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Get.to(() => NewItemsScreen());
//                             },
//                             child: Container(
//                               height: 35,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   width: 1,
//                                   color: Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Center(
//                                   child: Text(
//                                     "Add Items",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 2,
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             width: 1,
//                             color: Colors.grey.shade300,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Sub Total : ",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                   Obx(
//                                     () => itemListController
//                                                 .subtotalloading.value ==
//                                             false
//                                         ? Text(
//                                             itemListController.totalPrice.value
//                                                 .toStringAsFixed(2),
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w800,
//                                               fontSize: 14,
//                                             ),
//                                           )
//                                         : Text("calculating"),
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Discount (${itemListController.discount}%) : ",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                   Text(
//                                     itemListController.discountedPrice
//                                         .toString(),
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Tax (${itemListController.tax}%%) : ",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                   Text(
//                                     itemListController.taxmount.toString(),
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Divider(
//                                 thickness: 1,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Total : ",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w800,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   Obx(
//                                     () => itemListController.isloading.value ==
//                                             false
//                                         ? Text(
//                                             itemListController
//                                                 .subTotalPrice.value
//                                                 .toStringAsFixed(2),
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w800,
//                                               fontSize: 14,
//                                             ),
//                                           )
//                                         : Text("calculating"),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   height: 70,
//                   width: screenWidth,
//                   color: Color(0xffecf0f1),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: GestureDetector(
//                           onTap: () {
//                             if (box.read("design") == "design1") {
//                               Get.to(() => DesignOneTemplate());
//                             } else if (box.read("design") == "design2") {
//                               Get.to(() => DesignTwoTemplate());
//                             } else {
//                               print("Set design first");
//                             }
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.horizontal(
//                                   left: Radius.circular(20)),
//                               border: Border.all(
//                                 width: 1,
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                             child: Center(
//                                 child: Text(
//                               "Preview",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                             )),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: GestureDetector(
//                           onTap: () {
//                             itemListController.itemlist.clear();
//                             Get.back();
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.horizontal(
//                                   right: Radius.circular(20)),
//                               border: Border.all(
//                                 width: 1,
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                             child: Center(
//                                 child: Text(
//                               "Cancel",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                             )),
//                           ),
//                         ),
//                       ),

//                       // ElevatedButton(
//                       //   onPressed: () {},
//                       //   child: Text("Print"),
//                       // ),
//                       // ElevatedButton(
//                       //     onPressed: () {
//                       //       showDialog(
//                       //         context: context,
//                       //         builder: (context) {
//                       //           return AlertDialog(
//                       //             content: Container(
//                       //               height: 350,
//                       //               width: screenWidth,
//                       //               child: Column(
//                       //                 children: [
//                       //                   Text("Add Your Items"),
//                       //                   TextField(
//                       //                     controller: nameController,
//                       //                     decoration:
//                       //                         InputDecoration(hintText: "Name"),
//                       //                   ),
//                       //                   TextField(
//                       //                     controller: quantityController,
//                       //                     keyboardType: TextInputType.number,
//                       //                     decoration: InputDecoration(
//                       //                         hintText: "Quantity"),
//                       //                   ),
//                       //                   TextField(
//                       //                     controller: priceController,
//                       //                     keyboardType: TextInputType.number,
//                       //                     decoration: InputDecoration(
//                       //                         hintText: "Price"),
//                       //                   ),
//                       //                   TextField(
//                       //                     controller: comissionController,
//                       //                     keyboardType: TextInputType.number,
//                       //                     decoration: InputDecoration(
//                       //                         hintText: "Comission    % "),
//                       //                   ),
//                       //                   TextField(
//                       //                     controller: vatController,
//                       //                     keyboardType: TextInputType.number,
//                       //                     decoration: InputDecoration(
//                       //                         hintText: "Vat    % "),
//                       //                   ),
//                       //                   SizedBox(
//                       //                     height: 20,
//                       //                   ),
//                       //                   ElevatedButton(
//                       //                     onPressed: () {
//                       //                       setState(() {
//                       //                         if (nameController.text.isEmpty ||
//                       //                             quantityController
//                       //                                 .text.isEmpty ||
//                       //                             priceController
//                       //                                 .text.isEmpty) {
//                       //                           print("add data");
//                       //                         } else {
//                       //                           mydatalist.add({
//                       //                             "name": nameController.text,
//                       //                             "quantity": int.parse(
//                       //                                 quantityController.text),
//                       //                             "price": int.parse(
//                       //                                 priceController.text),
//                       //                           });
//                       //                         }

//                       //                         // Clear the text fields after adding
//                       //                         nameController.clear();
//                       //                         quantityController.clear();
//                       //                         priceController.clear();
//                       //                       });
//                       //                     },
//                       //                     child: Text("Add Now"),
//                       //                   ),
//                       //                 ],
//                       //               ),
//                       //             ),
//                       //           );
//                       //         },
//                       //       );
//                       //     },
//                       //     child: Text("add"))
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ItemDialogBox extends StatelessWidget {
//   ItemDialogBox({
//     super.key,
//     required this.index,
//   });
//   final int index;

//   final itemListController = Get.find<ItemListController>();

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Container(
//       height: 300,
//       width: screenWidth,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Do you want to delete this item?",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   itemListController.deleteItem(index); // Delete item
//                   Get.back(); // Close dialog
//                 },
//                 child: Text("Delete"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () => Get.back(), // Close dialog
//                 child: Text("Cancel"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.grey,
//                   foregroundColor: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
