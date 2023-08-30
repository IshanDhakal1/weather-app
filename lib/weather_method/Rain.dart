class Rain {
  Rain({
      this.h,});

  Rain.fromJson(dynamic json) {
    h = json['1h'];
  }
  double h;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['1h'] = h;
    return map;
  }

}