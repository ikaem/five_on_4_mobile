import 'package:auto_route/auto_route.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/tab_toggler/tab_toggler.dart';
import 'package:five_on_4_mobile/src/features/core/utils/constants/route_paths_constants.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/values/match_create_input_args.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match/provider/create_match_controller.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/controllers/create_match_inputs/provider/create_match_inputs_controller_provider.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_info_container.dart';
import 'package:five_on_4_mobile/src/features/matches/presentation/widgets/match_create/match_create_participants_container.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/wrappers/libraries/auto_route/auto_route_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MatchCreateUIState {
  const MatchCreateUIState({
    required this.isLoading,
    required this.isError,
    required this.matchId,
  });

  final bool isLoading;
  final bool isError;
  final int? matchId;
}

class MatchCreateScreenView extends ConsumerStatefulWidget {
  const MatchCreateScreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MatchCreateScreenViewState();
}

class _MatchCreateScreenViewState extends ConsumerState<MatchCreateScreenView> {
// TODO test

  // final matchCreateInputsController = CreateMatchInputsController();
  late final createMatchInputsController =
      ref.read(createMatchInputsControllerProvider);

  @override
  void dispose() {
    _onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO also can setup listener here
    ref.listen(
      createMatchControllerProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          data: (state) {
            final matchId = state?.matchId;
            if (matchId == null) {
              // TODO something has to be done here
              return;
            }
            context.replaceRoute(MatchRoute(matchId: matchId));
            // also - show message in snackbar
          },
        );
      },
    );
    final matchCreateControllerState = ref.watch(createMatchControllerProvider);
    final matchCreateUIState =
        _getMatchCreateUIState(matchCreateControllerState);
    final togglerOptions = _getTogglerOptions(
      matchCreateUIState: matchCreateUIState,
      // TODO this needs to be tested
      onRetry: () async {
        context.go(RoutePathsConstants.ROOT.value);
      },
      // input controller values
      nameStream: createMatchInputsController.validatedNameStream,
      onNameChanged: createMatchInputsController.onNameChanged,
      dateTimeStream: createMatchInputsController.validatedDateTimeStream,
      onDateTimeChanged: createMatchInputsController.onDateTimeChanged,
      descriptionStream: createMatchInputsController.validatedDescriptionStream,
      onDescriptionChanged: createMatchInputsController.onDescriptionChanged,
      locationStream: createMatchInputsController.validatedLocationStream,
      onLocationChanged: createMatchInputsController.onLocationChanged,
    );

    return Scaffold(
      backgroundColor: ColorConstants.BLUE_LIGHT,

      appBar: AppBar(
        // TODO wrap in will pop, to make sure to prevent user from leaving if they are creating amatch
        backgroundColor: ColorConstants.BLUE_LIGHT,
        actions: [
          // TODO extract to streamed icon button
          StreamBuilder<bool>(
              stream: createMatchInputsController.areInputsValidStream,
              builder: (context, snapshot) {
                final areInputsValid = snapshot.data ?? false;

                return _MatchCreateActionButton(
                  areInputsValid: areInputsValid,
                  onCreateMatch: ref
                      .read(createMatchControllerProvider.notifier)
                      .onCreateMatch,
                );
              }),
        ],
      ),
      body: TabToggler(
        options: togglerOptions,
        backgroundColor: ColorConstants.WHITE,
      ),
      // TODO view should show loading and error instead of passing it to the children
      // TODO it could use when
      // TODO do change to this
      // body: matchCreateControllerState.when(
      //   data: (data) {
      //     return TabToggler(
      //       options: togglerOptions,
      //     );
      //   },
      //   error: (error, stackTrace) {
      //     return ErrorStatus(
      //       message: "There was an issue creating match",
      //       onRetry: () async {
      //         context.go(RoutePathsConstants.ROOT.value);
      //       },
      //     );
      //   },
      //   loading: () {
      //     return const LoadingStatus(
      //       message: "Creating match...",
      //     );
      //   },
      // ),
    );
  }

  List<TabTogglerOptionValue> _getTogglerOptions({
    required MatchCreateUIState matchCreateUIState,
    required Future<void> Function() onRetry,
    // input controller values
    required Stream<String> nameStream,
    required ValueSetter<String> onNameChanged,
    required Stream<DateTime> dateTimeStream,
    required ValueSetter<DateTime?> onDateTimeChanged,
    required Stream<String> descriptionStream,
    required ValueSetter<String> onDescriptionChanged,
    required Stream<String> locationStream,
    required ValueSetter<String> onLocationChanged,
  }) {
    return [
      // TODO stopped here
      TabTogglerOptionValue(
        title: "INFO",
        child: MatchCreateInfoContainer(
          nameStream: nameStream,
          onNameChanged: onNameChanged,
          dateTimeStream: dateTimeStream,
          onDateTimeChanged: onDateTimeChanged,
          descriptionStream: descriptionStream,
          onDescriptionChanged: onDescriptionChanged,
          locationStream: locationStream,
          onLocationChanged: onLocationChanged,
          isLoading: matchCreateUIState.isLoading,
          isError: matchCreateUIState.isError,
          onRetry: onRetry,
        ),
      ),
      TabTogglerOptionValue(
        title: "PARTICIPANTS",
        // TODO this should have loading as well, and error and such
        child: MatchCreateParticipantsContainer(
          playersToInvite: const [],
          isLoading: matchCreateUIState.isLoading,
          isError: matchCreateUIState.isError,
          onRetry: onRetry,
        ),
      ),
    ];
  }

  Future<void> _onDispose() async {
    // await matchCreateInputsController.dispose();
    await createMatchInputsController.dispose();
  }
}

MatchCreateUIState _getMatchCreateUIState(
  AsyncValue<CreateMatchControllerState?> createMatchControllerState,
) {
  final isLoading = createMatchControllerState.maybeWhen<bool>(
    orElse: () => false,
    loading: () => true,
  );

  final isError = createMatchControllerState.maybeWhen<bool>(
    orElse: () => false,
    error: (error, _) => true,
  );

  final matchId = createMatchControllerState.maybeWhen<int?>(
    orElse: () => null,
    data: (state) => state?.matchId,
  );

  return MatchCreateUIState(
    isLoading: isLoading,
    isError: isError,
    matchId: matchId,
  );
}

class _MatchCreateActionButton extends StatelessWidget {
  const _MatchCreateActionButton({
    required this.areInputsValid,
    required this.onCreateMatch,
  });

  final bool areInputsValid;
  final Future<void> Function(MatchCreateInputArgs?) onCreateMatch;

  @override
  Widget build(BuildContext context) {
    final iconColor = areInputsValid ? ColorConstants.ORANGE : Colors.grey;

    return TextButton.icon(
      onPressed: areInputsValid ? () async => onCreateMatch(null) : null,
      icon: const Text("CREATE"),
      label: Icon(
        Icons.save,
        color: iconColor,
      ),
    );
  }
}
