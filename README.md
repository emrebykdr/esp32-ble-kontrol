# ESP32 BLE Kontrol

ESP32 ile Bluetooth Low Energy (BLE) üzerinden haberleşen Flutter uygulaması. Çevredeki BLE cihazlarını tarar, ESP32'ye bağlanır, LED/röle komutları gönderir ve sensör verisini canlı olarak gösterir.

> **Not:** Bu proje daha önce başka bir depoda geliştiriliyordu. Eski depo, güvenlik nedeniyle ve projenin rahatça paylaşılabilmesi için **private** yapıldı. Bu depo sonradan oluşturuldu; bu yüzden eski commit geçmişi burada yer almıyor ve proje tek bir başlangıç commit'i ile yüklendi.

## Özellikler

- BLE cihaz taraması (10 sn, isimsiz cihazlar filtrelenir)
- ESP32'ye bağlanma / bağlantıyı kesme
- LED ve röle kontrolü (write karakteristiği)
- Sensör verisini canlı okuma (notify karakteristiği)
- Koyu tema, responsive arayüz

## Proje Yapısı

```
lib/
├── main.dart               # Uygulama girişi, tema
├── home_screen.dart        # Ana ekran
├── ble_service.dart        # Tüm BLE mantığı (tarama, bağlantı, okuma/yazma)
├── ble_device_model.dart   # Bulunan cihaz modeli
├── core/                   # Renkler, responsive yardımcıları
└── widgets/                # Tarama butonu, cihaz listesi, LED/röle ve sensör kartları
```

## ESP32 Tarafı

Servis/karakteristik eşleştirmesi sabit UUID ile değil, karakteristiğin özelliğine göre yapılır:

- İlk bulunan **write** karakteristiği: LED/röle komutları
- İlk bulunan **notify** karakteristiği: sensör verisi

Bu nedenle ESP32 tarafında tek bir write ve tek bir notify karakteristiği olduğu varsayılır.

## Kurulum

```bash
flutter pub get
flutter run
```

Gerekli paketler: `flutter_blue_plus`, `permission_handler`. Android'de Bluetooth ve konum izinleri uygulama içinden istenir.
