class Api {
  static String get baseUrl {
    // return "http://192.168.0.126:8000/api";
    return "http://192.168.10.180:8000/api";
  }

  static const login = "/login";
  static const register = "/register";
  static const getCallsLog = "/get-call-Logs";
  static const registerVendor = "/auth/register/vendor";
  static const createActivity = "/activities";
  static const userData = "/users";

  // Quests
  static const quests = "/quests";
  static const durations = "/durations";
  static const durationMap = "/duration-map";

  //cart & checkout

  static const deliveryAddresses = "/delivery/addresses";
  static const paymentMethods = "/payment/methods";
  static const orders = "/orders";
  static const trackOrder = "/track/order";
  static const packageOrders = "/package/orders";
  static const packageOrderSummary = "/package/order/summary";
  static const generalOrderDeliveryFeeSummary =
      "/general/order/delivery/fee/summary";
  static const generalOrderSummary = "/general/order/summary";
  static const serviceOrderSummary = "/service/order/summary";
  // static const chat = "/chat/notification";
  static const rating = "/ratings";

  //packages
  static const packageTypes = "/package/types";
  static const packageVendors = "/package/order/vendors";

  //Taxi booking
  static const vehicleTypes = "/vehicle/types";
  static const vehicleTypePricing = "/vehicle/types/pricing";
  static const newTaxiBooking = "/taxi/book/order";
  static const currentTaxiBooking = "/taxi/current/order";
  static const lastRatebleTaxiBooking = "/taxi/rateable/order";
  static const cancelTaxiBooking = "/taxi/order/cancel";
  static const taxiDriverInfo = "/taxi/driver/info";
  static const taxiLocationAvailable = "/taxi/location/available";
  static const taxiTripLocationHistory = "/taxi/location/history";

  //wallet
  static const walletBalance = "/wallet/balance";
  static const walletTopUp = "/wallet/topup";
  static const walletTransactions = "/wallet/transactions";
  static const myWalletAddress = "/wallet/my/address";
  static const walletAddressesSearch = "/wallet/address/search";
  static const walletTransfer = "/wallet/address/transfer";

  //loyaltypoints
  static const myLoyaltyPoints = "/loyalty/point/my";
  static const loyaltyPointsWithdraw = "/loyalty/point/my/withdraw";
  static const loyaltyPointsReport = "/loyalty/point/my/report";

  //map
  static const geocoderForward = "/geocoder/forward";
  static const geocoderReserve = "/geocoder/2/reserve";
  static const geocoderPlaceDetails = "/geocoder/place/details";

  //reviews
  static const productReviewSummary = "/product/review/summary";
  static const productReviews = "/product/reviews";
  static const productBoughtFrequent = "/product/frequent";

  //flash sales
  static const flashSales = "/flash/sales";
  static const externalRedirect = "/external/redirect";

  //
  static const cancellationReasons = "/cancellation/reasons";

  // // Other pages
  // static String get privacyPolicy {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/privacy/policy";
  // }

  // static String get terms {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/pages/terms";
  // }

  // static String get paymentTerms {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/pages/payment/terms";
  // }

  // static String get refundTerms {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/pages/refund/terms";
  // }

  // static String get cancelTerms {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/pages/cancel/terms";
  // }

  // static String get shippingTerms {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/pages/shipping/terms";
  // }

  // static String get contactUs {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/pages/contact";
  // }

  // static String get inappSupport {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/support/chat";
  // }

  // static String get appShareLink {
  //   final webUrl = baseUrl.replaceAll('/api', '');
  //   return "$webUrl/preview/share";
  // }

  // static Future<String> redirectAuth({String? url, String? route}) async {
  //   final userToken = await AuthServices.getAuthBearerToken();
  //   final webUrl = "$baseUrl/external/web/redirect";
  //   return "$webUrl?token=$userToken&route=$route&url=$url";
  // }
}
