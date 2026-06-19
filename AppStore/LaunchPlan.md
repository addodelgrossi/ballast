# Ballast — launch and acquisition plan

## Positioning

Ballast is the fastest private way to start the 5-4-3-2-1 senses exercise on
Apple Watch: one tap from the watch face, eyes-closed haptics, and the Digital
Crown as a tactile counter. Keep the product free, watch-only, offline, and
single-purpose for version 1.0.

## App Store launch

1. Upload the localized metadata in `AppStore/Metadata` and the first five
   screenshots from `AppStore/Media`.
2. Use Health & Fitness as the primary category and Data Not Collected for App
   Privacy. Do not use claims such as “treats,” “prevents,” or “stops” anxiety.
3. Add the marketing, support, privacy, and accessibility URLs documented in
   `AppStore/README.md`.
4. Declare Apple Watch accessibility support only after final QA: VoiceOver,
   Larger Text, Dark Interface, Reduced Motion, Sufficient Contrast, and
   Differentiate Without Color.
5. Submit a Featuring Nomination at least two weeks before release. Lead with
   the watch-only design, eyes-closed interaction, privacy, four languages, and
   the personal accessibility problem the app solves.

Suggested nomination summary:

> Ballast turns the familiar 5-4-3-2-1 senses exercise into a native Apple
> Watch experience designed for moments when reading and precise taps are hard.
> A complication starts it in one tap; distinct haptics introduce each step;
> the Digital Crown counts each item. It is free, offline, account-free, and
> localized in English, Portuguese, Spanish, and French.

## Campaigns

Create separate App Store Connect campaign links after the app ID exists:

| Token | Placement | Message |
| --- | --- | --- |
| `website` | Product website | One tap, eyes closed, fully private |
| `watchcommunity` | Apple Watch communities | A purpose-built watchOS interaction |
| `mentalhealth` | Anxiety and wellbeing communities | Five senses when thoughts race |
| `professionals` | Therapists and counsellors | A simple private tool clients can keep on their wrist |
| `launch` | Launch posts and personal network | Free independent Apple Watch app |

Never post the same generic copy everywhere. Match each placement to the message
above and use its campaign URL so App Store Connect can attribute downloads.

## First 30 days

- Review App Store Connect weekly for impressions, product-page views,
  conversion rate, first-time downloads, territory, and source.
- Treat search conversion and campaign conversion separately. Apple does not
  support Product Page Optimization for Apple Watch product pages.
- Respond to every actionable review within 48 hours. Prioritize crashes,
  unclear Crown behavior, missed haptics, and complication launch failures.
- Do not add accounts, streaks, mood history, or subscriptions in response to
  weak acquisition. First improve search terms, screenshots, and the first-use
  instruction.
- Plan version 1.1 only from repeated feedback. The highest-value candidate is
  an App Intent/Siri shortcut for hands-free launch; alternative techniques and
  tracking remain lower priority.

## Release gates

- Signed Release archive contains `Products/Applications/Ballast.app` and the
  embedded complication.
- Physical Series 7 validates haptic counts, rapid Crown turns, both directions,
  eyes-closed completion, and complication deep-link launch.
- Five first-time users can complete the exercise without coaching; at least
  four understand “one noticed item = one Crown tick.”
- Public product, support, privacy, and accessibility pages return successfully.
