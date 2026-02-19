# 🧬 YKS İnteraktif Biyoloji Atlası

<p align="center">
  <img src="assets/logo.png" alt="YKS Biyoloji Atlası Logo" width="200"/>
</p>

<p align="center">
  <strong>Ezberleme, Dokun ve Keşfet!</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/HARGET-Mobil%20Birimi-blue?style=for-the-badge" alt="HARGET Mobil"/>
  <img src="https://img.shields.io/badge/Flutter-3.19+-02569B?style=for-the-badge&logo=flutter" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Supabase-Backend-3ECF8E?style=for-the-badge&logo=supabase" alt="Supabase"/>
</p>

<p align="center">
  <a href="#özellikler">Özellikler</a> •
  <a href="#kurulum">Kurulum</a> •
  <a href="#mimari">Mimari</a> •
  <a href="#ekip-ve-görev-dağılımı">Ekip</a> •
  <a href="#katkıda-bulunma">Katkıda Bulunma</a>
</p>

---

## 🏢 HARGET Mobil Birimi

Bu proje, **HARGET Mobil Birimi** tarafından geliştirilmektedir. Eğitim teknolojileri alanında yenilikçi çözümler üretmeyi hedefleyen ekibimiz, YKS'ye hazırlanan öğrencilere görsel ve etkileşimli bir öğrenme deneyimi sunmak için bu projeyi hayata geçirmektedir.

### 👥 Proje Yöneticileri

| Rol | İsim | GitHub |
|-----|------|--------|
| **Project Lead & Code Review** | Emin Kaan | [@desircim](https://github.com/desircim) |
| **Tech Lead & Code Review** | Alperen | [@alperenacr](https://github.com/alperenacr) |

---

## 📖 Proje Hakkında

YKS İnteraktif Biyoloji Atlası, klasik test çözme mantığını yıkan ve öğrencilerin hücresel yapıları, anatomik sistemleri ve biyolojik döngüleri **doğrudan vektörel (SVG) şemalar** üzerinde dokunarak, sürükleyerek ve keşfederek öğrendiği **oyunlaştırılmış bir dijital laboratuvardır**.

### 🎯 Çözülen Problem

YKS (TYT-AYT) Biyoloji müfredatı görsel ve mekansal bir bilim olmasına rağmen, öğrenciler bu dersi renksiz test kitaplarından ve "Aşağıdakilerden hangisi..." tarzı durağan sorulardan ezberlemeye çalışıyor. Bu uygulama, biyolojiyi **görsel**, **dokunsal** ve **etkileşimli** bir deneyime dönüştürür.

---

## ✨ Özellikler

### 🎮 5 Farklı Etkileşim Modu

| Mod | Açıklama | Öğrenme Hedefi |
|-----|----------|----------------|
| **🧊 Keşfet ve Öğren** | Bulanık etiketlere dokunarak açığa çıkar | Stressiz keşif, flashcard deneyimi |
| **📍 Nokta Atışı** | Hedef yapının yerini şema üzerinde işaretle | Mekansal hafıza güçlendirme |
| **✨ Parlayanı Bil** | Parlayan bölgenin adını şıklardan seç | Görsel tanıma hızı |
| **🎯 Sürükle ve Bırak** | Etiketleri doğru yerlere sürükle | Parça-bütün ilişkisi kurma |
| **🔄 Akış Tamamlama** | Döngülerdeki eksik basamakları tamamla | Süreç mantığı anlama |

### 📚 İkili Giriş Sistemi

```
┌─────────────────────────────────────────────────────────────┐
│                    İÇERİK FİLTRESİ                          │
├──────────────────────┬──────────────────────────────────────┤
│   🏫 SINIF MODU      │        📝 SINAV MODU                 │
│   (Okul Odaklı)      │        (YKS Odaklı)                  │
├──────────────────────┼──────────────────────────────────────┤
│   • 9. Sınıf         │   • TYT (9-10. Sınıf birleşimi)      │
│   • 10. Sınıf        │   • AYT (11-12. Sınıf birleşimi)     │
│   • 11. Sınıf        │                                      │
│   • 12. Sınıf        │                                      │
└──────────────────────┴──────────────────────────────────────┘
```

### 🎲 Dinamik Karma Test (Deneme Motoru)

Kullanıcının seçtiği filtreye göre algoritmanın rastgele görseller ve etkileşim modları çekerek oluşturduğu **benzersiz deneme sınavları**.

### 🎨 Tasarım Dili

- **Tema:** Aydınlık, temiz, minimalist (Apple Health / Medikal estetik)
- **Renkler:** Bolca beyaz boşluk, göz yormayan açık gri arka planlar
- **Geri Bildirim:** Haptic titreşimler, doğru için mint yeşili parlama, yanlış için medikal kırmızı

---

## 🛠 Tech Stack

| Katman | Teknoloji | Açıklama |
|--------|-----------|----------|
| **Frontend** | Flutter | Cross-platform mobil uygulama |
| **State Management** | Riverpod | Reactive ve scalable state yönetimi |
| **Backend** | Supabase | Auth, Database, Storage, Realtime |
| **SVG Rendering** | flutter_svg | Vektörel görsel işleme |
| **Animasyonlar** | Rive | İnteraktif mikro-animasyonlar |
| **Local Storage** | Hive | Offline-first veri saklama |
| **Haptic** | flutter_haptic | Dokunsal geri bildirim |

> 📄 Detaylı tech stack açıklaması için [TECH_STACK.md](./docs/TECH_STACK.md) dosyasına bakın.

---

## 📁 Proje Yapısı

```
lib/
├── core/                    # Temel yapılar ve yardımcılar
│   ├── constants/           # Sabitler (renkler, boyutlar, strings)
│   ├── extensions/          # Dart extension'ları
│   ├── theme/               # Tema ve stil tanımları
│   └── utils/               # Yardımcı fonksiyonlar
│
├── data/                    # Veri katmanı
│   ├── models/              # Data modelleri
│   ├── repositories/        # Repository implementasyonları
│   └── services/            # API ve external servisler
│
├── domain/                  # İş mantığı katmanı
│   ├── entities/            # Domain entity'leri
│   ├── repositories/        # Repository interface'leri
│   └── usecases/            # Use case'ler
│
├── presentation/            # UI katmanı
│   ├── providers/           # Riverpod provider'ları
│   ├── screens/             # Ekranlar
│   └── widgets/             # Yeniden kullanılabilir widget'lar
│
├── routes/                  # Navigasyon ve routing
└── main.dart
```

> 📄 Detaylı UI navigasyonu için [UI_NAVIGATION.md](./docs/UI_NAVIGATION.md) dosyasına bakın.

---

## 🚀 Kurulum

### Gereksinimler

- Flutter SDK `>=3.19.0`
- Dart SDK `>=3.3.0`
- Supabase hesabı (ekip tarafından sağlanacak)

### Adımlar

```bash
# 1. Kendi fork'unuzu oluşturun (GitHub'da Fork butonuna tıklayın)

# 2. Fork'unuzu klonlayın
git clone https://github.com/KULLANICI_ADINIZ/yks-biyoloji-atlas.git
cd yks-biyoloji-atlas

# 3. Ana repo'yu upstream olarak ekleyin
git remote add upstream https://github.com/alperenacr/yks-biyoloji-atlas.git

# 4. Bağımlılıkları yükleyin
flutter pub get

# 5. Environment dosyasını oluşturun
cp .env.example .env
# .env dosyasına Supabase credentials'ları ekleyin (ekipten alın)

# 6. Uygulamayı çalıştırın
flutter run
```

### Environment Değişkenleri

```env
SUPABASE_URL=your-supabase-url
SUPABASE_ANON_KEY=your-anon-key
```

> ⚠️ `.env` dosyası git'e eklenmez. Credentials'ları proje yöneticilerinden alın.

---

## 👥 Ekip ve Görev Dağılımı

### Mevcut Görev Alanları

| Alan | Açıklama | Atanacak Kişi |
|------|----------|---------------|
| `feature/auth` | Kimlik doğrulama (Supabase Auth) | - |
| `feature/home` | Ana sayfa ve dashboard | - |
| `feature/explore` | Keşfet ekranı ve konu listesi | - |
| `feature/quiz-explore` | Keşfet ve Öğren modu | - |
| `feature/quiz-pinpoint` | Nokta Atışı modu | - |
| `feature/quiz-glow` | Parlayanı Bil modu | - |
| `feature/quiz-dragdrop` | Sürükle ve Bırak modu | - |
| `feature/quiz-flow` | Akış Tamamlama modu | - |
| `feature/progress` | İlerleme takibi ekranı | - |
| `feature/settings` | Ayarlar ekranı | - |
| `feature/svg-engine` | SVG etkileşim motoru | - |
| `content/svg` | SVG içerik hazırlama | - |

> 

---

## 🤝 Katkıda Bulunma

HARGET Mobil Birimi olarak düzenli ve organize bir geliştirme süreci izliyoruz. Lütfen aşağıdaki adımları takip edin.

### 📋 Genel Kurallar

1. **Her özellik için ayrı branch** açılmalıdır
2. **Commit mesajları** anlamlı ve Türkçe olmalıdır
3. **Code review** olmadan `main` branch'e merge yapılmaz
4. Tüm PR'lar **@desircim** veya **@alperenacr** tarafından onaylanmalıdır

---

### 🔀 Git Workflow

#### 1. Fork Oluşturma (İlk Kez)

```bash
# GitHub'da alperenacr/yks-biyoloji-atlas reposuna gidin
# Sağ üstteki "Fork" butonuna tıklayın
# Kendi hesabınıza fork'layın
```

#### 2. Lokal Ortamı Hazırlama

```bash
# Fork'unuzu klonlayın
git clone https://github.com/KULLANICI_ADINIZ/yks-biyoloji-atlas.git
cd yks-biyoloji-atlas

# Ana repo'yu upstream olarak ekleyin
git remote add upstream https://github.com/alperenacr/yks-biyoloji-atlas.git

# Remote'ları kontrol edin
git remote -v
# origin    https://github.com/KULLANICI_ADINIZ/yks-biyoloji-atlas.git (fetch)
# origin    https://github.com/KULLANICI_ADINIZ/yks-biyoloji-atlas.git (push)
# upstream  https://github.com/alperenacr/yks-biyoloji-atlas.git (fetch)
# upstream  https://github.com/alperenacr/yks-biyoloji-atlas.git (push)
```

#### 3. Yeni Özellik Geliştirme

```bash
# Önce main branch'i güncelleyin
git checkout main
git fetch upstream
git merge upstream/main
git push origin main

# Görevinize uygun branch oluşturun
git checkout -b feature/gorev-adi

# Örnek branch isimleri:
# feature/auth-login-screen
# feature/quiz-dragdrop-mode
# feature/home-dashboard
# fix/svg-render-bug
# refactor/quiz-provider
```

#### 4. Geliştirme ve Commit

```bash
# Değişikliklerinizi yapın...

# Değişiklikleri stage'leyin
git add .

# Anlamlı commit mesajı yazın (Türkçe)
git commit -m "feat: login ekranı UI tasarımı tamamlandı"

# Commit mesaj formatları:
# feat: yeni özellik eklendi
# fix: hata düzeltildi
# refactor: kod iyileştirmesi yapıldı
# docs: döküman güncellendi
# style: kod formatı düzenlendi
# test: test eklendi
```

#### 5. Push ve Pull Request

```bash
# Branch'inizi kendi fork'unuza push'layın
git push origin feature/gorev-adi
```

Ardından GitHub'da:

1. Fork'unuza gidin
2. "Compare & pull request" butonuna tıklayın
3. PR açıklamasını doldurun (aşağıdaki şablonu kullanın)
4. **Reviewers** kısmına `@desircim` ve `@alperenacr` ekleyin
5. "Create pull request" butonuna tıklayın

---

### 📝 Pull Request Şablonu

PR açarken aşağıdaki şablonu kullanın:

```markdown
## 📋 Açıklama
Bu PR ile ne yapıldığını kısaca açıklayın.

## 🎯 İlgili Görev
- [ ] feature/auth
- [ ] feature/home
- [ ] feature/explore
- [ ] Diğer: ___

## 📸 Ekran Görüntüleri (UI değişikliği varsa)
| Önce | Sonra |
|------|-------|
| screenshot | screenshot |

## ✅ Checklist
- [ ] Kod çalışıyor ve hata vermiyor
- [ ] Flutter analyze'dan geçiyor
- [ ] Yeni widget'lar için temel testler yazıldı
- [ ] UI tasarım dökümanına uygun

## 🔗 Bağlantılı Issue (varsa)
Closes #issue_numarası
```

---

### 🆕 Yeni Özellik Talebi (Feature Request)

Yeni bir özellik önermek istiyorsanız:

1. GitHub'da **Issues** sekmesine gidin
2. **"New Issue"** butonuna tıklayın
3. **"Feature Request"** şablonunu seçin
4. Aşağıdaki bilgileri doldurun:

```markdown
## 🚀 Özellik Önerisi

### Açıklama
Özelliği detaylıca açıklayın.

### Motivasyon
Bu özellik neden gerekli? Hangi sorunu çözüyor?

### Önerilen Çözüm
Nasıl implement edilebileceğine dair fikirleriniz.

### Alternatifler
Düşündüğünüz alternatif çözümler.

### Ek Bilgiler
Mockup, referans link, vb.
```

> ⚠️ Tüm özellik talepleri **@desircim** ve **@alperenacr** tarafından değerlendirilecek ve uygun görülenler backlog'a eklenecektir.

---

### 🐛 Bug Raporu

Hata bildirmek için:

1. GitHub'da **Issues** sekmesine gidin
2. **"New Issue"** butonuna tıklayın
3. **"Bug Report"** şablonunu seçin

```markdown
## 🐛 Hata Raporu

### Açıklama
Hatayı kısaca açıklayın.

### Tekrarlama Adımları
1. Şuraya git...
2. Şuna tıkla...
3. Hata oluşuyor

### Beklenen Davranış
Ne olması gerekiyordu?

### Gerçekleşen Davranış
Ne oldu?

### Ekran Görüntüsü / Video
Varsa ekleyin.

### Ortam
- Cihaz: [örn. iPhone 14, Samsung S23]
- OS: [örn. iOS 17.2, Android 14]
- Flutter version: [flutter --version çıktısı]
```

---

### ✅ Code Review Süreci

1. PR açıldığında otomatik olarak CI/CD çalışır
2. **@desircim** veya **@alperenacr** review eder
3. Gerekirse değişiklik talep edilir (Request Changes)
4. Düzeltmeler yapılır ve tekrar review istenir
5. Onay alındıktan sonra **Squash and Merge** yapılır

#### Review Kriterleri

- [ ] Kod okunabilir ve anlaşılır mı?
- [ ] Naming convention'lara uyuyor mu?
- [ ] Gereksiz kod tekrarı var mı?
- [ ] Performance açısından sorun var mı?
- [ ] UI tasarım dökümanına uygun mu?
- [ ] Edge case'ler düşünülmüş mü?

---

### 🔄 Fork'u Güncel Tutma

Ana repo güncellendiğinde fork'unuzu senkronize edin:

```bash
# Main branch'e geçin
git checkout main

# Upstream'den güncellemeleri çekin
git fetch upstream
git merge upstream/main

# Kendi fork'unuza push'layın
git push origin main
```

---

## 📱 Ekran Görüntüleri

<p align="center">
  <img src="screenshots/home.png" width="200"/>
  <img src="screenshots/explore.png" width="200"/>
  <img src="screenshots/quiz.png" width="200"/>
  <img src="screenshots/profile.png" width="200"/>
</p>

---

## 🗺 Yol Haritası

### Phase 1 - MVP (Mevcut)
- [x] Proje mimarisi ve temel yapı
- [x] Dökümanlar (README, Tech Stack, UI Navigation)
- [ ] Supabase kurulumu ve auth
- [ ] Ana ekran ve navigasyon
- [ ] Keşfet ve Öğren modu
- [ ] Nokta Atışı modu

### Phase 2 - Core Features
- [ ] Parlayanı Bil modu
- [ ] Sürükle ve Bırak modu
- [ ] Akış Tamamlama modu
- [ ] Dinamik Deneme Motoru
- [ ] Kullanıcı profili ve ilerleme takibi

### Phase 3 - Polish & Launch
- [ ] Offline mod ve veri senkronizasyonu
- [ ] Push notification'lar
- [ ] Performans optimizasyonu
- [ ] Beta test
- [ ] App Store & Play Store yayını

### Phase 4 - Growth (Gelecek)
- [ ] Leaderboard ve sosyal özellikler
- [ ] AI-powered öneri sistemi
- [ ] Web versiyonu
- [ ] Tablet optimizasyonu

---

## 📄 Lisans

Bu proje HARGET'e aittir ve MIT licence kullanılmıştır

---

## 📬 İletişim

| Kanal | Link |
|-------|------|
| **GitHub Issues** | [Yeni Issue Aç](https://github.com/alperenacr/yks-biyoloji-atlas/issues) |
| **Proje Yöneticileri** | @desircim, @alperenacr |

---

<p align="center">
  <strong>HARGET Mobil Birimi</strong><br/>
  Made with ❤️ for Turkish students preparing for YKS
</p>
