import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sb_myreports/features/jokes/presentation/manager/jokes_provider.dart';

import '../../../../core/utils/globals/globals.dart';

class JokeListScreen extends StatelessWidget {
   JokeListScreen({Key? key}) : super(key: key);

JokesProvider jokesProvider=sl();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: jokesProvider),
        ],
        child: JokeListScreenContent());
  }
}

class JokeListScreenContent extends StatelessWidget {
  const JokeListScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Consumer<JokesProvider>(
          builder: (context,provider,ch){
            return ListView.builder(itemCount: provider.getQueryJokesResponseModel!.result.length,itemBuilder:(context,index){
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.8)
                  ),

                  child: Text(provider.getQueryJokesResponseModel!.result[index].value));
            },);
          },

        ),
      ),
    );
  }
}
