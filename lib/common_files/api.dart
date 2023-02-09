class API {
  static final API _instance = API._internal();
  String? baseUrl;

  factory API() {
    return _instance;
  }

  API._internal() {
    baseUrl = 'https://tradeengineers.com/bandhana/shaadi1/api/';
    // baseUrl = 'http://127.0.0.1:8000/api/';
  }
}

final API api = API();
