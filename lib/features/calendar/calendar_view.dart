import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:universal_milk/features/calendar/calendar_viewmodel.dart';
import 'package:universal_milk/shared/app_colors.dart';
import 'package:universal_milk/shared/ui_helpers.dart';
import 'package:universal_milk/shared/button.dart';
import 'package:universal_milk/shared/text_style.dart';
import 'package:universal_milk/shared/card.dart';

class CalendarView extends StackedView<CalendarViewModel> {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CalendarViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Schedule'),
        backgroundColor: kcPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Calendar header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kcPrimaryColor.withOpacity(0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select your delivery dates',
                  style: heading3Style(context),
                ),
                kSpaceSmall,
                Text(
                  'Tap on dates to select or skip deliveries',
                  style: bodyStyle(context),
                ),
              ],
            ),
          ),

          // Custom Calendar would normally go here
          // Using a placeholder for this fix
          Expanded(
            child: CustomCalendarWidget(
              selectedDay: viewModel.selectedDay,
              focusedDay: viewModel.focusedDay,
              onDaySelected: viewModel.onDaySelected,
              skippedDates: viewModel.skippedDates,
            ),
          ),

          // Legend
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(context, 'Delivery Date', kcPrimaryColor),
                kHorizontalSpaceMedium,
                _buildLegendItem(context, 'Skipped Date', kcErrorColor),
              ],
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomButton(
                  text: viewModel.isSelectedDaySkipped
                      ? 'Unskip Selected Date'
                      : 'Skip Selected Date',
                  variant: viewModel.isSelectedDaySkipped
                      ? ButtonVariant.outline
                      : ButtonVariant.primary,
                  onPressed: viewModel.toggleSkipDate,
                  isFullWidth: true,
                ),
                kSpaceMedium,
                CustomButton(
                  text: 'Save Changes',
                  variant: ButtonVariant.gradient,
                  onPressed: viewModel.saveChanges,
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        kHorizontalSpaceSmall,
        Text(
          label,
          style: bodySmallStyle(context),
        ),
      ],
    );
  }

  @override
  CalendarViewModel viewModelBuilder(BuildContext context) =>
      CalendarViewModel();
}

// Custom Calendar Widget to replace the table_calendar dependency
class CustomCalendarWidget extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Map<DateTime, bool> skippedDates;

  const CustomCalendarWidget({
    Key? key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    required this.skippedDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Month header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {},
              ),
              Text(
                "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
                style: heading3Style(context),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
              ),
            ],
          ),
          kSpaceMedium,
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Mon"),
              Text("Tue"),
              Text("Wed"),
              Text("Thu"),
              Text("Fri"),
              Text("Sat"),
              Text("Sun"),
            ],
          ),
          kSpaceMedium,
          // Calendar grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: 31, // Simplified for example
              itemBuilder: (context, index) {
                final day = index + 1;
                final date = DateTime(focusedDay.year, focusedDay.month, day);
                final isSelected = _isSameDay(selectedDay, date);
                final isSkipped = skippedDates[date] ?? false;

                return GestureDetector(
                  onTap: () => onDaySelected(date, date),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isSkipped ? kcErrorColor : kcPrimaryColor)
                          : (isSkipped ? kcErrorColor.withOpacity(0.1) : null),
                      shape: BoxShape.circle,
                      border: isSelected
                          ? null
                          : Border.all(
                              color:
                                  isSkipped ? kcErrorColor : Colors.transparent,
                            ),
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isSkipped ? kcErrorColor : null),
                          fontWeight: isSelected ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
