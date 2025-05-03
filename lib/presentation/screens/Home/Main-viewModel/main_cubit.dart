import 'package:flutter_bloc/flutter_bloc.dart';
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


}
