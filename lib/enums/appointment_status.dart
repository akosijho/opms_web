enum AppointmentStatus {
  Pending,
  Declined,
  Completed,
  Cancelled,
  OnRequest,
}

AppointmentStatus getAppointmentStatus(String appointmentStatus) {
  switch (appointmentStatus) {
    case 'COMPLETED':
      return AppointmentStatus.Completed;

    case 'CANCELLED':
      return AppointmentStatus.Cancelled;

    case 'PENDING':
      return AppointmentStatus.Pending;

    case 'DECLINED':
      return AppointmentStatus.Declined;

    case 'ON REQUEST':
      return AppointmentStatus.OnRequest;

    default:
      return AppointmentStatus.OnRequest;
  }
}

extension Ext on AppointmentStatus {
  String get name {
    switch (this) {
      case AppointmentStatus.Completed:
        return 'COMPLETED';

      case AppointmentStatus.Cancelled:
        return 'CANCELLED';

      case AppointmentStatus.Pending:
        return 'PENDING';

      case AppointmentStatus.Declined:
        return 'DECLINED';

      case AppointmentStatus.OnRequest:
        return 'ON REQUEST';

      default:
        return 'ERROR';
    }
  }
}
