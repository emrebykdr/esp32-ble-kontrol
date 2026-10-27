import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// Ana ekrandaki "Cihazları Tara" butonu.
// State tutmaz (StatelessWidget) — durumu (taranıyor mu?) dışarıdan (HomeScreen) alır.
class ScanButton extends StatelessWidget {
  // true ise buton "Taranıyor..." yazısı + dönen bir yükleniyor ikonu gösterir
  final bool isScanning;

  // Butona tıklanınca HomeScreen'deki _toggleScan() fonksiyonu çağrılır
  final VoidCallback onPressed;

  const ScanButton({
    super.key,
    required this.isScanning,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Kartı ekranın tüm genişliğine yayar
    return SizedBox(
      width: double.infinity,
      child: Card(
        // InkWell: tıklanabilir alan, tıklayınca hafif bir dalga (ripple) efekti verir
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              // Yazıyı sola, ikonu sağa yaslar
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Duruma göre buton yazısı değişir
                Text(
                  isScanning ? 'Taranıyor...' : 'Cihazları Tara',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Taranıyorsa dönen yükleniyor animasyonu, değilse tarama ikonu göster
                isScanning
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.accent,
                        ),
                      )
                    : const Icon(
                        Icons.crop_free_rounded,
                        color: AppColors.accent,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
