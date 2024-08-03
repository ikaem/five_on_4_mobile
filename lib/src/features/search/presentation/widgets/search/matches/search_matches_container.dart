import 'package:five_on_4_mobile/src/features/core/presentation/widgets/buttons/streamed_elevated_button.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/matches/search_matches_inputs.dart';
import 'package:five_on_4_mobile/src/features/search/presentation/widgets/search/matches/search_matches_results_presenter.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:flutter/material.dart';

// TODO all of this needs to be tested
// TODO this can probably be reused - or at least children here of the column can be reused
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
        const SizedBox(height: SpacingConstants.S),
        StreamedElevatedButton(
          isEnabledStream: widget.areInputsValidStream,
          onPressed: () {
            widget.onSearchButtonPressed(_matchTitleTextFieldController.text);
          },
          label: "Search",
        ),
        const SizedBox(height: SpacingConstants.S),
        const Divider(),
        const SizedBox(height: SpacingConstants.S),
        // if we use riverpod state from controller here, fields will be cleared on every rebuild? maybe - we will see
        // TODO search results will be displayed here
        // TODO will have loading and such here

        // TODO in tests, expanded might cause an issue here because it wraps sometimes just one element
        Expanded(
          child: SearchMatchesResultsPresenter(
            isLoading: widget.isLoading,
            isError: widget.isError,
            matches: widget.matches,
          ),
        ),
      ],
    );
  }

  void _onDispose() {
    _matchTitleTextFieldController.dispose();
  }
}
