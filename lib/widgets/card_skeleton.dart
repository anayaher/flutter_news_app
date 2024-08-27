import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class NewsCardSkeleton extends StatelessWidget {
  const NewsCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 0.2,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  height: 150,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 10),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 20,
                  width: 200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 16,
                  width: 100,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 16,
                  width: 150,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 16,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 16,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
