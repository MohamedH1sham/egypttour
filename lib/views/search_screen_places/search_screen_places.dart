import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/home_screen/data/place_model.dart';
import 'package:egypttour/views/place_screen/place_screen.dart';
import 'package:flutter/material.dart';

class SearchScreenPlaces extends StatefulWidget {
  final List<Place> places;

  const SearchScreenPlaces({super.key, required this.places});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenPlacesState createState() => _SearchScreenPlacesState();
}

class _SearchScreenPlacesState extends State<SearchScreenPlaces> {
  List<Place> filteredPlaces = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredPlaces = widget.places;
    searchController.addListener(_filterPlaces);
  }

  void _filterPlaces() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPlaces = widget.places.where((place) {
        return place.name!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterPlaces);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                child: Image.asset(
                  'assets/images/tourist.png',
                ),
              ),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search for a place'.tr(),
                  labelStyle: const TextStyle(fontSize: 22),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredPlaces.length,
                  itemBuilder: (context, index) {
                    final place = filteredPlaces[index];
                    return Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: ColorsManager.brown,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xffFAFAFA),
                          ),
                        ),
                        title: Text(
                          overflow: TextOverflow.ellipsis,
                          place.name!,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xffFAFAFA),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>PlaceScreen(placeNameText: place.name!, placeDescription: place.description!, img: place.img!, rating: place.rate!, time: place.time, placeLocation: place.location!)));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
