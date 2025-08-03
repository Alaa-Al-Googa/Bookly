import 'package:bookly/core/utils/launch_url.dart';
import 'package:bookly/core/utils/widget/custom_botton.dart';
import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key, required this.bookModel});
  final BookModel bookModel;

  String getText(BookModel bookModel) {
    if (bookModel.volumeInfo.previewLink == null) {
      return 'Not Avaliable';
    } else {
      return 'Preview';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomBotton(
              textcolor: Colors.black,
              backgroungcolor: Colors.white,
              text: '19.19',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: CustomBotton(
              onPressed: () async {
                launchCustomUrl(context, bookModel.volumeInfo.previewLink);
              },
              fontSize: 16,
              textcolor: Colors.white,
              backgroungcolor: Color(0xffEF8262),
              text: getText(bookModel),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
