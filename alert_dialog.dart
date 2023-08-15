import 'package:flutter/material.dart';

import '../theme/media_query.dart';

showAlertDialog(BuildContext context, String title, String content) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class CreateBottomSheet<T> extends StatefulWidget {
  final List<T> courseCategoryAndSubCategories;
  final ValueChanged<List<Map<String, dynamic>>>
      updateSubCategoryLibraryCallBack;
  const CreateBottomSheet(
      {super.key,
      required this.courseCategoryAndSubCategories,
      required this.updateSubCategoryLibraryCallBack});

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  final ValueNotifier subCategoryColumnWidgetUpdater =
      ValueNotifier<bool>(false);
  int selectedIndex = 0;
  String? selectedSubcategoryRadioTile;
  List<Map<String, dynamic>> selectedLibraryContents = [];

  @override
  void dispose() {
    subCategoryColumnWidgetUpdater.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueries.mediaQueryHeight! / 2,
      child: TweenAnimationBuilder<double?>(
          duration: const Duration(seconds: 2),
          tween: Tween(begin: 1.0, end: 0),
          curve: Curves.elasticOut,
          child: Container(
            height: MediaQueries.mediaQueryHeight! / 2,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQueries.mediaQueryHeight! / 2,
                          width: MediaQueries.mediaQueryWidth! / 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget
                                    .courseCategoryAndSubCategories.length,
                                itemBuilder: (builder, index) {
                                  return TextButton(
                                    onPressed: () {
                                      //1. Updating the selected Index to show the subcategories
                                      //2. Updating notifier to rebuild only this specific listview builder
                                      selectedIndex = index;

                                      subCategoryColumnWidgetUpdater.value =
                                          !subCategoryColumnWidgetUpdater.value;
                                    },
                                    child: Text(
                                        "${widget.courseCategoryAndSubCategories[index]['categoryname']}"),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQueries.mediaQueryHeight! / 2.5,
                                width: MediaQueries.mediaQueryWidth! / 2,
                                child: ValueListenableBuilder(
                                  valueListenable:
                                      subCategoryColumnWidgetUpdater,
                                  builder: (context, value, child) {
                                    if ((widget.courseCategoryAndSubCategories[
                                                selectedIndex]['subcategories'])
                                            .length >
                                        0) {
                                      return ListView.builder(
                                        itemCount: widget
                                            .courseCategoryAndSubCategories[
                                                selectedIndex]['subcategories']
                                            .length,
                                        shrinkWrap: true,
                                        itemBuilder: (builder, index) {
                                          return RadioListTile<String>(
                                            title: FittedBox(
                                              child: Text(
                                                  "${widget.courseCategoryAndSubCategories[selectedIndex]['subcategories'][index]['child_name']}"),
                                            ),
                                            value:
                                                "${widget.courseCategoryAndSubCategories[selectedIndex]['subcategories'][index]['child_name']}",
                                            groupValue:
                                                selectedSubcategoryRadioTile,
                                            onChanged: (String? value) {
                                              selectedLibraryContents.clear();
                                              selectedLibraryContents.addAll(List<
                                                      Map<String,
                                                          dynamic>>.from(
                                                  widget.courseCategoryAndSubCategories[
                                                              selectedIndex]
                                                          ['subcategories']
                                                      [index]['content']));

                                              selectedSubcategoryRadioTile =
                                                  value;
                                              subCategoryColumnWidgetUpdater
                                                      .value =
                                                  !subCategoryColumnWidgetUpdater
                                                      .value;
                                            },
                                          );
                                        },
                                      );
                                    } else {
                                      return const ListTile(
                                        title: Text('No Sub Category'),
                                      );
                                    }
                                  },
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  widget.updateSubCategoryLibraryCallBack(
                                      selectedLibraryContents);
                                },
                                child: const Text('Apply'),
                              )
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
          builder: (context, value, _) {
            return Transform.translate(
              offset: Offset(0.0, -100 * value!),
              child: _,
            );
          }),
    );
  }
}

// createBottomSheet(
//   BuildContext context,
//   List<Map<String, dynamic>> courseCategoryAndSubCategories,
// ) {
//   return Scaffold.of(context).showBottomSheet(
//       backgroundColor: Colors.transparent,
//       elevation: 10, (BuildContext context) {
//     int selectedIndex = 0;
//     return StatefulBuilder(
//       builder: (context, stateUpdater) => SizedBox(
//         height: MediaQueries.mediaQueryHeight! / 2,
//         child: TweenAnimationBuilder<double?>(
//             duration: const Duration(seconds: 2),
//             tween: Tween(begin: 1.0, end: 0),
//             curve: Curves.elasticOut,
//             child: Container(
//               height: MediaQueries.mediaQueryHeight! / 2,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//                 color: Colors.grey,
//               ),
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       icon: const Icon(Icons.close),
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: MediaQueries.mediaQueryHeight! / 2,
//                             width: MediaQueries.mediaQueryWidth! / 3,
//                             decoration: BoxDecoration(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                               ),
//                               color: Colors.grey[300],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(0),
//                               child: ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount:
//                                       courseCategoryAndSubCategories.length,
//                                   itemBuilder: (builder, index) {
//                                     return TextButton(
//                                       onPressed: () {
//                                         //FIXME CONTINE FROM HERE bottom sheet not updating
//                                         print(courseCategoryAndSubCategories[
//                                             index]['subcategories']);
//                                         stateUpdater(
//                                           () {
//                                             selectedIndex = index;
//                                           },
//                                         );
//                                       },
//                                       child: Text(
//                                           "${courseCategoryAndSubCategories[index]['categoryname']}"),
//                                     );
//                                   }),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 courseCategoryAndSubCategories[selectedIndex]
//                                                 ['subcategories']
//                                             .length !=
//                                         0
//                                     ? SizedBox(
//                                         height: MediaQueries.mediaQueryHeight! /
//                                             2.5,
//                                         width:
//                                             MediaQueries.mediaQueryWidth! / 2,
//                                         child: ListView.builder(
//                                           itemCount:
//                                               courseCategoryAndSubCategories[
//                                                           selectedIndex]
//                                                       ['subcategories']
//                                                   .length,
//                                           shrinkWrap: true,
//                                           itemBuilder: (builder, index) {
//                                             ListTile(
//                                               title: Text(
//                                                   "${courseCategoryAndSubCategories[selectedIndex]['subcategories'][0]['child_name']}"),
//                                             );
//                                             return null;
//                                           },
//                                         ),
//                                       )
//                                     : const Text('No Sub Categories Available'),
//                               ],
//                             ),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             builder: (context, value, _) {
//               return Transform.translate(
//                 offset: Offset(0.0, -100 * value!),
//                 child: _,
//               );
//             }),
//       ),
//     );
//   });
// }

// class ScrollableBottomSheet extends StatefulWidget {
//   final Widget child;

//   const ScrollableBottomSheet({super.key, required this.child});

//   @override
//   _ScrollableBottomSheetState createState() => _ScrollableBottomSheetState();
// }

// class _ScrollableBottomSheetState extends State<ScrollableBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Close the bottom sheet when tapping outside the content area
//         Navigator.of(context).pop();
//       },
//       child: DraggableScrollableSheet(
//         initialChildSize: 0.8, // Initial size of the sheet when expanded
//         minChildSize: 0.4, // Minimum size of the sheet when collapsed
//         maxChildSize: 0.9, // Maximum size of the sheet when expanded
//         builder: (context, scrollController) {
//           return ListView(
//             controller: scrollController,
//             children: <Widget>[
//               widget.child, // Your content goes here
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
