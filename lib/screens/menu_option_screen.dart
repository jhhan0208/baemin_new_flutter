import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/restaurant.dart';

class MenuOptionScreen extends StatefulWidget {
  final MenuItem menuItem;
  const MenuOptionScreen({Key? key, required this.menuItem}) : super(key: key);

  @override
  State<MenuOptionScreen> createState() => _MenuOptionScreenState();
}

class _MenuOptionScreenState extends State<MenuOptionScreen> {
  final Map<String, Set<OptionChoice>> _selectedByOptionId = {};
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    for (final option in widget.menuItem.options) {
      final defaults = option.choices.where((c) => c.isDefault).toSet();
      _selectedByOptionId[option.id] = defaults;
    }
  }

  int _extraPrice() {
    int extra = 0;
    for (final selected in _selectedByOptionId.values) {
      for (final c in selected) {
        extra += c.price ?? 0;
      }
    }
    return extra;
  }

  int _totalPrice() => (widget.menuItem.price + _extraPrice()) * _quantity;

  void _toggle(MenuOption option, OptionChoice choice) {
    final set = _selectedByOptionId[option.id] ?? <OptionChoice>{};
    final max = option.maxChoices ??
        (option.type == 'required' ? 1 : option.choices.length);
    final isChecked = set.contains(choice);
    setState(() {
      if (option.type == 'required' && max == 1) {
        _selectedByOptionId[option.id] = {choice};
        return;
      }
      if (isChecked) {
        set.remove(choice);
      } else {
        if (set.length >= max) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('최대 $max개까지 선택할 수 있어요.')),
          );
          return;
        }
        set.add(choice);
      }
      _selectedByOptionId[option.id] = set;
    });
  }

  bool _validate() {
    for (final option in widget.menuItem.options) {
      if (option.type == 'required') {
        if ((_selectedByOptionId[option.id] ?? {}).isEmpty) return false;
      }
    }
    return true;
  }

  Map<String, String> _selectedMap() {
    final Map<String, String> result = {};
    for (final o in widget.menuItem.options) {
      final s = _selectedByOptionId[o.id] ?? {};
      if (s.isEmpty) continue;
      result[o.name] = s.map((e) => e.name).join(', ');
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.menuItem.name,
          style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 120),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.asset(
              widget.menuItem.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.surfaceBackground,
                child: Icon(Icons.restaurant,
                    color: AppColors.textMuted, size: 40),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.menuItem.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
                if (widget.menuItem.description.isNotEmpty) ...[
                  SizedBox(height: 6),
                  Text(widget.menuItem.description,
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textSecondary)),
                ],
                SizedBox(height: 6),
                Text(
                    '${widget.menuItem.price.toString().replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (m) => '${m[1]},')}원',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          ...widget.menuItem.options.map(_buildOptionSection),
          _containerQuantity(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('메뉴 사진은 연출된 이미지로 실제와 다를 수 있어요.',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _buildOptionSection(MenuOption option) {
    final set = _selectedByOptionId[option.id] ?? <OptionChoice>{};
    final isRequired = option.type == 'required';
    final max = option.maxChoices ?? (isRequired ? 1 : option.choices.length);
    return Container(
      margin: EdgeInsets.only(top: 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(children: [
              Text(option.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      (isRequired ? AppColors.accentRed : AppColors.textMuted)
                          .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                    isRequired ? '필수' : (max == 1 ? '선택' : '선택 최대 $max개'),
                    style: TextStyle(
                        fontSize: 12,
                        color: isRequired
                            ? AppColors.accentRed
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600)),
              ),
            ]),
          ),
          ...option.choices.map((c) {
            final extra = c.price ?? 0;
            final checked = set.contains(c);
            final Widget leading = (isRequired && max == 1)
                ? Radio<bool>(
                    value: true,
                    groupValue: checked,
                    onChanged: (_) => _toggle(option, c))
                : Checkbox(
                    value: checked, onChanged: (_) => _toggle(option, c));
            return InkWell(
              onTap: () => _toggle(option, c),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(children: [
                  leading,
                  SizedBox(width: 4),
                  Expanded(child: Text(c.name, style: TextStyle(fontSize: 14))),
                  if (extra != 0)
                    Text(
                        '+${extra.toString().replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (m) => '${m[1]},')}원',
                        style: TextStyle(
                            fontSize: 14, color: AppColors.textSecondary)),
                ]),
              ),
            );
          }).toList(),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _containerQuantity() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Row(children: [
        Text('수량',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary)),
        Spacer(),
        IconButton(
            onPressed: () {
              if (_quantity > 1) setState(() => _quantity--);
            },
            icon: Icon(Icons.remove, color: AppColors.textSecondary)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderLight),
              borderRadius: BorderRadius.circular(6)),
          child: Text('$_quantity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        IconButton(
            onPressed: () => setState(() => _quantity++),
            icon: Icon(Icons.add, color: AppColors.baeminMint)),
      ]),
    );
  }

  Widget _bottomBar() {
    final total = _totalPrice();
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2))
      ]),
      child: Row(children: [
        Expanded(
            child: Text(
                '${total.toString().replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (m) => '${m[1]},')}원',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            if (!_validate()) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('필수 옵션을 선택해 주세요.')));
              return;
            }
            final selected = _selectedMap();
            Navigator.pop(
              context,
              CartItem(
                  menuItem: widget.menuItem,
                  quantity: _quantity,
                  selectedOptions: selected),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.baeminMint,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Text(
              '${(widget.menuItem.price + _extraPrice()).toString().replaceAllMapped(RegExp(r'(\\d{1,3})(?=(\\d{3})+(?!\\d))'), (m) => '${m[1]},')}원 담기',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }
}
