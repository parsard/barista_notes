# barista_notes

# 💻 اپلیکیشن حسابداری و فروش (POS) برای ویندوز — Flutter + Clean Architecture

این پروژه یک اپلیکیشن فروش (POS) برای **ویندوز** است که با **Flutter** توسعه داده شده و با تمرکز بر:
- معماری **Clean Architecture**
- مدیریت وضعیت با **Riverpod**
- پایگاه داده با **Drift (Moor)**
- پشتیبانی کامل از زبان فارسی و راست‌چین (RTL)

ساخته شده است.

---

## ✨ ویژگی‌ها
- 📦 **مدیریت محصولات:** اضافه، ویرایش، حذف و مشاهده لیست محصولات.
- 🛒 **مدیریت سفارش‌ها:** ایجاد سفارش، مشاهده لیست سفارش‌ها، آیتم‌های سفارش.
- 📄 **خروجی PDF** برای فاکتور با پشتیبانی کامل از فونت و چینش فارسی.
- 🖨️ **چاپ حرارتی** (Thermal Receipt) با پشتیبانی از پرینتر شبکه و تنظیمات IP.
- 🎨 UI واکنش‌گرا با **flutter_screenutil** و پشتیبانی از افکت Shimmer Loading.
- 🗂️ کدنویسی ماژولار و تست‌پذیری بالا با رعایت جدا‌سازی لایه‌ها.

---

## 🏗 معماری
پروژه مطابق با Clean Architecture به ۳ لایه اصلی تقسیم شده:

### **1. Domain Layer**
- موجودیت‌ها (Entities) مانند `ProductEntity`, `OrderEntity`, `OrderItemEntity`
- واسط‌های ریپازیتوری (Repository Interfaces)

### **2. Data Layer**
- پیاده‌سازی ریپازیتوری‌ها با **Drift DAO**
- تبدیل Entityها به مدل‌های پایگاه داده (Companions)
- مدیریت کامل CRUD برای محصولات و سفارش‌ها.

### **3. Presentation Layer**
- ویجت‌های Flutter و مدیریت حالت با **Riverpod**
- State Providers برای استفاده Asynchronous و Stream
- صفحه POS، کارت محصولات، لیست سفارش‌ها

---

## 🗄 پایگاه داده Drift
- استفاده از جداول جداگانه برای `products`, `orders`, `order_items`
- قابلیت تماشا (`watchAllProducts`) و فراخوانی (`getAllOrders`)
- سازگار با **sqlite3_flutter_libs** برای اجرا در ویندوز.

---

## 🖨 چاپ و خروجی
- **PDF:** با پکیج‌های `pdf` و `printing` و پشتیبانی کامل RTL
- **چاپ حرارتی (Thermal Printer):** با `bluetooth_print` و امکان اتصال به پرینتر شبکه

---

## 📦 وابستگی‌ها (Dependencies)
```yaml
dependencies:
  flutter:
sdk: flutter
  fluent_ui:
  flutter_riverpod:
  drift:
  drift_flutter:
  path_provider:
  path:
  sqlite3_flutter_libs:
  flutter_localization:
  cupertino_icons: ^1.0.8
  persian_fonts:
  flutter_screenutil: ^5.9.3
  shimmer:
  pdf: ^3.11.3
  printing: ^5.14.2
  bluetooth_print:
  network_info_plus:
