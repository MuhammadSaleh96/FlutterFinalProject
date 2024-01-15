
import 'package:firebase_database/firebase_database.dart';

class CountryModel{
  String? countryName;
  String? imageUrl;
  String? countryDesc;
  String? numOfTours;
  String? rating;
  String? price;
  
 
 
  CountryModel({
    required this.countryName,
    required this.imageUrl,
    required this.countryDesc, 
    required this.numOfTours, 
    required this.rating, 
    required this.price
    }
  );
 
 
Map<dynamic, dynamic>toMap(){
  return{
    "countryName": countryName,
    'imageUrl': imageUrl,
    'desc': countryDesc,
    'numOfTours': numOfTours,
    'rating': rating,
    'price': price
  };
}
factory CountryModel.fromMap(Map<dynamic, dynamic> map){
  return CountryModel(
    countryName: map["countryName"],
    imageUrl: map["imageUrl"], 
    countryDesc: map["desc"],
    numOfTours: map["numOfTours"],
    rating: map["rating"],
    price: map["price"],
  );
  }
}
  
// Add data to database using instance of dbRef using (toMap method) that takes object class model.
  void addtodb() {
    final DatabaseReference dataref =
        FirebaseDatabase.instance.ref().child("Countries");
    for (int i = 0; i < countryNames.length; i++) {
      CountryModel country = CountryModel(
          countryName: countryNames[i], imageUrl: images[i], countryDesc: tripDesc[i], numOfTours: numOfTour[i], rating: rates[i], price: prices[i]);
      dataref.push().set(country.toMap()).then((value) {
        print("Products Details Added Sucessfully");
      });
    }
}

List<String> images = [
  "../images/sao paulo.jpg",
  "../images/barcelona.jpg",
  "../images/singapore.jpg",
  "../images/patera.jpg"
];

List<String> numOfTour =[
  "10 tours", "6 tours", "12 tours", "7 tours"
];

List<String> tripDesc = [
  "Brazil is the largest country in South America, covering a significant portion of the continent. The Amazon Rainforest, the world largest tropical rainforest, is a major part of Brazils landscape, showcasing incredible biodiversity.",
  "Spain, a vibrant European destination, enchants visitors with its rich history, diverse cultural heritage, iconic landmarks like the Sagrada Familia, Flamenco dance, and picturesque landscapes from the beaches of Costa del Sol to the historic streets of Barcelona.",
  "Singapore, a dynamic city-state, beckons tourists with its futuristic skyline, multicultural ambiance, delectable street food, and iconic attractions like Marina Bay Sands and Gardens by the Bay.",
  "Jordan, a captivating Middle Eastern gem, boasts ancient wonders such as Petra and the Dead Sea, offering a rich blend of history, culture, and natural beauty for travelers to explore.",
];

List<String> countryNames = ["Brazil", "Spain", "Singapore", "Jordan"];

List<String> prices = ["499.99 JD", "299.49 JD", "699.99 JD", "269.99 JD"];

List<String> rates = ["4.3", "3.9", "4.8", "4.5"];


