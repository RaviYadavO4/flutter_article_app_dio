import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Show 10 shimmer items while loading
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Container(
                  color: Colors.white,
                  height: 16,
                  width: double.infinity,
                ),
                subtitle: Container(
                  color: Colors.white,
                  height: 14,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
