import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// A service class for managing caching operations using CacheManager.
class CacheService {
  /// Create a `CacheService` instance with a given [CacheManager].
  const CacheService(this.cacheManager);

  /// The CacheManager instance used for caching operations.
  final CacheManager cacheManager;

  /// Saves data to cache for a specified URL.
  ///
  /// - [url]: The URL identifier for the cached data.
  /// - [data]: The data to be cached.
  ///
  /// This method encodes the provided data as JSON and stores it in the cache.
  Future<void> saveDataToCache(String url, dynamic data) async {
    await cacheManager.putFile(
      url,
      Uint8List.fromList(
        utf8.encode(
          jsonEncode(data),
        ),
      ),
    );
  }

  /// Retrieves data from the cache for a specified URL.
  ///
  /// - [url]: The URL identifier for the cached data.
  ///
  /// This method reads and returns the cached data as a string. If the data is not found in the cache,
  /// an empty string is returned.
  Future<String> getDataFromCache(String url) async {
    final cachedFile = await cacheManager.getFileFromCache(url);

    if (cachedFile != null) {
      final data = await cachedFile.file.readAsString();
      return data;
    } else {
      return '';
    }
  }
}
