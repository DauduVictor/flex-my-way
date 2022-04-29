import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/circle-indicator.dart';
import '../../controllers/host-controller.dart';
import '../../util/constants/constants.dart';

class ContactScreen extends StatelessWidget {

  static const String id = 'contactScreen';
  ContactScreen({Key? key}) : super(key: key);

  /// calling the [HostController] for [ContactScreen]
  final HostController controller = Get.put(HostController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: Text(
          'Contacts',
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: controller.contact.isNotEmpty
        ? ListView.builder(
            itemCount: controller.contact.length,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = controller.contact.elementAt(index);
              return ListTile(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(contact.avatar!),
                    )
                  : CircleAvatar(
                    child: Text(contact.initials()),
                    backgroundColor: primaryColor,
                  ),
                title: Text(
                  contact.displayName ?? '',
                  style: textTheme.bodyText1,
                ),
                trailing: Obx(() => Checkbox(
                    value: controller.termsAndConditionsAccepted.value,
                    onChanged: (value) {
                      controller.termsAndConditionsAccepted.toggle();
                    },
                  )
                ),
                onTap: () {
                  controller.termsAndConditionsAccepted.toggle();
                },
              );
            },
          )
        : const Center(
            child: CircleProgressIndicator(),
          ),
    );
  }
}
