import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahnegar/common/widgets/back_ground.dart';
import 'package:rahnegar/features/intro/presentation/manager/bloc/widgets/rahnegar_widget.dart';
import 'package:rahnegar/locator.dart';
import 'package:rahnegar/routes/route_names.dart';

import '../../blocs/authorize/authorize_cubit.dart';


class SplashPage extends StatelessWidget {
  SplashPage({super.key}) {
    Future.delayed(const Duration(seconds: 2)).then((onValue) {
      authorizeCubit.checkAuthorization();
    });
  }

  AuthorizeCubit authorizeCubit = locator<AuthorizeCubit>();
  final int startAnimateTime = 1000;
  final int timeOffset = 300;


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizeCubit, AuthorizeState>(
      listener: (context, state) {
        if(state is Authorized){
          Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.mainPage, (Route<dynamic> route) => false);
        }else if(state is UnAuthorized){
          Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.otpPage, (Route<dynamic> route) => false);
        }
      },
      child: SafeArea(
          child: Scaffold(body:
             Animate(
               effects: const [FadeEffect(duration: Duration(seconds: 2))],
               child: BackGroundWidget(
                 widget: Align(
                   alignment: Alignment.topCenter,
                   child:
                   Column(
                     children: [
                       SizedBox(height: MediaQuery.of(context).size.height/5,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Image.asset("assets/images/splash/logo.png",width: 250.0,),
                         ],
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 80.0),
                         child: Image.asset("assets/images/splash/group.png",),
                       ),
                     ],
                   ),
                 )
                 ),
             )
          // SizedBox(
          //     height: double.infinity,
          //     width: double.infinity,
          //     child: Image.asset(
          //       "assets/images/splash/splash.png", fit: BoxFit.fill,)
          // ),
          )
      ),
    );
  }
}