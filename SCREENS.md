# Pocket Wrench - Screens

Design frame: **430 x 932** (iPhone Pro Max). Font: **General Sans** (bundled in `assets/fonts/`).

| # | Screen | Feature | Route | Status | Outstanding TODOs |
|---|--------|---------|-------|--------|-------------------|
| 1 | Splash | `splash` | `/splash` | done | None. Holds 2s, then fades to `/welcome`. |
| 2 | Welcome | `welcome` | `/welcome` | done | Hero is `assets/images/onboardingimage1.png` with a 20% black scrim, as designed. "Get Started" -> `/auth/role`, "Log In" -> `/auth/login`. |
| 3 | Role selection ("How will you use Pocket Wrench?") | `auth` | `/auth/role` | done | None. Continue -> `/auth/sign-up` with the chosen role. |
| 4 | Create Account | `auth` | `/auth/sign-up` | done | None. Success -> `/auth/verify-otp`. |
| 5 | Login ("Welcome Back") | `auth` | `/auth/login` | done | None. Success -> `/main` (requester) or `/mechanic` (mechanic). |
| 6 | Forgot Password | `auth` | `/auth/forgot-password` | done | Success -> `/auth/reset-password` (stand-in for the emailed link). |
| 7 | Reset Password | `auth` | `/auth/reset-password` | done | Success -> `/auth/login`. |
| 8 | Verify your account (OTP) | `auth` | `/auth/verify-otp` | done | Success -> `/onboarding/profile` (requester) or `/mechanic` (mechanic). |
| 9 | Profile setup ("Let's set up your profile") | `onboarding` | `/onboarding/profile` | done | Two identical screenshots were supplied (9 and 10), so one screen. "Browse Files" needs an image/file picker package (not approved). City list is a mock bottom sheet. Next -> `/onboarding/all-set`. |
| 10 | You're all set! | `onboarding` | `/onboarding/all-set` | done | Get Started -> `/main` (clears the stack). |
| 11 | Home (inside the main shell) | `main` + `home` | `/main` | done | Banner is `getexperthelpimage.png`; people photos are network images from the mock repository. Content below the first request card was hidden by the nav bar in the screenshot. Find a Mechanic and See All open the Explore tab, a mechanic card opens the profile; the bell, Add and request cards show a "coming soon" snackbar. |
| 12 | Suggested Mechanics (Explore tab) | `explore` | `/main` (tab 3) | done | Search with debounce, filter bar, mechanic list. Back returns to the Home tab. "Find a Mechanic" and "See All" on Home switch to this tab. |
| 13 | Mechanic Filters (bottom sheet) | `explore` | sheet | done | Edits a draft; "Apply Filters" commits it and reloads. "Near me" is stored but the mock repository ignores it (no device location). |
| 14 | Mechanic profile | `mechanics` | `/mechanics/profile` | done | Full screen, no nav bar. Takes a mechanic id. The kebab menu shows a "coming soon" snackbar. |
| 15 | Contact mechanic (bottom sheet) | `mechanics` | sheet | done | Pick a request, then "Continue to Conversation" (opens the chat) or "Create a Support Request" (shows "coming soon"). |
| 16 | Messages list (Messages tab) | `messages` | `/main` (tab 4) | done | Search filters locally. Back returns to the Home tab. Tapping a row opens the chat. |
| 17 | Chat | `messages` | `/messages/chat` | done | Full screen, no nav bar. Opened from a conversation or from the contact sheet on a mechanic profile. Opens scrolled to the newest message. |
| 18 | Add to message (sheet) | `messages` | sheet | done | Camera, Photos, Video, Document show a "not available" snackbar until pickers are approved. |
| 19 | Recording voice note (sheet) | `messages` | sheet | done | Live timer and moving waveform. "Send Voice" shows a "not available" snackbar until a recorder package is approved. |
| 20 | No messages yet (empty state) | `messages` | `/main` (tab 4) | done | Shown when there are no conversations. "Find a Mechanic" opens the Explore tab. |
| 21 | My Requests (Requests tab) | `requests` | `/main` (tab 2) | done | All (count) / Active / Resolved segments filter locally. "Add" starts the new-request flow; a card shows a "coming soon" snackbar (no request detail design yet). Back returns to the Home tab. |
| 22 | New request: Enter Details | `requests` | `/requests/new/details` | done | Title, Category, Make, Model + Year, Urgency (default Normal), Description. Title, category, make, model and year are required; description is optional. |
| 23 | New request: Add Photos or Files | `requests` | `/requests/new/files` | done | Optional. Uses a mock picker (see notes). Next does not wait for uploads. |
| 24 | New request: Review Details | `requests` | `/requests/new/review` | done | Edit links go back to the details or files step. Send Request saves to the mock repository. |
| 25 | Request Submitted | `requests` | `/requests/new/submitted` | done | Replaces the three steps and keeps the main shell underneath. Go to Home and Find an Expert return to the shell on the Home or Explore tab. |
| 26 | Request description (full text) | `requests` | `/requests/new/description` | done | My reading of the text-only screenshot: tapping the (3-line) description on the review step opens the whole text. Tell me if it is something else. |
| 27 | Profile (Profile tab) | `profile` | `/main` (tab 5) | done | Back returns to the Home tab. "Help & Support" shows a "coming soon" message (no design). |
| 28 | Edit Profile | `profile` | `/profile/edit` | done | Name, email and phone are validated; date of birth uses the Material date picker; location uses the city sheet. The camera badge shows a "not available" message until an image picker is approved. |
| 29 | Notifications | `profile` | `/profile/notifications` | done | Switches edit a draft that Save Changes stores. |
| 30 | Privacy | `profile` | `/profile/privacy` | done | One fixed option (city-level location only), so Save Changes just stores it. |
| 31 | Update Password | `profile` | `/profile/password` | done | Current password is required, new one needs 8+ characters, confirmation must match. |
| 32 | About Us | `profile` | `/profile/about` | done | The four rows show a "coming soon" message (links need a URL launcher package). |
| 33 | Mechanic onboarding: Experience | `mechanic_onboarding` | `/mechanic/onboarding/experience` | done | First screen after a mechanic verifies their code. Trade, years, city and one or more specialties are required. |
| 34 | Mechanic onboarding: Vehicles | `mechanic_onboarding` | `/mechanic/onboarding/vehicles` | done | Search filters the brand chips; at least one brand is required. |
| 35 | Mechanic onboarding: Expertise | `mechanic_onboarding` | `/mechanic/onboarding/expertise` | done | Certifications and skills are optional; "+ Add" turns a typed certification into a selected chip. Prices start at $100 / $150 / $200 and must be filled in. |
| 36 | Mechanic onboarding: Verification | `mechanic_onboarding` | `/mechanic/onboarding/verification` | done | Mock picker adds a sample PDF (no file picker package yet); at least one document is required. Next sends the answers to the mock repository. |
| 37 | Verification submitted | `mechanic_onboarding` | `/mechanic/onboarding/submitted` | done | Back returns to Verification. "Go to Home" lands on the mechanic placeholder (`/mechanic`), which is still undesigned. |
| 38 | Mechanic Home (Home tab) | `mechanic/home` | `/mechanic` (tab 1) | done | Banner photo is `skillsmatterimage.jpg`. Accept / Decline remove the request (mock). The bell and "Upgrade Now" show "coming soon"; "See All" opens the Requests tab. |
| 39 | Mechanic Messages list (Messages tab) | `shared/messages` | `/mechanic` (tab 3) | done | Same list as the requester's, with customers' conversations. Back returns to Home. |
| 40 | Mechanic chat | `shared/messages` | `/messages/chat` | done | Header shows "Active Request" instead of the verified tag and role; the request card has a "Start Live Stream" link ("coming soon"). Bubbles use the mechanic palette (see notes). |
| 41 | Mechanic Messages empty state | `shared/messages` | `/mechanic` (tab 3) | done | "Browse Requests" opens the Requests tab (not designed yet). |
| 42 | Alerts (mechanic Alerts tab) | `shared/alerts` | `/mechanic` (tab 4) | done | Today / Earlier groups. Tapping an unread alert marks it read (lime bell and dot go away); where an alert leads is not designed yet. Back returns to Home. |
| 43 | Service Requests: All (mechanic Requests tab) | `mechanic/requests` | `/mechanic` (tab 2) | done | Lists the requests still waiting for an answer, with Decline / Accept. Back returns to Home. |
| 44 | Service Requests: Active | `mechanic/requests` | `/mechanic` (tab 2) | done | Accepted requests with the requester, their last message and "Open Conversation". |
| 45 | Service Requests: Resolved | `mechanic/requests` | `/mechanic` (tab 2) | done | Finished requests; tapping one opens its detail. |
| 46 | Request detail (pending) | `mechanic/requests` | `/mechanic/requests/detail` | done | Opened from any card, on Home or the tab. Decline leaves; Accept moves the request to Active. |
| 47 | Request detail (active) | `mechanic/requests` | `/mechanic/requests/detail` | done | Same screen with "Open Conversation". A resolved request shows no buttons (not in the design). |
| 48 | Profile menu (mechanic) | `shared/profile` + `mechanic/profile` | `/mechanic` (tab 5) | done | Same Profile tab, driven by `MechanicProfileMenuViewModel`: ACCOUNT, PROFESSIONAL (compact rows; Verification carries the verified badge), NOTIFICATIONS, CERTIFICATIONS, PRIVACY, SUPPORT, ABOUT. |
| 49 | Edit Profile / Update Password / About Us (mechanic) | `shared/profile` | `/profile/*` | done | Same screens as the requester's; they show the mechanic's account (King Tom, KT). |
| 50 | Professional Profile | `mechanic/profile` | `/mechanic/profile/professional` | done | Basic info, brands, expertise and skills from `MechanicProfileRepository`. "Edit Profile" opens the shared Edit Profile; the camera badge shows a "coming soon" snackbar (no image picker package). |
| 51 | Verification: Verified | `mechanic/profile` | `/mechanic/profile/verification` | done | Green check, document rows with "Verified". |
| 52 | Verification: Pending Review | `mechanic/profile` | `/mechanic/profile/verification` | done | Same screen with the clock and check-only rows. The mock repository defaults to verified; pass `MockMechanicProfileRepository(verificationStatus: VerificationStatus.pending)` to see this one. |
| 53 | Notifications (mechanic) | `shared/profile` | `/profile/notifications` | done | Same screen with the mechanic's four switches and wording (route argument `ProfileAudience.mechanic`). |
| 54 | Privacy (mechanic) | `shared/profile` | `/profile/privacy` | done | Same screen with the mechanic's Location Privacy copy. |
| 55 | Pricing Tiers | `mechanic/profile` | `/mechanic/profile/pricing` | done | Switch tiers on and off, "Add Custom Tier" and the minimum fee open bottom sheets, "Save Changes" stores the plan and goes back. |
| 56 | Certifications | `mechanic/profile` | `/mechanic/profile/certifications` | done | Cards with status chips and a menu to remove; Upload (mock picker), Enter Manually (focuses the write-in field) and Write-In submit to the mock repository as pending. |

## Code layout

`lib/features` is split by who uses it, then by feature:

- `features/requester/` - home, explore, requests, mechanics (viewing a mechanic's profile), onboarding (profile setup), main (the requester shell).
- `features/mechanic/` - onboarding (the five expert onboarding steps), home, requests, profile (professional profile, verification, pricing, certifications and the mechanic Profile menu), main (the mechanic shell).
- `features/shared/` - splash, welcome, auth, messages, profile (account and settings), shell (the tab shell both roles use), plus `home` (header and promo banner) and `requests` (request model, urgency tag, status icon) used by both roles.

Both shells are `TabShell` (`shared/shell`) with their own tab list and ViewModel (`MainShellViewModel`, `MechanicShellViewModel`), so the bottom navigation bar and tab handling exist once.

## Notes on mechanic home

- **Nav bar:** Home, Requests, Messages, Alerts (bell), Profile, as drawn in the Messages screenshots. The first mechanic Home screenshot had Alerts third with a magnifier; I followed the newer one. Every tab is real now.
- **Sample account:** the mechanic shell swaps in a mechanic sample account (King Tom) so the header and Profile tab match the design.
- **Banner:** `assets/images/skillsmatterimage.jpg` is a plain square photo, so the left fade and a light dimming are drawn in code (`PromoBanner.fadeImageEdge`), and the text is kept beside the photo. The design also has a handwritten lime "Your Skills Matter" caption on the photo; it is not drawn because it needs a script font (or the caption baked into the image).
- **Cards:** the request cards reuse the urgency tag and status icon from `features/shared/requests`; Accept and Decline both just remove the request from the mock list.

## Notes on mechanic messages

- **One screen, two perspectives:** the conversation list and chat are shared (`features/shared/messages`) and take a `ChatPerspective`. The mechanic version differs only where the design does: header status, "Start Live Stream", incoming bubbles on the surface color (not grey), outgoing bubbles 8 dp further from the edge, bubbles always full width, and 180 x 130 dp media.
- **Names in the design:** the list shows Mike Anderson, but the chat screenshot is titled "James Wilson". The mock uses Mike Anderson for both, with the chat content from the screenshot.
- **Mock data is switched per role:** the shared mock account and message repositories serve the requester's data by default, and each shell's binding switches them to its own role's data (they are permanent so GetX does not rebuild them when a route closes).
- **Avatar quirk:** as on the requester list, the design draws the second row's avatar and card slightly larger; all rows use one size here.

## Notes on alerts

- **Shared, used by the mechanic for now:** `features/shared/alerts` holds the list, so the requester can reuse it when it gets an Alerts entry point (the bell on Home still shows "coming soon").
- **Sample data:** the eight notifications come from `MockAlertsRepository`; the last one ("Advice Implemented") is cut off by the nav bar in the design, so its message is my own wording.
- **Text sizes:** titles are 14sp semibold and messages 12sp, smaller than the other lists.

## Notes on mechanic requests

- **"All" means "waiting for you":** the All tab lists only pending requests, as drawn, and its count is the real number of them (the design shows "All (3)" above four cards). Active and Resolved hold the rest.
- **One list for Home and the tab:** both read `ServiceRequestRepository`, so accepting or declining anywhere updates the other. This replaced Home's earlier two sample cards, so Home now starts with "Engine Stalls After Warming Up" instead of "Battery Warning Light".
- **Sample data:** pending requests are four; Active has three, including a second "Engine Stalls After Warming Up" (as drawn), so accepting the pending one adds a fourth; Resolved has two. Requesters other than the drawn ones (Daniel Brooks, Emily Carter, Noah Bennett) are made up.
- **Open Conversation:** starts (or reopens) the mechanic's chat with that customer, with the request pinned. James Wilson's chat has the thread from the chat screenshot; Sarah Lee and Robert Smith start from their last message.
- **Priority tag:** lists show NORMAL, IMPORTANT or URGENT; the design's IMPORTANT is a mechanic-side priority, separate from the requester's Low / Normal / Urgent.
- **Design slips:** the first Resolved card shows a question-mark icon while the second shows a check; both use the check. The Attachments thumbnails have no white frame on the first image as drawn.
- `SupportRequest` (the request pinned in a chat) moved to `features/shared/messages`, since both roles use it.

## Notes on mechanic settings

- **Log Out** (not in the design, so styled as a menu row in the error color, no chevron) sits under the last section of the Profile tab for both roles. It asks for confirmation in a bottom sheet, calls `AuthRepository.logout()` (mock: short delay) and clears the navigation stack to Welcome and opens role selection on top of it (so Back returns to Welcome).
- The Profile tab is shared. `ProfileViewModel` builds its sections from `ProfileMenuSection`/`ProfileMenuItem` data; `MechanicProfileMenuViewModel` overrides `audience`, `menu` and `extraSections`. Notifications and Privacy read `ProfileAudience` from `Get.arguments`.
- The screens are drawn on a taller canvas than the phone frame, so spacing was matched at the normal frame height and the extra length is scroll.
- Several texts use sizes of about 14.4, 12.5 and 10.8 sp (for example body copy, chips, the status chip); they were matched to the design by measurement.
- Design slips kept as drawn: the Expertise card sits 8 px further from its label than the other cards, and the Pricing and Certifications titles are 18 sp while other screen titles are 20 sp.
- The Professional Profile rows use one gap, where the design draws 25 px between some rows and 17 px between others.
- The "Verified" screen body reads "Your expertise has been verified and your mechanic profile is live."
- Data is mock and lasts until restart. `MockMechanicProfileRepository` is created in `MechanicMainBinding` (not lazily) so the pushed profile screens keep seeing the same data after they are popped.
- Upload Certificate uses the same mock `DocumentPicker` as onboarding; a real file picker needs a package that has not been approved.

## Navigation shell

`TabShell` (`features/shared/shell`) is a Scaffold whose `bottomNavigationBar` is the reusable `AppBottomNavBar` and whose body is an `IndexedStack` of tabs, so each tab keeps its state. Each role has a thin shell view (`MainShellView`, `MechanicShellView`) listing its tabs, and a ViewModel that extends `TabShellViewModel`. Add a tab by adding an `AppNavItem` and a body widget to that role's shell view.

## Fidelity

Screens 1-8 were measured against the supplied screenshots at 860 px wide (2x). Every element row (title, subtitle, labels, fields, buttons, dividers, footers, OTP boxes) lands on the same pixel rows as the design, and text widths are within 1-2 px. The Create Account footer sits below the fold of a 932 frame, so it was checked by offset only. The requests and profile screens (21-32) were compared the same way, row by row at 2x, and land within 1-2 px.

## Assumptions to confirm

- **Create Account frame is taller (860 x 2102)** than the others. It is built as a scrollable screen with the footer pinned at the bottom when content is short.
- **Footer spacing differs per screen in the design** (Login footer sits about 25 dp lower than Forgot Password / Create Account). Matched per screen via `bottomPadding`.
- **Role Continue button is 52 dp tall** (others are 50 dp), as drawn.
- **Terms checkbox starts unchecked.** The design shows it checked, but a pre-ticked consent box is poor practice. Submit shows an error snackbar until it is ticked. "Remember me" starts checked as drawn.
- **Forgot Password -> Reset Password:** the design emails a link, so the real app would deep-link to Reset Password. For now "Send Reset Link" shows a success message and opens Reset Password directly.
- **"Log in" on Forgot Password** is styled as plain text in the design; it is tappable and returns to Login.
- **Error states** are not in the design. Fields show an inline message under the field with a red border (`AppColors.error`, provisional). Non-field errors use `AppSnackbar`.
- **Verify screen** has one hidden text field behind the six boxes. The keyboard opens automatically. Verify with fewer than 6 digits shows an error snackbar.
- Filled OTP boxes are drawn wider than empty ones in the design; reproduced with flex weights so six filled boxes still fit.
- The auth repository is mocked (`MockAuthRepository`, 0.9 s delay, always succeeds). Swap it in `InitialBinding`.

## Assets

- Drawn by me as stand-ins (24 px, stroke icons): `ic_arrow_left`, `ic_search`, `ic_wrench`, `ic_eye`, `ic_eye_off`, `ic_check`. Replace the files in `assets/icons/` if the Figma icons differ.
- Provided by you and wired in: `googleicon.svg`, `githubicon.svg`, `onboardingimage1.png`, `pocketwrenchlogo.svg`.
- Also drawn by me as stand-ins: `ic_bell`, `ic_plus`, `ic_upload_cloud`, `ic_chevron_down`, `ic_shield_check`, `ic_help_circle`, `ic_home`, `ic_requests`, `ic_messages`, `ic_profile`, and `ic_verified` (gradient badge). The nav and profile icons are the most likely to differ from Figma.
- Also drawn by me: `ic_close`, `ic_more_vertical`. Also drawn by me for messages: `ic_camera`, `ic_image`, `ic_video`, `ic_file_text`, `ic_mic`, `ic_phone`, `ic_send`, `ic_message_square`, `ic_play`, `ic_arrow_right`.
- Home banner: `getexperthelpimage.png` (the right half of the card at 4x, with its left fade baked in). People photos (user and mechanics) are network images loaded through `AppImage`; the mock repository uses randomuser.me portraits, so swap in real URLs from your API.

## Notes on the requester flow

- Flow: sign up -> verify code -> profile setup -> all set -> home. Login and social sign-in skip onboarding and go straight to `/main`.
- The hero banner has a 20% black scrim on the welcome screen and a left fade on the home banner; both come from the design.
- Home text sizes were fitted to the screenshot by measuring widths in General Sans; names use 16sp semibold, section titles 18sp, small copy 14sp / 12sp.
- `lib/app.dart` was merged into `lib/main.dart` (not by me). Tests now import `package:pocketwrench/main.dart`.

## Notes on explore and mechanic profile

- **Filter chips row:** screenshot 13 (the list) has no chips row, but screenshot 14 (the filters sheet) shows one behind the sheet (Specialty, Near Me, Experience, Verified). I kept the row because it is the only way to open the sheet; tell me if it should appear only when a filter is active, or if a filter icon belongs in the search bar.
- **Nav highlight:** screenshot 13 highlights "Messages", which looks like a design slip; Explore is highlighted here.
- **Contact sheet title:** the design says "Contact Mike Anderson" over King Tom's profile; the sheet uses the opened mechanic's name.
- **Experience filter:** "Any" is selected by default (the screenshot shows no option selected).
- **Mechanic cards** are shared by Home and Explore (`features/requester/mechanics`). The Explore list uses 14 dp padding where Home uses 16 dp, as drawn.
- **Bottom sheets** now blur and dim the screen behind them (`AppBottomSheet`), including the city picker.
- **Filter and profile data** come from `MockMechanicRepository`; avatars are randomuser.me portraits.
- Formatting: running `dart format` on `lib/` reformatted many files to the current Dart style (no logic changes).

## Notes on messages

- **Avatar size:** in the list screenshot the second row has a larger avatar and a taller card than the other two. I used one avatar size for all rows, so that card is 3 dp shorter than drawn.
- **Chat scroll:** the chat opens at the newest message. The screenshot shows the top of the thread; both are the same layout.
- **Voice notes and attachments** have working UI but no capture: they need an audio recorder and image/file picker packages, which are not approved.
- **Sending text** works against the mock repository (adds the message and updates the list preview). When the field has text, the mic becomes a send button.
- **New conversations:** "Continue to Conversation" on a mechanic profile opens that mechanic's chat (creating it if needed) with the chosen request pinned at the top.
- **Bottom sheets** have two styles: blurred (filters, contact) and a dimmed surface panel (attachments, recording).
- Chat photos and videos in the mock are picsum.photos placeholders, and avatars are randomuser.me portraits.

## Notes on requests

- **One request model:** Home, the Requests tab, the contact sheet on a mechanic profile and the chat all read requests from `RequestRepository` (`features/requester/requests`, models in `features/shared/requests`). The old Home-only request type and the mechanic support-request mock were removed.
- **Mock picker:** there is no image/file picker package, so the Photos, Video, Document and Take Photo tiles add a sample file through `MockAttachmentPicker` and simulate upload progress. Swap in a real `AttachmentPicker` when pickers are approved.
- **Vehicle data:** categories, makes, models and years come from `VehicleCatalog` (mock). The engine on the review screen ("Ecoboost V6") is looked up from the chosen model.
- **Field sizes:** Category is 47 dp tall and the other selects 48 dp, as drawn.
- **Request cards** show a help badge for active and a check badge for resolved requests.
- **New icons drawn by me:** `ic_badge_help`, `ic_badge_check`, `ic_file`.
- **Calibration:** all five screens were rendered at 2x and compared row by row with the screenshots; positions and widths are within 1-2 px. The attachment thumbnail in the review card is a network placeholder image in the mock.
- **Review card:** the description is clamped to three lines (as drawn) and opens the full text on tap; the Urgency tag is a small pill, not a full-width bar.
- **Home list:** the design shows two cards under "All (3)"; the app shows all three mock requests.

## Notes on profile

- **Shared account:** `AccountRepository` (`features/shared/profile`) is the single source for the signed-in person. Home's greeting and avatar read from it, so saving Edit Profile updates Home too.
- **Edit Profile avatar:** the design shows initials, not a photo, so the screen always shows initials (from the display name) with the camera badge; changing the photo needs an image picker package. The profile list header shows the photo.
- **Sample data:** the screenshots show different sample values per screen (Jess Monroe on the list, "Alex" on Edit Profile, initials "JW"). The mock uses Jess Monroe everywhere, so the initials read "JM".
- **Switch:** the notification switch is purple with a light knob (the filter sheet keeps its lime switch); `AppSwitch` takes size and color overrides.
- **Text sizes:** this section uses 14sp for row titles and 12sp for section labels, the version line and the password hint; a few screens use slightly tighter tracking than the rest, matched by measuring widths.
- **Drawn by me:** `ic_user`, `ic_lock`, `ic_shield`, `ic_info`, `ic_chevron_right`, `ic_calendar`, `ic_map_pin`, `ic_star`, `ic_mail` and `ic_camera_filled`.
- **Version line:** "Version 1.0.0 • BETA" is a fixed string (reading the real version needs `package_info_plus`).
- **Snackbars:** screens pop first and then show their confirmation, because `Get.back()` closes an open snackbar instead of the route.

## Notes on mechanic onboarding

- **Flow:** sign up as a mechanic -> verify code -> Experience -> Vehicles -> Expertise -> Verification -> Verification submitted. Logging in as a mechanic still goes straight to the (undesigned) mechanic area.
- **One shared ViewModel** (`MechanicOnboardingViewModel`) holds the answers across the five screens, so going back keeps what was entered.
- **Progress bar:** the label says 20 / 40 / 60 / 60 %, and the bar is filled as drawn (19 %, 47 %, 73 %, 73 %), which does not match the percentages exactly. Both are kept as constants in `AppOnboardingProgress`; Expertise and Verification are both 60 % in the design.
- **Tall frames:** Experience (2036 px) and Expertise (2322 px) are taller than a phone, so they scroll with the Next button below the content. Checked against the screenshots at the normal frame height plus the scrolled bottom.
- **Design slip:** on Expertise the second row of skill chips ("Wheel Alignment") sits 5 dp lower than its neighbour, and everything below is pushed down by it. I used even rows, so the lower half sits 5 dp higher than the screenshot.
- **Brand search field:** the design shows "Toyota, Ford, Chevrolet" in white as if typed. It is a real search field here with that text as its hint (light grey), so typing filters the brands.
- **Sample data:** trades, brands (with flag emoji), certifications (with emoji) and skills live in `OnboardingCatalog`; cities come from the account repository. The confirmation lists the first certification chosen (the design says "ASE Certification"; the mock chip is "ASE Certified").
- **Emoji:** flags and certification icons are emoji characters, so they follow each platform's emoji font.
- **Drawn by me:** `ic_x_circle` (remove button on a document).

## Fixes

- **Disposed FocusNode crash:** a ViewModel is closed when its route is disposed, but the leaving screen can rebuild in that same frame (for example when the keyboard dismisses). Controllers and focus nodes are now disposed after the frame via `AppHelpers.disposeAfterFrame`. Covered by a regression test.

## Other notes

- "Seen once" logic for the welcome screen is not implemented (needs `shared_preferences`, which has not been approved).
- `lottie` is not installed because no design uses animation yet.
- `AppColors` entries under "Provisional" (`error`, `success`) are placeholders until a design shows them.
