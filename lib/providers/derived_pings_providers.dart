import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/data/ping_data.dart';
import 'package:practice/enums/day_of_week_enum.dart';
import 'package:practice/enums/month_enum.dart';
import 'package:practice/extensions/date_time_extensions.dart';
import 'package:practice/providers/pings_map_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'derived_pings_providers.g.dart';

@riverpod
List<PingData> allPings(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) => map.values.where((ping) => !ping.hidden).toList()
          ..sort((a, b) => b.time.compareTo(a.time)),
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> resonatedPings(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) => map.values
            .where((ping) => !ping.hidden && ping.resonantCount > 0)
            .toList()
          ..sort((a, b) {
            if (a.resonantTime == null) return 1;
            if (b.resonantTime == null) return -1;
            return b.resonantTime!.compareTo(a.resonantTime!);
          }),
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> hiddenPings(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) => map.values.where((ping) => ping.hidden).toList()
          ..sort((a, b) => b.time.compareTo(a.time)),
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> visiblePings(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) => map.values.where((ping) => !ping.hidden).toList()
          ..sort((a, b) => b.time.compareTo(a.time)),
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> pingReplies(Ref ref, int pingId) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          if (!map.containsKey(pingId)) return [];

          // Get all pings in the entire reply tree (both up and down)
          final Set<int> allConnectedIds = {};
          final Set<int> processedIds = {};
          final List<int> toProcess = [pingId];

          // Process all connected pings in breadth-first manner
          while (toProcess.isNotEmpty) {
            final currentId = toProcess.removeAt(0);
            if (processedIds.contains(currentId)) continue;

            processedIds.add(currentId);
            allConnectedIds.add(currentId);

            // Get the current ping
            final currentPing = map[currentId];
            if (currentPing == null) continue;

            // Add parent (upward connection)
            if (currentPing.replyId != null &&
                !processedIds.contains(currentPing.replyId)) {
              toProcess.add(currentPing.replyId!);
            }

            // Add children (downward connections)
            final childIds = map.values
                .where((p) => p.replyId == currentId && !p.hidden)
                .map((p) => p.id!)
                .toList();

            for (final childId in childIds) {
              if (!processedIds.contains(childId)) {
                toProcess.add(childId);
              }
            }
          }

          // Remove the original ping ID and filter out hidden pings
          allConnectedIds.remove(pingId);
          final visibleIds = allConnectedIds
              .where((id) => map[id] != null && !map[id]!.hidden)
              .toList();

          // Convert to pings and include the current ping
          final replies = [...visibleIds.map((id) => map[id]!)];

          // Add the current ping
          final currentPing = map[pingId];
          if (currentPing != null && replies.length > 0) {
            replies.add(currentPing);
          }

          // Sort all pings together by id
          replies.sort((a, b) => a.id!.compareTo(b.id!));

          return replies;
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
PingData? latestPing(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          final visiblePings = map.values.where((ping) => !ping.hidden);
          if (visiblePings.isEmpty) return null;
          return visiblePings.reduce((a, b) => a.id! > b.id! ? a : b);
        },
        loading: () => null,
        error: (_, __) => null,
      );
}

@riverpod
List<PingData> modeFilteredPings(Ref ref, String mode) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values.where((ping) {
            if (ping.hidden) return false;
            final hour = ping.time.hour;
            switch (mode) {
              case 'morning':
                return hour >= 5 && hour < 12;
              case 'afternoon':
                return hour >= 12 && hour < 17;
              case 'evening':
                return hour >= 17 && hour < 22;
              case 'night':
                return hour >= 22 || hour < 5;
              default:
                return hour >= 5 && hour < 12;
            }
          }).toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> dayOfWeekPings(Ref ref, int weekday) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values
              .where((ping) => !ping.hidden && ping.time.weekday == weekday)
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> monthPings(Ref ref, int month) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values
              .where((ping) => !ping.hidden && ping.time.month == month)
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> dayOfMonthPings(Ref ref, int day) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values
              .where((ping) => !ping.hidden && ping.time.day == day)
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> yearPings(Ref ref, int year) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values
              .where((ping) => !ping.hidden && ping.time.year == year)
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> lastWeekPings(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          final now = DateTime.now();
          // Get the start of the current week (Monday)
          final currentWeekStart =
              now.subtract(Duration(days: now.weekday - 1));
          // Get the start of last week (Monday)
          final lastWeekStart =
              currentWeekStart.subtract(const Duration(days: 7));
          // Get the end of last week (Sunday)
          final lastWeekEnd =
              currentWeekStart.subtract(const Duration(days: 1));

          return map.values
              .where((ping) =>
                  !ping.hidden &&
                  ping.time.isAfter(lastWeekStart) &&
                  ping.time.isBefore(lastWeekEnd.add(const Duration(days: 1))))
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
PingData? pingOfTheDay(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          if (map.isEmpty) return null;
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final pings = map.values
              .where((ping) => !ping.hidden && ping.time.isAfter(today))
              .toList();
          if (pings.isEmpty) return null;
          return pings[DateTime.now().millisecondsSinceEpoch % pings.length];
        },
        loading: () => null,
        error: (_, __) => null,
      );
}

@riverpod
List<int> pingYears(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          final years = map.values
              .where((ping) => !ping.hidden)
              .map((ping) => ping.time.year)
              .toSet()
              .toList();
          years.sort((a, b) => a.compareTo(b));
          return years;
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
bool anyResonated(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) =>
            map.values.any((ping) => !ping.hidden && ping.resonantCount > 0),
        loading: () => false,
        error: (_, __) => false,
      );
}

@riverpod
bool anyLastWeek(Ref ref) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          final weekAgo = DateTime.now().subtract(const Duration(days: 7));
          return map.values
              .any((ping) => !ping.hidden && ping.time.isAfter(weekAgo));
        },
        loading: () => false,
        error: (_, __) => false,
      );
}

@riverpod
int pingViewCount(Ref ref, int pingId) {
  return ref.watch(pingsMapProvider).when(
        data: (map) => map[pingId]?.viewCount ?? 0,
        loading: () => 0,
        error: (_, __) => 0,
      );
}

@riverpod
int pingResonanceCount(Ref ref, int pingId) {
  return ref.watch(pingsMapProvider).when(
        data: (map) => map[pingId]?.resonantCount ?? 0,
        loading: () => 0,
        error: (_, __) => 0,
      );
}

@riverpod
List<PingData> dayOfWeekFilteredPings(Ref ref, DayOfWeekEnum dayOfWeek) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values
              .where(
                  (ping) => !ping.hidden && ping.time.dayOfWeek() == dayOfWeek)
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> monthFilteredPings(Ref ref, MonthEnum month) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values
              .where((ping) =>
                  !ping.hidden &&
                  MonthEnum.values[ping.time.month - 1] == month)
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> dayOfMonthFilteredPings(Ref ref, int dayOfMonth) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values
              .where((ping) => !ping.hidden && ping.time.day == dayOfMonth)
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}

@riverpod
List<PingData> yearFilteredPings(Ref ref, int year) {
  return ref.watch(pingsMapProvider).when(
        data: (map) {
          return map.values
              .where((ping) => !ping.hidden && ping.time.year == year)
              .toList()
            ..sort((a, b) => b.time.compareTo(a.time));
        },
        loading: () => [],
        error: (_, __) => [],
      );
}
