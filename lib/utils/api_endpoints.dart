class ApiEndPoints {
  static String baseUrl = "https://invoiceapi.samiulcse.cloud/";

  static OtherendPoints otherendpoints = OtherendPoints();
}

class OtherendPoints {
  final String signin = "auth/sign-in";
  final String clientlist = "auth/get-clients";
  final String addclient = "auth/add-client";
  final String addshop = "shops/create";
  final String addproduct = "products/create";
  final String updateprofile = "auth/update-business-profile";
}
