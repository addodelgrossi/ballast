# Ballast — App Store submission

## Product record

- Platform record: iOS with a watchOS-only app
- Name: `Ballast`
- Bundle ID: `com.addodelgrossi.ballast`
- SKU suggestion: `ballast-watch-001`
- Primary language: English (U.S.)
- Primary category: Health & Fitness
- Price: Free
- Version: `1.0`
- App privacy: Data Not Collected

Apple requires an iOS App Store record even for a watchOS-only app. Because
Ballast has no iOS component, iPhone screenshots are not required. Add the
watchOS media through **Previews and Screenshots → Apple Watch**.

## Media

Upload-ready Series 7 screenshots are available in English and Portuguese:

- [`docs/assets/screenshots/en-US`](../docs/assets/screenshots/en-US)
- [`docs/assets/screenshots/pt-BR`](../docs/assets/screenshots/pt-BR)

Each file is `396 × 484` pixels, matching Apple’s Series 7 specification. Apple
accepts one to ten watch screenshots. Spanish and French metadata can initially
use the English media fallback.

The watchOS product page does not currently accept App Preview videos. The
`docs/assets/ballast-demo.mp4` video is for the product website and other
marketing channels.

References:

- [Apple Watch screenshot specifications](https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications/)
- [Add watchOS app information](https://developer.apple.com/help/app-store-connect/create-an-app-record/add-watchos-app-information)
- [Upload previews and screenshots](https://developer.apple.com/help/app-store-connect/manage-app-information/upload-app-previews-and-screenshots)

## Public URLs

Once GitHub Pages is enabled for this repository:

- Marketing: `https://addodelgrossi.github.io/ballast/`
- Support: `https://addodelgrossi.github.io/ballast/support/`
- Privacy: `https://addodelgrossi.github.io/ballast/privacy/`

The support page currently uses GitHub Issues. Add a public support email before
submission if one should be displayed directly.

## Review notes

Suggested text for App Review:

> Ballast is a standalone Apple Watch grounding tool. It requires no account,
> backend, network connection, or sensitive permissions. Tap Start or launch
> from a complication. During each step, turn the Digital Crown in either
> direction once per noticed item. The app automatically advances from 5 to 1.
> Tapping the full screen provides an equivalent fallback. Haptic feedback must
> be evaluated on physical Apple Watch hardware.

## Submission checklist

- [ ] Confirm Apple Developer Program membership and agreements
- [ ] Register bundle identifiers and select the development Team
- [ ] Create the App Store Connect app record
- [ ] Archive a Release build and upload it
- [ ] Run an internal TestFlight pass on the physical Series 7
- [ ] Confirm the complication starts a fresh exercise
- [ ] Confirm haptic strength and timing on physical hardware
- [ ] Upload Apple Watch screenshots
- [ ] Add EN, PT-BR, ES, and FR metadata
- [ ] Enter Marketing, Support, and Privacy URLs
- [ ] Complete age-rating and app-privacy questionnaires
- [ ] Add App Review contact details and review notes
- [ ] Select manual release for version 1.0
- [ ] Submit for review
