class ShippingCompany {
    int? partnerId;
    String? name;
    String? logo;

    ShippingCompany({
        this.partnerId,
        this.name,
        this.logo,
    });

    factory ShippingCompany.fromJson(Map<String, dynamic> json) => ShippingCompany(
        partnerId: json["partner_id"],
        name: json["name"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "partner_id": partnerId,
        "name": name,
        "logo": logo,
    };
}