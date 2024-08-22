import 'package:five_on_4_mobile/src/features/core/utils/extensions/date_time_extension.dart';
import 'package:five_on_4_mobile/src/features/core/utils/extensions/string_extension.dart';
import 'package:five_on_4_mobile/src/features/matches/domain/models/match/match_model.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/spacing_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/text_size_constants.dart';
import 'package:flutter/material.dart';

class MatchBrief extends StatelessWidget {
  const MatchBrief({
    super.key,
    required this.match,
  });

  final MatchModel match;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          match.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.BLACK,
            fontSize: TextSizeConstants.LARGE,
          ),
        ),
        const SizedBox(height: SpacingConstants.XS),
        Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: ColorConstants.BLUE_DARK,
            ),
            const SizedBox(width: SpacingConstants.XS),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  color: ColorConstants.BLACK,
                ),
                children: [
                  TextSpan(
                      text: match.dateAndTime.dateMonthYearString.uppercase),
                  const _SeparatorTextSpan(),
                  TextSpan(text: match.dateAndTime.dayNameString.uppercase),
                  const _SeparatorTextSpan(),
                  TextSpan(text: match.dateAndTime.hourMinuteString),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: SpacingConstants.XS),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: ColorConstants.BLUE_DARK,
            ),
            const SizedBox(width: SpacingConstants.XS),
            Text(
              match.location,
              style: const TextStyle(
                color: ColorConstants.BLACK,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SeparatorTextSpan extends TextSpan {
  const _SeparatorTextSpan()
      : super(
          text: '  |  ',
          style: const TextStyle(
            color: ColorConstants.BLUE_DARK,
          ),
        );
}





/////////// - old
// import 'package:flutter/material.dart';

// // TODO this seems to be not used for now - but it should be used - come back to it

// class MatchBrief extends StatelessWidget {
//   const MatchBrief({
//     super.key,
//     required this.date,
//     required this.dayName,
//     required this.time,
//     required this.title,
//     required this.location,
//   });

//   final String date;
//   final String dayName;
//   final String time;
//   final String title;
//   final String location;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Row(
//       children: [
//         Expanded(
//           child: _DateElement(
//             date: date,
//             dayName: dayName,
//             time: time,
//           ),
//         ),
//         Expanded(
//           child: Column(
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 location,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ));
//   }
// }

// class _DateElement extends StatelessWidget {
//   const _DateElement({
//     required this.date,
//     required this.dayName,
//     required this.time,
//   });

//   final String date;
//   final String dayName;
//   final String time;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           color: Colors.blue,
//           child: Column(
//             children: [
//               Text(
//                 date,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 dayName,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Text(
//           time,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }
