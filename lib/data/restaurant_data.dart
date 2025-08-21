import '../models/restaurant.dart';

class RestaurantData {
  static List<Restaurant> getRestaurants() {
    return [
      // 1. Poke all day 포케&샐러드 영통점
      Restaurant(
        id: '1',
        name: 'Poke all day 포케&샐러드 영통점',
        description: '스파이시 연어 참치 프로틴 포케, 단백질 35g, 몸 관리 중에도 매운 맛은 못참지',
        rating: 5.0,
        reviewCount: 1578,
        deliveryTime: '12~27분',
        deliveryFee: '무료배달 1,000원',
        minOrder: '최소주문 12,000원',
        imageUrl: 'assets/img/poke_all_day.jpg',
        badges: ['배민클럽'],
        isAd: true,
        categories: [
          MenuCategory(
            id: '1',
            name: '인기 메뉴',
            items: [
              MenuItem(
                id: '1-1',
                name: '스파이시 연어 참치 프로틴 포케(야채 베이스 없음)',
                description:
                    '단백질 35g, 몸 관리 중에도 매운 맛은 못참지, K 한국인의 입맛까지 사로 잡는 스파이시 포케',
                price: 13900,
                reviewCount: 150,
                imageUrl: 'assets/img/spicy_poke.jpg',
                badges: ['인기 4위', '사장님 추천'],
                isPopular: true,
                options: [
                  MenuOption(
                    id: '1-1-1',
                    name: '토핑 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '1-1-1-1', name: '현미밥', isDefault: true),
                      OptionChoice(id: '1-1-1-2', name: '퀴노아밥', price: 1000),
                      OptionChoice(id: '1-1-1-3', name: '메밀면', price: 1000),
                    ],
                  ),
                  MenuOption(
                    id: '1-1-2',
                    name: '소스 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(
                          id: '1-1-2-1', name: '스리라차 마요소스', isDefault: true),
                      OptionChoice(id: '1-1-2-2', name: '와사비 마요소스'),
                      OptionChoice(id: '1-1-2-3', name: '고추장 소스'),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '1-2',
                name: '곡물밥 포케',
                description: '건강한 곡물밥과 신선한 연어가 만나는 클래식 포케',
                price: 12900,
                reviewCount: 89,
                imageUrl: 'assets/img/grain_poke.jpg',
                badges: ['인기 2위'],
                isPopular: true,
                options: [
                  MenuOption(
                    id: '1-2-1',
                    name: '토핑 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '1-2-1-1', name: '현미밥', isDefault: true),
                      OptionChoice(id: '1-2-1-2', name: '퀴노아밥', price: 1000),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '1-3',
                name: '메밀면 포케',
                description: '시원한 메밀면과 신선한 해산물이 어우러진 특별한 포케',
                price: 12900,
                reviewCount: 67,
                imageUrl: 'assets/img/buckwheat_poke.jpg',
                badges: ['신메뉴'],
                options: [
                  MenuOption(
                    id: '1-3-1',
                    name: '소스 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(
                          id: '1-3-1-1', name: '간장 소스', isDefault: true),
                      OptionChoice(id: '1-3-1-2', name: '고추장 소스'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          MenuCategory(
            id: '2',
            name: '포케올데이 X 타바',
            items: [
              MenuItem(
                id: '2-1',
                name: '타바스코 스파이시 포케',
                description: '타바스코 소스와 매콤달콤한 고추장이 만나는 특별한 포케',
                price: 14900,
                reviewCount: 45,
                imageUrl: 'assets/img/tabasco_poke.jpg',
                badges: ['한정판매'],
                options: [
                  MenuOption(
                    id: '2-1-1',
                    name: '매운 정도',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '2-1-1-1', name: '순한맛', isDefault: true),
                      OptionChoice(id: '2-1-1-2', name: '중간맛'),
                      OptionChoice(id: '2-1-1-3', name: '매운맛'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // 2. 뱃살도둑 샐러드&포케 영통점
      Restaurant(
        id: '2',
        name: '뱃살도둑 샐러드&포케 영통점',
        description: '목살 스테이크 포케, [한정판매] 생연어 포케, 건강한 다이어트 식단',
        rating: 4.9,
        reviewCount: 904,
        deliveryTime: '12~27분',
        deliveryFee: '무료배달 1,000원',
        minOrder: '최소주문 12,900원',
        imageUrl: 'assets/img/belly_thief.jpg',
        badges: ['배민클럽'],
        categories: [
          MenuCategory(
            id: '3',
            name: '인기 메뉴',
            items: [
              MenuItem(
                id: '3-1',
                name: '목살 스테이크 포케',
                description: '부드러운 목살 스테이크와 신선한 채소가 어우러진 프리미엄 포케',
                price: 15900,
                reviewCount: 234,
                imageUrl: 'assets/img/pork_poke.jpg',
                badges: ['인기 1위', '사장님 추천'],
                isPopular: true,
                options: [
                  MenuOption(
                    id: '3-1-1',
                    name: '밥 종류',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '3-1-1-1', name: '현미밥', isDefault: true),
                      OptionChoice(id: '3-1-1-2', name: '퀴노아밥', price: 1000),
                      OptionChoice(id: '3-1-1-3', name: '카무트밥', price: 1500),
                    ],
                  ),
                  MenuOption(
                    id: '3-1-2',
                    name: '추가 토핑',
                    type: 'optional',
                    maxChoices: 3,
                    choices: [
                      OptionChoice(id: '3-1-2-1', name: '아보카도', price: 2000),
                      OptionChoice(id: '3-1-2-2', name: '견과류 믹스', price: 1500),
                      OptionChoice(id: '3-1-2-3', name: '치즈', price: 1000),
                      OptionChoice(id: '3-1-2-4', name: '계란', price: 1000),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '3-2',
                name: '[한정판매] 생연어 포케',
                description: '신선한 생연어와 다양한 채소가 만나는 클래식 포케',
                price: 17900,
                reviewCount: 156,
                imageUrl: 'assets/img/salmon_poke.jpg',
                badges: ['한정판매', '인기 3위'],
                isPopular: true,
                options: [
                  MenuOption(
                    id: '3-2-1',
                    name: '밥 종류',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '3-2-1-1', name: '현미밥', isDefault: true),
                      OptionChoice(id: '3-2-1-2', name: '퀴노아밥', price: 1000),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '3-3',
                name: '닭가슴살 샐러드',
                description: '단백질이 풍부한 닭가슴살과 신선한 채소로 만든 건강한 샐러드',
                price: 12900,
                reviewCount: 89,
                imageUrl: 'assets/img/chicken_salad.jpg',
                badges: ['다이어트'],
                options: [
                  MenuOption(
                    id: '3-3-1',
                    name: '드레싱',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(
                          id: '3-3-1-1', name: '올리브오일', isDefault: true),
                      OptionChoice(id: '3-3-1-2', name: '발사믹 드레싱'),
                      OptionChoice(id: '3-3-1-3', name: '레몬 드레싱'),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '3-4',
                name: '퀴노아 샐러드',
                description: '슈퍼푸드 퀴노아와 신선한 채소가 만나는 건강한 샐러드',
                price: 11900,
                reviewCount: 67,
                imageUrl: 'assets/img/quinoa_salad.jpg',
                badges: ['비건'],
                options: [
                  MenuOption(
                    id: '3-4-1',
                    name: '드레싱',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(
                          id: '3-4-1-1', name: '올리브오일', isDefault: true),
                      OptionChoice(id: '3-4-1-2', name: '발사믹 드레싱'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // 3. 읍천리382 서천점
      Restaurant(
        id: '3',
        name: '읍천리382 서천점',
        description: '신선도100% 포케 샐러드, [겉바속촉] 치킨텐더 포케 샐러드, 천리만의 특별한 맛',
        rating: 4.9,
        reviewCount: 419,
        deliveryTime: '16~26분',
        deliveryFee: '무료배달 3,700원',
        minOrder: '최소주문 16,000원',
        imageUrl: 'assets/img/eupcheonri.jpg',
        badges: ['배민클럽'],
        isAd: true,
        categories: [
          MenuCategory(
            id: '4',
            name: '인기 메뉴',
            items: [
              MenuItem(
                id: '4-1',
                name: '신선도100% 포케 샐러드',
                description: '가장 기본적인 것이 가장 아름답다 고로, 이것은 읍천리만의 손색없는 시그니처 메뉴',
                price: 9900,
                reviewCount: 9,
                imageUrl: 'assets/img/fresh_poke.jpg',
                badges: ['사장님 추천'],
                isPopular: true,
                options: [
                  MenuOption(
                    id: '4-1-1',
                    name: '토핑 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '4-1-1-1', name: '현미밥', isDefault: true),
                      OptionChoice(id: '4-1-1-2', name: '퀴노아밥', price: 1000),
                      OptionChoice(id: '4-1-1-3', name: '메밀면', price: 1000),
                    ],
                  ),
                  MenuOption(
                    id: '4-1-2',
                    name: '소스 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(
                          id: '4-1-2-1',
                          name: '랜치 드레싱 (연어 / 오리훈제 조합)',
                          isDefault: true),
                      OptionChoice(id: '4-1-2-2', name: '고추장 소스'),
                      OptionChoice(id: '4-1-2-3', name: '와사비 마요소스'),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '4-2',
                name: '[겉바속촉] 치킨텐더 포케 샐러드',
                description: '갓 튀긴 바삭바삭하고 짭짤한 맛이 일품인 치킨텐더가 올라간 매력적인 포케',
                price: 11900,
                reviewCount: 27,
                imageUrl: 'assets/img/chicken_tender_poke.jpg',
                badges: ['사장님 추천'],
                isPopular: true,
                options: [
                  MenuOption(
                    id: '4-2-1',
                    name: '토핑 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '4-2-1-1', name: '현미밥', isDefault: true),
                      OptionChoice(id: '4-2-1-2', name: '퀴노아밥', price: 1000),
                    ],
                  ),
                  MenuOption(
                    id: '4-2-2',
                    name: '소스 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(
                          id: '4-2-2-1', name: '랜치 드레싱', isDefault: true),
                      OptionChoice(id: '4-2-2-2', name: '고추장 소스'),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '4-3',
                name: '[연어 큐브] 연어 포케 샐러드',
                description: '신선한 연어와 다양한 채소들이 만나는 클래식 포케',
                price: 9900,
                reviewCount: 15,
                imageUrl: 'assets/img/salmon_cube_poke.jpg',
                badges: ['신메뉴'],
                options: [
                  MenuOption(
                    id: '4-3-1',
                    name: '토핑 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '4-3-1-1', name: '현미밥', isDefault: true),
                      OptionChoice(id: '4-3-1-2', name: '퀴노아밥', price: 1000),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '4-4',
                name: '들기름 메밀면 샐러드',
                description: '고소한 들기름과 쫄깃한 메밀면이 어우러진 특별한 샐러드',
                price: 8900,
                reviewCount: 23,
                imageUrl: 'assets/img/buckwheat_salad.jpg',
                badges: ['시즌메뉴'],
                options: [
                  MenuOption(
                    id: '4-4-1',
                    name: '소스 택1',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(
                          id: '4-4-1-1', name: '들기름 소스', isDefault: true),
                      OptionChoice(id: '4-4-1-2', name: '고추장 소스'),
                    ],
                  ),
                ],
              ),
              MenuItem(
                id: '4-5',
                name: '[무조건]아메리카노',
                description: '깊고 진한 에스프레소의 맛을 그대로 느낄 수 있는 클래식 아메리카노',
                price: 3500,
                reviewCount: 45,
                imageUrl: 'assets/img/americano.jpg',
                badges: ['베스트'],
                options: [
                  MenuOption(
                    id: '4-5-1',
                    name: 'ICE/HOT',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(id: '4-5-1-1', name: 'ICE', isDefault: true),
                      OptionChoice(id: '4-5-1-2', name: 'HOT'),
                    ],
                  ),
                  MenuOption(
                    id: '4-5-2',
                    name: '뚜껑 선택',
                    type: 'required',
                    maxChoices: 1,
                    choices: [
                      OptionChoice(
                          id: '4-5-2-1', name: '기본 뚜껑 (기본)', isDefault: true),
                      OptionChoice(id: '4-5-2-2', name: '빨대 뚜껑'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
