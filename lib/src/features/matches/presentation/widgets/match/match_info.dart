import 'package:five_on_4_mobile/src/features/core/utils/extensions/date_time_extension.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/circular_radius_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

class MatchInfo extends StatelessWidget {
  const MatchInfo({
    super.key,
    required this.match,
  });

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DateElement(
          dateAndTime: match.dateAndTime,
        ),
        Expanded(
          child: _InfoElement(match: match),
        ),
      ],
    );
  }
}

class _InfoElement extends StatelessWidget {
  const _InfoElement({
    required this.match,
  });

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: SpacingConstants.XL,
        right: SpacingConstants.M,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            match.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: TextSizeConstants.EXTRA_EXTRA_LARGE,
            ),
          ),
          const SizedBox(height: SpacingConstants.S),
          Text.rich(
            style: const TextStyle(
              fontSize: TextSizeConstants.EXTRA_LARGE,
            ),
            TextSpan(
              children: [
                const TextSpan(
                  text: "location: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: match.location,
                ),
              ],
            ),
          ),
          const SizedBox(height: SpacingConstants.XS),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(height: SpacingConstants.XS),
          const Text.rich(
            style: TextStyle(
              fontSize: TextSizeConstants.LARGE,
            ),
            TextSpan(
              children: [
                TextSpan(
                  text: "organizer: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "match.organizer",
                ),
              ],
            ),
          ),
          const SizedBox(height: SpacingConstants.XS),
          const Text.rich(
            style: TextStyle(
              fontSize: TextSizeConstants.LARGE,
            ),
            TextSpan(
              children: [
                TextSpan(
                  text: "arriving: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  // ignore: prefer_interpolation_to_compose_strings
                  text: ("12") + " player(s)",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateElement extends StatelessWidget {
  const _DateElement({
    required this.dateAndTime,
  });

  final DateTime dateAndTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(SpacingConstants.L),
          decoration: const BoxDecoration(
            color: ColorConstants.BLUE_DARK,
            borderRadius: BorderRadius.horizontal(
              right: CircularRadiusConstants.REGULAR,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateAndTime.dateMonthString,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TextSizeConstants.EXTRA_EXTRA_LARGE,
                  color: ColorConstants.WHITE,
                ),
              ),
              Text(
                dateAndTime.dayNameString,
                style: const TextStyle(
                  fontSize: TextSizeConstants.EXTRA_LARGE,
                  color: ColorConstants.WHITE,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: SpacingConstants.M),
          child: Text(
            dateAndTime.hourMinuteString,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: TextSizeConstants.EXTRA_EXTRA_LARGE,
              color: ColorConstants.BLUE_DARK,
            ),
          ),
        ),
      ],
    );
  }
}
