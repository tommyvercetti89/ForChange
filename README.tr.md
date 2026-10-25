<p align="center">
  <img src="assets/logo.png" alt="ForChange Logo" width="120" height="120">
</p>

<h1 align="center">ForChange</h1>

<p align="center">
  <strong>Windows için yüksek performanslı, çift sürümlü medya dönüştürücü — görüntü, video ve ses — Windows Explorer sağ tık menü entegrasyonuyla.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows-0078d7?style=for-the-badge&logo=windows" alt="Platform">
  <img src="https://img.shields.io/badge/Dil-Go_1.26-00add8?style=for-the-badge&logo=go" alt="Dil">
  <img src="https://img.shields.io/badge/GUI-Wails_v2-00f0ff?style=for-the-badge&logo=wails" alt="Wails">
  <img src="https://img.shields.io/badge/UI-Win32_Walk-7000ff?style=for-the-badge" alt="Walk">
  <img src="https://img.shields.io/badge/Sıkıştırma-UPX_LZMA-orange?style=for-the-badge" alt="Sıkıştırma">
  <img src="https://img.shields.io/badge/Lisans-MIT-emerald?style=for-the-badge" alt="Lisans">
</p>

<p align="center">
  <a href="README.md">English</a> &nbsp;|&nbsp; <a href="README.tr.md">Türkçe</a>
</p>

---

## Genel Bakış

**ForChange**, Windows için geliştirilmiş hızlı, modüler ve hafif bir medya dönüştürme paketidir. Görüntüler, video formatları ve ses dosyaları arasında kapsamlı dönüştürme yetenekleri sunar. Hem komut satırı (CLI) üzerinden hem de iki farklı grafik arayüz seçeneğiyle kullanılabilir:

1. **Klasik Win32 Sürümü** — Sistem kaynaklarını neredeyse hiç tüketmeyen, 7-Zip tarzı yerel Windows arayüzü (Walk Win32 kütüphanesi).
2. **Modern Sürüm** — Zifiri karanlık mod, yumuşak geçişler ve gerçek zamanlı işlem göstergeleri sunan web tabanlı modern masaüstü arayüzü (Wails v2 + Vite).

Her iki sürüm de isteğe bağlı olarak **Lightweight** (harici sistem FFmpeg kullanan hafif sürüm) ve **Standalone** (FFmpeg tamamen içine gömülü, sıfır harici bağımlılık) olarak derlenebilir ve UPX LZMA algoritmasıyla minimum dosya boyutuna sıkıştırılmıştır.

---

## Sürümler ve Dağıtımlar

| Dosya Adı | Grafik Motoru | FFmpeg Bağımlılığı | UPX Boyutu | Açıklama |
| :--- | :--- | :--- | :--- | :--- |
| **ForChange_Classic.exe** | Walk (Win32) | Harici / Sistem PATH | **~2.0 MB** | Minimum bellek tüketimli yerel Windows aracı. |
| **ForChange_Modern.exe** | Wails v2 (WebView2) | Harici / Sistem PATH | **~3.5 MB** | Karanlık/açık tema ve sürükle-bırak destekli modern arayüz. |
| **ForChange_Classic_Standalone.exe** | Walk (Win32) | **Gömülü (Bağımsız)** | **~27.3 MB** | Sıfır bağımlılıklı taşınabilir tek dosya; her Windows'ta çalışır. |
| **ForChange_Modern_Standalone.exe** | Wails v2 (WebView2) | **Gömülü (Bağımsız)** | **~28.6 MB** | Modern cam efektli arayüz ve entegre medya işleme motoru. |

> **Standalone Mimarisi Notu:** Bağımsız (Standalone) sürümler, Go derleme etiketleri (`embed_ffmpeg`) aracılığıyla tam FFmpeg araç takımını doğrudan çalıştırılabilir dosya içine gömer. İlk çalıştırmada binary bayt düzeyinde doğrulanarak `%LOCALAPPDATA%\ForChange` dizinine atomik olarak güvenle çıkarılır.

---

## Desteklenen Formatlar

### Görüntü Formatları

| Format | Okuma | Yazma | Notlar |
| :--- | :---: | :---: | :--- |
| **PNG** | Evet | Evet | Yüksek sıkıştırmalı kayıpsız kodlama |
| **JPEG / JPG** | Evet | Evet | Saydamlık arka plan birleştirme destekli kalite ayarı (1–100) |
| **GIF** | Evet | Evet | Standart 256 renkli palet niceleme |
| **BMP** | Evet | Evet | Sıkıştırılmamış yerel bitmap |
| **TIFF / TIF** | Evet | Evet | Deflate sıkıştırma devrede |
| **WEBP** | Evet | Hayır | Saf Go kod çözme motoru |
| **ICO** | Evet | Evet | Kare tuval ve Catmull-Rom yeniden örnekleme (16–256 px) |

### Video Formatları

| Format | Okuma | Yazma | Notlar |
| :--- | :---: | :---: | :--- |
| **MP4** | Evet | Evet | H.264 video, AAC ses, `+faststart` web optimizasyonu |
| **MKV** | Evet | Evet | Çoklu kanal destekli Matroska kapsayıcısı |
| **WEBM** | Evet | Evet | VP9 video kod çözücü, Opus ses kod çözücü |
| **AVI** | Evet | Evet | MPEG-4 video kod çözücü, MP3 ses kod çözücü |
| **MOV** | Evet | Evet | Apple QuickTime uyumlu kapsayıcı |
| **GIF (Videodan)** | Evet | Evet | İki geçişli Lanczos palettegen / paletteuse animasyonlu GIF |

### Ses Formatları

| Format | Okuma | Yazma | Notlar |
| :--- | :---: | :---: | :--- |
| **MP3** | Evet | Evet | Yüksek kaliteli LAME kodlayıcı (320 kbps'ye kadar) |
| **WAV** | Evet | Evet | Sıkıştırılmamış 16-bit PCM |
| **FLAC** | Evet | Evet | Kayıpsız ses sıkıştırması |
| **AAC** | Evet | Evet | Yerel AAC kodlayıcı |
| **M4A** | Evet | Evet | MPEG-4 ses kapsayıcısı içinde AAC |
| **OGG** | Evet | Evet | Vorbis ses kodlayıcı |

---

## Windows Explorer Sağ Tık Menü Entegrasyonu

ForChange, Windows Explorer'ın sağ tık basamaklı menüsüne entegre olur. Böylece arayüz açmaya gerek kalmadan dosyaları tek tıkla dönüştürebilirsiniz.

### Mimari Yaklaşım

Kayıt defteri kayıtları `Software\Classes\SystemFileAssociations` altında oluşturulur. Bu yaklaşım:
- VLC, Media Player veya Windows Fotoğraflar gibi varsayılan uygulamaların ayarlarını **asla bozmaz**.
- Windows 10 ve Windows 11 üzerinde sorunsuz görünür.
- Video dosyaları için çift katmanlı kayıt içerir (genel `video\shell` ve dosya uzantısına özel anahtarlar).

### Menü Kapsamı

| Hedef Kategori | İzlenen Uzantılar | Mevcut Alt Menü İşlemleri |
| :--- | :--- | :--- |
| **Görüntüler** | `.png`, `.jpg`, `.jpeg`, `.bmp`, `.gif`, `.tiff`, `.ico` | PNG, JPG, BMP, GIF, ICO'ya Dönüştür, GUI ile Aç |
| **Videolar** | `.mp4`, `.mkv`, `.avi`, `.mov`, `.webm` | MP4, WEBM, MKV, MP3 (Ses), GIF'e Dönüştür, GUI ile Aç |
| **Sesler** | `.mp3`, `.wav`, `.aac`, `.flac`, `.ogg`, `.m4a` | MP3, WAV, M4A, FLAC'a Dönüştür, GUI ile Aç |

---

## Komut Satırı Arayüzü (CLI)

Tüm binary'ler betikler ve toplu işlemler için konsol modunu destekler:

```bash
# Görseli PNG formatına dönüştürme
ForChange_Classic.exe -i girdi.jpg -f png

# Özel kalite katsayısıyla JPEG'e dönüştürme
ForChange_Classic.exe -i foto.png -o cikti.jpg -f jpg -q 92

# Görselden 256x256 Windows ikonu oluşturma
ForChange_Classic.exe -i logo.png -o logo.ico -f ico -q 256

# Videoyu MP4 formatına dönüştürme
ForChange_Modern.exe -i kayit.mkv -f mp4

# Videodaki ses akışını MP3 olarak kaydetme
ForChange_Classic.exe -i sunum.mp4 -o sunum.mp3 -f mp3 -q 85

# Sesi kayıpsız FLAC formatına dönüştürme
ForChange_Classic.exe -i muzik.wav -f flac
```

### CLI Parametreleri

| Bayrak | Parametre | Açıklama | Zorunlu | Varsayılan |
| :--- | :--- | :--- | :---: | :--- |
| `-i` | `<dosya_yolu>` | Kaynak medya dosyasının yolu | Evet | Yok |
| `-o` | `<dosya_yolu>` | Hedef dosya yolu (belirtilmezse otomatik üretilir) | Hayır | Kaynak dosya ile aynı dizin |
| `-f` | `<format>` | Hedef format adı (png, jpg, mp4, webm, mp3 vb.) | Evet | Yok |
| `-q` | `<değer>` | Kodlama kalite faktörü (1–100) veya İkon boyutu (16–256) | Hayır | `80` (ICO için `256`) |

---

## Kaynak Koddan Derleme

### Gereksinimler

- Go (Golang) 1.23 veya üzeri
- Node.js 18+ ve `npm` *(Yalnızca Modern sürüm için)*
- Wails CLI v2 *(Yalnızca Modern sürüm için)*
- Inno Setup 6 *(İsteğe bağlı, yükleyici kurulum dosyası üretmek için)*
- UPX 5.x *(İsteğe bağlı, binary sıkıştırması için)*

### Derleme Adımları

1. **Depoyu klonlayın:**
   ```bash
   git clone https://github.com/tommyvercetti89/ForChange.git
   cd ForChange
   ```

2. **Klasik Sürümü Derleyin (Lightweight):**
   ```bash
   go build -ldflags="-s -w -H windowsgui" -o ForChange_Classic.exe .
   ```

3. **Klasik Sürümü Derleyin (FFmpeg Gömülü / Standalone):**
   ```bash
   go build -tags embed_ffmpeg -ldflags="-s -w -H windowsgui" -o ForChange_Classic_Standalone.exe .
   ```

4. **Modern Sürümü Derleyin (Lightweight):**
   ```bash
   cd modern/frontend && npm install && npm run build && cd ..
   go build -tags "desktop,production" -ldflags="-w -s -H windowsgui" -o ..\ForChange_Modern.exe .
   cd ..
   ```

5. **Modern Sürümü Derleyin (FFmpeg Gömülü / Standalone):**
   ```bash
   cd modern
   go build -tags "desktop,production,embed_ffmpeg" -ldflags="-w -s -H windowsgui" -o ..\ForChange_Modern_Standalone.exe .
   cd ..
   ```

6. **UPX ile Sıkıştırma (İsteğe bağlı):**
   ```bash
   upx --best --lzma ForChange_Classic.exe ForChange_Modern.exe ForChange_Classic_Standalone.exe ForChange_Modern_Standalone.exe
   ```

7. **Yükleyicileri Üretin:**
   ```bash
   & "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" setup.iss
   & "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" setup_modern.iss
   ```

---

## Proje Yapısı

```
ForChange/
├── main.go                          # Ana giriş noktası — CLI yönlendirme ve GUI başlatma
├── main.manifest                    # Windows Common Controls manifest dosyası
├── cli/
│   └── cli.go                       # Başsız (headless) CLI yürütme mantığı
├── converter/
│   ├── converter.go                 # Saf Go görsel işleme ve format yönlendirici
│   ├── media.go                     # Video ve ses kodlama motoru (FFmpeg sarmalayıcı)
│   ├── ffmpeg.go                    # FFmpeg tespit, çıkarma ve bütünlük doğrulama
│   ├── ffmpeg_embedded.go           # Gömülü FFmpeg yönergesi (-tags embed_ffmpeg)
│   └── ffmpeg_noembed.go            # Harici FFmpeg derlemeleri için taslak yönerge
├── gui/
│   └── gui.go                       # Yerel Win32 klasik arayüz (Walk)
├── modern/
│   ├── main.go                      # Wails v2 masaüstü giriş noktası
│   ├── app.go                       # Go-JS köprü metodları ve dosya iletişim pencereleri
│   ├── wails.json                   # Wails proje yapılandırması
│   └── frontend/                    # Web arayüzü (HTML5, Vanilla CSS, ES modülleri, Vite)
├── assets/                          # Uygulama ikonları ve marka görselleri
├── setup.iss                        # Inno Setup yapılandırması — Klasik Sürüm
└── setup_modern.iss                 # Inno Setup yapılandırması — Modern Sürüm
```

---

## Güvenlik ve Gizlilik

- **Sıfır Telemetri:** ForChange hiçbir analiz, telemetri veya uzaktan bağlantı kodu içermez.
- **Yerel İşleme:** Medya çözme, dönüştürme ve kodlama işlemlerinin %100'ü yerel olarak kendi bilgisayarınızda gerçekleşir.
- **Güvenli Kayıt Defteri:** Sağ tık entegrasyonu sistem standartlarına tam uyumludur ve kaldırıldığında kayıt defterinde artık bırakmaz.

---

## Katkı ve Teşekkür

Bu proje, Google DeepMind ekibi tarafından tasarlanan gelişmiş ajansal yapay zeka kodlama asistanı **Antigravity** ile **tommyvercetti89**'un çift programlama iş birliğiyle geliştirilmiştir.

---

## Lisans

Bu proje [MIT Lisansı](LICENSE) kapsamında lisanslanmıştır.
