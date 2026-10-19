import 'dart:async';

import 'package:flutter/material.dart' show CustomScrollView, TextField;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_fonts.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_switch.dart';
import 'package:pocketwrench/features/mechanic/onboarding/view_models/mechanic_onboarding_view_model.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/certifications_view_model.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/pricing_view_model.dart';
import 'package:pocketwrench/features/requester/requests/data/models/vehicle_catalog.dart';
import 'package:pocketwrench/features/requester/requests/view_models/new_request_view_model.dart';
import 'package:pocketwrench/features/shared/alerts/view_models/alerts_view_model.dart';
import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';
import 'package:pocketwrench/features/shared/auth/data/models/verify_otp_args.dart';
import 'package:pocketwrench/features/shared/messages/data/models/conversation.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/message_repository.dart';
import 'package:pocketwrench/features/shared/messages/data/repositories/mock_message_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/notification_settings_view_model.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_menu.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';
import 'package:pocketwrench/main.dart';

Future<void> _loadFonts() async {
  final loader = FontLoader(AppFonts.family);
  for (final file in ['Regular', 'Italic', 'Medium', 'Semibold', 'Bold']) {
    loader.addFont(rootBundle.load('assets/fonts/GeneralSans-$file.otf'));
  }
  await loader.load();
}

/// A repository with no conversations, to see the empty state.
class _NoConversationsRepository extends MockMessageRepository {
  @override
  Future<List<Conversation>> loadConversations() async => const [];
}

Future<void> _pumpApp(WidgetTester tester, {VoidCallback? beforeApp}) async {
  Get.reset();
  beforeApp?.call();
  await _loadFonts();
  tester.view
    ..physicalSize = AppSizes.designSize * 2
    ..devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(const PocketWrenchApp());
  await tester.pump();
  // Start from the splash screen whatever the app's initial route is.
  if (Get.currentRoute != AppRoutes.splash) {
    unawaited(Get.offAllNamed<void>(AppRoutes.splash));
    await tester.pump();
  }
  await tester.pump(const Duration(milliseconds: 100));
}

/// Lets a snackbar run its course so no animation is left at teardown.
Future<void> _dismissSnackbars(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

Future<void> _openRoute(WidgetTester tester, String route) async {
  await tester.pump(AppDurations.splashHold);
  await tester.pumpAndSettle();
  unawaited(Get.offAllNamed<void>(route));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('splash hands over to the welcome screen', (tester) async {
    await _pumpApp(tester);

    expect(find.text(AppStrings.splashWordmark), findsOneWidget);

    await tester.pump(AppDurations.splashHold);
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.welcomeGetStarted), findsOneWidget);
    expect(find.text(AppStrings.welcomeLogIn), findsOneWidget);
  });

  testWidgets('get started leads through role selection to sign up', (
    tester,
  ) async {
    await _pumpApp(tester);
    await tester.pump(AppDurations.splashHold);
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.welcomeGetStarted));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.roleTitle), findsOneWidget);

    await tester.tap(find.text(AppStrings.roleHelpTitle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.continueLabel));
    await tester.pumpAndSettle();

    // Both the title and the submit button read "Create Account".
    expect(find.text(AppStrings.signUpTitle), findsNWidgets(2));
  });

  testWidgets('login shows validation errors for empty fields', (tester) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.login);

    await tester.tap(find.text(AppStrings.loginButton));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.fieldRequired), findsNWidgets(2));
    expect(find.text(AppStrings.emailInvalid), findsNothing);
  });

  testWidgets('verify screen shows typed digits and rejects short codes', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.verifyOtp);

    await tester.enterText(find.byType(EditableText), '58');
    await tester.pump();
    expect(find.text('5'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);

    await tester.tap(find.text(AppStrings.verifyButton));
    await tester.pump();
    expect(find.text(AppStrings.otpIncomplete), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 4));
  });

  testWidgets(
    'leaving a focused screen as the keyboard hides keeps focus nodes alive',
    (tester) async {
      await _pumpApp(tester);
      await _openRoute(tester, AppRoutes.login);

      await tester.tap(find.byType(EditableText).first);
      await tester.pump();
      tester.view.viewInsets = const FakeViewPadding(bottom: 600);
      await tester.pump();

      unawaited(Get.offNamed<void>(AppRoutes.roleSelection));
      await tester.pump();
      tester.view.viewInsets = FakeViewPadding.zero;
      for (var i = 0; i < 30; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      expect(tester.takeException(), isNull);
      expect(find.text(AppStrings.roleTitle), findsOneWidget);
    },
  );

  testWidgets(
    'verifying a requester continues to profile setup, all set and home',
    (tester) async {
      await _pumpApp(tester);
      await tester.pump(AppDurations.splashHold);
      await tester.pumpAndSettle();
      unawaited(
        Get.offAllNamed<void>(
          AppRoutes.verifyOtp,
          arguments: const VerifyOtpArgs(
            phone: '+1 555 000 0000',
            role: UserRole.vehicleOwner,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(EditableText), '582193');
      await tester.pump();
      await tester.tap(find.text(AppStrings.verifyButton));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.text(AppStrings.profileTitle), findsOneWidget);

      await tester.tap(find.text(AppStrings.locationHint));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dallas, TX'));
      await tester.pumpAndSettle();
      expect(find.text('Dallas, TX'), findsOneWidget);

      await tester.tap(find.text(AppStrings.next));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.text(AppStrings.allSetTitle), findsOneWidget);

      await tester.tap(find.text(AppStrings.allSetGetStarted));
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(find.text('Jess Monroe'), findsOneWidget);
      expect(find.text(AppStrings.findMechanics), findsOneWidget);
    },
  );

  testWidgets('bottom navigation switches the body of the main shell', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.bannerTitle), findsOneWidget);

    await tester.tap(find.text(AppStrings.navProfile));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.profileVersion), findsOneWidget);
    expect(find.text(AppStrings.bannerTitle), findsNothing);

    await tester.tap(find.text(AppStrings.navHome));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.bannerTitle), findsOneWidget);
  });

  testWidgets('find a mechanic opens explore, filters narrow the list, '
      'and a card opens the profile', (tester) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.findAMechanic));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.exploreTitle), findsOneWidget);
    expect(find.text('Mohamed El-Sayed'), findsOneWidget);
    expect(find.text('Carlos Rivera'), findsOneWidget);

    await tester.tap(find.text(AppStrings.filterSpecialty));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.filtersTitle), findsOneWidget);
    await tester.tap(find.text(AppStrings.specElectrical));
    await tester.pump();
    await tester.tap(find.text(AppStrings.applyFilters));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Mohamed El-Sayed'), findsOneWidget);
    expect(find.text('Carlos Rivera'), findsNothing);

    await tester.tap(find.text('Mohamed El-Sayed'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.sectionSpecialties), findsOneWidget);
    expect(find.text(AppStrings.contactMechanic), findsOneWidget);

    await tester.ensureVisible(find.text(AppStrings.contactMechanic));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.contactMechanic));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(
      find.text(AppStrings.contactTitle('Mohamed El-Sayed')),
      findsOneWidget,
    );
    expect(find.text('Engine Stalls After Warming Up'), findsOneWidget);
  });

  testWidgets(
    'messages lists conversations, opens a chat and sends a message',
    (tester) async {
      await _pumpApp(tester);
      await _openRoute(tester, AppRoutes.main);
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.text(AppStrings.navMessages));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Mike Anderson'), findsOneWidget);
      expect(find.text('Robert Davis'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Robert');
      await tester.pump();
      expect(find.text('Mike Anderson'), findsNothing);
      expect(find.text('Robert Davis'), findsOneWidget);
      await tester.enterText(find.byType(TextField), '');
      await tester.pump();

      await tester.tap(find.text('Mike Anderson'));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text(AppStrings.supportRequestCardLabel), findsOneWidget);
      expect(find.text('Engine overheating at idle'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Any update?');
      await tester.pump();
      await tester.testTextInput.receiveAction(TextInputAction.send);
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Any update?'), findsOneWidget);
    },
  );

  testWidgets('messages shows an invitation when there are no conversations', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      beforeApp: () => Get.put<MessageRepository>(
        _NoConversationsRepository(),
        permanent: true,
      ),
    );
    await _openRoute(tester, AppRoutes.main);
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text(AppStrings.navMessages));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.noMessagesTitle), findsOneWidget);

    await tester.tap(find.text(AppStrings.findAMechanic));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.exploreTitle), findsOneWidget);
  });

  testWidgets('contacting a mechanic opens a chat about the chosen request', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    unawaited(
      Get.toNamed<void>(AppRoutes.mechanicProfile, arguments: 'king-tom'),
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text(AppStrings.contactMechanic));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.contactMechanic));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.continueToConversation));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('King Tom'), findsOneWidget);
    expect(find.text(AppStrings.supportRequestCardLabel), findsOneWidget);
    expect(find.text('Engine Stalls After Warming Up'), findsOneWidget);
  });

  testWidgets('requests tab lists requests and filters them by status', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    await tester.tap(find.text(AppStrings.navRequests));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.requestsTitle), findsOneWidget);
    expect(find.text('Engine Stalls After Warming Up'), findsOneWidget);
    expect(find.text('A/C Blows Hot Air'), findsOneWidget);

    await tester.tap(find.text(AppStrings.requestsResolved));
    await tester.pumpAndSettle();

    expect(find.text('Engine Stalls After Warming Up'), findsNothing);
    expect(find.text('A/C Blows Hot Air'), findsOneWidget);
  });

  testWidgets('new request validates, uploads, reviews, sends and lists', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    await tester.tap(find.text(AppStrings.navRequests));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.add));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.enterDetailsTitle), findsOneWidget);
    await tester.tap(find.text(AppStrings.next));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.enterDetailsTitle), findsOneWidget);
    expect(find.text(AppStrings.fieldRequired), findsWidgets);

    final vm = Get.find<NewRequestViewModel>();
    await tester.enterText(find.byType(EditableText).at(0), 'Rattling exhaust');
    await tester.enterText(find.byType(EditableText).at(1), 'Loud rattle.');
    vm
      ..selectCategory(VehicleCatalog.categories.first)
      ..selectMake('Ford')
      ..selectModel(VehicleCatalog.modelsByMake['Ford']!.first)
      ..selectYear(2019)
      ..selectUrgency(RequestUrgency.urgent);
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.next));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.addFilesTitle), findsOneWidget);
    await tester.tap(find.text(AppStrings.chooseDocument));
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.uploadedFiles), findsOneWidget);
    await tester.tap(find.text(AppStrings.next));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.reviewTitle), findsOneWidget);
    expect(find.text('Rattling exhaust'), findsOneWidget);
    await tester.tap(find.text(AppStrings.sendRequest));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.requestSubmittedTitle), findsOneWidget);
    await tester.tap(find.text(AppStrings.goToHome));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.requestSubmittedTitle), findsNothing);

    await tester.tap(find.text(AppStrings.navRequests));
    await tester.pumpAndSettle();
    expect(find.text('Rattling exhaust'), findsWidgets);
  });

  testWidgets('editing the profile updates the profile and home headers', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text(AppStrings.navProfile));
    await tester.pumpAndSettle();
    expect(find.text('Jess Monroe'), findsWidgets);

    await tester.tap(find.text(AppStrings.profileEditProfile).last);
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.editProfileTitle), findsOneWidget);

    await tester.enterText(find.byType(EditableText).first, 'Alex Rider');
    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.displayNameLabel), findsNothing);
    expect(find.text('Alex Rider'), findsOneWidget);
    await _dismissSnackbars(tester);

    await tester.tap(find.text(AppStrings.navHome));
    await tester.pumpAndSettle();
    expect(find.text('Alex Rider'), findsOneWidget);
  });

  testWidgets('notification preferences toggle and save', (tester) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    await tester.tap(find.text(AppStrings.navProfile));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.profileNotificationPrefs));
    await tester.pumpAndSettle();

    final vm = Get.find<NotificationSettingsViewModel>();
    expect(find.text(AppStrings.notificationsTitle), findsOneWidget);
    expect(vm.isOn(NotificationKind.responses), isFalse);
    await tester.tap(find.byType(AppSwitch).first);
    await tester.pumpAndSettle();
    expect(vm.isOn(NotificationKind.responses), isTrue);

    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.notificationsTitle), findsNothing);
    await _dismissSnackbars(tester);
  });

  testWidgets('update password validates before saving', (tester) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    await tester.tap(find.text(AppStrings.navProfile));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.profileChangePassword));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.updatePasswordTitle), findsOneWidget);
    expect(find.text(AppStrings.fieldRequired), findsWidgets);

    await tester.enterText(find.byType(EditableText).at(0), 'OldPassword1');
    await tester.enterText(find.byType(EditableText).at(1), 'NewPassword1');
    await tester.enterText(find.byType(EditableText).at(2), 'Different123');
    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.passwordsDoNotMatch), findsOneWidget);

    await tester.enterText(find.byType(EditableText).at(2), 'NewPassword1');
    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.updatePasswordTitle), findsNothing);
    await _dismissSnackbars(tester);
  });

  testWidgets('privacy and about open from the profile menu', (tester) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.main);
    await tester.tap(find.text(AppStrings.navProfile));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.profilePrivacy));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.locationPrivacyTitle), findsOneWidget);
    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.locationPrivacyTitle), findsNothing);
    await _dismissSnackbars(tester);

    await tester.tap(find.text(AppStrings.profileAbout));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.aboutTagline), findsOneWidget);
    await tester.tap(find.text(AppStrings.aboutTerms));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text(AppStrings.featureComingSoon), findsOneWidget);
    await _dismissSnackbars(tester);
  });

  testWidgets('a new mechanic is guided through five onboarding steps', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicExperience);

    Future<void> tapNext() async {
      await tester.drag(
        find.byType(CustomScrollView).last,
        const Offset(0, -2000),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(AppStrings.next));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
    }

    // Nothing chosen yet: stays on the first step with errors.
    await tapNext();
    expect(find.text(AppStrings.experienceTitle), findsOneWidget);
    expect(find.text(AppStrings.selectionRequired), findsWidgets);
    expect(find.text(AppStrings.selectAtLeastOneSpecialty), findsOneWidget);

    final vm = Get.find<MechanicOnboardingViewModel>();
    vm
      ..selectTrade('Automotive Technician')
      ..selectYears('5-10 yrs')
      ..selectCity('Dallas, TX')
      ..toggleSpecialty('Engine');
    await tester.pumpAndSettle();
    await tapNext();
    expect(find.text(AppStrings.vehiclesTitle), findsOneWidget);

    // A brand is required.
    await tapNext();
    expect(find.text(AppStrings.vehiclesTitle), findsOneWidget);
    await _dismissSnackbars(tester);
    await tester.tap(find.text('Toyota 🇯🇵'));
    await tester.pumpAndSettle();
    await tapNext();
    expect(find.text(AppStrings.expertiseTitle), findsOneWidget);

    // Custom certification becomes a selected chip.
    await tester.enterText(
      find.byType(EditableText).first,
      'Brake Master Level 2',
    );
    await tester.tap(find.text(AppStrings.addCertification));
    await tester.pumpAndSettle();
    expect(find.text('Brake Master Level 2'), findsOneWidget);
    expect(vm.certifications, contains('Brake Master Level 2'));
    await tapNext();
    expect(find.text(AppStrings.verificationTitle), findsOneWidget);

    // A document is required before submitting.
    await tapNext();
    expect(find.text(AppStrings.verificationTitle), findsOneWidget);
    await _dismissSnackbars(tester);
    await tester.tap(find.text(AppStrings.browseFiles));
    await tester.pumpAndSettle();
    expect(find.text('ASE_Certification_2026.pdf'), findsOneWidget);
    expect(find.text(AppStrings.uploadedFilesLabel(1)), findsOneWidget);
    await tapNext();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.verificationSubmittedTitle), findsOneWidget);
    expect(find.text('Brake Master Level 2'), findsOneWidget);
    await tester.tap(find.text(AppStrings.goToHome));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.verificationSubmittedTitle), findsNothing);
  });

  testWidgets('mechanic home shows activity and lets requests be answered', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('King Tom'), findsOneWidget);
    expect(find.text(AppStrings.visibilityTitle), findsOneWidget);
    expect(find.text(AppStrings.yourActivity), findsOneWidget);
    expect(find.text('142'), findsOneWidget);
    expect(find.text('Engine Stalls After Warming Up'), findsOneWidget);
    expect(find.text('Engine Overheating'), findsOneWidget);

    await tester.tap(find.text(AppStrings.accept).first);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Engine Stalls After Warming Up'), findsNothing);
    expect(find.text('Engine Overheating'), findsOneWidget);
    await _dismissSnackbars(tester);

    await tester.tap(find.text(AppStrings.decline).first);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Engine Overheating'), findsNothing);
    await _dismissSnackbars(tester);

    await tester.tap(find.text(AppStrings.navAlerts));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.alertsToday), findsOneWidget);
    expect(find.text('Mike Responded'), findsOneWidget);

    await tester.tap(find.text(AppStrings.navProfile));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.profileVersion), findsOneWidget);
    expect(find.text('King.t@email.com'), findsOneWidget);
  });

  testWidgets('mechanic messages list opens a chat from the mechanic side', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.navMessages));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.searchConversations), findsOneWidget);
    expect(find.text('Mike Anderson'), findsOneWidget);
    expect(find.text('Robert Davis'), findsOneWidget);

    await tester.tap(find.text('Mike Anderson'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.activeRequest), findsOneWidget);
    expect(find.text(AppStrings.startLiveStream), findsOneWidget);
    expect(find.text('The coolant level is normal.'), findsOneWidget);
    // The mechanic sees no verified tag beside the customer's name.
    expect(find.text(AppStrings.verifiedTag), findsNothing);
  });

  testWidgets('mechanic messages invite browsing requests when empty', (
    tester,
  ) async {
    await _pumpApp(
      tester,
      beforeApp: () => Get.put<MessageRepository>(
        _NoConversationsRepository(),
        permanent: true,
      ),
    );
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.navMessages));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.noMessagesTitle), findsOneWidget);
    expect(find.text(AppStrings.mechanicNoMessagesBody), findsOneWidget);
    expect(find.text(AppStrings.findAMechanic), findsNothing);

    await tester.tap(find.text(AppStrings.browseRequests));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.serviceRequestsTitle), findsOneWidget);
  });

  testWidgets('alerts are grouped by day and opening one marks it read', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.navAlerts));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.alertsToday), findsOneWidget);
    expect(find.text(AppStrings.alertsEarlier), findsOneWidget);

    final vm = Get.find<AlertsViewModel>();
    expect(vm.today.where((a) => a.isUnread), hasLength(3));
    await tester.tap(find.text('Mike Responded'));
    await tester.pumpAndSettle();
    expect(vm.today.where((a) => a.isUnread), hasLength(2));
  });

  testWidgets('service requests tab splits requests by status', (tester) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.navRequests));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.serviceRequestsTitle), findsOneWidget);
    expect(find.text('Engine Stalls After Warming Up'), findsOneWidget);
    expect(find.text(AppStrings.decline), findsWidgets);

    await tester.tap(find.text(AppStrings.requestsActive));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.requesterLine('Sarah Lee')), findsOneWidget);
    expect(find.text(AppStrings.lastMessageLabel), findsWidgets);
    expect(find.text(AppStrings.decline), findsNothing);

    await tester.tap(find.text(AppStrings.requestsResolved));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.tagResolved), findsNWidgets(2));
    expect(find.text(AppStrings.openConversation), findsNothing);
  });

  testWidgets('opening an active request starts the chat with its customer', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.navRequests));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.requestsActive));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.openConversation).first);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Sarah Lee'), findsOneWidget);
    expect(find.text(AppStrings.activeRequest), findsOneWidget);
    expect(find.text("I've checked the levels, and it's low."), findsOneWidget);
  });

  testWidgets('a request detail can be accepted and then appears as active', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.navRequests));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Engine Overheating'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.requestedBy), findsOneWidget);
    expect(find.text('Daniel Brooks'), findsOneWidget);
    await tester.drag(
      find.byType(SingleChildScrollView).last,
      const Offset(0, -800),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.accept));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    await _dismissSnackbars(tester);

    expect(find.text(AppStrings.requestedBy), findsNothing);
    await tester.tap(find.text(AppStrings.requestsActive));
    await tester.pumpAndSettle();
    expect(find.text('Engine Overheating'), findsOneWidget);
  });

  testWidgets('mechanic profile menu has professional and certification rows', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.navProfile));
    await tester.pumpAndSettle();

    expect(find.text('King Tom'), findsOneWidget);
    expect(find.text(AppStrings.profileSectionProfessional), findsOneWidget);
    expect(find.text(AppStrings.profileSectionCertifications), findsOneWidget);

    await tester.ensureVisible(
      find.text(AppStrings.profileProfessionalProfile),
    );
    await tester.tap(find.text(AppStrings.profileProfessionalProfile));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Anderson Auto Care'), findsOneWidget);
    expect(find.text('Chevrolet'), findsOneWidget);
    expect(find.text('Electrical Systems'), findsOneWidget);
    expect(find.text('KT'), findsOneWidget);
  });

  testWidgets('verification shows the verified state and its documents', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    unawaited(Get.toNamed<void>(AppRoutes.verificationStatus));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // The title and the three document rows all read "Verified".
    expect(find.text(AppStrings.verifiedTitle), findsNWidgets(4));
    expect(find.text('Trade License'), findsOneWidget);
  });

  testWidgets('pricing tiers toggle, take a custom tier and save', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    unawaited(Get.toNamed<void>(AppRoutes.servicePricing));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    final vm = Get.find<PricingViewModel>();
    expect(find.text(AppStrings.pricingTiersTitle), findsOneWidget);
    expect(vm.plan!.tiers.where((tier) => tier.isEnabled), hasLength(3));

    await tester.tap(find.byType(AppSwitch).last);
    await tester.pumpAndSettle();
    expect(vm.plan!.tiers.where((tier) => tier.isEnabled), hasLength(4));

    await tester.tap(find.text(AppStrings.addCustomTier));
    await tester.pumpAndSettle();
    await tester.tap(find.text(AppStrings.addTier));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.fieldRequired), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Weekend Call');
    await tester.enterText(find.byType(TextField).at(1), '120');
    await tester.tap(find.text(AppStrings.addTier));
    await tester.pumpAndSettle();
    expect(find.text('Weekend Call'), findsOneWidget);
    expect(find.text(r'$120'), findsOneWidget);

    await tester.tap(find.text(AppStrings.saveChanges));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.pricingTiersTitle), findsNothing);
    await _dismissSnackbars(tester);
  });

  testWidgets('certifications can be written in and removed', (tester) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    unawaited(Get.toNamed<void>(AppRoutes.certifications));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    final vm = Get.find<CertificationsViewModel>();
    expect(find.text('ASE Master Technician'), findsOneWidget);
    expect(find.text(AppStrings.certPending), findsOneWidget);
    expect(vm.certifications, hasLength(3));

    await tester.enterText(find.byType(TextField), 'OSHA Safety');
    await tester.tap(find.text(AppStrings.submitForReview));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(vm.certifications, hasLength(4));
    expect(find.text('OSHA Safety'), findsOneWidget);
    await _dismissSnackbars(tester);

    unawaited(vm.remove(vm.certifications.first));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(vm.certifications, hasLength(3));
    await _dismissSnackbars(tester);
  });

  testWidgets('mechanic notifications and privacy use mechanic wording', (
    tester,
  ) async {
    await _pumpApp(tester);
    await _openRoute(tester, AppRoutes.mechanicHome);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    unawaited(
      Get.toNamed<void>(
        AppRoutes.notificationSettings,
        arguments: ProfileAudience.mechanic,
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.mechNotifyMessageTitle), findsOneWidget);
    expect(find.byType(AppSwitch), findsNWidgets(4));

    Get.back<void>();
    await tester.pumpAndSettle();
    unawaited(
      Get.toNamed<void>(
        AppRoutes.privacySettings,
        arguments: ProfileAudience.mechanic,
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.mechLocationPrivacyBody), findsOneWidget);
  });

  testWidgets('the bottom navigation stays clear of the system buttons', (
    tester,
  ) async {
    await _pumpApp(tester);
    // A 3-button navigation bar: 48 dp reserved at the bottom (2x pixels).
    tester.view
      ..padding = const FakeViewPadding(bottom: 96)
      ..viewPadding = const FakeViewPadding(bottom: 96);
    addTearDown(tester.view.resetPadding);
    addTearDown(tester.view.resetViewPadding);
    await _openRoute(tester, AppRoutes.main);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    final screenBottom = tester.view.physicalSize.height / 2;
    final labelBottom = tester
        .getBottomLeft(find.text(AppStrings.navProfile))
        .dy;
    expect(labelBottom, lessThanOrEqualTo(screenBottom - 48));
  });

  for (final route in [AppRoutes.main, AppRoutes.mechanicHome]) {
    testWidgets('logging out from $route returns to role selection', (
      tester,
    ) async {
      await _pumpApp(tester);
      await _openRoute(tester, route);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppStrings.navProfile));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text(AppStrings.profileLogout));
      await tester.pumpAndSettle();
      await tester.tap(find.text(AppStrings.profileLogout));
      await tester.pumpAndSettle();

      // Asked to confirm first; cancelling stays on the profile.
      expect(find.text(AppStrings.logoutConfirmTitle), findsOneWidget);
      await tester.tap(find.text(AppStrings.cancel));
      await tester.pumpAndSettle();
      expect(find.text(AppStrings.logoutConfirmTitle), findsNothing);
      expect(find.text(AppStrings.roleTitle), findsNothing);

      await tester.tap(find.text(AppStrings.profileLogout));
      await tester.pumpAndSettle();
      await tester.tap(find.text(AppStrings.profileLogout).last);
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      expect(Get.currentRoute, AppRoutes.roleSelection);
      expect(find.text(AppStrings.roleTitle), findsOneWidget);

      // Back goes to Welcome rather than leaving the app.
      await tester.tap(find.byType(AppIconButton).first);
      await tester.pumpAndSettle();
      expect(find.text(AppStrings.welcomeGetStarted), findsOneWidget);
    });
  }
}
