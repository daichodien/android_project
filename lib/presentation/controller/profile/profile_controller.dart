import 'package:fmbp/models/export_model.dart';

import '../../../data/repository/export_repository.dart';

class ProfileController {
  final DriverRepository _driverRepository = DriverRepository();

  Future<DriverModel> getStaff() {
    return _driverRepository.getStaff();
  }

  Future<DriverModel> updateStaff(String iCNumber, String licNumber) {
    return _driverRepository.update(iCNumber, licNumber);
  }

  Future deleteAccount() {
    return _driverRepository.deleteAcc();
  }
}
