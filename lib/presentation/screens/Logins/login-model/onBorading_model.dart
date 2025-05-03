class OnBoardingModel {
  final String image;
  final String title;
  final String subtitle;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

 List<OnBoardingModel> onboardingPages = [
  OnBoardingModel(
    image: 'assets/images/img_1.png',
    title: 'Everything you need to know\n about the city',
    subtitle: '',
  ),
  OnBoardingModel(
    image: 'assets/images/onboard2.png',
    title: 'let\'s enjoy a new world',
    subtitle: 'search the safest destination',
  ),

];

