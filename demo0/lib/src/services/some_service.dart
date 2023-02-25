

class SomeService {

  // Legacy solution
  // static SomeService? _object;
  // static SomeService getInstance(){
  //   if (_object == null){
  //     _object = SomeService();
  //   }
  //   return _object!;
  // }

  // New Solution
  // https://www.youtube.com/watch?v=2hTL5gvE5tQ
  // สอน Factory Design Pattern / Singleton ใน Flutter Dart แบบละเอียด (static, factory, _internal)
  SomeService._internal(); // SomeService();
  static final SomeService _instance = SomeService._internal();
  factory SomeService() => _instance;


  int _count = 0;
  addCount(){
    _count++;
    print("Count: $_count");
    return _count;
  }
}