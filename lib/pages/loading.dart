import 'package:flutter/material.dart';
import 'package:perfect_flatmate/services/auth.dart';
import 'package:perfect_flatmate/util/theme.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> 
{
  @override
  void initState() 
  {
    // var startTime = DateTime.now().millisecondsSinceEpoch;
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 1000), () {Auth.checkLogin(context);});
    

  }
  
  void setup() async
  {
    //TODO setup here
  }

  @override
  Widget build(BuildContext context) 
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child: Column(
        children: [
          Spacer(flex: 2,),
          Expanded(child: Text("Perfect Flatmate",
          style: CustomTheme.title
          ),),
          Expanded(
            flex: 2,
            child: Image.asset("assets/logo.png",
          scale: 1,
          )),
          Spacer(flex: 2,)

        ],)),
    );
  }
}