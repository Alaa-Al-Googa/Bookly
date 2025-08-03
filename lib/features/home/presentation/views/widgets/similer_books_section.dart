import 'package:bookly/core/utils/styles.dart';
import 'package:bookly/features/home/presentation/views/widgets/similar_books_list_view.dart';
import 'package:flutter/material.dart';

class SimilerBooksSection extends StatelessWidget {
  const SimilerBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'you can also like',
            style: Styles.TextStyle14.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 16),
        SimilarBooksListview(),
      ],
    );
  }
}
