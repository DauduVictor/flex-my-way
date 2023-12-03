import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../networking/flex-datasource.dart';
import 'package:flex_my_way/model/model.dart';

class FlexHistoryImageArchive extends StatefulWidget {
  static const String id = 'flexHistoryImageArchive';
  final String? flexTag;

  const FlexHistoryImageArchive({
    Key? key,
    this.flexTag,
  }) : super(key: key);

  @override
  State<FlexHistoryImageArchive> createState() =>
      _FlexHistoryImageArchiveState();
}

class _FlexHistoryImageArchiveState extends State<FlexHistoryImageArchive> {
  /// dynamic variable to hold an instance of flexDataSource
  var api = FlexDataSource();

  List<FlexeryModel> flexery = [];

  @override
  void initState() {
    getFlexeryByHashTag();
    super.initState();
  }

  /// Variable to hold the state of the spinner
  bool showSpinner = false;

  ///Function to get images by search
  void getFlexeryByHashTag() async {
    setState(() => showSpinner = true);
    await api.getFlexeryByHashTag(widget.flexTag!).then((value) {
      setState(() {
        showSpinner = false;
        flexery = value;
      });
    }).catchError((e) {
      setState(() => showSpinner = false);
      print(':::error: $e');
      Functions.showToast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: Text(
          'Flex archive',
          style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: showSpinner == false
          ? Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 15, 0),
              child: GridView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _showImageDialog(flexery, index, context);
                    },
                    child: Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: CachedNetworkImage(
                        alignment: Alignment.topCenter,
                        imageUrl: flexery[index].url!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return SpinKitCircle(
                            color: primaryColor.withOpacity(0.7),
                            size: 30,
                          );
                        },
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: neutralColor.withOpacity(0.4),
                          size: 30,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                itemCount: flexery.length,
                padding: const EdgeInsets.only(bottom: 12),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
              ),
            )
          : Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.35),
                SpinKitCircle(
                  color: primaryColor.withOpacity(0.9),
                  size: 45,
                ),
              ],
            ),
    );
  }

  ///widget to show the dialog for image
  Future<void> _showImageDialog(
      List<FlexeryModel> flexery, int position, BuildContext context) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: neutralColor.withOpacity(0.4),
        transitionBuilder: (context, animation, secondaryAnimation, widget) {
          return Transform.translate(
            offset: Offset(0, 10 * animation.value),
            child: StatefulBuilder(builder: (context, stateSetter) {
              return Stack(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 60, horizontal: 2),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(
                                    Icons.close,
                                    color: whiteColor,
                                    size: 31,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CarouselSlider(
                              options: CarouselOptions(
                                initialPage: position,
                                autoPlay: false,
                                viewportFraction: 1,
                                height: SizeConfig.screenHeight! * 0.72,
                              ),
                              items: flexery.map((e) {
                                return CachedNetworkImage(
                                  alignment: Alignment.topCenter,
                                  imageUrl: e.url!,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) {
                                    return SpinKitCircle(
                                      color: primaryColor.withOpacity(0.7),
                                      size: 30,
                                    );
                                  },
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: neutralColor.withOpacity(0.4),
                                    size: 30,
                                  ),
                                  height: SizeConfig.screenHeight! * 0.7,
                                  fit: BoxFit.cover,
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                  /*Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (position < flexery.length -1) {
                            stateSetter(() {
                              position += 1;
                            });
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent.withOpacity(0.1),
                          radius: 22,
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 21,
                          ),
                        ),
                      ),
                    ),*/
                ],
              );
            }),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }
}
