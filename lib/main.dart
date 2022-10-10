
import 'package:flutter/material.dart';
import 'package:todolast/bottom%20sheet.dart';
import 'package:todolast/database.dart';
import 'package:todolast/drawer.dart';
import 'package:todolast/todomodal.dart';
import 'todomodal.dart';
void main()async {
  runApp(const MyApp());
  await DbHelper.instance.opendatabase();
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}
List<TodoDetails> todo=[];
class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          drawer:DrawerNavigation() ,
          appBar: AppBar(
            elevation: 0,
            title: Text('Tasker',style:TextStyle(fontSize: 35,fontWeight: FontWeight.w700,color: Colors.white),),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showModalBottomSheet(
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                  ),
                  context: context,
                  builder: (context){
                      return CustomBottomSheet() ;
                  }
                  );

            },
            child: Icon(Icons.add),
          ),
          body: FutureBuilder<List<TodoDetails>>(
            future:DbHelper.instance.allTodos() ,
            builder: (context,snapshot){
                if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()));
                }
                if(snapshot.hasData)  {
               todo=snapshot.data!;
               return ListView.builder(
                 itemCount: todo.length,
                   itemBuilder:(context,index){
                     TodoDetails todoobj =todo[index];
                   return ListTile(
                     leading: Checkbox(
                       value: todoobj.isChecked,
                       onChanged: (bool? change){
                        setState(() {
                        todo[index].isChecked=change!;
                        });

                       },
                     ),
                     title: Text('${todoobj.name}'),
                     subtitle: Text(DateTime.fromMillisecondsSinceEpoch(todoobj.date).toString()),
                     trailing: IconButton(onPressed:()async{
                       await DbHelper.instance.removetodo(todoobj.id!);
                     }, icon:Icon( Icons.delete)),
                   );

                   });


             }
              return Center(
              child: Container(
              height: 100,
              width: 100,
              child: CircularProgressIndicator()));
            },


          ),

        ),
    );
  }
}




