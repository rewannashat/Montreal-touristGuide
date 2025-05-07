import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial()) {
    fetchPlaces(); // Fetch data on init
  }

  static MainCubit get(context) => BlocProvider.of(context);

  List<String> categories = ['hotel', 'restaurant', 'tourist', 'entertainment'];
  int selectedCategoryIndex = 0;

  List<Map<String, dynamic>> allPlaces = [];
  List<Map<String, dynamic>> filteredPlaces = [];
  List<Map<String, dynamic>> topHotels = [];


  void selectCategory(int index) {
    selectedCategoryIndex = index;
    filterPlaces();
    emit(MainCategoryChanged());
  }

  List<Map<String, dynamic>> get filteredHotels => filteredPlaces;

  void fetchPlaces() async {
    emit(MainLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('places') // Searches all subcollections named 'places'
          .get();

      allPlaces = snapshot.docs.map((doc) => doc.data()).toList();
      topHotels = allPlaces.where((place) => place['isTopHotel'] == true).toList();
      /*print('📦 All places: ${allPlaces.length} === ${topHotels}');
      for (var place in allPlaces) {
        print('✅ Place: ${place['name']}, isTopHotel: ${place['isTopHotel']}');
      }*/

      filterPlaces();
      emit(MainSuccess());
    } catch (e) {
      emit(MainError(e.toString()));
    }
  }

  void filterPlaces() {
    final selectedCategory = categories[selectedCategoryIndex];
    filteredPlaces = allPlaces
        .where((place) =>
    place['category']?.toString().toLowerCase() == selectedCategory.toLowerCase())
        .toList();
  }

  /// Get current location
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
