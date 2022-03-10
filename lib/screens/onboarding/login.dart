import 'package:flex_my_way/networking/user-datasource.dart';
import 'package:flex_my_way/screens/dashboard/dashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/text-form-field.dart';
import '../../database/user-db-helper.dart';
import '../../model/user.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/size-config.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {

  static const String id = 'login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  /// Instantiating the user model
  var user = User();

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// TextEditingController for email address
  final TextEditingController _emailAddressController = TextEditingController();

  /// TextEditingController for email address
  final TextEditingController _passwordController = TextEditingController();

  /// Variable to hold the bool value of show spinner
  bool _showSpinner = false;

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
                      'Login',
                      style: textTheme.headline4!.copyWith(fontSize: 30),
                    ),
                    const SizedBox(height: 32),
                    _buildForm(),
                    const SizedBox(height: 24),
                    Button(
                      label: 'Log in',
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                        if(_formKey.currentState!.validate()){
                          _login();
                        }
                      },
                      child: _showSpinner == true
                        ? const SizedBox(
                          height: 19,
                          width: 19,
                          child: CircleProgressIndicator())
                        : null,
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
                              Navigator.pushNamed(context, ForgotPassword.id);
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
        ),
      ),
    );
  }

  /// Widget to hold the form container
  Widget _buildForm () {
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
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          CustomTextFormField(
            textEditingController: _passwordController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            hintText: 'Your Password',
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
  void _login() async {
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
      var db = DatabaseHelper();
      await db.initDb();
      await db.saveUser(user);
      _addBoolToSP(user);
    }).catchError((e){
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showErrorMessage(e);
      print(e);
    });
  }

  /// This function adds a true boolean value to show user is logged in and also
  /// saves token as reference from the [user] model using [SharedPreferences]
  /// It moves to the [Dashboard] after saving those details
  _addBoolToSP(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);
    Navigator.pushNamed(context, Dashboard.id);
  }
}