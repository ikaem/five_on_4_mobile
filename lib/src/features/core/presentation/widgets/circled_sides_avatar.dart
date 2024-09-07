// TODO maybe this could later be converted to OneSided - so we can specify side
// TODO could this be reused in match screen, where we list participatns
import 'package:five_on_4_mobile/src/style/utils/constants/circular_radius_constants.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircledSidesAvatar extends StatelessWidget {
  const CircledSidesAvatar({
    super.key,
    required this.avatarUri,
    required this.radius,
    // required this.width,
    // required this.height,
  });

  final Uri avatarUri;

  // final double width;
  // final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius / 2)),
        color: ColorConstants.BLUE_DARK,
      ),
      child: Image.network(
        avatarUri.toString(),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.error,
            color: ColorConstants.GREY_LIGHT,
          );
        },
      ),
    );

    // return Container();

    // return Container(
    //   // width: 60,
    //   // height: 50,
    //   width: width,
    //   height: height,
    //   clipBehavior: Clip.hardEdge,
    //   decoration: const BoxDecoration(
    //     borderRadius: BorderRadius.only(
    //       topRight: CircularRadiusConstants.REGULAR,
    //       bottomRight: CircularRadiusConstants.REGULAR,
    //     ),
    //     color: ColorConstants.BLUE_DARK,
    //   ),

    //   child: Image.network(
    //     avatarUri.toString(),
    //     // width: 54,
    //     // height: 30,
    //     fit: BoxFit.cover,
    //     // loadingBuilder: (context, child, loadingProgress) =>
    //     errorBuilder: (context, error, stackTrace) {
    //       return const Icon(
    //         Icons.error,
    //         color: ColorConstants.GREY_LIGHT,
    //       );
    //     },
    //   ),
    // );
  }
}
