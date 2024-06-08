import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/mutual_widgets/CustRowIcon.dart';
import 'package:egypttour/spacing/spacing.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/home_screen/data/cubit/city_informations_cubit.dart';
import 'package:egypttour/views/place_screen/place_screen.dart';
import 'package:egypttour/views/search_screen_places/search_screen_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egypttour/views/home_screen/data/place_model.dart';
import 'package:egypttour/views/favourites_screen/data/favourites_shared.dart';
import 'package:egypttour/views/favourites_screen/data/favourites_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String _selectedCategory = 'Hotels';
  List<FavoritePlace> favoritePlaces = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
    // Fetching the places information
    BlocProvider.of<CityInformationsCubit>(context).fetchPlaces();
  }

  void loadFavorites() async {
    favoritePlaces = await FavoriteStorage.getFavorites();
    setState(() {});
  }

  bool isFavorite(Place place) {
    return favoritePlaces.any((fav) => fav.id == place.id);
  }

  void addToFavorites(Place place) async {
    final favorite = FavoritePlace(
      time: place.time,
      location: place.location!,
      rate: place.rate!,
      id: place.id!,
      name: place.name!,
      description: place.description!,
      imageUrl: place.img!,
    );
    if (!isFavorite(place)) {
      favoritePlaces.add(favorite);
      await FavoriteStorage.saveFavorites(favoritePlaces);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${place.name} added to favorites!'),
        ),
      );
    } else {
      favoritePlaces.removeWhere((fav) => fav.id == place.id);
      await FavoriteStorage.saveFavorites(favoritePlaces);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${place.name} removed from favorites!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CityInformationsCubit, CityInformationsState>(
        builder: (context, state) {
          if (state is CityInformationsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CityInformationsSuccess) {
            var places = state.governorate;
            var allPlaces = _getAllPlaces(places);
            return ListView(
              children: [
                _buildSearchBar(allPlaces),
                buildCategory('Hotels', places.hotels),
                buildCategory('Restaurants', places.restaurants),
                buildCategory('Museums', places.museums),
                buildCategory('Historical Sites', places.historicalSites),
              ],
            );
          } else if (state is CityInformationsFailure) {
            return Center(child: Text(state.errorMessge));
          }
          return Container();
        },
      ),
    );
  }

  List<Place> _getAllPlaces(Governorate governorate) {
    return [
      ...governorate.hotels,
      ...governorate.restaurants,
      ...governorate.museums,
      ...governorate.historicalSites,
    ];
  }

  Widget _buildSearchBar(List<Place> allPlaces) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchScreenPlaces(places: allPlaces),
              ),
            );
          },
          icon: const Icon(Icons.search),
        ),
        Center(
          child: SizedBox(
            height: 50.h,
            child: Image.asset(
              'assets/images/tourist.png',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCategory(String categoryName, List<Place> items) {
    if (_selectedCategory != categoryName) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.h, left: 16.w, bottom: 15.h),
          child: Text(
            'Categories'.tr(),
            style: TextStyle(fontSize: 24.sp, color: Color(0xffc39126)),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 9.w, right: 4.w),
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: CUSTRowICON(
                    image: 'assets/images/Historical Sites.png',
                    text1: 'Historical \n Sites'.tr(),
                    ontap: () {
                      setState(() {
                        _selectedCategory = 'Historical Sites';
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: CUSTRowICON(
                  image: 'assets/images/Museums.png',
                  text1: 'Museums'.tr(),
                  ontap: () {
                    setState(() {
                      _selectedCategory = 'Museums';
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: CUSTRowICON(
                  image: 'assets/images/Hotel.png',
                  text1: 'Hotels'.tr(),
                  ontap: () {
                    setState(() {
                      _selectedCategory = 'Hotels';
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: CUSTRowICON(
                  image: 'assets/images/Restaurants.png',
                  text1: 'Restaurants'.tr(),
                  ontap: () {
                    setState(() {
                      _selectedCategory = 'Restaurants';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.w),
          child: Center(
            child: Text(
              categoryName,
              style: GoogleFonts.sora(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.primaryColor,
              ),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final imageUrl = item.img!;
            final driveId = extractDriveId(imageUrl);
            print('URL: $imageUrl, Drive ID: $driveId');
            return GestureDetector(
              onDoubleTap: () {
                addToFavorites(item);
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaceScreen(
                      placeLocation: item.location!,
                      time: item.time,
                      rating: item.rate!,
                      img: item.img!,
                      placeNameText: item.name ?? 'none',
                      placeDescription: item.description ?? 'none',
                    ),
                  ),
                );
              },
              child: Card(
                color: ColorsManager.brown,
                margin: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 140.h,
                            child: Image.network(
                              'https://docs.google.com/uc?id=${extractDriveId(item.img!)}',
                            ),
                          ),
                          heightSpace(4.h),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            item.name!,
                            style: GoogleFonts.sora(
                              color: ColorsManager.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow[700]),
                              Text(item.rate ?? 'N/A'),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  isFavorite(item)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite(item)
                                      ? Colors.red
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  addToFavorites(item);
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
        ),
      ],
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
