import 'package:equatable/equatable.dart';

class SearchMatchesInputArgsValue extends Equatable {
  const SearchMatchesInputArgsValue({
    required this.matchTitle,
  });

  final String matchTitle;

  @override
  List<Object?> get props => [
        matchTitle,
      ];
}
