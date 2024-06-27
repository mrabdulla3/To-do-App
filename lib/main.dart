import 'package:flutter/material.dart';
import 'package:to_do_list/IntroScreen.dart';
import 'package:to_do_list/task_List.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent.shade200),
        useMaterial3: true,
      ),
      home:IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var arrIcon = [
    Icons.lightbulb_outlined,
    Icons.fastfood_outlined,
    Icons.sports_baseball_outlined,
    Icons.note_alt_outlined,
    Icons.library_music_outlined,
    Icons.video_collection_outlined,
    Icons.more_outlined
  ];
  var arrName = ['Idea', 'Food', 'Sport', 'Work', 'Music','Movies', 'Other'];
  var titleColor=Colors.blue.shade300;

  List<int> taskCount=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0; i<arrName.length; i++){
      taskCount.add(0);
    }
  }
  void updateTaskCount(int index, int count){
    setState(() {
      taskCount[index]=count;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Center(
            child: Text('Choose Activity',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600,color: Colors.blue.shade400,fontFamily: 'Poppins-Medium')),
          ),
        ),
        body: Center(
          child: Column(
            children: [

              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          leading: Icon(arrIcon[index % arrIcon.length]),
                          title: Text(arrName[index % arrName.length],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: titleColor),),
                          subtitle: Text('Total Available Task: ${taskCount[index]} ',style: TextStyle(fontSize: 13),),
                          trailing:IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => task_List(activityName: arrName[index % arrName.length],
                              updateTaskCount: (count) => updateTaskCount(index, count),),));
                          },icon: Icon(Icons.arrow_forward_ios),)
                      ),
                    );
                  },
                  itemCount: arrIcon.length,
                  itemExtent: 110,
                ),
              )
            ],
          ),
        ));
  }
}
