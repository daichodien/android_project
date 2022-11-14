import 'package:fmbp/data/repository/export_repository.dart';
import 'package:http/http.dart';

class TripController {
  final TripRepository _tripRepository = TripRepository();

  Future getTrip(String selectDate) {
    return _tripRepository.getTrip(selectDate);
  }

  Future<Response> deleteTrip(int id) {
    return _tripRepository.delTrip(id);
  }

  Future getMile() {
    return _tripRepository.getFleetMile();
  }

  Future<Response> saveAddDayTrip(
    int startMile,
    String startTime,
    int endMile,
    String endTime,
    String route,
    String tripMemo,
    int tollFee,
    int parkingFee,
  ) {
    return _tripRepository.saveDayTrip(
      startMile,
      startTime,
      endMile,
      endTime,
      route,
      tripMemo,
      tollFee,
      parkingFee,
    );
  }

  Future setLocationWhenAddTrip() {
    return _tripRepository.initLocationService();
  }
}
