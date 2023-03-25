import 'package:opmswebstaff/app/app.locator.dart';
import 'package:opmswebstaff/core/service/api/api_service.dart';
import 'package:opmswebstaff/core/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

class MedicalHistoryViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  Future<void> getPatientMedicalHistory(String patientId) async {}

  void goToPhotoView({required int index}) {
    // navigationService.pushNamed(Routes.MedHistoryPhotoView,
    //     arguments: MedHistoryPhotoViewArguments(
    //         medHistory: medHistoryList, initialIndex: index));
  }
}
