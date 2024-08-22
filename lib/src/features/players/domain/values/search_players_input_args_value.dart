import 'package:equatable/equatable.dart';

class SearchPlayersInputArgsValue extends Equatable {
  const SearchPlayersInputArgsValue({
    required this.nameTerm,
  });

  final String nameTerm;

  @override
  List<Object?> get props => [
        nameTerm,
      ];
}
