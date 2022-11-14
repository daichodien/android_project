import 'package:fmbp/data/repository/inspection/inspection_repo.dart';

class InspectionController {
  final InspectionRepository _inspectionRepository = InspectionRepository();
  Future getInspection() {
    return _inspectionRepository.getCheckList();
  }

  Future getCheckListDetail(int clId) {
    return _inspectionRepository.getDetail(clId);
  }
}
