// TODO move to values somewhere
import 'package:equatable/equatable.dart';

class SearchPlayersFilterValue extends Equatable {
  const SearchPlayersFilterValue({required this.name});

  /// [name] will be used to search against players:
  /// - First name
  /// - Last name
  /// - Nickname
  final String name;

  @override
  List<Object> get props => [
        name,
      ];
}
