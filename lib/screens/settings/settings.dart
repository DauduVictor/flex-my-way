import 'package:flex_my_way/screens/find-a-flex.dart';
import 'package:flex_my_way/screens/settings/help-and-support.dart';
import 'package:flex_my_way/screens/settings/privacy-policy.dart';
import 'package:flex_my_way/screens/settings/terms-and-condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../components/app-bar.dart';
import '../../components/button.dart';
import '../../components/list-tile-button.dart';
import '../../components/text-form-field.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';
import '../dashboard/drawer.dart';
import 'about.dart';
import 'edit-profile-detail.dart';

class Settings extends StatefulWidget {

  static const String id = "settings";
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  /// Variable to hold the user's name
  String userName = 'there';

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for current password
  final TextEditingController _currentPasswordController = TextEditingController();

  // A [TextEditingController] to control the input text for new password
  final TextEditingController _newPasswordController = TextEditingController();

  /// bool variable to hold the status of show edit password
  bool _showEditPassword = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: buildAppBarWithNotification(textTheme, context, userName),
      drawer: const RefactoredDrawer(),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.fromLTRB(27, 12, 20, 15),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: appBarBottomBorder,
              ),
              child: Text(
                AppStrings.settings,
                style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: ListTileButton(
                title: AppStrings.becomeAHost,
                onPressed: () {},
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: Column(
                    children: [
                      ReusableSettingsButton(
                        name: AppStrings.editProfileDetails,
                        icon: IconlyLight.edit,
                        onPressed: () {
                          Navigator.pushNamed(context, EditProfileDetail.id);
                        },
                      ),
                      ReusableSettingsButton(
                        name: AppStrings.editPassword,
                        icon: IconlyBroken.unlock,
                        onPressed: () {
                          setState(() {
                            _showEditPassword = !_showEditPassword;
                          });
                        },
                      ),
                      _showEditPassword == true
                        ? _showEditPasswordField()
                        : Container(),
                      ReusableSettingsButton(
                        name: AppStrings.inviteYourFriends,
                        icon: Icons.share_outlined,
                        onPressed: () {},
                      ),
                      ReusableSettingsButton(
                        name: AppStrings.about,
                        icon: Icons.lightbulb_outline,
                        onPressed: () {
                          Navigator.pushNamed(context, About.id);
                        },
                      ),
                      ReusableSettingsButton(
                        name: AppStrings.termsAndConditions,
                        icon: IconlyLight.dangerCircle,
                        onPressed: () {
                          Navigator.pushNamed(context, TermsAndCondition.id);
                        },
                      ),
                      ReusableSettingsButton(
                        name: AppStrings.privacyPolicy,
                        icon: IconlyLight.paper,
                        onPressed: () {
                          Navigator.pushNamed(context, PrivacyPolicy.id);
                        },
                      ),
                      ReusableSettingsButton(
                        name: AppStrings.helpAndSupport,
                        icon: IconlyLight.shieldDone,
                        onPressed: () {
                          Navigator.pushNamed(context, HelpAndSupport.id);
                        },
                      ),
                      ReusableSettingsButton(
                        name: AppStrings.logOut,
                        icon: IconlyLight.logout,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, FindAFlex.id);
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Widget to show password edit fields
  Widget _showEditPasswordField () {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 16, 15, 16),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: AppStrings.enterCurrentPassword,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {},
                  textEditingController: _currentPasswordController,
                ),
                CustomTextFormField(
                  hintText: AppStrings.enterNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {},
                  textInputAction: TextInputAction.done,
                  textEditingController: _newPasswordController,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Button(
              onPressed: () { },
              label: AppStrings.save,
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableSettingsButton extends StatelessWidget {

  final String name;
  final IconData icon;
  final void Function() onPressed;

  const ReusableSettingsButton({
    Key? key,
    required this.name,
    required this.icon,
    required this.onPressed
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.black,
            ),
            title: Text(
              name,
              style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
