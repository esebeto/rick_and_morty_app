import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/providers/location_provider.dart';

class LocationList extends StatelessWidget {
  const LocationList({super.key, required this.locationProvider});

  final LocationProvider locationProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: locationProvider.locations.length,
        itemBuilder: (context, index) {
          final location = locationProvider.locations[index];
          return ListTile(
            title: Text(location.name),
            subtitle: Text(location.dimension),
            leading: Text(location.type),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
