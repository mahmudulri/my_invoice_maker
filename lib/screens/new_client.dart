import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_maker/invoicecontrollers/billto_controller.dart';
import 'package:invoice_maker/widgets/business_textbox.dart';
import '../invoicecontrollers/address_controller.dart';
import '../helper/database_helper.dart';

class NewClientScreen extends StatefulWidget {
  NewClientScreen({super.key});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  final ClientAddressController clientAddressController =
      Get.put(ClientAddressController());

  final BilltoController billtoController = Get.put(BilltoController());

  List<Map<String, dynamic>> clientsList = [];
  int? editingClientId; // Store ID of client being edited

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {
    final clients = await DatabaseHelper.instance.getClients();
    setState(() {
      clientsList = clients;
    });
  }

  Future<void> _saveClient() async {
    if (clientAddressController.nameController.text.isEmpty ||
        clientAddressController.address1Controller.text.isEmpty ||
        clientAddressController.phoneNumberController.text.isEmpty) {
      Get.snackbar("Error", "Client Name, Address, and Phone are required!");
      return;
    }

    final client = {
      'name': clientAddressController.nameController.text,
      'address1': clientAddressController.address1Controller.text,
      'address2': clientAddressController.address2Controller.text,
      'phone': clientAddressController.phoneNumberController.text,
      'website': clientAddressController.websiteController.text,
    };

    if (editingClientId == null) {
      // Add new client
      await DatabaseHelper.instance.insertClient(client);
      Get.snackbar("Success", "Client added successfully!");
    } else {
      // Update existing client
      client['id'] = editingClientId.toString();
      await DatabaseHelper.instance.updateClient(client);
      Get.snackbar("Success", "Client updated successfully!");
      editingClientId = null; // Reset after update
    }

    _fetchClients();
    _clearFields();
  }

  void _editClient(Map<String, dynamic> client) {
    setState(() {
      editingClientId = client['id'];
      clientAddressController.nameController.text = client['name'];
      clientAddressController.address1Controller.text = client['address1'];
      clientAddressController.address2Controller.text = client['address2'];
      clientAddressController.phoneNumberController.text = client['phone'];
      clientAddressController.websiteController.text = client['website'];
    });
  }

  void _cancelEdit() {
    setState(() {
      editingClientId = null;
    });
    _clearFields();
  }

  Future<void> _confirmDeleteClient(int id) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete this client?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close the dialog
              await DatabaseHelper.instance.deleteClient(id);
              _fetchClients();
              Get.snackbar("Success", "Client deleted successfully!");
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _clearFields() {
    clientAddressController.nameController.clear();
    clientAddressController.address1Controller.clear();
    clientAddressController.address2Controller.clear();
    clientAddressController.phoneNumberController.clear();
    clientAddressController.websiteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Client Address",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        BusinessTextbox(
                          hintText: "Client Name",
                          controller: clientAddressController.nameController,
                        ),
                        BusinessTextbox(
                          hintText: "Billing Address 1",
                          controller:
                              clientAddressController.address1Controller,
                        ),
                        BusinessTextbox(
                          hintText: "Billing Address 2",
                          controller:
                              clientAddressController.address2Controller,
                        ),
                        BusinessTextbox(
                          hintText: "Phone No.",
                          controller:
                              clientAddressController.phoneNumberController,
                        ),
                        BusinessTextbox(
                          hintText: "Business Website",
                          controller: clientAddressController.websiteController,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: _saveClient,
                                child: Text(editingClientId == null
                                    ? "Save & Add"
                                    : "Update"),
                              ),
                            ),
                            if (editingClientId != null) SizedBox(width: 10),
                            if (editingClientId != null)
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  onPressed: _cancelEdit,
                                  child: Text("Cancel"),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text(
                        "Select From Saved Items",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: ListView.separated(
                          itemCount: clientsList.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            var client = clientsList[index];
                            return GestureDetector(
                              onTap: () {
                                billtoController.nameController.text =
                                    client['name'];
                                billtoController.address1Controller.text =
                                    client['address1'];
                                billtoController.address2Controller.text =
                                    client['address2'] ?? "";
                                billtoController.phoneNumberController.text =
                                    client['phone'];
                                billtoController.websiteController.text =
                                    client['website'] ?? "";

                                Get.back();
                              },
                              child: ListTile(
                                title: Text(client['name']),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(client['address1']),
                                    Text(client['address2'] ?? ""),
                                    Text(client['phone']),
                                    Text(client['website'] ?? ""),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () => _editClient(client),
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () =>
                                          _confirmDeleteClient(client['id']),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
