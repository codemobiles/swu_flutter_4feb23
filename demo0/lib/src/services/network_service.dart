class NetworkService {
  SomeService._internal(); // SomeService();
  static final SomeService _instance = SomeService._internal();
  factory SomeService() => _instance;

  method1() {
    print("Call me Why?");
  }
}
