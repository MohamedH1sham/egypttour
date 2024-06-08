import 'package:easy_localization/easy_localization.dart';
import 'package:egypttour/theming/colors_manager.dart';
import 'package:egypttour/views/city_screen/city_screen.dart';
import 'package:egypttour/views/floating_action/city_text_and_endpoint_model.dart';
import 'package:egypttour/views/home_screen/data/cubit/city_informations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  final List<CityModel> cities;

  const SearchScreen({super.key, required this.cities});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    List<CityModel> filteredCities = widget.cities
        .where((city) =>
            city.cityText.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

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
                onChanged: (value) => setState(() => searchText = value),
                decoration: InputDecoration(
                  labelText: 'Search for a city'.tr(),
                  labelStyle: const TextStyle(fontSize: 22),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(
                  height:
                      10),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = filteredCities[index];
                    final isArabic = context.locale.languageCode == 'ar';
                    final endpoint =
                        isArabic ? city.endpointAr : city.endpointEn;
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
                              fontSize: 24, color: Color(0xffFAFAFA)),
                        ),
                        title: Text(
                          city.cityText,
                          style: const TextStyle(
                              fontSize: 24, color: Color(0xffFAFAFA)),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) => CityInformationsCubit(
                                    endpoint, city.weatherEndPoint)
                                  ..fetchPlaces(),
                                child: const CityScreen(),
                              ),
                            ),
                          );
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
