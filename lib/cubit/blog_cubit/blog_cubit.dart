import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tsi_mobile/models/models.dart';
import 'package:tsi_mobile/services/services.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitial());

  Future<void> getBlogs({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<Blog>> result = await BlogServices.getBlog(body);

    print(result);

    if (result.value != null) {
      emit(BlogLoaded(result.value));
    } else {
      emit(BlogLoadingFailed(result.message));
    }
  }

  Future<void> getSearchBlogs({@required Map<String, dynamic> body}) async {
    ApiReturnValue<List<Blog>> result = await BlogServices.getSearchBlog(body);

    print(result);

    if (result.value != null) {
      emit(BlogLoaded(result.value));
    } else {
      emit(BlogLoadingFailed(result.message));
    }
  }
}
