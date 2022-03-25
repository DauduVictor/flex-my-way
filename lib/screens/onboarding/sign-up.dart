import 'package:flutter/material.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/dropdown-field.dart';
import '../../components/text-form-field.dart';
import '../../networking/user-datasource.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class SignUp extends StatefulWidget {

  static const String id = "signUp";
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// TextEditingController for email address
  final TextEditingController _emailAddressController = TextEditingController();

  /// TextEditingController for email address
  final TextEditingController _passwordController = TextEditingController();

  /// TextEditingController for email address
  final TextEditingController _confirmPasswordController = TextEditingController();

  /// A [TextEditingController] to control the input text for host name
  final TextEditingController _nameController = TextEditingController();

  /// A [TextEditingController] to control the input text for host phone number
  final TextEditingController _phoneNumberController = TextEditingController();

  /// A variable to hold the type of flex
  String _typeOfFlex = '';

  /// A variable to hold the gender
  String _gender = '';

  /// A variable to hold the occupation
  String _occupation = '';

  /// A variable to hold the info source
  String _infoSource = '';

  /// Bool value to hold the obscure state for password
  bool _obscurePassword = true;

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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 50, 40, 10),
                child: Text(
                  'Sign Up',
                  style: textTheme.headline4!.copyWith(fontSize: 30),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(loginDecoratedImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          _buildForm(textTheme),
                          const SizedBox(height: 16),
                          Button(
                            label: 'Sign Up',
                            onPressed: () {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                              if(_formKey.currentState!.validate()){
                                _signUp();
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
                          Text(
                            'Already have an account?',
                            textAlign: TextAlign.center,
                            style: textTheme.headline5!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: textTheme.headline5!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
          /// name
          CustomTextFormField(
            textEditingController: _nameController,
            hintText: 'Your Name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value.length < 2){
                return 'This field is required';
              }
              return null;
            },
          ),
          /// email address
          CustomTextFormField(
            textEditingController: _emailAddressController,
            hintText: 'Your Email Address',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value.length < 3 || !value.contains('@') || !value.contains('.')){
                return 'This field is required';
              }
              return null;
            },
          ),
          /// password
          CustomTextFormField(
            textEditingController: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            hintText: 'Create Password',
            suffix: GestureDetector(
              onTap: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,17.5 ,10 ,0),
                child: Text(
                  _obscurePassword == true ? 'SHOW' : 'HIDE',
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
              if(value.length < 4){
                return 'Password length too short';
              }
              return null;
            },
          ),
          /// confirm password
          CustomTextFormField(
            textEditingController: _confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            textInputAction: TextInputAction.next,
            hintText: 'Confirm Password',
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              if(value != _passwordController.text) {
                return 'Confirm your password';
              }
              return null;
            },
          ),
          /// phone number
          CustomTextFormField(
            textEditingController: _phoneNumberController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            hintText: 'Your Phone Number',
            validator: (value) {
              if(value!.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          /// gender
          CustomDropdownButtonField(
            hintText: AppStrings.gender,
            items: genders,
            onChanged: (value) {
              value = value.toString();
              setState(() {
                _gender = value.toString();
              });
            },
            validator: (value) {
              if (_gender.isEmpty) {
                return 'This field is required';
              }
            },
          ),
          /// occupation
          CustomDropdownButtonField(
            hintText: AppStrings.occupation,
            items: occupations,
            onChanged: (value) {
              value = value.toString();
              setState(() {
                _occupation = value.toString();
              });
            },
            validator: (value) {
              if (_occupation.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          /// preferredFlex
          CustomDropdownButtonField(
            hintText: AppStrings.typeOfFlex,
            items: preferredFlex,
            onChanged: (value) {
              value = value.toString();
              setState(() {
                _typeOfFlex = value.toString();
              });
            },
            validator: (value) {
              if (_typeOfFlex.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          /// infoSource
          CustomDropdownButtonField(
            hintText: 'How did you hear about us',
            items: infoSource,
            onChanged: (value) {
              value = value.toString();
              setState(() {
                _infoSource = value.toString();
              });
            },
            validator: (value) {
              if (_infoSource.isEmpty) {
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
  void _signUp() async {
    if(!mounted) return;
    setState(() => _showSpinner = true);
    var api = UserDataSource();
    Map<String, String> body = {
      'name': _nameController.text,
      'phone': _phoneNumberController.text,
      'email' : _emailAddressController.text,
      'password' : _passwordController.text,
      'gender': _gender,
      'preferredFlex': _typeOfFlex,
      'infoSource': _infoSource,
      'occupation': _occupation
    };
    await api.signUp(body).then((value) async {
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage('Registration Successful');
    }).catchError((e){
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage('It seems a user exists with those details. Try again!');
      print(e);
    });
  }
}
