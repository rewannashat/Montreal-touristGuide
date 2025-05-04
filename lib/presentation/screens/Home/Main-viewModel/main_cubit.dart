import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Main-Model/hotelCard_model.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of<MainCubit>(context);

  List<String> categories = ['hotels', 'restaurants', 'tourist', 'entertainment'];
  int selectedCategoryIndex = 0;

  final List<HotelModel> allHotels = [
    HotelModel(
      imagePath: 'assets/images/rec.png',
      title: 'Hilton Garden',
      location: '500m city center',
      rating: 4.96,
      category: 'hotels',
    ),
    HotelModel(
      imagePath: 'assets/images/rec.png',
      title: 'Urban Stay',
      location: '300m city center',
      rating: 4.80,
      category: 'hotels',
    ),
    HotelModel(
      imagePath: 'assets/images/rec.png',
      title: 'Sushi Place',
      location: '1.2km downtown',
      rating: 4.5,
      category: 'restaurants',
    ),
    HotelModel(
      imagePath: 'assets/images/rec.png',
      title: 'Museum Visit',
      location: '700m central park',
      rating: 4.7,
      category: 'tourist',
    ),
  ];


  void selectCategory(int index) {
    selectedCategoryIndex = index;
    emit(MainCategoryChanged());
  }

  List<HotelModel> get filteredHotels {
    final selectedCategory = categories[selectedCategoryIndex];
    return allHotels.where((hotel) {
      return hotel.category == selectedCategory;
    }).toList();
  }


  /// get My location
  LatLng? userLatLng;
  Future<LatLng?> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return null;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }



}
