import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../../common/widgets/my_button.dart';
import '../../../../../../../common/widgets/my_text_form_field.dart';
import '../../../../../../../routes/route_names.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool checkValue = false;
  // final LocalAuthentication auth = LocalAuthentication(
  // );
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  // List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    // auth.isDeviceSupported().then(
    //       (bool isSupported) => setState(() => _supportState = isSupported
    //       ? _SupportState.supported
    //       : _SupportState.unsupported),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('loginUserName'.tr),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                showCursor: false,
                textInputAction: TextInputAction.next,
                decoration: MyTextFormField(
                        fillColor: Colors.white,
                        borderColor: Theme.of(context).primaryColor,
                        context: context,
                        suffixIcon: Image.asset(
                          "assets/images/login/pen.png",
                          width: 16.0,
                          height: 16.0,
                          color: Colors.grey,
                        ),
                       )
                    .decoration(),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Text('loginPassword'.tr),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                showCursor: false,
                decoration: MyTextFormField(
                        fillColor: Colors.white,
                        borderColor: Theme.of(context).primaryColor,
                        context: context,
                        suffixIcon: Image.asset(
                          "assets/images/login/password.png",
                          width: 16.0,
                          height: 16.0,
                          color: Colors.grey,
                        ),
                        )
                    .decoration(),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                        color: Theme.of(context).primaryColor
                      ),
                      value: checkValue, onChanged: (_)=>setState(() {
                    checkValue=!checkValue;
                  })),
                  Text('saveUserName'.tr)],
              ),
              const SizedBox(
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('activate'.tr),
                  Text('resetPassword'.tr)
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              MyButton(
                  color: const Color(0xffF39200),
                  text: 'login'.tr,
                  onTap: () {
                    print("tapped");
                  }),
              const SizedBox(
                height: 64.0,
              ),
              if (_supportState == _SupportState.unknown)
                const CircularProgressIndicator()
              else if (_supportState == _SupportState.supported)
                InkWell(
                  onTap: ()=>_authenticate(),
                  child: Column(
                    children: [
                      Image.asset("assets/images/login/finger_print.png"),
                      Text('biometricLogin'.tr),
                    ],
                  ),
                )
              // else
              //   const Text('This device is not supported'),

            ],
          ),
        ));
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      // authenticated = await auth.authenticate(
      //   authMessages: [
      //     const AndroidAuthMessages(
      //       biometricHint: " ",
      //       signInTitle: " ",
      //       // deviceCredentialsRequiredTitle: "a",
      //       // biometricRequiredTitle: "b",
      //       // biometricNotRecognized: "c",
      //       // biometricSuccess: "d",
      //       // cancelButton: "e",
      //       // deviceCredentialsSetupDescription: "f",
      //       // goToSettingsButton: "g",
      //       // goToSettingsDescription: "h"
      //
      //     )
      //   ],
      //   localizedReason: ' ',
      //   options: const AuthenticationOptions(
      //     stickyAuth: true,
      //   ),
      // );
    } on PlatformException catch (e) {
      print(e);
      return;
    }
    if (!mounted) {
      return;
    }
    if (authenticated){
      Get.offAndToNamed(RouteNames.mainPage);
    }

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }


  Future<void> _cancelAuthentication() async {
    // await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
