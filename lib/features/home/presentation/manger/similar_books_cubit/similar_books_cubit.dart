import 'package:bloc/bloc.dart';
import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:bookly/features/home/data/repos/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'similar_books_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksState> {
  SimilarBooksCubit(this.homeRepo) : super(SimilarBooksInitial());

  final HomeRepo homeRepo;
  Future<void> fethSimilarBooks({required String categary}) async {
    emit(SimilarBooksLoading());
    var result = await homeRepo.fechSimilarBook(category: categary);
    result.fold(
      (failure) {
        emit(SimilarBooksFailure(failure.errMessage));
      },
      (books) {
        emit(SimilarBooksSuccess(books));
      },
    );
  }
}
