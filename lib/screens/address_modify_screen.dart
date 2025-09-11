import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import 'dart:js' as js;
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

    // 웹에서 iframe 생성
    if (kIsWeb) {
      _createMapIframe();
    }
  }

  void _createMapIframe() {
    final lat = widget.addressData['lat'] ?? 37.2974;
    final lng = widget.addressData['lng'] ?? 127.0456;
    final title = widget.addressData['title'] ?? '현재 위치';

    // 카카오맵 iframe URL 생성
    final mapUrl = 'https://map.kakao.com/link/map/$title,$lat,$lng';

    // iframe 요소 생성
    final iframe = html.IFrameElement()
      ..src = mapUrl
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '200px';

    // DOM에 등록
    html.document.body?.append(iframe);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '주소 상세',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMapSection(),
            SizedBox(height: 24),
            _buildAddressSection(),
            SizedBox(height: 24),
            _buildAddressTypeSection(),
            SizedBox(height: 24),
            _buildRiderInstructionSection(),
            SizedBox(height: 24),
            _buildEntrancePasswordSection(),
            SizedBox(height: 24),
            _buildDirectionsSection(),
            SizedBox(height: 24),
            _buildInfoText(),
            SizedBox(height: 32),
            _buildRegisterButton(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _buildKakaoMap(),
      ),
    );
  }

  Widget _buildKakaoMap() {
    final lat = widget.addressData['lat'] ?? 37.2974;
    final lng = widget.addressData['lng'] ?? 127.0456;
    final title = widget.addressData['title'] ?? '현재 위치';

    return Stack(
      children: [
        // 실제 카카오맵 iframe (웹) 또는 플레이스홀더 (모바일)
        if (kIsWeb)
          Container(
            width: double.infinity,
            height: 200,
            child: HtmlElementView(
              viewType: 'map-iframe-${widget.addressData['id']}',
            ),
          )
        else
          Container(
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
                  SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
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
          ),
        // 지도 서비스 표시
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'KAKAO MAP',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderMap() {
    final lat = widget.addressData['lat'] ?? 37.2974;
    final lng = widget.addressData['lng'] ?? 127.0456;
    final title = widget.addressData['title'] ?? '현재 위치';

    return Container(
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
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
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

  void _openDaumPostcode() {
    // Daum 우편번호 서비스 열기
    js.context.callMethod('eval', [
      '''
      new daum.Postcode({
        oncomplete: function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드
          var addr = ''; // 주소 변수
          var extraAddr = ''; // 참고항목 변수

          // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
          }

          // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
          if(data.userSelectedType === 'R'){
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]\$/g.test(data.bname)){
              extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraAddr !== ''){
              extraAddr = ' (' + extraAddr + ')';
            }
          }

          // 주소 정보를 Flutter로 전달
          window.postMessage({
            type: 'address_selected',
            roadAddress: data.roadAddress,
            jibunAddress: data.jibunAddress,
            zonecode: data.zonecode,
            extraAddr: extraAddr,
            fullAddress: addr + extraAddr
          }, '*');
        }
      }).open();
    '''
    ]);

    // 주소 선택 이벤트 리스너 등록
    html.window.addEventListener('message', (html.Event event) {
      final messageEvent = event as html.MessageEvent;
      if (messageEvent.data != null &&
          messageEvent.data['type'] == 'address_selected') {
        final data = Map<String, dynamic>.from(messageEvent.data);
        _handleAddressSelected(data);
      }
    });
  }

  void _handleAddressSelected(Map<String, dynamic> data) {
    setState(() {
      // 주소 상세란에 검색 결과 반영
      _addressDetailController.text = data['fullAddress'] ?? '';

      // 주소명도 업데이트 (필요시)
      if (data['roadAddress'] != null) {
        _addressNameController.text = data['roadAddress'];
      }
    });

    // 지도 업데이트
    _updateMapWithNewAddress(data);

    _showSnackBar('주소가 선택되었습니다: ${data['fullAddress']}');
  }

  void _updateMapWithNewAddress(Map<String, dynamic> addressData) {
    // 새로운 주소로 지도 업데이트
    final newAddress =
        addressData['fullAddress'] ?? addressData['roadAddress'] ?? '새로운 주소';
    final mapUrl =
        'https://map.kakao.com/link/map/$newAddress,37.5665,126.9780';

    if (kIsWeb) {
      // 웹에서는 iframe src 업데이트
      final iframe =
          html.document.querySelector('iframe') as html.IFrameElement?;
      if (iframe != null) {
        iframe.src = mapUrl;
      }
    }
  }

  Future<void> _openMap(double lat, double lng, String title) async {
    // 카카오맵 URL 생성
    final kakaoMapUrl = 'https://map.kakao.com/link/map/$title,$lat,$lng';
    final googleMapUrl = 'https://www.google.com/maps?q=$lat,$lng';

    // 플랫폼에 따라 다른 지도 앱 열기
    if (kIsWeb) {
      // 웹에서는 카카오맵 열기
      if (await canLaunchUrl(Uri.parse(kakaoMapUrl))) {
        await launchUrl(Uri.parse(kakaoMapUrl),
            mode: LaunchMode.externalApplication);
      }
    } else {
      // 모바일에서는 구글맵 열기
      if (await canLaunchUrl(Uri.parse(googleMapUrl))) {
        await launchUrl(Uri.parse(googleMapUrl),
            mode: LaunchMode.externalApplication);
      }
    }
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주소',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (kIsWeb) {
                _openDaumPostcode();
              } else {
                _showSnackBar('지도에서 위치 확인');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[100],
              foregroundColor: Colors.black,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('주소 검색'),
          ),
        ),
        SizedBox(height: 8),
        Text(
          '표시된 위치가 다르다면 지도에서 위치 확인을 눌러 변경해주세요',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 12),
        Text(
          widget.addressData['address'] ?? '경기 용인시 기흥구 덕영대로 1732',
          style: TextStyle(
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
        Text(
          '주소 상세',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _addressDetailController,
          decoration: InputDecoration(
            hintText: '상세 주소를 입력하세요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: _addressTypes.map((type) {
            final isSelected = _selectedAddressType == type;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 8),
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
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _addressNameController,
          decoration: InputDecoration(
            hintText: '주소 이름을 입력하세요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildRiderInstructionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '라이더님께',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _riderInstructionController,
          decoration: InputDecoration(
            hintText: '배달 요청사항을 입력하세요',
            suffixIcon: PopupMenuButton<String>(
              icon: Icon(Icons.keyboard_arrow_down),
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildEntrancePasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '공동현관 비밀번호',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _entrancePasswordController,
          decoration: InputDecoration(
            hintText: '예) #1234',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDirectionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '찾아오는 길 안내',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _directionsController,
          decoration: InputDecoration(
            hintText: '예) 편의점 옆 건물이에요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoText() {
    return Container(
      padding: EdgeInsets.all(12),
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
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '입력된 공동현관 비밀번호는 원활한 배달을 위해 필요한 정보로, 배달을 진행하는 라이더님과 사장님께 전달됩니다.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // 주소 데이터 업데이트
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
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
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
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.baeminMint,
      ),
    );
  }
}
