class ProductInfo {
  String? label; 
  String? countryName;
  int? numOfTours;
  double? rating;
  String? imageurl;
  String? subTitle;
  String? moreDescription;
 
ProductInfo(
  {
      required    this.countryName, 
      required    this.label, 
      required    this.numOfTours, 
      required    this.rating, 
      required   this.imageurl,
      required    this.subTitle,
      required    this.moreDescription, 
  }
);
 
Map<dynamic, dynamic>toMap(){
  return{
    'label': label,
    'desc': moreDescription,
    'numOfTours': numOfTours,
    'rating': rating,
    'imageUrl': imageurl,
    'subTitle': subTitle,
    'countryName': countryName
};
}
factory ProductInfo.fromMap(Map<dynamic, dynamic> map){
  return ProductInfo(
    label: map["label"],
    moreDescription: map["desc"],
    numOfTours: map["numOfTours"],
    rating: map["rating"],
    imageurl: map["imageUrl"], 
    subTitle: map["subTitle"],
    countryName: map["countryName"],
  );
}
}