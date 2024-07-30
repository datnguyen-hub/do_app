class TypeShip {
    int? partnerId;
    String? name;
    List<FeeWithTypeShip>? feeWithTypeShip;

    TypeShip({
        this.partnerId,
        this.name,
        this.feeWithTypeShip,
    });

    factory TypeShip.fromJson(Map<String, dynamic> json) => TypeShip(
        partnerId: json["partner_id"],
        name: json["name"],
        feeWithTypeShip: json["fee_with_type_ship"] == null ? [] : List<FeeWithTypeShip>.from(json["fee_with_type_ship"]!.map((x) => FeeWithTypeShip.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "partner_id": partnerId,
        "name": name,
        "fee_with_type_ship": feeWithTypeShip == null ? [] : List<dynamic>.from(feeWithTypeShip!.map((x) => x.toJson())),
    };
}

class FeeWithTypeShip {
    String? description;
    int? fee;
    dynamic shipSpeedCode;

    FeeWithTypeShip({
        this.description,
        this.fee,
        this.shipSpeedCode,
    });

    factory FeeWithTypeShip.fromJson(Map<String, dynamic> json) => FeeWithTypeShip(
        description: json["description"],
        fee: json["fee"],
        shipSpeedCode: json["ship_speed_code"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "fee": fee,
        "ship_speed_code": shipSpeedCode,
    };
}