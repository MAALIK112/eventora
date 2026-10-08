# Eventora - Luxury Event Booking & Service Marketplace

Eventora is a mobile-first event booking and service marketplace application built in **Flutter & Dart**, styled strictly to the **Celebration Luxe** design system and engineered to **OWASP MASVS** mobile security standards.

---

## 💎 Celebration Luxe Design Tokens Implemented

- **Primary Interactive**: Deep Amber (`#903F00` / `#B45309`) & Radiant Gold (`#D97706`)
- **Trust & Verification**: Emerald Sage (`#059669` / `#ECFDF5`) for insured partner badges and escrow security
- **Surfaces & Background**: Warm Ivory canvas (`#FDFBF7`), Alabaster Veil (`#F8F5EE`), Pure White containers (`#FFFFFF`)
- **Hairlines & Borders**: Warm Linen (`#EFECE6` / `#DDC1B3`)
- **Typography**:
  - Display & Section Titles: **Noto Serif** (editorial grandeur)
  - UI, Meta & Pricing: **Plus Jakarta Sans** (clean tabular legibility)
- **Elevation**: Ambient daylight glowing shadows paired with 1px hairline borders

---

## 📱 Features & Screen Architecture

### 1. Browse & Discovery Hub (`/lib/screens/home/`)
- **VIP Member Top Bar**: Profile avatar with VIP badge & notifications
- **Hero Editorial Banner**: Curated Celebration Luxe callout
- **Category Carousel**: Quick pill filters (Photography, Venues, Catering, Event Planning, Decorations, Entertainment, Florals, Lighting)
- **Featured Masters Section**: Verified partner cards with event count and star ratings
- **Service Cards**: 16:9 media cards with instant bookmarking, starting package price, and location

### 2. Multi-Criteria Search & Filter (`/lib/screens/search/`)
- Real-time text search across services, descriptions, providers, and locations
- **Filter Bottom Sheet**:
  - Sort by: Popularity, Top Rated, Price Low-to-High, Price High-to-Low
  - Category selector
  - Dual-thumb price slider (\$500 – \$20,000)
  - Minimum rating filter (4.5+, 4.8+, 4.9+)
  - "Verified Partners Only" toggle switch

### 3. Service Detail & Package Selection (`/lib/screens/service_detail/`)
- Full-bleed image gallery with page indicators
- Service highlights checklist
- Tiered Packages: **Silver (Essential)**, **Gold (Grand Gala)**, **Platinum Luxe (Royal Heritage)**
- Bespoke add-ons with toggle pricing calculation
- Provider profile card with background bio, statistics, and direct concierge contact
- Escrow guarantee & flexible cancellation policy
- Client reviews breakdown
- **Sticky Booking Dock**: Pinned to viewport with real-time price calculation and "Reserve Date" action

### 4. 5-Step Booking Wizard (`/lib/screens/booking/`)
- **Step 1**: Package tier confirmation & custom add-ons selection
- **Step 2**: Date picker, time slot selector, and venue address with input sanitization
- **Step 3**: Event classification (Wedding, Milestone, Gala, Corporate) and guest count slider
- **Step 4**: Payment instrument (Eventora Wallet balance, Credit Card, Apple Pay), VIP coupon code (`LUXE100`), and Escrow protection toggle
- **Step 5**: Itemized financial breakdown (Package base, add-ons, 4% concierge fee, 7% taxes, protection insurance, discounts, Grand Total)
- **Confirmation Screen**: Celebration badge, Booking ID pass, QR ticket, and live execution milestones

### 5. Bookings Management Dashboard (`/lib/screens/bookings/`)
- 3 Tab View: **Upcoming**, **Past**, **Cancelled**
- Live booking ticket passes
- **Detail & Execution Tracker**:
  - Live milestone timeline (Requested ➔ Confirmed ➔ Vendor Assigned ➔ In Progress ➔ Completed)
  - Reschedule reservation modal with calendar update
  - Cancel reservation with 100% automated refund to Luxe Wallet
  - Direct message to provider and VIP Concierge

### 6. Payments & Luxe Escrow Wallet (`/lib/screens/wallet/`)
- Dark luxury Escrow Vault Card showing available balance, funds in active escrow, and total managed assets
- **Quick Top-Up Modal**: Instant deposits with \$500, \$1000, \$2500, \$5000 quick chips or custom amounts
- **Add Card Modal**: PCI-DSS cardholder input with Luhn checksum validation and live brand detection (AMEX, VISA, Mastercard)
- **Transaction Receipt Modal**: Reference numbers, timestamps, and settlement status
- Filter transactions by Deposits, Escrow Holds, and Loyalty Cashback Rewards

### 7. User Profile & Account (`/lib/screens/profile/`)
- Profile overview with member tier and hosted celebration metrics
- **Edit Profile**: Full name, email, phone, and primary city
- **Security & Vault Center (OWASP MASVS)**:
  - Biometric Face ID / Touch ID toggle
  - Two-Factor Authentication (2FA) switch
  - Escrow 4-digit PIN setup
  - Device security audit checklist (Hardware Keystore, TLS pinning)
- **Saved Wishlist**: Bookmarked collections with quick reserve action
- **Settings**: Push/email notifications, currency selection, and legal terms

### 8. Concierge & Help Center (`/lib/screens/support/`)
- **VIP Live Chat Simulator**: Real-time conversation with typing indicator, suggested prompt pills, and smart luxury concierge responses
- **Submit Priority Ticket Modal**: Category routing, related booking ID, and priority escalation
- **Interactive FAQ Accordion**: Searchable answers on escrow guarantees, cancellations, and vetting standards

---

## 🔒 Security & Code Standards (OWASP MASVS & Clean Architecture)

- **Input Validation & Sanitization**: `InputValidator.sanitizeText()` strips XSS / injection vectors. Luhn checksum algorithm for cards.
- **Secure Memory & Key Handling**: `SecureStorageService` simulates Keychain/Keystore encryption.
- **State Management**: Reactive `ChangeNotifierProvider` architecture separating UI, Domain Models, and Data Services.
- **Tabular Currency Stability**: Numeric prices formatted with `CurrencyFormatter` to avoid layout shifts.

---

## 🚀 Running the App

```bash
# Get dependencies
flutter pub get

# Run tests
flutter test

# Run application on device / emulator / chrome
flutter run
```
