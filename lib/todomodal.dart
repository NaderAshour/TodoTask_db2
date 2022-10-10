import 'database.dart';
class TodoDetails{
  int? id;
  late String name;
  late int date;
  late bool isChecked;

  TodoDetails({this.id, required this.name, required this.date, required this.isChecked,});
  TodoDetails.fromMap(Map<String,dynamic>inmap){
    if(inmap[columnId]!=null){
      this.id=inmap[columnId];
      this.name=inmap[columnName];
      this.date=inmap[columnDate];
      this.isChecked=inmap[columnIsChecked]==0?false:true;
    }
  }
  Map<String,dynamic> toMap(){
    Map<String, dynamic> map = {};
     if(this.id!=null){
       map[columnId]=this.id;
       map[columnName]=this.name;
       map[columnDate]=this.date;
       map[columnIsChecked]=this.isChecked?1:0;
  }
    return map;
}
}