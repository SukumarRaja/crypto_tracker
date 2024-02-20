class GraphModel {
  DateTime? date;
  double? price;

  GraphModel({this.date, this.price});

  GraphModel.fromList(List<dynamic> list) {
    date = DateTime.fromMillisecondsSinceEpoch(list[0]);
    price = list[1].toDouble();
  }
}
