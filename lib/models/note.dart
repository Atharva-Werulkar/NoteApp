import 'package:isar/isar.dart';

//this line is needed to generate the file
//then run the command: dart run build_runner build
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
