import 'package:get/get.dart';

class LocationViewController extends GetxController {
  //observable list to hold filtered location that match the search criteria
  List<String> filterlocationsList = <String>[].obs;
  //list of all locations
  List<String> alllocationsList = [
    'Kathmandu, Nepal',
    'Bhaktapur, Nepal',
    'Lalitpur, Nepal',
    'Surkhet, Nepal',
    'Makwanpur, Nepal',
    'Birgunj, Nepal',
    'Nawalparasi, Nepal',
    'Dailekh, Nepal',
    'Doti, Nepal',
    'Jumla, Nepal',
    'Humla, Nepal',
    'Banke, Nepal',
    'Bardiya, Nepal',
    'Janakpur, Nepal',
    'Washington D.C., US',
    'Tokyo, Japan',
    'London, UK',
    'Paris, France',
    'Hetauda, Nepal',
    'Beijing, China',
    'New Delhi, India',
    'Ottawa, Canada',
    'Canberra, Australia',
    'Moscow, Russia',
    'Rome, Italy',
    'Madrid, Spain',
    'Seoul, South Korea',
    'Jakarta, Indonesia',
    'Bangkok, Thailand',
    'Brasília, Brazil',
    'Buenos Aires, Argentina',
    'Cairo, Egypt',
    'Mexico City, Mexico',
    'Riyadh, Saudi Arabia',
    'Ankara, Turkey',
    'Pretoria, South Africa',
    'Tehran, Iran',
    'Baghdad, Iraq',
    'Kuala Lumpur, Malaysia',
    'Abuja, Nigeria',
    'Stockholm, Sweden',
    'Oslo, Norway',
    'Helsinki, Finland',
    'Copenhagen, Denmark',
    'Lisbon, Portugal',
    'Athens, Greece',
    'Amsterdam, Netherlands',
    'Vienna, Austria',
    'Manila, Philippines',
    'Islamabad, Pakistan',
    'Singapore, Singapore',
    'Hanoi, Vietnam',
    'Dhaka, Bangladesh',
    'Wellington, New Zealand',
    'Bogotá, Colombia',
    'Caracas, Venezuela',
    'Lima, Peru',
    'Warsaw, Poland',
    'Brussels, Belgium',
    'Bern, Switzerland',
    'Dublin, Ireland',
    'Prague, Czech Republic',
    'Budapest, Hungary',
    'Bratislava, Slovakia',
    'Sofia, Bulgaria',
    'Bucharest, Romania',
    'Havana, Cuba',
    'San José, Costa Rica',
    'Santiago, Chile',
    'Montevideo, Uruguay',
    'Doha, Qatar',
    'Muscat, Oman',
    'Kuwait City, Kuwait',
    'Manama, Bahrain',
    'Suva, Fiji',
    'Port Louis, Mauritius',
    'Colombo, Sri Lanka',
    'Nairobi, Kenya',
    'Accra, Ghana',
    'Harare, Zimbabwe',
    'Kigali, Rwanda',
    'Dakar, Senegal',
    'Baku, Azerbaijan',
    'Tbilisi, Georgia',
    'Yerevan, Armenia',
    'Astana, Kazakhstan',
    'Tashkent, Uzbekistan',
    'Bishkek, Kyrgyzstan',
    'Ashgabat, Turkmenistan',
    'Ulaanbaatar, Mongolia',
    'Vientiane, Laos',
    'Thimphu, Bhutan',
    'Male, Maldives',
    'Port Moresby, New Guinea',
  ];


  @override
  void onReady() {
    //initially add all available location to filterlocation list
    filterlocationsList.addAll(alllocationsList);
    super.onReady();
  }

  onSearchLocation(String value) {
    filterlocationsList.clear();
    filterlocationsList.addAll(alllocationsList
        .where((e) => e.toLowerCase().contains(value.toLowerCase())));
  }

  onLocationSelection(int index) {
    //close the current view and return the selected location
    Get.back(result: filterlocationsList[index]);
  }
}
