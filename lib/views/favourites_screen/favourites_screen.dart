import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/changers/language_changer/cubit/language_changer_cubit.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/favourites_screen/data/favourites_model.dart';
import 'package:egypttour/views/favourites_screen/data/favourites_shared.dart';
import 'package:egypttour/views/place_screen/place_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<FavoritePlace> favoritePlaces = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() async {
    List<FavoritePlace> favorites = await FavoriteStorage.getFavorites();
    setState(() {
      favoritePlaces = favorites;
    });
  }

  void removeFavorite(String id) async {
    await FavoriteStorage.removeFavorite(id);
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoritePlaces.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: favoritePlaces.length,
              itemBuilder: (context, index) {
                final place = favoritePlaces[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlaceScreen(
                          placeNameText: place.name,
                          placeDescription: place.description,
                          img: place.imageUrl,
                          rating: place.rate,
                          time: place.time,
                          placeLocation: place.location, // Pass the location
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: ColorsManager.brown,
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 140.h,
                                child: Image.network(
                                  'https://docs.google.com/uc?id=${extractDriveId(place.imageUrl)}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              heightSpace(4),
                              Text(
                                place.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.sora(
                                  color: ColorsManager.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.yellow[700]),
                                  Text(place.rate),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      removeFavorite(place.id);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('No favorites added.'),
            ),
    );
  }

  String extractDriveId(String url) {
    try {
      Uri uri = Uri.parse(url);
      String? id = uri.queryParameters['id'];
      if (id != null && id.isNotEmpty) {
        return id;
      }
      RegExp regExp =
          RegExp(r'^https:\/\/drive\.google\.com\/file\/d\/([^\/]+)\/?.*$');
      Match? match = regExp.firstMatch(url);
      if (match != null && match.groupCount > 0) {
        return match.group(1) ?? '';
      }

      return '';
    } catch (e) {
      return '';
    }
  }
}
