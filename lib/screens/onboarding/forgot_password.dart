import 'package:flutter/material.dart';
import '../../components/reusable-text-form-field.dart';
import '../../util/constants/constants.dart';
import '../../util/size-config.dart';

class ForgotPassword extends StatefulWidget {

  static const String id = "forgotPassword";
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  /// TextEditingController for email address
  final TextEditingController _emailAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    SizeConfig().init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/jpegs/login-decorated-screen.png'
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forgot your password?',
                  textAlign: TextAlign.center,
                  style: textTheme.headline4!.copyWith(fontSize: 30),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.0),
                  child: Text(
                    'Enter your Email and we will send a link to your registered email',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText1!,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  textEditingController: _emailAddressController,
                  onChanged: (value) { },
                  hintText: 'Enter Email Address',
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 30),
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                  },
                  child: const Text(
                    'Send Recovery Email',
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Back to Login',
                      textAlign: TextAlign.center,
                      style: textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
