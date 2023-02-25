class NetworkService {
  int count = 0;

  // Singleton
  NetworkService._internal(); // SomeService();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  method1() {
    count++;
    print("Count: $count");
  }
}
