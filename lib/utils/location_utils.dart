import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practice/design_system/system_text.dart';

class LocationUtils {
  static Future<String?> getNeighborhood(BuildContext context) async {
    await Geolocator.isLocationServiceEnabled().then((value) {
      if (!value) {
        showError(context, AppLocalizations.of(context)!.setup_location_alert);
        return null;
      }
    });

    LocationPermission checkValue =
        await Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.deniedForever) {
        showError(context, AppLocalizations.of(context)!.setup_location_alert);
      }

      return value;
    });

    if (checkValue == LocationPermission.deniedForever) {
      return null;
    } else if (checkValue == LocationPermission.denied) {
      await Geolocator.requestPermission().then((requestValue) {
        if (requestValue == LocationPermission.denied) {
          showError(
              context, AppLocalizations.of(context)!.setup_location_alert);
          return null;
        }
      });
    }

    setLocaleIdentifier('en_US');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    print(placemarks.first.subLocality);
    return placemarks.first.subLocality;
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SystemText(text: message, color: Colors.white),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }
}
