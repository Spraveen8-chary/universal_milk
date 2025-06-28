import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:universal_milk/app/app.locator.dart';
import 'package:universal_milk/app/app.router.dart';

class CalendarViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, bool> _skippedDates = {};
  bool _hasUnsavedChanges = false;

  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;
  Map<DateTime, bool> get skippedDates => _skippedDates;
  bool get isSelectedDaySkipped => _skippedDates[_selectedDay] ?? false;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      notifyListeners();
    }
  }

  void toggleSkipDate() {
    if (_skippedDates.containsKey(_selectedDay)) {
      _skippedDates.remove(_selectedDay);
    } else {
      _skippedDates[_selectedDay] = true;
    }
    _hasUnsavedChanges = true;
    notifyListeners();
  }

  Future<void> saveChanges() async {
    if (_skippedDates.isEmpty) {
      await _dialogService.showDialog(
        title: 'No Changes',
        description: 'You haven\'t made any changes to your delivery schedule.',
      );
      return;
    }

    // This would normally save changes to a service or API
    setBusy(true);
    await Future.delayed(const Duration(seconds: 1));

    // Format dates for display
    final formattedDates = _skippedDates.keys
        .map((date) => DateFormat('dd MMM yyyy').format(date))
        .join('\n');

    setBusy(false);
    _hasUnsavedChanges = false;

    await _dialogService.showDialog(
      title: 'Changes Saved',
      description:
          'Your delivery schedule has been updated. Skipped dates:\n$formattedDates',
    );
  }

  void navigateBack() {
    if (_hasUnsavedChanges) {
      _dialogService
          .showDialog(
        title: 'Unsaved Changes',
        description:
            'You have unsaved changes. Do you want to save before leaving?',
        buttonTitle: 'Save',
        cancelTitle: 'Discard',
      )
          .then((response) {
        if (response?.confirmed == true) {
          saveChanges().then((_) {
            _navigationService.back();
          });
        } else {
          _navigationService.back();
        }
      });
    } else {
      _navigationService.back();
    }
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
