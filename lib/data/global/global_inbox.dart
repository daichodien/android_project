class GlobalInbox {
  String? id;

  int? countInbox;
  int? get getCountInbox => countInbox;
  set setCountInbox(int? value) => countInbox = value;

  get getId => id;
  set setId(value) => id = value;
}

GlobalInbox globalInbox = GlobalInbox();
