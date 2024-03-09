import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

/// Helper class that excplicitly requires dio's [Header] class
class CookiesHandlerWrapper {
  // TODO name could be better here

  // what does it need to do

  // when it receives a valid cookie string, it should - maybe it receives a map
  // also, receive a key of the cookie we need
  // it should also receive callback to call on the found cookie string
  Future<bool> handleFoundRequestCookie({
    required Headers headers,
    required String cookieName,
    required Future<void> Function(String) onCookieFound,
  }) async {
    final rawCookiesString = headers.value("set-cookie");
    if (rawCookiesString == null) {
      return false;
    }

    final cookiesMap =
        _getCookiesMapFromString(rawCookiesString: rawCookiesString);

    final foundCookie = cookiesMap[cookieName];
    if (foundCookie == null) {
      return false;
    }

    try {
      final cookieString = foundCookie.toString();
      await onCookieFound(cookieString);
    } catch (e) {
      log("Error calling onCookieFound(): $e");
      return false;
    }

    return true;
  }

  // other function is a function to generate cookie from a callback that is passed to it
  // - receive a cookie retriever or someting
  // validate that the cookie retrieved is valid whatever that means
  // if it is valid, return it as string

  // maybe also a function to add cookie to request options object

  // maybe also a function to remove cookie from request options object

  // maybe also a function to remove all cookies from request options object

  // TODO logic will be needed for merging existing cookies - because this logic could be used for multiple cookies

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
}
