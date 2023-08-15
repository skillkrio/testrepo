import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  final int crossAxisCountcount;
  final List<Map<String, dynamic>> allLibraryContents;
  final List<Map<String, dynamic>> selectedLibraryContentsContents;
  final List<String> selectedAssetList;

  const GridViewWidget({
    super.key,
    required this.allLibraryContents,
    required this.selectedLibraryContentsContents,
    this.crossAxisCountcount = 2,
    this.selectedAssetList = const [],
  });

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    print("gggggggggg");
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: widget.crossAxisCountcount,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      children: (widget.selectedLibraryContentsContents.isEmpty
              ? widget.allLibraryContents
              : widget.selectedLibraryContentsContents)
          .map(
        (item) {
          if (widget.selectedAssetList.isNotEmpty) {
            return const Text('');
          } else {
            return InkWell(
              onTap: () {
                // context.push(trainingCatalogDetailViewRoute);
              },
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://images.template.net/27470/Download-Modern-Book-Cover-Template.jpg'),
                              fit: BoxFit.cover)),
                      child: Transform.translate(
                        offset: const Offset(50, -50),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 65, vertical: 63),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const Icon(
                            Icons.bookmark_border,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      color: const Color.fromARGB(94, 65, 64, 63),
                      child: Text(
                        "${item['title']}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ).toList(),
    );
  }
}












// import 'package:flutter/material.dart';

// class GridViewWidget extends StatefulWidget {
//   final List listItem;
//   final String? title;
//   final int count;
//   final bool type;
//   final bool authorVisible;
//   final String authorTitle;
//   final String documentType;
//   const GridViewWidget(
//       {super.key,
//       required this.listItem,
//       this.title,
//       this.count = 2,
//       this.type = false,
//       this.authorVisible = false,
//       this.authorTitle = '',
//       this.documentType = ''});

//   @override
//   State<GridViewWidget> createState() => _GridViewWidgetState();
// }

// class _GridViewWidgetState extends State<GridViewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       shrinkWrap: true,
//       crossAxisCount: widget.count,
//       crossAxisSpacing: 5,
//       mainAxisSpacing: 5,
//       children: widget.listItem
//           .map(
//             (item) => InkWell(
//               onTap: () {
//                 // context.push(trainingCatalogDetailViewRoute);
//               },
//               child: Card(
//                 color: Colors.transparent,
//                 elevation: 0,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           image: DecorationImage(
//                               image: NetworkImage(item), fit: BoxFit.cover)),
//                       child: Transform.translate(
//                         offset: const Offset(50, -50),
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 65, vertical: 63),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white),
//                           child: const Icon(
//                             Icons.bookmark_border,
//                             size: 15,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(5),
//                       color: const Color.fromARGB(94, 65, 64, 63),
//                       child: Text(
//                         widget.title!,
//                         style: const TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }
// }
