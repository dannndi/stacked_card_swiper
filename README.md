# stacked_card_swiper

A Flutter package for creating smooth stacked card swiper with gesture support, layered animations, and full control over swipe behavior.

---

## ✨ Key Features
- Smooth stacked card animations
- Horizontal & vertical swipe support
- Fully customizable card UI
- Works with static data and dynamic lists

---

## 🚀 Example
| On Static Layout | On List Layout (scroll able) |
|----------|----------|
| <img src="https://raw.githubusercontent.com/dannndi/stacked_card_swiper/main/example/assets/example/example_static.gif" width="720" alt="Example"> | <img src="https://raw.githubusercontent.com/dannndi/stacked_card_swiper/main/example/assets/example/example_list.gif" width="720" alt="Example"> |



---

## 📱 Live Demo
https://stacked-card-swiper.vercel.app/

---

## 📦 Installation
Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  stacked_card_swiper: ^latest
```

Then run:

```bash
flutter pub get
```

Import it in your Dart file:

```dart
import 'package:stacked_card_swiper/stacked_card_swiper.dart';
```

---

## 🚀 How To Use

### Basic Usage

```dart
StackedCardSwiper(
  values: Colors.primaries.take(4).toList(),
  swipeAxis: Axis.horizontal,
  onChanged: (color) {
    // triggered when top card is swiped
  },
  builder: (context, color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: const Text("Your Content"),
    );
  },
);
```