# 🎨 GirlRide Design System Documentation

## Overview
This document outlines the complete design system for GirlRide - a premium, safety-first, women-only ride-hailing application.

---

## 🎨 Color Palette

### Primary Colors
```
Royal Purple   #6A0DAD   RGB(106, 13, 173)   - Primary brand color, buttons, headers
Lavender       #CFA9FF   RGB(207, 169, 255)  - Secondary accents, highlights
White          #FFFFFF   RGB(255, 255, 255)  - Backgrounds, text on dark
```

### Secondary Colors
```
Soft Pink           #F9E6FF   RGB(249, 230, 255)  - Light backgrounds
Deep Violet         #4B0B82   RGB(75, 11, 130)    - Dark accents
Dark Charcoal       #2A2A2A   RGB(42, 42, 42)     - Primary text
Light Lavender      #E8D5FF   RGB(232, 213, 255)  - Subtle backgrounds
Pale Lavender       #F5ECFF   RGB(245, 236, 255)  - Input fields
Medium Purple       #8B3FBF   RGB(139, 63, 191)   - Gradient stops
```

### Functional Colors
```
Success     #4CAF50   RGB(76, 175, 80)    - Success states, confirmations
Warning     #FFA726   RGB(255, 167, 38)   - Warnings, cautions
Error       #EF5350   RGB(239, 83, 80)    - Errors, validation
Panic Red   #D32F2F   RGB(211, 47, 47)    - Emergency, panic button
```

### Neutral Colors
```
Grey Light    #F5F5F5   RGB(245, 245, 245)  - Light backgrounds
Grey Medium   #BDBDBD   RGB(189, 189, 189)  - Disabled states
Grey Dark     #757575   RGB(117, 117, 117)  - Secondary text
```

### Gradients

#### Purple Gradient
```dart
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [#6A0DAD, #8B3FBF],
)
```
**Usage**: Primary buttons, headers, premium features

#### Lavender Gradient
```dart
LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [#CFA9FF, #E8D5FF],
)
```
**Usage**: Backgrounds, subtle accents

#### Soft Gradient
```dart
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [#F9E6FF, #F5ECFF],
)
```
**Usage**: Onboarding, welcome screens

#### Panic Gradient
```dart
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [#D32F2F, #E57373],
)
```
**Usage**: Emergency states, panic button

---

## 📝 Typography

### Font Family
**Primary**: System Default (Inter recommended)

### Text Styles

#### Display Styles (Headlines)
```
Display Large
  Size: 32px
  Weight: Bold (700)
  Line Height: 1.2
  Letter Spacing: -0.5px
  Usage: Splash screen, major headings

Display Medium
  Size: 28px
  Weight: Bold (700)
  Line Height: 1.2
  Letter Spacing: -0.5px
  Usage: Page titles, onboarding

Display Small
  Size: 24px
  Weight: Bold (700)
  Line Height: 1.3
  Usage: Section headers
```

#### Headline Styles
```
Headline Large
  Size: 22px
  Weight: SemiBold (600)
  Line Height: 1.3
  Usage: Card titles, important labels

Headline Medium
  Size: 20px
  Weight: SemiBold (600)
  Line Height: 1.3
  Usage: Sub-headers

Headline Small
  Size: 18px
  Weight: SemiBold (600)
  Line Height: 1.4
  Usage: List headers, small titles
```

#### Body Styles
```
Body Large
  Size: 16px
  Weight: Regular (400)
  Line Height: 1.5
  Usage: Main content, descriptions

Body Medium
  Size: 14px
  Weight: Regular (400)
  Line Height: 1.5
  Usage: Secondary content, captions

Body Small
  Size: 12px
  Weight: Regular (400)
  Line Height: 1.4
  Color: Grey Dark
  Usage: Timestamps, metadata
```

#### Label Styles
```
Label Large
  Size: 14px
  Weight: SemiBold (600)
  Letter Spacing: 0.1px
  Usage: Input labels, menu items

Label Medium
  Size: 12px
  Weight: SemiBold (600)
  Letter Spacing: 0.1px
  Usage: Small labels, tags

Label Small
  Size: 10px
  Weight: SemiBold (600)
  Letter Spacing: 0.1px
  Usage: Micro labels, badges
```

#### Special Styles
```
Button
  Size: 16px
  Weight: SemiBold (600)
  Letter Spacing: 0.5px
  Usage: All button text

Caption
  Size: 12px
  Weight: Regular (400)
  Line Height: 1.3
  Color: Grey Dark
  Usage: Helper text, hints

Overline
  Size: 10px
  Weight: SemiBold (600)
  Letter Spacing: 1.5px
  Uppercase: true
  Usage: Category labels, tags
```

---

## 📏 Spacing System

### Base Unit: 4px

```
XS    4px    Tight spacing, icon padding
S     8px    Small gaps, compact layouts
M     16px   Default spacing, card padding
L     24px   Section spacing, large gaps
XL    32px   Major sections, screen padding
XXL   48px   Hero sections, large separations
```

### Usage Guidelines
- **Component Padding**: Use M (16px) as default
- **Screen Margins**: Use L (24px) or XL (32px)
- **Element Gaps**: Use S (8px) or M (16px)
- **Section Spacing**: Use L (24px) or XL (32px)

---

## 🔲 Border Radius

```
S      8px     Small elements, chips, tags
M      12px    Input fields, small cards
L      16px    Buttons, medium cards
XL     24px    Large cards, modals, sheets
Circle 999px   Avatars, circular buttons
```

### Usage Guidelines
- **Buttons**: L (16px)
- **Cards**: XL (24px)
- **Input Fields**: L (16px)
- **Modals**: XL (24px)
- **Avatars**: Circle (999px)

---

## 📦 Component Specifications

### Buttons

#### Primary Button
```
Height: 56px
Padding: 32px horizontal, 16px vertical
Border Radius: 16px
Background: Royal Purple or Gradient
Text: White, 16px, SemiBold
Shadow: 0px 4px 12px rgba(106, 13, 173, 0.3)

States:
  Default: Full opacity
  Hover: Scale 1.02
  Pressed: Scale 0.98
  Disabled: 40% opacity
  Loading: Show spinner, disable interaction
```

#### Secondary Button
```
Height: 56px
Padding: 32px horizontal, 16px vertical
Border Radius: 16px
Border: 2px solid Lavender
Background: Transparent
Text: Royal Purple, 16px, SemiBold

States:
  Default: Lavender border
  Hover: Royal Purple border
  Pressed: Pale Lavender background
  Disabled: Grey border, grey text
```

#### Panic Button
```
Size: 56px (compact) or 80px (normal)
Shape: Circle
Background: Panic Gradient
Icon: crisis_alert, 28px or 40px
Shadow: 0px 0px 16px rgba(211, 47, 47, 0.5)
Animation: Pulse (scale 0.95 to 1.05, 1s loop)
```

### Cards

#### Soft Card
```
Padding: 24px
Border Radius: 24px
Background: White
Shadow: 0px 4px 16px rgba(207, 169, 255, 0.2)
```

#### Quick Action Card
```
Padding: 16px
Border Radius: 16px
Background: Pale Lavender
Icon Container: 
  - Size: 48px
  - Shape: Circle
  - Background: White
  - Icon Size: 32px
  - Icon Color: Royal Purple
```

### Input Fields

#### Text Field
```
Height: 48px minimum
Padding: 20px horizontal, 16px vertical
Border Radius: 16px
Background: Pale Lavender
Border: None (default), 2px Royal Purple (focused), 2px Error (error)

States:
  Default: Pale Lavender background
  Focused: Royal Purple border
  Error: Error border
  Disabled: Grey Light background
```

#### Search Field
```
Height: 48px
Padding: 20px horizontal, 16px vertical
Border Radius: 16px
Background: White
Shadow: 0px 2px 12px rgba(207, 169, 255, 0.2)
Icon: search_rounded, 24px, Royal Purple
```

### Navigation

#### Bottom Navigation Bar
```
Height: 56px + safe area
Background: White
Shadow: 0px -4px 16px rgba(207, 169, 255, 0.2)
Item Count: 4
Icon Size: 24px
Selected Color: Royal Purple
Unselected Color: Grey Medium
Label: 10px, SemiBold
```

### Icons

```
XS: 16px   - Inline icons, badges
M:  24px   - Standard icons, navigation
L:  32px   - Feature icons, quick actions
XL: 48px   - Hero icons, empty states
XXL: 64px  - Splash, major features
```

---

## 🎭 Animation Guidelines

### Durations
```
Fast:   200ms  - Micro-interactions, hovers
Medium: 300ms  - Standard transitions, fades
Slow:   500ms  - Page transitions, reveals
```

### Curves
```
easeInOut:   Standard interactions
easeOut:     Entrances
easeIn:      Exits
elasticOut:  Playful bounces (logo, onboarding)
```

### Common Animations
```
Fade In/Out:     Opacity 0 ↔ 1, 300ms, easeInOut
Slide Up:        TranslateY 24px ↔ 0, 300ms, easeOut
Scale:           Transform 0.8 ↔ 1.0, 300ms, elasticOut
Pulse:           Scale 0.95 ↔ 1.05, 1000ms, loop
```

---

## 🖼️ Imagery Guidelines

### Profile Photos
```
Size: 80px - 120px diameter
Shape: Circle
Border: 3px white (on colored backgrounds)
Verification Badge: 20px, positioned bottom-right
```

### Empty States
```
Icon Size: 80px - 100px
Icon Color: Lavender
Text: Body Large, Grey Dark
Spacing: 16px between icon and text
```

---

## ♿ Accessibility

### Color Contrast
- **Primary Text on White**: 12.7:1 (AAA)
- **Royal Purple on White**: 7.5:1 (AA)
- **Grey Dark on White**: 4.8:1 (AA)

### Touch Targets
- **Minimum**: 44x44px (iOS), 48x48px (Android)
- **Recommended**: 56x56px for primary actions

### Text Sizing
- **Minimum**: 12px for body text
- **Recommended**: 14px+ for readability

---

## 📱 Responsive Breakpoints

```
Small:   < 360px   (Compact phones)
Medium:  360-414px (Standard phones)
Large:   414-768px (Large phones, small tablets)
XLarge:  > 768px   (Tablets, foldables)
```

---

## 🎯 Design Principles

### 1. Safety First
Every design decision prioritizes user safety and security.

### 2. Feminine & Professional
Soft colors, rounded shapes, and gentle animations create a welcoming yet professional environment.

### 3. Clear Hierarchy
Typography and spacing create obvious visual hierarchy for easy scanning.

### 4. Minimal Cognitive Load
Simple, intuitive interfaces reduce user effort and decision fatigue.

### 5. Premium Feel
High-quality gradients, shadows, and animations convey trustworthiness.

### 6. Consistency
Reusable components ensure a cohesive experience throughout the app.

---

## 📋 Component Checklist

When creating new components, ensure:
- [ ] Uses defined color tokens
- [ ] Follows spacing system
- [ ] Implements proper border radius
- [ ] Includes all interactive states
- [ ] Has appropriate shadows/elevation
- [ ] Meets accessibility standards
- [ ] Includes loading states (if applicable)
- [ ] Handles edge cases (long text, etc.)
- [ ] Uses system typography
- [ ] Implements smooth animations

---

## 🔗 Resources

### Design Files
- Figma: [Link to Figma file]
- Adobe XD: [Link to XD file]
- Sketch: [Link to Sketch file]

### Assets
- Icons: Material Icons (built-in Flutter)
- Illustrations: Custom or from resources
- Photos: Stock or professional photography

### Inspiration
- Dribbble: Women's safety apps
- Behance: Ride-hailing interfaces
- Pinterest: Purple UI designs

---

**Last Updated**: November 2025
**Version**: 1.0.0
**Maintained by**: GirlRide Design Team
