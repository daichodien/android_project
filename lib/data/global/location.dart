class LocationServices {
  double? lat;
  double? lon;

  get getLat => lat;
  set setLat(value) => lat = value;

  get getLon => lon;
  set setLon(value) => lon = value;
}

LocationServices locationServices = LocationServices();
