import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sb_myreports/core/utils/constants/app_assets.dart';
import 'package:sb_myreports/features/jokes/presentation/manager/jokes_provider.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/validators/form_validator.dart';
import '../../../../core/widgets/custom/continue_button.dart';
import '../../../../core/widgets/custom/custom_form_field.dart';

class JokeScreen extends StatelessWidget {
  JokeScreen({Key? key}) : super(key: key);
  JokesProvider jokesProvider = sl();
  // Provider state managements

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: jokesProvider, child: JokeScreenContent());
  }
}

class JokeScreenContent extends StatefulWidget {
  JokeScreenContent({Key? key}) : super(key: key);

  @override
  State<JokeScreenContent> createState() => _JokeScreenContentState();
}

class _JokeScreenContentState extends State<JokeScreenContent> {

  TextEditingController jokeQueryController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<JokesProvider>().getRandomJoke();

  }

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'Search',
                  labelText: 'Joke',
                  validator: FormValidators.validateJoke,

                  controller: jokeQueryController,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ContinueButton(
                    loadingNotifier: context.read<JokesProvider>().queryJokeLoading,
                    text: 'Find', onPressed: () {
                  if(_key.currentState!.validate()){
                    context.read<JokesProvider>().getQueryJokes(jokeQueryController.text);
                  }


                }),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.all(15.r),
                  width: double.infinity,
                  height: 300.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.grey.withOpacity(.2)),
                  child: Center(
                      child: ValueListenableBuilder<bool>(
                          valueListenable:
                              context.read<JokesProvider>().randomJokeLoading,
                          builder: (_, loading, __) {


                            return loading == true
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : Text(context

                                    .read<JokesProvider>()
                                    .getRandomJokeResponseModel!
                                    .value);
                          })),
                ),
                IconButton(
                    onPressed: () {
                      context.read<JokesProvider>().getRandomJoke();
                    },
                    icon: Icon(Icons.refresh)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
