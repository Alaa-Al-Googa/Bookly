import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/core/utils/styles.dart';
import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:bookly/features/search/data/repos/search_repo_impl.dart';
import 'package:bookly/features/search/presentation/view/widgets/custom_search_text_field.dart';
import 'package:bookly/features/search/presentation/view/widgets/search_result_list_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final searchRepo = SearchRepoImpl(ApiService(Dio()));
  List<BookModel> searchResults = [];
  bool isLoading = false;
  String errorMessage = '';

  void onSearchChanged(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        errorMessage = '';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final result = await searchRepo.fetchSearchBooks(query: query);

    result.fold(
      (failure) => setState(() {
        errorMessage = failure.errMessage;
        searchResults = [];
        isLoading = false;
      }),
      (books) => setState(() {
        searchResults = books;
        isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextField(onChanged: onSearchChanged),
          const SizedBox(height: 16),
          Text('Search Result', style: Styles.TextStyle18),
          const SizedBox(height: 16),
          if (isLoading) const LinearProgressIndicator(),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(child: SearchResultListView(books: searchResults)),
        ],
      ),
    );
  }
}
