import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sb_myreports/core/router/models/page_config.dart';
import 'package:sb_myreports/core/utils/enums/page_state_enum.dart';
import 'package:sb_myreports/core/utils/validators/form_validator.dart';
import 'package:sb_myreports/core/widgets/custom/continue_button.dart';
import 'package:sb_myreports/core/widgets/custom/custom_form_field.dart';

import '../../../../core/router/app_state.dart';
import '../../../../core/utils/globals/globals.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const SplashScreenContent(),
    );
  }
}

class SplashScreenContent extends StatefulWidget {
  const SplashScreenContent({Key? key}) : super(key: key);

  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppState appState = sl();
      appState.goToNext(PageConfigs.googleMapPageConfig,
          pageState: PageState.replace);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("SPlash Screen"),
    ));
  }
}

class JokeScreenContent extends StatelessWidget {
  JokeScreenContent({Key? key}) : super(key: key);
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
                ),
                SizedBox(
                  height: 10.h,
                ),
                ContinueButton(text: 'Find', onPressed: () {}),
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
                  child: const Center(child: Text("Hello testing")),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
