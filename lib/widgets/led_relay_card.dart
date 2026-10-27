import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// Kırmızı/Yeşil/Mavi LED ve Röle için birer açma-kapama (Switch) satırı gösteren kart.
// Her switch değiştiğinde ilgili on/off callback'i tetiklenir; HomeScreen bu callback
// içinde hem kendi state'ini günceller hem de BleService.sendCommand() ile ESP32'ye
// tek byte'lık komutu gönderir (bkz. ble_service.dart'taki komut sabitleri).
class LedRelayCard extends StatelessWidget {
  // Switch'lerin şu anki açık/kapalı durumu (state HomeScreen'de tutulur)
  final bool redLed;
  final bool greenLed;
  final bool blueLed;
  final bool relay;

  // Kullanıcı switch'e dokununca çağrılan callback'ler — yeni değeri (bool) parametre olarak alır
  final Function(bool) onRedChanged;
  final Function(bool) onGreenChanged;
  final Function(bool) onBlueChanged;
  final Function(bool) onRelayChanged;

  const LedRelayCard({
    super.key,
    required this.redLed,
    required this.greenLed,
    required this.blueLed,
    required this.relay,
    required this.onRedChanged,
    required this.onGreenChanged,
    required this.onBlueChanged,
    required this.onRelayChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bölüm başlığı
            const Text(
              'LED & RÖLE',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _LedRow(label: 'Kırmızı LED', dotColor: Colors.red,   value: redLed,   onChanged: onRedChanged),
            _LedRow(label: 'Yeşil LED',   dotColor: Colors.green, value: greenLed, onChanged: onGreenChanged),
            _LedRow(label: 'Mavi LED',    dotColor: Colors.blue,  value: blueLed,  onChanged: onBlueChanged),
            _LedRow(label: 'Röle',        dotColor: AppColors.textMuted, value: relay, onChanged: onRelayChanged),
          ],
        ),
      ),
    );
  }
}

class _LedRow extends StatelessWidget {
  final String label;
  final Color dotColor;
  final bool value;
  final Function(bool) onChanged;

  const _LedRow({
    required this.label,
    required this.dotColor,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Renk göstergesi nokta
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
          ),
          const SizedBox(width: 12),
          // LED/Röle adı
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
            ),
          ),
          // Açma/kapama toggle
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
