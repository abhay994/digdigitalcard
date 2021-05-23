import 'package:digitalcard/models/dr_users.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:digitalcard/constants/dr_database_constant.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class Services{
  // database name
  static final _databasename = "digitalVcard.db";
  static final _databaseversion = 1;

  // table names
  static final _databaseTable = "digitalVcard";

  static Database? database;

  var databasesPath;
  String? path;

  BehaviorSubject<List<Map<String,dynamic>>>? savedUserProfile;

  Stream<List<Map<String,dynamic>>>? get savedUserProfileJson => savedUserProfile!.stream;

  Services._privateConstructor() {

    savedUserProfile = new BehaviorSubject<List<Map<String,dynamic>>>.seeded([]);

    initializeSqlDatabase();
  }



  static final Services instance = Services._privateConstructor();


  // ID Generation
  String uuidGeneration()=>Uuid().v1();


  //timeStamp
  String timeStamp()=> DateTime.now().toIso8601String();


  // Database Exists
  Future<bool> databaseExists(String path) async => await databaseFactory.databaseExists(path);


  // Initialize Sql DataBase
  Future<bool> initializeSqlDatabase() async{
     databasesPath = await getDatabasesPath();
     path = join(databasesPath, _databasename);
    var exist= await databaseExists(path!);
    if(exist){



      database = await openDatabase(path!);
     //  await getAdmin();
      return true;



    }else{


      return false;

    }

  }


  // create Sql DataBase
  Future<void> createSqldatabase() async => database = await openDatabase(path!, version: _databaseversion, onCreate: _onCreate);



  // create a database since it doesn't exist
  Future _onCreate(Database db, int version) async => await db.execute('''
      CREATE TABLE $_databaseTable (
        $uid TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $profession TEXT NOT NULL,
        $about TEXT NOT NULL,
        $type TEXT  NOT NULL,
        $timeStampVar TEXT NOT NULL,
        $image TEXT,
        $githubUrl TEXT,
        $linkedInUrl TEXT ,
        $mediumUrl TEXT
        );
      ''');


  // delete Sql DataBase
  Future<void> deleteSqlDatabase() async => await deleteDatabase(path!);


  // insert User
  Future<void> addUser(Users users) async{ await database!.insert(_databaseTable,users.toJson());}


  // Update User
  Future<void> updateUser(Users users) async{

    await database!.update(
        _databaseTable, users.toJson(), where: 'uid = ?',
        whereArgs: [users.uid]);

  }

  // Get Admin
  Future<Users?> getAdmin() async{
    List<Map<String,dynamic>>? data = await database!.rawQuery('SELECT * FROM digitalVcard WHERE type = ? ', ['admin']);
    return Users.fromData(data[0]);

  }

  // Get saved Users
 Future<void> getSavedUsers() async {
    List<Map<String,dynamic>>? data = await database!.rawQuery('SELECT * FROM digitalVcard WHERE type = ? ', ['saved']);
    savedUserProfile!.sink.add(data);
    // return data;

  }

  // Get saved Users
  Future<void> delete(String userUid) async {
     await database!.delete(_databaseTable, where: '$uid = ?', whereArgs: [userUid]);
     await getSavedUsers();
  }

  void dispose() {
    savedUserProfile!.close();

 }



}