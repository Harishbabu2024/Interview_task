import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/post_cubit.dart';
import 'package:task/data/post_state.dart';
import 'package:task/service/api_service.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/widgets/app_bar.dart';
import 'package:task/widgets/post_card_widget.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(ApiService())..fetchPosts(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppNavigationBar(title: "Post Page"),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<PostCubit>().fetchPosts();
              },
              child: BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
                  }
                  if (state is PostLoaded) {
                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return PostCardWidget(
                          title: post.title ?? "",
                          body: post.body ?? "",
                          
                        );
                      },
                    );
                  }

                  if (state is PostError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
