import 'package:fmbp/data/repository/inbox/inbox_repository.dart';

class InboxController {
  final InboxRepository _inboxRepository = InboxRepository();

  Future getNotifi() {
    return _inboxRepository.getNotifications();
  }

  int getCountInbox() {
    return _inboxRepository.getCountInbox();
  }

  Future deleteNotifications(int id) {
    return _inboxRepository.delete(id);
  }
}
