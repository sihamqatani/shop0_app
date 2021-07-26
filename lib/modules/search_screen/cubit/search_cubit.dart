import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop01_app/models/search_model.dart';
import 'package:shop01_app/modules/search_screen/cubit/search_states.dart';
import 'package:shop01_app/shared/network/components/constatnts.dart';
import 'package:shop01_app/shared/network/end_points.dart';
import 'package:shop01_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchDataModel? searchDataModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {'text': text}, token: token)
        .then((value) {
      searchDataModel = SearchDataModel.fromJson(value?.data);
      print('search is success**');

      emit(SearchSuccessState());
    }).catchError((onError) {
      print('error search is.....${onError.toString()}');

      emit(SearchErrorState());
    });
  }
}
