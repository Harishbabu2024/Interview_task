import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/post_state.dart';
import 'package:task/model/post_model.dart';
import 'package:task/utils/app_utils.dart';
import 'package:task/utils/hive_initializer_utils.dart';
import '../service/api_service.dart';

class PostCubit extends Cubit<PostState> {
  final ApiService apiService;

  PostCubit(this.apiService) : super(PostInitial());

  Future<void> fetchPosts() async {
    emit(PostLoading());

    try {
      final posts = await apiService.makeGetRequest<List<PostModel>>(
        (json) => (json as List).map((e) => PostModel.fromJson(e)).toList(),
        null,
      );
      await PostLocalStorage.savePosts(posts);

      emit(PostLoaded(posts));
    } catch (e) {
      if (PostLocalStorage.hasCache()) {
        AppUtils.showToast("You are Offline, Showing cached data");
        emit(PostLoaded(PostLocalStorage.getAllPosts()));
      } else {
        emit(PostError(e.toString()));
      }
    }
  }
}
