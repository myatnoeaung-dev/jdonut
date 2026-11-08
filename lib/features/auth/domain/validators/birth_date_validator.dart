enum BirthDateError { missing, invalidDate, inFuture, tooYoung }

/// Date of birth: a real calendar date, not in the future, and at least
/// [minimumAgeYears] years ago.
abstract final class BirthDateValidator {
  static const int minimumAgeYears = 13;

  /// Returns null when [date] is valid on [today].
  static BirthDateError? validate(DateTime? date, {required DateTime today}) {
    if (date == null) return BirthDateError.missing;
    final birthDay = _dateOnly(date);
    final currentDay = _dateOnly(today);
    if (birthDay.isAfter(currentDay)) return BirthDateError.inFuture;
    final minimumAgeDay = DateTime(birthDay.year + minimumAgeYears, birthDay.month, birthDay.day);
    return minimumAgeDay.isAfter(currentDay) ? BirthDateError.tooYoung : null;
  }

  /// For typed dates: rejects days that don't exist (31 April, 29 February
  /// outside leap years), then applies [validate].
  static BirthDateError? validateParts({
    required int year,
    required int month,
    required int day,
    required DateTime today,
  }) {
    final date = DateTime(year, month, day);
    final exists = date.year == year && date.month == month && date.day == day;
    return exists ? validate(date, today: today) : BirthDateError.invalidDate;
  }

  static DateTime _dateOnly(DateTime value) => DateTime(value.year, value.month, value.day);
}
