import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../components/reusable-button.dart';
import '../../components/reusable-text-form-field.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';
import 'forgot_password.dart';

class Login extends StatelessWidget {

  static const String id = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// TextEditingController for email address
    final TextEditingController _emailAddressController = TextEditingController();

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
                  'Login',
                  style: textTheme.headline4!.copyWith(fontSize: 30),
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  textEditingController: _emailAddressController,
                  onChanged: (value) { },
                  hintText: 'Your Email Address',
                ),
                CustomTextFormField(
                  textEditingController: _emailAddressController,
                  onChanged: (value) { },
                  hintText: 'Your Password',
                ),
                const SizedBox(height: 24),
                Button(
                  label: 'Log in',
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                    // Navigator.pushNamed(context, HostAFlex.id);
                  },
                ),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    style: textTheme.bodyText1!,
                    children: [
                      const TextSpan(
                        text: 'Forgot your password? ',
                      ),
                      TextSpan(
                        text: 'Click Here',
                        style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ForgotPassword()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Don’t have an account?',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText1!,
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w600,
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