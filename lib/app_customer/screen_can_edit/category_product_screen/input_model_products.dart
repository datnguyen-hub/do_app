class InputModelProducts {
  final int? categoryId;
  final FILTER_PRODUCTS? filterProducts;

  InputModelProducts({this.categoryId, this.filterProducts});
}

enum FILTER_PRODUCTS {
  TOP_SALE,
  NEW,
  DISCOUNT,
  VIEW,
}

final Map mapTypeActionSort = {
  FILTER_PRODUCTS.TOP_SALE: "sales",
  FILTER_PRODUCTS.NEW: "created_at",
  FILTER_PRODUCTS.DISCOUNT: "discount",
  FILTER_PRODUCTS.VIEW: "views",
};
