class Restaurant {
  final String id;
  final String name;
  final String description;
  final double rating;
  final int reviewCount;
  final String deliveryTime;
  final String deliveryFee;
  final String minOrder;
  final String imageUrl;
  final List<String> badges;
  final bool isAd;
  final List<MenuCategory> categories;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minOrder,
    required this.imageUrl,
    required this.badges,
    this.isAd = false,
    required this.categories,
  });
}

class MenuCategory {
  final String id;
  final String name;
  final List<MenuItem> items;

  MenuCategory({
    required this.id,
    required this.name,
    required this.items,
  });
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final int reviewCount;
  final String imageUrl;
  final List<String> badges;
  final List<MenuOption> options;
  final bool isPopular;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.reviewCount,
    required this.imageUrl,
    required this.badges,
    required this.options,
    this.isPopular = false,
  });
}

class MenuOption {
  final String id;
  final String name;
  final String type; // 'required', 'optional', 'quantity'
  final List<OptionChoice> choices;
  final int? maxChoices;

  MenuOption({
    required this.id,
    required this.name,
    required this.type,
    required this.choices,
    this.maxChoices,
  });
}

class OptionChoice {
  final String id;
  final String name;
  final int? price;
  final bool isDefault;

  OptionChoice({
    required this.id,
    required this.name,
    this.price,
    this.isDefault = false,
  });
}

// 장바구니 아이템 모델
class CartItem {
  final MenuItem menuItem;
  int quantity;
  final Map<String, String> selectedOptions;

  CartItem({
    required this.menuItem,
    required this.quantity,
    required this.selectedOptions,
  });
}
