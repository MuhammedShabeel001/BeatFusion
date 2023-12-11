// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';

// class HiveServices{
//   Future<void> initHive() async{
//     final appDocumentDir = await getApplicationDocumentsDirectory();
//     Hive.init(appDocumentDir.path);
//   }
//   Future <Box<dynamic>> openBox(String name) async{
//     return Hive.openBox(name);
//   }
// }