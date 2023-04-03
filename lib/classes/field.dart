class Field {
  String? id;
  String? type;
  String? title;
  String? link;
  bool? visible;
  int? order;
  int? click;

  Field({this.type, this.title, this.link,this.visible,this.order,this.click});

  Field.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    link = json['link'];
    visible = json['visible'];
    order = json['order'];
    click = json['click'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['link'] = link;
    data['visible'] = visible;
    data['order'] = order;
    data['click'] = click;
    return data;
  }
}