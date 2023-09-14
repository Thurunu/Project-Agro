class Find {
  late double latitude;
  late double longitude;

  Find({
    required this.latitude,
    required this.longitude,
  });

  String findAgriculturalZone() {
    // Define approximate latitude and longitude ranges for each zone
    final wetZoneLatRange = [6, 8];
    final wetZoneLongRange = [79, 81];

    final intermediateZoneLatRange = [7, 9];
    final intermediateZoneLongRange = [79, 81];

    final dryZoneLatRange = [8, 10];
    final dryZoneLongRange = [80, 82];

    final aridZoneLatRange = [7, 10];
    final aridZoneLongRange = [80, 82];

    final uplandZoneLatRange = [6, 7.5];
    final uplandZoneLongRange = [79, 81];

    final highlandZoneLatRange = [6, 7];
    final highlandZoneLongRange = [79, 81];

    final coastalZoneLatRange = [5, 10];
    final coastalZoneLongRange = [79, 82];

    // Check both latitude and longitude to determine the zone
    if (latitude >= wetZoneLatRange[0] &&
        latitude <= wetZoneLatRange[1] &&
        longitude >= wetZoneLongRange[0] &&
        longitude <= wetZoneLongRange[1]) {
      return "Wet Zone";
    } else if (latitude >= intermediateZoneLatRange[0] &&
        latitude <= intermediateZoneLatRange[1] &&
        longitude >= intermediateZoneLongRange[0] &&
        longitude <= intermediateZoneLongRange[1]) {
      return "Intermediate Zone";
    } else if (latitude >= dryZoneLatRange[0] &&
        latitude <= dryZoneLatRange[1] &&
        longitude >= dryZoneLongRange[0] &&
        longitude <= dryZoneLongRange[1]) {
      return "Dry Zone";
    } else if (latitude >= aridZoneLatRange[0] &&
        latitude <= aridZoneLatRange[1] &&
        longitude >= aridZoneLongRange[0] &&
        longitude <= aridZoneLongRange[1]) {
      return "Arid Zone";
    } else if (latitude >= uplandZoneLatRange[0] &&
        latitude <= uplandZoneLatRange[1] &&
        longitude >= uplandZoneLongRange[0] &&
        longitude <= uplandZoneLongRange[1]) {
      return "Upland Zone";
    } else if (latitude >= highlandZoneLatRange[0] &&
        latitude <= highlandZoneLatRange[1] &&
        longitude >= highlandZoneLongRange[0] &&
        longitude <= highlandZoneLongRange[1]) {
      return "Highland Zone";
    } else if (latitude >= coastalZoneLatRange[0] &&
        latitude <= coastalZoneLatRange[1] &&
        longitude >= coastalZoneLongRange[0] &&
        longitude <= coastalZoneLongRange[1]) {
      return "Coastal Zone";
    } else {
      return "Unknown Zone";
    }
  }
}
