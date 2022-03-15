import 'package:flex_my_way/util/constants/strings.dart';
import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/text-form-field.dart';
import '../../networking/user-datasource.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/size-config.dart';

class ResetPassword extends StatefulWidget {

  static const String id = "resetPassword";
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// TextEditingController for email address
  final TextEditingController _emailAddressController = TextEditingController();

  /// TextEditingController for email address
  final TextEditingController _passwordController = TextEditingController();

  /// Variable to hold the bool value of show spinner
  bool _showSpinner = false;

  ///Variable to hold the bool value of password field obscure text
  bool _obscureText = true;

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
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(loginDecoratedImage),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.resetPassword,
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
                    _buildForm(textTheme),
                    const SizedBox(height: 24),
                    Button(
                      label: AppStrings.resetPassword,
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                        if(_formKey.currentState!.validate()){
                          _resetPassword();
                        }
                      },
                      child: _showSpinner == true
                          ? const SizedBox(
                              height: 21,
                              width: 19,
                              child: CircleProgressIndicator())
                          : null,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget to hold the form container
  Widget _buildForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
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
          CustomTextFormField(
            textEditingController: _passwordController,
            keyboardType: TextInputType.text,
            obscureText: _obscureText,
            textInputAction: TextInputAction.done,
            hintText: 'Your Password',
            suffix: GestureDetector(
              onTap: () {
                setState(() => _obscureText = !_obscureText);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,17.5 ,10 ,0),
                child: Text(
                  _obscureText == true ? 'SHOW' : 'HIDE',
                  style: textTheme.button!.copyWith(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Function to make api call to login
  void _resetPassword() async {
    if(!mounted) return;
    setState(() => _showSpinner = true);
    var api = UserDataSource();
    Map<String, String> body = {
      'email' : _emailAddressController.text,
      'password' : _passwordController.text
    };
    await api.signIn(body).then((value) async {
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage(value);
    }).catchError((e){
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage(e);
      print(e);
    });
  }
}
