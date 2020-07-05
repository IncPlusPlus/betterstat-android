import 'package:betterstatmobile/api/scheduling/api_day.dart';
import 'package:betterstatmobile/models/day.dart';
import 'package:betterstatmobile/repository/generic_future_repository.dart';

class DayRepository implements GenericFutureRepository<Day, String> {
  const DayRepository();

  @override
  Future<Day> createById(Day schedule) {
    return postDay(schedule);
  }

  @override
  Future<Day> deleteById(String id) {
    return deleteDay(id);
  }

  @override
  Future<Day> getById(String id) {
    return getDay(id);
  }

  @override
  Future<List<Day>> getAll() {
    return getDays();
  }

  @override
  Future saveById(Day schedule, String id) {
    return putDay(schedule, id);
  }
}
