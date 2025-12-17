import 'dart:math';
import 'package:flutter/material.dart';

class PostCardWidget extends StatelessWidget {
  final String title;
  final String body;


  const PostCardWidget({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final likes = random.nextInt(500);
    final comments = random.nextInt(200);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 77, 75, 75).withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(3, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey[600]!,
              ),
            ),
            const SizedBox(height: 8),
            Divider(color: Colors.grey[200]!),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite_outline_outlined,
                      color: Colors.grey[500]!,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(likes.toString()),
                  ],
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    Icon(
                      Icons.mode_comment_outlined,
                      color: Colors.grey[500]!,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(comments.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
