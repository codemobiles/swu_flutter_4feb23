# review flutter course

## Day 1
- setup flutter dev tools
- Learn about UIs
  + main -> runApp -> MaterialApp -> Widgets(Login)
  + Row, Column, Container, SizedBox, Card 
  + Colors, Text, Icon, SingleChildScrollView
  + TextButton, OutlinedButton, ElevatedButton
  + Image.asset, Image.network
  + TextField, TextEditController
  + Etc... 
- Types of Flutter Widgets
  + StatelessWidget (stl) vs StatefullWidget (stf)
  + Widget lifecycle [initState, build, dispose]
  + Scaffold [appbar, body, floatingActionButton, title]
  + pubspec.yml [www.pub.dev, assets]

## Day2
- Page Navigation
  + setup in MaterialApp 
  + [routes: AppRoute.all, Navigator.pushNamed(..), Navigator.pop(..)]
  + Event onPressed (){method();} vs ()=>method() vs _method 
- int tmp1 = 0, String tmp2 = ""
- int? tmp1 = null, String? tmp2 = null
- setState((){ tmp1 = 1 }) -> force to refresh UI
- Bloc => Bussiness Login Component
  + plugin (bloc)
  + single bloc [XXXstate, XXXevent, XXXBloc]
  + Register bloc in app.dart [BlocProvider, MultiBlocProvider, provider]
  + context.read<HomeBloc>().add(HomeEventLoadData());
  + context.read<HomeBloc>().state
  + BlocBuilder 
  + setState(refresh whole screen) vs BlocBuilder (refresh only wrapped widget)
+ Dio Http client 

``` 
final dio = Dio();
final url = "https://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=songs";
final response  = await dio.get(url);
final youtubeResponse  = youtubeResponseFromJson(response.data);
emit(state.copyWith(youtubes: youtubeResponse.youtubes));
```


## Day3 
- Review BLOC
- ListView and GridView
- Deploy on Android and iOS Device
- Drawer


# Day 4
- map: https://pub.dev/packages/google_maps_flutter