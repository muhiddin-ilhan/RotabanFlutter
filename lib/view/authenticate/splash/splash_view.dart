import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nestle_app/core/base/state/base_state.dart';
import 'package:nestle_app/core/base/view/BaseView.dart';
import 'package:nestle_app/core/localization/app_localization.dart';
import 'package:nestle_app/view/authenticate/splash/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> {
  SplashViewModel viewModel = SplashViewModel();

  @override
  Widget build(BuildContext context) {
    AppLocalizations.of(context);
    return BaseView<SplashViewModel>(
        onModelReady: (model) {
          viewModel = model;
        },
        viewModel: SplashViewModel(),
        onDispose: () {},
        onPageBuilder: (ctx, value) {
          viewModel.isUserLogin(ctx);
          return scaffold;
        });
  }

  Widget get scaffold => Scaffold(
        body: Container(
          height: dynamicHeight(1),
          width: dynamicWidth(1),
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomCenter, colors: [Colors.blue.shade500, Colors.blue.shade800]),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: "image_logo",
                  child: Image(
                    image: AssetImage("asset/image/rotaban_login.png"),
                    width: dynamicWidth(0.7),
                    height: dynamicHeight(0.3),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset(
                  "asset/anim/circles_anim.json",
                  frameRate: FrameRate(60),
                ),
              ),
            ],
          ),
        ),
      );
}
