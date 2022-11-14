import 'package:fmbp/data/repository/todo_list/todo_repository.dart';
import 'package:http/http.dart';

class TodoController {
  final TodoRepository _todoRepository = TodoRepository();
  Future<Response> getTodoTrip() {
    return _todoRepository.getTodo();
  }

  Future<Response> acceptTrip(String bookNo, int fleetId) {
    return _todoRepository.acceptTrip(bookNo, fleetId);
  }

  Future updatePickUp() {
    return _todoRepository.updatePickUp();
  }

  Future<Response> saveBookTrip(
    int startMile,
    String startTime,
    int endMile,
    String endTime,
    String route,
    String tripMemo,
    int tollFee,
    int parkingFee,
    int brId,
  ) {
    return _todoRepository.saveBookTrip(
      startMile,
      startTime,
      endMile,
      endTime,
      route,
      tripMemo,
      tollFee,
      parkingFee,
      brId,
    );
  }
}
