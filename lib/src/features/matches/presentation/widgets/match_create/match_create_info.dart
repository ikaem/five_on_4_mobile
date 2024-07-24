import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_date_time_field.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_mutliline_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/presentation/widgets/inputs/streamed_text_field.dart';
import 'package:five_on_4_mobile/src/features/core/utils/extensions/date_time_extension.dart';
import 'package:five_on_4_mobile/src/features/core/utils/helpers/date_time_input_on_tap_setter.dart';
import 'package:five_on_4_mobile/src/style/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

// TODO these inputs should not show error immediately after page opens - only after they are dirty
class MatchCreateInfo extends StatelessWidget {
  const MatchCreateInfo({
    super.key,
    required this.nameStream,
    required this.nameController,
    required this.onNameChanged,
    required this.dateTimeStream,
    required this.dateTimeController,
    required this.onDateTimeChanged,
    required this.descriptionStream,
    required this.descriptionController,
    required this.onDescriptionChanged,
    required this.locationStream,
    required this.locationController,
    required this.onLocationChanged,
  });

  // name
  final Stream<String> nameStream;
  final TextEditingController nameController;
  final ValueSetter<String> onNameChanged;

  // date & time
  final Stream<DateTime> dateTimeStream;
  final TextEditingController dateTimeController;
  final ValueSetter<DateTime?> onDateTimeChanged;

  // description
  final Stream<String> descriptionStream;
  final TextEditingController descriptionController;
  final ValueSetter<String> onDescriptionChanged;

  // location
  final Stream<String> locationStream;
  final TextEditingController locationController;
  final ValueSetter<String> onLocationChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StreamedTextField(
          stream: nameStream,
          textController: nameController,
          onChanged: onNameChanged,
          label: "MATCH NAME",
          fillColor: ColorConstants.GREY,
        ),
        const SizedBox(
          height: 10,
        ),
        StreamedTextField(
          stream: locationStream,
          textController: locationController,
          onChanged: onLocationChanged,
          label: "LOCATION",
          fillColor: ColorConstants.GREY,
        ),
        const SizedBox(
          height: 10,
        ),
        StreamedDateTimeField(
          stream: dateTimeStream,
          label: "MATCH DATE & TIME",
          onTapSetter: DateTimeInputOnTapSetter(
            initiallySelectedDate: DateTime.now().dayStart,
            fromDate: DateTime.now().dayStart,
            toDate: DateTime.now().add(const Duration(days: 365)).dayStart,
            onDateTimeChanged: onDateTimeChanged,
            textController: dateTimeController,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamedMultilineTextField(
          stream: descriptionStream,
          textController: descriptionController,
          onChanged: onDescriptionChanged,
          label: "Match Description",
        ),
      ],
    );
  }
}
