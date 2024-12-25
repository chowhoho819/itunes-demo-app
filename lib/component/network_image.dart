import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  const CachedImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        cacheManager: CacheManager(
          // Limit the cached image store period to avoid image store to gb / tbs.
          Config(
            'itunes-demo-app-caches',
            stalePeriod: Duration(days: 1),
          ),
        ),
      ),
    );
  }
}
