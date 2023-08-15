import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycoach_slic/core/widgets/alert_dialog.dart';
import 'package:mycoach_slic/core/widgets/book_header_widget.dart';
import 'package:mycoach_slic/core/widgets/multi_select_chip.dart';
import 'package:mycoach_slic/core/widgets/search_bar_widget.dart';
import 'package:mycoach_slic/features/custom_menu/document_library/domain/entities/document_library.dart';
import 'package:mycoach_slic/features/custom_menu/document_library/presentation/cubit/document_library_cubit.dart';

import '../../../../../core/widgets/grid_view_widget.dart';

class DocumentLibraryPage extends StatefulWidget {
  const DocumentLibraryPage({super.key});

  @override
  State<DocumentLibraryPage> createState() => _DocumentLibraryPageState();
}

class _DocumentLibraryPageState extends State<DocumentLibraryPage> {
  @override
  void initState() {
    context.read<DocumentLibraryCubit>().handleGetDocumentLibraryList();
    super.initState();
  }

  // This controller will store the value of the search bar
  final TextEditingController searchController = TextEditingController();
  List<String> assetType = [];
  List<String> selectedAssetList = [];
  List<Map<String, dynamic>> categoryAndSubCategories = [];
  List<Map<String, dynamic>> selectedSubcategoriesLibraryContents = [];
  List<Map<String, dynamic>> libraryContents = [];
  bool dataNotPopulatedYet = true;

  void updateSelectedAssetListCallBackFucn(List<String> newList) {
    selectedAssetList = newList;
  }

  void updateSelectedSubCategoriesLibraryContentCallBackFunc(
      List<Map<String, dynamic>> capturedLibraryContents) {
    setState(() {
      selectedSubcategoriesLibraryContents = capturedLibraryContents;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("!!!!!!!!!!!!!!!");
    return Scaffold(
      appBar: AppBar(
        title: BookHeaderWidget(
          bookmark: false,
          bookmarkSelected: (value) {},
          name: 'Video Bytes',
          pageNumber: 12,
          subname: '',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              print(selectedSubcategoriesLibraryContents);
              print(libraryContents);
            },
            icon: const Icon(Icons.abc),
          )
        ],
      ),
      body: BlocBuilder<DocumentLibraryCubit, DocumentLibraryState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DocumentLibraryLoaded) {
            if (dataNotPopulatedYet) {
              populateAssetType(state.documentLibraryList);
              populateCourseContents(state.documentLibraryList);
              populateCategoryAndSubCategories(state.documentLibraryList);
              dataNotPopulatedYet = false;
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomSearchBar(
                    searchController: searchController,
                  ),

                  //   ],
                  // ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => CreateBottomSheet(
                                courseCategoryAndSubCategories:
                                    categoryAndSubCategories,
                                updateSubCategoryLibraryCallBack:
                                    updateSelectedSubCategoriesLibraryContentCallBackFunc,
                              ),
                            );
                            // createBottomSheet(
                            //   context,
                            //   categoryAndSubCategories,
                            // );
                          },
                          child: const Icon(
                            Icons.filter_alt_rounded,
                            size: 30,
                          ),
                        ),
                        MultiSelectChip(
                          assetType,
                          onSelectionChanged: (selectedList) {
                            updateSelectedAssetListCallBackFucn(selectedList);
                          },
                        ),
                      ],
                    ),
                  ),
                  GridViewWidget(
                    allLibraryContents: libraryContents,
                    crossAxisCountcount: 2,
                    selectedLibraryContentsContents:
                        selectedSubcategoriesLibraryContents,
                    selectedAssetList: selectedAssetList,
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void populateAssetType(List<DocumentLibrary> documentLibraryList) {
    for (var documentLibrary in documentLibraryList) {
      for (var content in documentLibrary.contents) {
        if (!assetType.contains(content['accept_type'])) {
          assetType.add(content['accept_type']);
        }
      }
    }
  }

  void populateCourseContents(List<DocumentLibrary> documentLibraryList) {
    for (var documentLibrary in documentLibraryList) {
      libraryContents.addAll(documentLibrary.contents);
    }
  }

  void populateCategoryAndSubCategories(
      List<DocumentLibrary> documentLibraryList) {
    for (var documentLibrary in documentLibraryList) {
      categoryAndSubCategories.add({
        'categoryname': documentLibrary.categoryname,
        'subcategories': documentLibrary.subCategories
      });
    }
  }

  void filterselectedAssetList() {}
}
