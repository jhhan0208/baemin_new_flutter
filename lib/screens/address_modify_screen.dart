import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';
import '../data/address_data.dart';

class AddressModifyScreen extends StatefulWidget {
  final Map<String, dynamic> addressData;

  const AddressModifyScreen({
    Key? key,
    required this.addressData,
  }) : super(key: key);

  @override
  State<AddressModifyScreen> createState() => _AddressModifyScreenState();
}

class _AddressModifyScreenState extends State<AddressModifyScreen> {
  late TextEditingController _addressDetailController;
  late TextEditingController _addressNameController;
  late TextEditingController _riderInstructionController;
  late TextEditingController _entrancePasswordController;
  late TextEditingController _directionsController;

  String _selectedAddressType = '직접입력';

  final List<String> _addressTypes = ['우리집', '회사', '직접입력'];
  final List<String> _riderInstructions = [
    '전화주시면 마중 나갈게요',
    '문 앞에 두고 벨 눌러주세요',
    '문 앞에 두면 가져갈게요 (벨X, 노크X)',
    '건물 중앙문 앞',
    '6층와서 전화주세요',
  ];

  @override
  void initState() {
    super.initState();
    _addressDetailController =
        TextEditingController(text: widget.addressData['address']);
    _addressNameController =
        TextEditingController(text: widget.addressData['title']);
    _riderInstructionController =
        TextEditingController(text: widget.addressData['instruction']);
    _entrancePasswordController = TextEditingController();
    _directionsController = TextEditingController();
  }

  @override
  void dispose() {
    _addressDetailController.dispose();
    _addressNameController.dispose();
    _riderInstructionController.dispose();
    _entrancePasswordController.dispose();
    _directionsController.dispose();
    super.dispose();
  }

  Future<void> _openExternalUrl(String url) async {
    final uri = Uri.parse(url);
    final ok = await canLaunchUrl(uri);
    if (!ok) {
      _showSnackBar('링크를 열 수 없습니다.');
      return;
    }
    await launchUrl(
      uri,
      mode:
          kIsWeb ? LaunchMode.platformDefault : LaunchMode.externalApplication,
    );
  }

  Future<void> _openMap(double lat, double lng, String title) async {
    final kakaoMapUrl = 'https://map.kakao.com/link/map/$title,$lat,$lng';
    final googleMapUrl = 'https://www.google.com/maps?q=$lat,$lng';

    // 웹: 카카오맵 링크, 모바일: 구글맵 링크(설치 안돼도 브라우저로 열림)
    final url = kIsWeb ? kakaoMapUrl : googleMapUrl;
    await _openExternalUrl(url);
  }

  Future<void> _openDaumPostcodeUrl() async {
    // 간단: 우편번호 검색 안내/데모 페이지로 이동 (실사용 시 자체 검색 화면으로 대체 가능)
    const url = 'https://postcode.map.daum.net/guide';
    await _openExternalUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '주소 상세',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMapSection(),
            const SizedBox(height: 24),
            _buildAddressSection(),
            const SizedBox(height: 24),
            _buildAddressTypeSection(),
            const SizedBox(height: 24),
            _buildRiderInstructionSection(),
            const SizedBox(height: 24),
            _buildEntrancePasswordSection(),
            const SizedBox(height: 24),
            _buildDirectionsSection(),
            const SizedBox(height: 24),
            _buildInfoText(),
            const SizedBox(height: 32),
            _buildRegisterButton(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    final lat = (widget.addressData['lat'] ?? 37.2974).toDouble();
    final lng = (widget.addressData['lng'] ?? 127.0456).toDouble();
    final title = widget.addressData['title'] ?? '현재 위치';

    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            _buildPlaceholderMap(),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'MAP',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: ElevatedButton.icon(
                onPressed: () => _openMap(lat, lng, title),
                icon: const Icon(Icons.map),
                label: const Text('지도로 열기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderMap() {
    final lat = (widget.addressData['lat'] ?? 37.2974).toDouble();
    final lng = (widget.addressData['lng'] ?? 127.0456).toDouble();
    final title = widget.addressData['title'] ?? '현재 위치';

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[100]!,
            Colors.green[100]!,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 50,
              color: AppColors.baeminMint,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '위도: ${lat.toStringAsFixed(4)}, 경도: ${lng.toStringAsFixed(4)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    final shownAddr = widget.addressData['address'] ?? '경기 용인시 기흥구 덕영대로 1732';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '주소',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              // 웹/모바일 모두 우편번호/주소 검색 페이지를 외부로 여는 방식
              await _openDaumPostcodeUrl();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[100],
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('주소 검색'),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '표시된 위치가 다르다면 지도로 열기를 눌러 변경해주세요',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          shownAddr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '주소 상세',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _addressDetailController,
          decoration: InputDecoration(
            hintText: '상세 주소를 입력하세요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: _addressTypes.map((type) {
            final isSelected = _selectedAddressType == type;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedAddressType = type;
                    });
                  },
                  icon: Icon(
                    type == '우리집'
                        ? Icons.home
                        : type == '회사'
                            ? Icons.business
                            : Icons.location_on,
                    size: 16,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  label: Text(
                    type,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.black : Colors.white,
                    side: BorderSide(color: Colors.grey[400]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _addressNameController,
          decoration: InputDecoration(
            hintText: '주소 이름을 입력하세요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildRiderInstructionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '라이더님께',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _riderInstructionController,
          decoration: InputDecoration(
            hintText: '배달 요청사항을 입력하세요',
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(Icons.keyboard_arrow_down),
              onSelected: (String value) {
                setState(() {
                  _riderInstructionController.text = value;
                });
              },
              itemBuilder: (BuildContext context) {
                return _riderInstructions.map((String instruction) {
                  return PopupMenuItem<String>(
                    value: instruction,
                    child: Text(instruction),
                  );
                }).toList();
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildEntrancePasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '공동현관 비밀번호',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _entrancePasswordController,
          decoration: InputDecoration(
            hintText: '예) #1234',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDirectionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '찾아오는 길 안내',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _directionsController,
          decoration: InputDecoration(
            hintText: '예) 편의점 옆 건물이에요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoText() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.grey[600],
            size: 16,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              '입력된 공동현관 비밀번호는 원활한 배달을 위해 필요한 정보로, 배달을 진행하는 라이더님과 사장님께 전달됩니다.',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 100, 97, 97),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          AddressData.updateAddress(
            widget.addressData['id'],
            {
              'title': _addressNameController.text,
              'address': _addressDetailController.text,
              'instruction': _riderInstructionController.text,
            },
          );

          _showSnackBar('주소가 수정되었습니다.');
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          '주소 등록',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.baeminMint,
      ),
    );
  }
}
