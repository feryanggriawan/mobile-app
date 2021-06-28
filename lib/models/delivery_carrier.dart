class DeliveryCarrier {
  String by;
  int status;
  OngkirCarrier ongkir;

  DeliveryCarrier({this.by, this.status, this.ongkir});

  DeliveryCarrier.fromJson(Map<String, dynamic> json) {
    by = json['by'];
    status = json['status'];
    ongkir = json['ongkir'] != null
        ? new OngkirCarrier.fromJson(json['ongkir'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['status'] = this.status;
    if (this.ongkir != null) {
      data['ongkir'] = this.ongkir.toJson();
    }
    return data;
  }
}

class OngkirCarrier {
  Query query;
  Status status;
  OriginCarrierDetails originDetails;
  OriginCarrierDetails destinationDetails;
  List<ResultsCarrier> results;

  OngkirCarrier(
      {this.query,
      this.status,
      this.originDetails,
      this.destinationDetails,
      this.results});

  OngkirCarrier.fromJson(Map<String, dynamic> json) {
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    originDetails = json['origin_details'] != null
        ? new OriginCarrierDetails.fromJson(json['origin_details'])
        : null;
    destinationDetails = json['destination_details'] != null
        ? new OriginCarrierDetails.fromJson(json['destination_details'])
        : null;
    if (json['results'] != null) {
      results = new List<ResultsCarrier>();
      json['results'].forEach((v) {
        results.add(new ResultsCarrier.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.query != null) {
      data['query'] = this.query.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.originDetails != null) {
      data['origin_details'] = this.originDetails.toJson();
    }
    if (this.destinationDetails != null) {
      data['destination_details'] = this.destinationDetails.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Query {
  String origin;
  String originType;
  String destination;
  String destinationType;
  int weight;
  String courier;

  Query(
      {this.origin,
      this.originType,
      this.destination,
      this.destinationType,
      this.weight,
      this.courier});

  Query.fromJson(Map<String, dynamic> json) {
    origin = json['origin'];
    originType = json['originType'];
    destination = json['destination'];
    destinationType = json['destinationType'];
    weight = json['weight'];
    courier = json['courier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin'] = this.origin;
    data['originType'] = this.originType;
    data['destination'] = this.destination;
    data['destinationType'] = this.destinationType;
    data['weight'] = this.weight;
    data['courier'] = this.courier;
    return data;
  }
}

class Status {
  int code;
  String description;

  Status({this.code, this.description});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class OriginCarrierDetails {
  String cityId;
  String provinceId;
  String province;
  String type;
  String cityName;
  String postalCode;

  OriginCarrierDetails(
      {this.cityId,
      this.provinceId,
      this.province,
      this.type,
      this.cityName,
      this.postalCode});

  OriginCarrierDetails.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['province_id'] = this.provinceId;
    data['province'] = this.province;
    data['type'] = this.type;
    data['city_name'] = this.cityName;
    data['postal_code'] = this.postalCode;
    return data;
  }
}

class ResultsCarrier {
  String code;
  String name;
  List<Costs> costs;

  ResultsCarrier({this.code, this.name, this.costs});

  ResultsCarrier.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    if (json['costs'] != null) {
      costs = new List<Costs>();
      json['costs'].forEach((v) {
        costs.add(new Costs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    if (this.costs != null) {
      data['costs'] = this.costs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Costs {
  String service;
  String description;
  List<Cost> cost;

  Costs({this.service, this.description, this.cost});

  Costs.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    description = json['description'];
    if (json['cost'] != null) {
      cost = new List<Cost>();
      json['cost'].forEach((v) {
        cost.add(new Cost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service'] = this.service;
    data['description'] = this.description;
    if (this.cost != null) {
      data['cost'] = this.cost.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cost {
  int value;
  String etd;
  String note;

  Cost({this.value, this.etd, this.note});

  Cost.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    etd = json['etd'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['etd'] = this.etd;
    data['note'] = this.note;
    return data;
  }
}
