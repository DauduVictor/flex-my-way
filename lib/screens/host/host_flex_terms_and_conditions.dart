import 'package:flex_my_way/screens/host/host_flex_success.dart';
import 'package:flex_my_way/components/button.dart';
import 'package:flutter/material.dart';
import '../../components/circle-indicator.dart';
import '../../components/text-form-field.dart';
import '../../networking/user-datasource.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class HostFlexTermsAndConditions extends StatefulWidget {

  static const String id = "hostFlexTermsAndConditions";

  final String? paid;
  final Map<String, String>? body;

  const HostFlexTermsAndConditions ({
    Key? key,
    this.paid,
    this.body
  }) : super(key: key);

  @override
  State<HostFlexTermsAndConditions> createState() => _HostFlexTermsAndConditionsState();
}

class _HostFlexTermsAndConditionsState extends State<HostFlexTermsAndConditions> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for bvn
  final TextEditingController _bvnController = TextEditingController();

  /// A variable to hold the bool value of the spinner
  bool _showSpinner = false;

  /// bool value to hold the state of terms and condition
  bool _termsAndConditionsAccepted = false;

  /// bool value to hold the state of privacy policy
  bool _privacyPolicyAccepted = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: AbsorbPointer(
          absorbing: _showSpinner,
          child: SingleChildScrollView(
            child: SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppStrings.termsAndConditions,
                        style: textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight! * 0.47,
                      padding: const EdgeInsets.fromLTRB(2, 24, 2, 10),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(24)),
                      child: const RawScrollbar(
                        thumbColor: primaryColor,
                        radius: Radius.circular(8.0),
                        thickness: 4.0,
                        isAlwaysShown: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: SingleChildScrollView(
                            child: Text(AppStrings.loremIpsum),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    widget.paid == 'Paid'
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Form(
                          key: _formKey,
                          child: CustomTextFormField(
                          hintText: AppStrings.yourBVN,
                          textEditingController: _bvnController,
                            validator: (value) {
                            if(value!.isEmpty && widget.paid == 'Paid') {
                              return 'This field is required';
                            }
                            return null;
                            },
                          ),
                        ),
                      )
                      : Container(),
                    Text(
                      AppStrings.acceptThe,
                      style: textTheme.headline5!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        AppStrings.termsAndConditions,
                        style: textTheme.bodyText2,
                      ),
                      trailing: Checkbox(
                        value: _termsAndConditionsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _termsAndConditionsAccepted = !_termsAndConditionsAccepted;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        AppStrings.privacyPolicy,
                        style: textTheme.bodyText2!,
                      ),
                      trailing: Checkbox(
                        value: _privacyPolicyAccepted,
                        onChanged: (value) {
                          setState(() {
                            _privacyPolicyAccepted = !_privacyPolicyAccepted;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.center,
                      child: Button(
                        label: AppStrings.finish,
                        onPressed: () {
                          if(widget.paid == 'Paid') {
                            if(_formKey.currentState!.validate()) {
                              if(_termsAndConditionsAccepted && _privacyPolicyAccepted) {
                                _hostFlex();
                              }
                            }
                          }
                          else {
                            if(_termsAndConditionsAccepted && _privacyPolicyAccepted) {
                              _hostFlex();
                            }
                          }
                        },
                        child: _showSpinner == false
                            ?  null
                            : const SizedBox(
                                height: 19,
                                width: 19,
                                child: CircleProgressIndicator(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _hostFlex() async {
    if(!mounted) return;
    setState(() => _showSpinner = false);
    var api = UserDataSource();
    if(widget.paid == 'Paid'){
      // widget.body!.addAll('bvn', _bvnController.text);
      print('api call with bvn');
      print(widget.body);
      Navigator.pushNamed(context, HostFlexSuccess.id);
    }
    else {
      // api.signIn(body).then((value) => null);
      print('api call without bvn');
      Navigator.pushNamed(context, HostFlexSuccess.id);
    }
  }
}
