class AddressData {
  static List<Map<String, dynamic>> addresses = [
    {
      'id': '1',
      'title': '경희대학교 전자정보대학관',
      'address': '경기 용인시 기흥구 덕영대로 1732 경희대학교 전자정보대학관',
      'instruction': '전화주시면 마중 나갈게요',
      'isSelected': true,
      'icon': 'location_on',
      'lat': 37.2974,
      'lng': 127.0456,
    },
    {
      'id': '2',
      'title': '소프트웨어중심대학협의회',
      'address': '서울특별시 강남구 테헤란로 7길 21 소프트웨어중심대학협의회',
      'instruction': '문 앞에 두고 벨 눌러주세요',
      'isSelected': false,
      'icon': 'business',
      'lat': 37.5665,
      'lng': 126.9780,
    },
    {
      'id': '3',
      'title': '한국시각장애인연합회',
      'address': '서울특별시 중구 세종대로 110 한국시각장애인연합회',
      'instruction': '문 앞에 두면 가져갈게요 (벨X, 노크X)',
      'isSelected': false,
      'icon': 'location_on',
      'lat': 37.5665,
      'lng': 126.9780,
    },
  ];

  static String getCurrentAddressTitle() {
    final currentAddress = addresses.firstWhere(
      (address) => address['isSelected'] == true,
      orElse: () => addresses.first,
    );
    return currentAddress['title'];
  }

  static Map<String, dynamic> getCurrentAddress() {
    return addresses.firstWhere(
      (address) => address['isSelected'] == true,
      orElse: () => addresses.first,
    );
  }

  static void updateAddress(String id, Map<String, dynamic> updatedData) {
    final index = addresses.indexWhere((address) => address['id'] == id);
    if (index != -1) {
      addresses[index] = {...addresses[index], ...updatedData};
    }
  }

  static void setSelectedAddress(String id) {
    // 모든 주소의 선택 상태를 false로 설정
    for (var address in addresses) {
      address['isSelected'] = false;
    }
    // 선택된 주소만 true로 설정
    final index = addresses.indexWhere((address) => address['id'] == id);
    if (index != -1) {
      addresses[index]['isSelected'] = true;
    }
  }

  static void deleteAddress(String id) {
    addresses.removeWhere((address) => address['id'] == id);
    // 삭제 후 현재 선택된 주소가 없으면 첫 번째 주소를 선택
    if (addresses.isNotEmpty && !addresses.any((address) => address['isSelected'] == true)) {
      addresses.first['isSelected'] = true;
    }
  }
}
