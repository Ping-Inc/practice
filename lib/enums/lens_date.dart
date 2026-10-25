import 'package:practice/data/ping_data.dart';

/// Which date a lens orders its pings by and shows above them
/// (the focus view date and the grid's day headings).
class LensDate {
  const LensDate(this._dateOf);

  final DateTime? Function(PingData ping) _dateOf;

  /// When the ping was captured. Used by most lenses.
  static const captured = LensDate(_captured);

  /// When the ping was last re-pinged. Used by `re-pings`.
  static const rePinged = LensDate(_rePinged);

  /// When the ping was placed. Used by `placed`.
  static const placed = LensDate(_placed);

  /// When the ping was made public. Used by `public`.
  static const madePublic = LensDate(_madePublic);

  /// The ping's date for this lens, falling back to when it was captured.
  DateTime of(PingData ping) => _dateOf(ping) ?? ping.time;

  /// Keeps each of [pings]' dates as they are now, so a ping stays in place
  /// even if that date changes (e.g. a ping made private inside `public`).
  LensDate frozenFor(List<PingData> pings) {
    final dates = {for (final ping in pings) ping.id: of(ping)};
    return LensDate((ping) => dates[ping.id] ?? _dateOf(ping));
  }

  static DateTime? _captured(PingData ping) => ping.time;
  static DateTime? _rePinged(PingData ping) => ping.resonantTime;
  static DateTime? _placed(PingData ping) => ping.placedTime;
  static DateTime? _madePublic(PingData ping) => ping.publicTime;
}
