import 'package:five_on_4_mobile/src/features/core/presentation/widgets/error_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/loading_status.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/matches_list.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/streamed_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/search_matches_inputs.dart';
import 'package:flutter/material.dart';

// TODO all of this needs to be tested
class SearchMatchesContainer extends StatefulWidget {
  const SearchMatchesContainer({
    super.key,
    required this.matchTitleInputStream,
    required this.onMatchTitleInputChanged,
    required this.matches,
    required this.onSearchButtonPressed,
    required this.isLoading,
    required this.isError,
    required this.areInputsValidStream,
  });

  final Stream<String> matchTitleInputStream;
  final ValueSetter<String> onMatchTitleInputChanged;
  final ValueSetter<String> onSearchButtonPressed;
  final Stream<bool> areInputsValidStream;

  final List<MatchModel> matches;

  final bool isLoading;
  final bool isError;

  @override
  State<SearchMatchesContainer> createState() => _SearchMatchesContainerState();
}

class _SearchMatchesContainerState extends State<SearchMatchesContainer> {
  final TextEditingController _matchTitleTextFieldController =
      TextEditingController();

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchMatchesInputs(
          matchTitleInputStream: widget.matchTitleInputStream,
          matchTitleTextFieldController: _matchTitleTextFieldController,
          onMatchTitleInputChanged: widget.onMatchTitleInputChanged,
        ),
        StreamedElevatedButton(
          isEnabledStream: widget.areInputsValidStream,
          onPressed: () {
            widget.onSearchButtonPressed(_matchTitleTextFieldController.text);
          },
          label: "Search",
        ),
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     // fixedSize:
        //     fixedSize: Size(MediaQuery.of(context).size.width, 50),
        //   ),
        //   onPressed: () => widget.onSearchButtonPressed("Iv"),
        //   child: const Text("Search"),
        // ),
        const Divider(),
        // if we use riverpod state from controller here, fields will be cleared on every rebuild? maybe - we will see
        // TODO search results will be displayed here
        // TODO will have loading and such here

        // TODO in tests, expanded might cause an issue here because it wraps sometimes just one element
        Expanded(
          child: _SearchMatchesContainerResultsPresenter(
            isLoading: widget.isLoading,
            isError: widget.isError,
            matches: widget.matches,
          ),
        ),

        // widget.isLoading
        //     ? const LoadingStatus(message: "Searching matches...")
        //     : Expanded(
        //         child: MatchesList(
        //           matches: widget.matches,
        //         ),
        //       ),
      ],
    );
  }

  void _onDispose() {
    _matchTitleTextFieldController.dispose();
  }
}

// TODO widget that will handle situations:
// - when loading
// - when error
// - when no matches found
// - when matches found
class _SearchMatchesContainerResultsPresenter extends StatelessWidget {
  const _SearchMatchesContainerResultsPresenter({
    super.key,
    required this.isLoading,
    required this.isError,
    required this.matches,
  });

  final bool isLoading;
  final bool isError;
  final List<MatchModel> matches;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return const ErrorStatus(
        message: "There was an issue searching matches",
        onRetry: null,
        // onRetry: () async {
        //   // TODO for now do noting, dont offer it
        // },
      );
    }
    if (isLoading) {
      return const LoadingStatus(
        message: "Searching matches...",
      );
    }

    if (matches.isEmpty) {
      return const Center(
        child: Text("No matches found"),
      );
    }

    return MatchesList(matches: matches);
  }
}
