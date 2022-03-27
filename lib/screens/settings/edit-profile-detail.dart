import 'package:flex_my_way/networking/user-datasource.dart';
import 'package:flex_my_way/util/constants/strings.dart';
import 'package:flutter/material.dart';
import '../../bloc/future-values.dart';
import '../../components/app-bar.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/dropdown-field.dart';
import '../../components/text-form-field.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/size-config.dart';

class EditProfileDetail extends StatefulWidget {

  static const String id = "editProfileDetail";
  const EditProfileDetail({Key? key}) : super(key: key);

  @override
  _EditProfileDetailState createState() => _EditProfileDetailState();
}

class _EditProfileDetailState extends State<EditProfileDetail> {

  /// Instantiating a class of the [FutureValues]
  var futureValues = FutureValues();

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for name
  final TextEditingController _nameController = TextEditingController();

  /// A [TextEditingController] to control the input text for email address
  final TextEditingController _emailAddressController = TextEditingController();

  /// A [TextEditingController] to control the input text for phone number
  final TextEditingController _phoneNumberController = TextEditingController();

  /// A [TextEditingController] to control the input text for occupation
  final TextEditingController _occuapationController = TextEditingController();

  /// Variable to hold the value of the gender
  String _gender = genders[0];

  /// Variable to hold the value of the gender
  String _preferredFlex = preferredFlex[0];

  /// Variable to hold the bool value of the spinner
  bool _showSpinner = false;

  /// Function to get user details from the database
  void _getCurrentUser() async {
    if(!mounted) return;
    await futureValues.getCurrentUser().then((user) {
      setState(() {
        _nameController.text = user.name!;
        _emailAddressController.text = user.email!;
        _phoneNumberController.text = user.phone!;
        _gender = user.gender!;
        _occuapationController.text = user.occupation!;
        _preferredFlex = user.preferredFlex!;
      });
    }).catchError((e){
      print(e);
    });
  }

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, AppStrings.editProfileDetails),
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
              padding: const EdgeInsets.fromLTRB(24, 25, 24, 20),
              child: Column(
                children: [
                  Text(
                    'See something wrong?\nChange it below',
                    textAlign: TextAlign.center,
                    style: textTheme.button!.copyWith(
                      color: neutralColor.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: 'Your Name',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          textEditingController: _nameController,
                        ),
                        CustomTextFormField(
                          hintText: 'Your Email Address',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: _emailAddressController,
                        ),
                        CustomTextFormField(
                          hintText: 'Your Phone Number',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textEditingController: _phoneNumberController,
                        ),
                        CustomDropdownButtonField(
                          hintText: 'Select a Gender',
                          items: genders,
                          value: _gender,
                          onChanged: (value) {
                            _gender = value.toString();
                          },
                        ),
                        CustomTextFormField(
                          hintText: 'Your Occupation',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          textEditingController: _occuapationController,
                        ),
                        CustomDropdownButtonField(
                          hintText: 'What type of flex are you interested in?',
                          items: preferredFlex,
                          value: _preferredFlex,
                          onChanged: (value) {
                            _preferredFlex = value.toString();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Button(
                    label: AppStrings.save,
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                      if(_formKey.currentState!.validate()){
                        updateUserInfo();
                      }
                    },
                    child: _showSpinner == true
                      ? const SizedBox(
                        height: 21,
                        width: 19,
                        child: CircleProgressIndicator()
                      )
                      : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateUserInfo() async{
    if(!mounted) return;
    setState(() => _showSpinner = true);
    var api = UserDataSource();
    Map<String, dynamic> body = {
      'name': _nameController.text,
      'email': _emailAddressController.text,
      'phone': _phoneNumberController.text,
      'gender': _gender,
      'occupation': _occuapationController.text,
      'preferredFlex': _preferredFlex,
    };
    print(body);
    await api.updateUserInfo(body).then((value) {
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage('Your details have been updated successfully');
    }).catchError((e){
      if(!mounted) return;
      setState(() => _showSpinner = false);
      Functions.showMessage(e);
    });
  }
}
