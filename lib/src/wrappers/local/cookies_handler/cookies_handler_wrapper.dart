import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';

/// Helper class that excplicitly requires Dio http client
class CookiesHandlerWrapper {
  // TODO name could be better here
  const CookiesHandlerWrapper();

  // function to get request options with cookie from getCookie() function in headers
  Future<RequestOptions> getRequestOptionsWithCookieInHeaders({
    required RequestOptions requestOptions,
    required Future<String?> Function() getCookie,
  }) async {
    try {
      final cookieString = await getCookie();
      if (cookieString == null) {
        return requestOptions;
      }

      final cookie = Cookie.fromSetCookieValue(cookieString);
      final clonedRequestOptions = requestOptions.copyWith();
      final headersMap = _getRequestHeadersMapWithAddedCookie(
        headersMap: clonedRequestOptions.headers,
        cookie: cookie,
      );

      final newRequestOptions = clonedRequestOptions.copyWith(
        headers: headersMap,
      );

      return newRequestOptions;
    } catch (e) {
      log("Error getting request options with cookie in headers -> Returning original RequestOptions: $e");
      return requestOptions;
    }
  }

  Future<bool> handleStoreResponseCookie({
    required Response response,
    required String cookieName,
    required Future<void> Function(String cookie) storeCookie,
  }) async {
    final cookies = _getCookiesFromResponse(response: response);
    if (cookies.isEmpty) {
      log("No cookies found in response");
      return false;
    }

    final foundCookie =
        cookies.firstWhereOrNull((cookie) => cookie.name == cookieName);
    if (foundCookie == null) {
      log("No cookie found by name: $cookieName");
      return false;
    }

    try {
      final cookieString = foundCookie.toString();
      await storeCookie(cookieString);

      return true;
    } catch (e) {
      log("Error storing cookie: $e");
      return false;
    }
  }

  List<Cookie> _getCookiesFromResponse({
    required Response response,
  }) {
    final headersMap = response.headers.map;
    final cookiesStrings = headersMap["set-cookie"];

    if (cookiesStrings == null) {
      return [];
    }

    if (cookiesStrings.isEmpty) {
      return [];
    }

    final cookies = cookiesStrings.map((cs) {
      try {
        final cookie = Cookie.fromSetCookieValue(cs);
        return cookie;
      } catch (e) {
        return null;
      }
    }).toList();

    final validCookies = cookies.whereNotNull().toList();

    return validCookies;
  }

  Map<String, Cookie> _getCookiesMapFromString({
    required String rawCookiesString,
  }) {
    final regex = RegExp('(?:[^,]|, )+');
    final cookiesMap = <String, Cookie>{};
    final rawCookiesMatches = regex.allMatches(rawCookiesString).toList();

    // going through all matches
    for (final rawCookieMatch in rawCookiesMatches) {
      // find first match for entire cookie string
      final matchedGroup = rawCookieMatch.group(0);
      if (matchedGroup == null) {
        continue;
      }

      try {
        final cookie = Cookie.fromSetCookieValue(matchedGroup);
        cookiesMap[cookie.name] = cookie;
      } catch (e) {
        log("Error parsing cookie: $matchedGroup, error: $e");
        continue;
      }
    }

    return cookiesMap;
  }

  Map<String, dynamic> _getRequestHeadersMapWithAddedCookie({
    required Map<String, dynamic> headersMap,
    required Cookie cookie,
  }) {
    final newHeaders = Map<String, dynamic>.from(headersMap);

    final cookiesString = newHeaders["cookie"] as String?;
    if (cookiesString == null) {
      // if no cookies string, add cookie to headers and return new headers map
      newHeaders["cookie"] = cookie.toString();

      return newHeaders;
    }

    final cookiesMap =
        _getCookiesMapFromString(rawCookiesString: cookiesString);

    // add new cookie to map
    cookiesMap[cookie.name] = cookie;

    final updatedCookiesString =
        _getCookiesStringFromMap(cookiesMap: cookiesMap);

    // add new cookies string to headers
    newHeaders["cookie"] = updatedCookiesString;

    return newHeaders;
  }

  String _getCookiesStringFromMap({
    required Map<String, Cookie> cookiesMap,
  }) {
    final cookiesList = cookiesMap.values.toList();
    final cookiesString = cookiesList.join(", ");

    return cookiesString;
  }
}
