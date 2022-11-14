class GlobalMile {
  int? lastMile;
  int? lastRead;

  int? get getLastMile => lastMile;
  set setLastMile(int? value) => lastMile = value;

  get getLastRead => lastRead;
  set setLastRead(value) => lastRead = value;
}

GlobalMile globalMile = GlobalMile();
