import 'package:flex_my_way/screens/onboarding/reset-password.dart';
import 'package:flutter/material.dart';
import '../../bloc/future-values.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/text-form-field.dart';
import '../../model/user.dart';
import '../../networking/user-datasource.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/size-config.dart';

class ForgotPassword extends StatefulWidget {

  static const String id = "forgotPassword";
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  /// Instantiating a class of the [FutureValues]
  var futureValues = FutureValues();

  /// Instantiating the user model
  var user = User();

  /// Function to get user details from the database
  void _getCurrentUser() async {
    if(!mounted) return;
    await futureValues.getCurrentUser().then((user) {
      setState(() {
        _emailAddressController.text = user.email!;
      });
    }).catchError((e){
      print(e);
    });
  }

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// TextEditingController for email address
  final TextEditingController _emailAddressController = TextEditingController();

  /// Variable to hold the bool value of show spinner
  bool _showSpinner = false;

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

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
        child: AbsorbPointer(
          absorbing: _showSpinner,
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
                  Form(
                    key: _formKey,
                    child: CustomTextFormField(
                      textEditingController: _emailAddressController,
                      hintText: 'Your Email Address',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'This field is required';
                        }
                        if(value.length < 3 || !value.contains('@')){
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Button(
                    label: 'Send Recovery Email',
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                      if(_formKey.currentState!.validate()){
                        _forgotPassword();
                      }
                    },
                    child: _showSpinner == true
                        ? const SizedBox(
                        height: 21,
                        width: 19,
                        child: CircleProgressIndicator())
                        : null,
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
      ),
    );
  }

  /// Function to make api call for forgotPassword
  void _forgotPassword() async {
    if(!mounted) return;
    setState(() => _showSpinner = true);
    var api = UserDataSource();
    Map<String, String> body = {
      'email' : _emailAddressController.text
    };
    await api.forgotPassword(body).then((value) async {
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage(value);
      Navigator.pushNamed(context, ResetPassword.id);
    }).catchError((e){
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage(e);
      print(e);
    });
  }

}
