import 'package:flex_my_way/components/dropdown-field.dart';
import 'package:flex_my_way/components/button.dart';
import 'package:flex_my_way/components/text-form-field.dart';
import 'package:flex_my_way/screens/host/host_a_flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';

class HostRegistration extends StatefulWidget {

  static const String id = "hostRegistration";
  const HostRegistration({Key? key}) : super(key: key);

  @override
  _HostRegistrationState createState() => _HostRegistrationState();
}

class _HostRegistrationState extends State<HostRegistration> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for host name
  final TextEditingController _hostNameController = TextEditingController();

  /// A [TextEditingController] to control the input text for host email
  final TextEditingController _hostEmailAddressController = TextEditingController();

  /// A [TextEditingController] to control the input text for host password
  final TextEditingController _passwordController = TextEditingController();

  /// A [TextEditingController] to control the input text for host phone number
  final TextEditingController _hostPhoneNumberController = TextEditingController();

  /// A [TextEditingController] to control the input text for host phone number
  final TextEditingController _bvnController = TextEditingController();

  /// Bool value to hold the obscure state for password
  bool _obscureText = true;

  /// Function to get the formatted date for date time picker
  String _formatDate(DateTime date) {
    return DateFormat.yMd('en_US').format(date);
  }

  @override
  void initState() {
    // _formatDate();
    super.initState();
  }

  // final genderState = useState('Male');
  // final occupationState = useState('Architect');
  // final ValueNotifier<DateTime?> dateOfBirthState = useState(null);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: const [
          Icon(
            Icons.close,
            color: neutralColor,
          ),
          SizedBox(width: 24),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: AppStrings.hostName,
                    textEditingController: _hostNameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {},
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.hostEmailAddress,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {},
                    textEditingController: _hostEmailAddressController,
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.password,
                    obscureText: _obscureText,
                    validator: (value) {},
                    textEditingController: _passwordController,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() => _obscureText = !_obscureText);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,13 ,10 ,0),
                        child: Text(
                          _obscureText == true ? 'SHOW' : 'HIDE',
                          style: textTheme.button!.copyWith(
                            fontSize: 17,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.hostPhoneNumber,
                    keyboardType: TextInputType.number,
                    validator: (value) {},
                    onChanged: (value) {},
                    textEditingController: _hostPhoneNumberController,
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.gender,
                    items: genders,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.occupation,
                    items: occupations,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  // InkWell(
                  //   onTap: () async {
                  //     dateOfBirthState.value = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime(1900),
                  //       lastDate: DateTime.now(),
                  //     );
                  //   },
                  //   child: Container(
                  //     height: 60,
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: neutralColor)),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           dateOfBirthState.value.toString() == 'null'
                  //               ? AppStrings.dateOfBirth
                  //               : viewModel.formatDate(dateOfBirthState.value!),
                  //           style: textTheme.bodyText2,
                  //         ),
                  //         SvgPicture.asset(calendar)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    hintText: AppStrings.yourBVN,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    textEditingController: _bvnController,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: neutralColor,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(uploadIcon),
                            const SizedBox(height: 8),
                            const Text(
                              AppStrings.uploadYourID,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Button(
                    label: AppStrings.signUp,
                    onPressed: () {
                      Navigator.pushNamed(context, HostAFlex.id);
                    },
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
