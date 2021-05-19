import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../ressource/constante.dart';
Database bdd;
void creer_bdd() async{
  /**creation des tables**/
  await bdd.execute("CREATE TABLE ITEM(id TEXT PRIMARY KEY,modelpath TEXT,name TEXT )");
  await bdd.execute("CREATE TABLE QR(id TEXT PRIMARY KEY, isnot INTEGER,iditem TEXT,FOREIGN KEY(iditem) REFERENCES ITEM(id) )");
  await bdd.execute("CREATE TABLE Hint(id TEXT PRIMARY KEY,hint TEXT,isnot INTEGER)");
  await bdd.execute("CREATE TABLE Place(id TEXT PRIMARY KEY,isnot INTEGER)");
  await bdd.execute("CREATE TABLE PLACEHINT(idplace TEXT,idhint TEXT,PRIMARY KEY(idplace,idhint),FOREIGN KEY(idplace) REFERENCES Place(id),FOREIGN KEY(idhint) REFERENCES Hint(id))");
  /***insertion des qrcode***/
  await bdd.execute("INSERT INTO ITEM(id,modelpath,name)values(1,'assets/images/table.glb','the table of death')");
  await bdd.execute("INSERT INTO QR(id,isnot,iditem)VALUES('https://eqrcode.co/a/8cOgVN',0,1)");
  await bdd.execute("INSERT INTO Hint(id,isnot,hint)VALUES('hint n-5',1,'dela3 raho ghali a hbibi wsh ak hab')");
  print("bdd creer");
  await bdd.close();
}

ouvrirbdd()async{

  bdd= await openDatabase(join(await getDatabasesPath(),"GH.db" ));
  print("bdd ouverte");
}

bddexiste()async{
  await ouvrirbdd();
    try{
      list_hint=await bdd.query("Hint",where: "isnot=1");
    }catch(e){
      await creer_bdd();
    }
  bdd.close();
}