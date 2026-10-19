/// Every user-facing string, grouped by feature so it can be localized later.
abstract final class AppStrings {
  // App
  static const String appName = 'Pocket Wrench';

  // Common
  static const String comingSoonTitle = 'Coming soon';
  static const String comingSoonMessage = 'This screen is not built yet.';
  static const String retry = 'Retry';
  static const String close = 'Close';
  static const String genericError = 'Something went wrong. Please try again.';
  static const String or = 'OR';
  static const String continueLabel = 'Continue';

  // Validation
  static const String fieldRequired = 'This field is required';
  static const String emailInvalid = 'Enter a valid email address';
  static const String phoneInvalid = 'Enter a valid phone number';
  static const String passwordTooShort =
      'Password must be at least 8 characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String termsRequired =
      'Please accept the Terms of Service and Privacy Policy';
  static const String otpIncomplete = 'Enter the 6-digit code';

  // Splash
  static const String splashWordmark = 'Pocket Wrench';

  // Welcome
  // Line break is part of the design.
  static const String welcomeHeading = 'Expert Help. Right When\nYou Need It.';
  static const String welcomeBody =
      'Connect with specialized mechanics and solve vehicle problems faster.';
  static const String welcomeGetStarted = 'Get Started';
  static const String welcomeHaveAccount = 'Already have an account?';
  static const String welcomeLogIn = 'Log In';

  // Auth: social providers
  static const String google = 'Google';
  static const String github = 'GitHub';

  // Auth: role selection
  static const String roleTitle = 'How will you use Pocket Wrench?';
  static const String roleSubtitle =
      'Choose the experience that fits your automotive goals.';
  static const String roleHelpTitle = "I'm Looking for Help";
  static const String roleHelpDescription =
      'Get help from a specialized mechanic with your vehicle problem.';
  static const String roleMechanicTitle = "I'm an Expert Mechanic";
  static const String roleMechanicDescription =
      'Share your expertise and help vehicle owners solve difficult problems.';

  // Auth: sign up
  static const String signUpTitle = 'Create Account';
  static const String signUpSubtitle =
      'Get expert help for your vehicle, right when you need it.';
  static const String fullNameLabel = 'Full Name';
  static const String fullNameHint = 'Jane Doe';
  static const String emailLabel = 'Email';
  static const String emailHint = 'you@example.com';
  static const String phoneLabel = 'Phone Number';
  static const String phoneHint = '+1 (555) 000-0000';
  static const String passwordLabel = 'Password';
  static const String passwordHint = '••••••••';
  static const String signUpTerms =
      'I agree to the Pocket Wrench Terms of Service and Privacy Policy.';
  static const String signUpButton = 'Create Account';
  static const String signUpHaveAccount = 'Already have an account?';
  static const String signUpSignIn = 'Sign In';

  // Auth: login
  static const String loginTitle = 'Welcome Back';
  static const String loginSubtitle =
      'Your vehicle problems are one step closer to a solution.';
  static const String rememberMe = 'Remember me';
  static const String forgotPasswordLink = 'Forgot Password?';
  static const String loginButton = 'Sign In';
  static const String loginNoAccount = "Don't have an account?";
  static const String loginSignUp = 'Sign Up';

  // Auth: forgot password
  static const String forgotTitle = 'Forgot Password?';
  static const String forgotSubtitle =
      "Enter your email address and we'll send you a secure link to reset "
      'your credentials.';
  static const String emailAddressLabel = 'Email Address';
  static const String sendResetLink = 'Send Reset Link';
  static const String forgotRemember = 'Remember your account?';
  static const String forgotLogIn = 'Log in';
  static const String resetLinkSent = 'Reset link sent. Check your inbox.';

  // Auth: reset password
  static const String resetTitle = 'Reset Password';
  static const String resetSubtitle =
      'Create a strong, unique password to secure your Pocket Wrench account.';
  static const String newPasswordLabel = 'New Password';
  static const String confirmPasswordLabel = 'Confirm New Password';
  static const String resetButton = 'Reset Password';
  static const String passwordResetDone =
      'Password updated. Log in with your new password.';

  // Auth: verify OTP
  static const String verifyTitle = 'Verify your account';
  static const String verifyButton = 'Verify';
  static const String verifyNoCode = "Didn't receive the code?";
  static const String verifyResend = 'Resend code';
  static const String verifyChangeContact = 'Change contact information';
  static const String codeResent = 'A new code is on its way.';

  // Onboarding: profile setup
  static const String profileTitle = 'Let’s set up your profile';
  static const String profileSubtitle =
      'A few details will help mechanics know who they’re helping.';
  static const String profilePhotoLabel = 'Profile Photo';
  static const String dropTitle = 'Drop your photo';
  static const String dropFormats = 'Supported formats: PNG, JPG';
  static const String dropMaxSize = 'Maximum size: 2 MB';
  static const String browseFiles = 'Browse Files';
  static const String locationLabel = 'Location';
  static const String locationHint = 'Select your city';
  static const String cityPickerTitle = 'Select your city';
  static const String next = 'Next';
  static const String photoPickerUnavailable =
      'Photo upload is not available yet.';

  // Onboarding: all set
  static const String allSetTitle = "You're all set!";
  static const String allSetBody =
      'Find the right mechanic, describe your problem, and get expert help.';
  static const String allSetGetStarted = 'Get Started';

  // Home
  static const String welcomeBack = 'Welcome back,';
  static const String bannerTitle = 'Get Expert Help';
  // Line breaks are part of the design.
  static const String bannerBody =
      'Find trusted\nmechanics and get\nreliable repair advice.';
  static const String findAMechanic = 'Find a Mechanic';
  static const String findMechanics = 'Find Mechanics';
  static const String seeAll = 'See All';
  static const String myRequests = 'My Requests';
  static const String add = 'Add';
  static const String urgent = 'URGENT';
  static const String featureComingSoon = 'Implemented later';

  // Explore
  static const String exploreTitle = 'Suggested Mechanics';
  static const String searchHint = 'Search mechanics';
  static const String filterSpecialty = 'Specialty';
  static const String filterNearMe = 'Near Me';
  static const String filterExperience = 'Experience';
  static const String filterVerified = 'Verified';
  static const String noMechanicsTitle = 'No mechanics found';
  static const String noMechanicsMessage =
      'Try a different search or adjust your filters.';

  // Explore: filters sheet
  static const String filtersTitle = 'Mechanic Filters';
  static const String filtersHelpWith = 'What do you need help with?';
  static const String nearMeTitle = 'Near me';
  static const String nearMeSubtitle = 'Show mechanics within 15 miles';
  static const String experienceLabel = 'Experience';
  static const String priceRangeLabel = 'Price Range';
  static const String verifiedOnly = 'Verified mechanics only';
  static const String applyFilters = 'Apply Filters';
  static const String specEngine = 'Engine';
  static const String specElectrical = 'Electrical';
  static const String specTransmission = 'Transmission';
  static const String specAirConditioning = 'A/C';
  static const String specBodywork = 'Bodywork';
  static const String specDiagnostics = 'Diagnostics';
  static const String specDiesel = 'Diesel';
  static const String specHeavyMachinery = 'Heavy Machinery';
  static const String experienceAny = 'Any';
  static const String experience1to5 = '1-5 years';
  static const String experience5to10 = '5-10 years';
  static const String experience10plus = '10+ years';
  static const String priceAny = 'Any';
  static const String priceUnder100 = 'Under \$100';
  static const String price100to150 = '\$100–\$150';
  static const String price150to200 = '\$150–\$200';
  static const String price200plus = '\$200+';

  // Mechanic profile
  static const String sectionSpecialties = 'SPECIALTIES';
  static const String sectionBrands = 'BRAND EXPERTISE';
  static const String sectionAbout = 'ABOUT';
  static const String sectionPricing = 'SERVICE PRICING';
  static const String sectionSkills = 'SKILLS';
  static const String sectionActivity = 'ACTIVITY';
  static const String requestsHelped = 'Requests Helped';
  static const String helpfulRatings = 'Helpful Ratings';
  static const String contactMechanic = 'Contact Mechanic';

  // Mechanic profile: contact sheet
  static const String contactSubtitle = 'What would you like help with?';
  static const String supportRequestLabel = 'YOUR SUPPORT REQUEST';
  static const String continueToConversation = 'Continue to Conversation';
  static const String orLower = 'Or';
  static const String createSupportRequest = 'Create a Support Request';

  static String contactTitle(String name) => 'Contact $name';

  // Messages
  static const String messagesTitle = 'Messages';
  static const String searchConversations = 'Search conversations';
  static const String noConversationsFound = 'No conversations found';
  static const String noMessagesTitle = 'No messages yet';
  static const String noMessagesBody =
      'Once you connect with a mechanic, your conversations will appear here.';
  static const String verifiedTag = 'VERIFIED';
  static const String supportRequestCardLabel = 'SUPPORT REQUEST';
  static const String viewRequest = 'View Request';
  static const String writeMessage = 'Write a message…';
  static const String addToMessage = 'Add to message';
  static const String attachCamera = 'Camera';
  static const String attachPhotos = 'Photos';
  static const String attachVideo = 'Video';
  static const String attachDocument = 'Document';
  static const String recordingTitle = 'Recording Voice Note';
  static const String cancel = 'Cancel';
  static const String sendVoice = 'Send Voice';
  static const String attachmentsUnavailable = '';
  static const String voiceNotesUnavailable =
      'Voice notes are not available yet.';

  // Requests
  static const String requestsTitle = 'My Requests';
  static const String requestsActive = 'Active';
  static const String requestsResolved = 'Resolved';
  static const String noRequestsTitle = 'No requests here';
  static const String noRequestsMessage =
      'Tap Add to describe a problem and get help from a mechanic.';
  static const String urgencyLow = 'Low';
  static const String urgencyNormal = 'Normal';
  static const String urgencyUrgent = 'Urgent';
  static const String tagLow = 'LOW';
  static const String tagNormal = 'NORMAL';

  static String requestsAll(int count) => 'All ($count)';

  // Requests: new request, step 1
  static const String enterDetailsTitle = 'Enter Details';
  static const String enterDetailsSubtitle = 'What do you need help with?';
  static const String problemTitleLabel = 'Problem Title';
  static const String problemTitleHint = 'Briefly describe the problem';
  static const String categoryLabel = 'Category';
  static const String categoryHint = 'Select a category';
  static const String makeLabel = 'Make';
  static const String makeHint = 'Select a make';
  static const String modelLabel = 'Model';
  static const String modelHint = 'Select a model';
  static const String yearLabel = 'Year';
  static const String yearHint = 'Year';
  static const String urgencyLabel = 'Urgency';
  static const String descriptionLabel = 'Description';
  static const String descriptionHint =
      'Tell the mechanic what is happening, and when';
  static const String pickCategoryTitle = 'Select a category';
  static const String pickMakeTitle = 'Select a make';
  static const String pickModelTitle = 'Select a model';
  static const String pickYearTitle = 'Select a year';
  static const String selectionRequired = 'Please choose an option';

  // Requests: new request, step 2
  static const String addFilesTitle = 'Add Photos or Files';
  static const String addFilesSubtitle =
      'Upload resources to help the mechanic understand the issue.';
  static const String takePhoto = 'Take Photo';
  static const String choosePhotos = 'Choose Photos';
  static const String chooseVideo = 'Choose Video';
  static const String chooseDocument = 'Choose Document';
  static const String uploadedFiles = 'Uploaded Files';
  static const String tagImage = 'IMAGE';
  static const String tagVideo = 'VIDEO';
  static const String tagDocument = 'DOCUMENT';

  // Requests: new request, step 3
  static const String reviewTitle = 'Review Details';
  static const String reviewSubtitle =
      'Review the title, category, issue details, and attachments.';
  static const String sectionTitleCategory = 'Title & Category';
  static const String sectionVehicle = 'Vehicle';
  static const String sectionUrgency = 'Urgency';
  static const String sectionDescription = 'Description';
  static const String edit = 'Edit';
  static const String sendRequest = 'Send Request';

  static String sectionAttachments(int count) => 'Attachments ($count)';

  // Requests: submitted
  static const String requestSubmittedTitle = 'Request Submitted!';
  static const String requestSubmittedBody =
      'Your support request has been submitted. Find the right expert to '
      'help you solve it.';
  static const String goToHome = 'Go to Home';
  static const String findAnExpert = 'Find an Expert';

  // Bottom navigation
  static const String navHome = 'Home';
  static const String navRequests = 'Requests';
  static const String navExplore = 'Explore';
  static const String navMessages = 'Messages';
  static const String navProfile = 'Profile';

  static String verifySubtitle(String phone) =>
      "We've sent a verification code to $phone. Enter the 6-digit code below.";

  // Profile
  static const String profileSectionAccount = 'ACCOUNT';
  static const String profileSectionNotifications = 'NOTIFICATIONS';
  static const String profileSectionPrivacy = 'PRIVACY';
  static const String profileSectionSupport = 'SUPPORT';
  static const String profileSectionAbout = 'ABOUT';
  static const String profileEditProfile = 'Edit Profile';
  static const String profileChangePassword = 'Change Password';
  static const String profileNotificationPrefs = 'Notification Preferences';
  static const String profilePrivacy = 'Privacy';
  static const String profileHelp = 'Help & Support';
  static const String profileAbout = 'About Pocket Wrench';
  static const String profileVersion = 'Version 1.0.0 • BETA';
  static const String profileLogout = 'Log Out';
  static const String logoutConfirmTitle = 'Log out?';
  static const String logoutConfirmBody =
      'You will need to sign in again to use Pocket Wrench.';

  static const String editProfileTitle = 'Edit Profile';
  static const String displayNameLabel = 'Display Name';
  static const String birthDateLabel = 'Date of Birth';
  static const String saveChanges = 'Save Changes';
  static const String profileSaved = 'Profile updated.';

  static const String notificationsTitle = 'Notifications';
  static const String notifyResponsesTitle = 'New responses to my requests';
  static const String notifyResponsesBody =
      'Get notified when a mechanic responds to your request.';
  static const String notifyChatTitle = 'New chat message';
  static const String notifyChatBody =
      'Direct messages from mechanics helping with your vehicle.';
  static const String notifyLiveTitle = 'Live stream invitations';
  static const String notifyLiveBody =
      'Get invited to join live diagnostic sessions.';
  static const String notifyResolvedTitle = 'Request resolved';
  static const String notifyResolvedBody =
      'Get notified when a request is marked complete.';
  static const String notifyHelpfulTitle = 'Response marked helpful';
  static const String notifyHelpfulBody =
      'Get notified when you mark a mechanic’s response as helpful.';
  static const String notificationsSaved = 'Notification preferences saved.';

  static const String privacyTitle = 'Privacy';
  static const String locationPrivacyTitle = 'Location Privacy';
  static const String locationPrivacyBody =
      'Your exact location is never shared with mechanics.';
  static const String locationPrivacyBadge = 'City-level location only';
  static const String privacySaved = 'Privacy settings saved.';

  static const String updatePasswordTitle = 'Update Password';
  static const String currentPasswordLabel = 'Current Password';
  static const String currentPasswordHint = 'Enter current password';
  static const String newPasswordHint = 'Enter new password';
  static const String confirmNewPasswordHint = 'Confirm new password';
  static const String passwordRule = 'At least 8 characters';
  static const String passwordUpdated = 'Password updated.';

  static const String aboutTitle = 'About Us';
  static const String aboutTagline = 'Expert mechanics, on demand';
  static const String aboutTerms = 'Terms & Conditions';
  static const String aboutPrivacyPolicy = 'Privacy Policy';
  static const String aboutRate = 'Rate the App';
  static const String aboutContact = 'Contact Support';

  // Dates
  static const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // Mechanic onboarding
  static String progressPercent(int percent) => '$percent%';
  static const String selectAtLeastOneSpecialty =
      'Select at least one specialty';
  static const String selectAtLeastOneBrand = 'Select at least one brand';
  static const String uploadAtLeastOneDocument = 'Upload at least one document';
  static const String enterAllPrices = 'Enter a price for every service';

  static const String experienceTitle = 'Experience';
  static const String experienceSubtitle =
      'Let vehicle owners know about your professional background and technical experience.';
  static const String primaryTradeLabel = 'Your Primary Trade';
  static const String primaryTradeHint = 'Select your primary trade';
  static const String tradePickerTitle = 'Primary trade';
  static const String yearsLabel = 'Years of Experience';
  static const String cityLabel = 'Select Your City';
  static const String specialtiesLabel = 'Specialties';
  static const String specialtiesHint =
      'Select all that apply (comprehensive list coming soon)';

  static const String vehiclesTitle = 'Vehicles';
  static const String vehiclesSubtitle =
      'Select the vehicle brands you specialize in or are most comfortable diagnosing.';
  static const String brandsLabel = 'Search or Select Brands';
  static const String brandsSearchHint = 'Toyota, Ford, Chevrolet';

  static const String expertiseTitle = 'Expertise';
  static const String expertiseSubtitle =
      'Provide proof of credentials to guarantee maximum platform safety and credibility.';
  static const String certificationsLabel = 'Certifications';
  static const String certificationsHint = 'Comprehensive list coming soon';
  static const String certificationInputHint =
      'Enter certification not listed above...';
  static const String addCertification = '+ Add';
  static const String skillsLabel = 'Technical Skills & Tools';
  static const String pricingLabel = 'Service Pricing';
  static const String priceStandard = 'Standard Question';
  static const String priceUrgent = 'Urgent Question';
  static const String priceLive = 'Live Consultation';

  static const String verificationTitle = 'Verification';
  static const String verificationSubtitle =
      'Provide proof of your credentials to ensure platform safety and credibility.';
  static const String uploadDocumentLabel = 'Upload Document';
  static const String docDropTitle = 'Drop your documents';
  static const String docDropFormats = 'Supported formats: PDF, DOCX';
  static const String docDropMaxSize = 'Maximum size: 10 MB';
  static String uploadedFilesLabel(int count) =>
      'Uploaded ($count ${count == 1 ? 'File' : 'Files'})';

  static const String pendingVerification = 'PENDING VERIFICATION';
  static const String verificationSubmittedTitle = 'Verification submitted!';
  static const String verificationSubmittedBody =
      'Our master mechanics are reviewing your qualifications and documents. We’ll notify you when you’re approved for payouts.';
  static const String averageReviewTime = 'Average Review Time';
  static const String averageReviewTimeValue = '< 2 hours';
  static const String submittedCertification = 'Submitted Certification';
  static const String verificationFootnote =
      'Usually verified within an hour during business hours.';

  // Mechanic home
  static const String navAlerts = 'Alerts';
  static const String visibilityTitle = 'Get High Visibility';
  static const String visibilityBody =
      'Get priority visibility, unlimited responses, and detailed analytics.';
  static const String upgradeNow = 'Upgrade Now';
  static const String yourActivity = 'Your Activity';
  static const String helpfulRating = 'Helpful Rating';
  static const String decline = 'Decline';
  static const String accept = 'Accept';
  static const String requestAccepted = 'Request accepted.';
  static const String requestDeclined = 'Request declined.';

  // Mechanic messages
  static const String mechanicNoMessagesBody =
      'Once a customer contacts you, your conversations will appear here.';
  static const String browseRequests = 'Browse Requests';
  static const String activeRequest = 'Active Request';
  static const String startLiveStream = 'Start Live Stream';

  // Alerts
  static const String alertsTitle = 'Alerts';
  static const String alertsToday = 'TODAY';
  static const String alertsEarlier = 'EARLIER';
  static const String noAlertsTitle = 'No alerts yet';
  static const String noAlertsMessage =
      'New activity on your requests will show up here.';

  // Mechanic service requests
  static const String serviceRequestsTitle = 'Service Requests';
  static String requesterLine(String name) => 'Requester: $name';
  static const String lastMessageLabel = 'Last Message';
  static String lastMessageQuote(String text) => '"$text"';
  static const String openConversation = 'Open Conversation';
  static const String tagImportant = 'IMPORTANT';
  static const String tagResolved = 'RESOLVED';
  static const String tagActive = 'ACTIVE';
  static const String priorityImportant = 'Important';
  static const String requestedBy = 'Requested By';
  static const String noServiceRequestsTitle = 'No requests here';
  static const String noServiceRequestsMessage =
      'Requests in this tab will show up here.';

  // Mechanic settings
  static const String profileSectionProfessional = 'PROFESSIONAL';
  static const String profileSectionCertifications = 'CERTIFICATIONS';
  static const String profileProfessionalProfile = 'Professional Profile';
  static const String profileVerification = 'Verification';
  static const String profileServicePricing = 'Service Pricing';
  static const String profileManageCertifications = 'Manage Certifications';

  static const String mechNotifyMessageTitle = 'New customer message';
  static const String mechNotifyMessageBody =
      'Direct messages from customers seeking your expertise.';
  static const String mechNotifyLiveTitle = 'Live consultation requests';
  static const String mechNotifyLiveBody =
      'Get notified about new live consultation requests.';
  static const String mechNotifyResolvedBody =
      'Get notified when a customer marks a request complete.';
  static const String mechNotifyHelpfulTitle = 'Advice marked helpful';
  static const String mechNotifyHelpfulBody =
      'Get notified when customers mark your advice as helpful.';
  static const String mechLocationPrivacyBody =
      'Your exact location is never shared with customers.';

  static const String sectionBasicInfo = 'BASIC INFORMATION';
  static const String sectionBrandSpecialization = 'BRAND SPECIALIZATION';
  static const String sectionExpertise = 'EXPERTISE';
  static const String workshopLabel = 'Workshop';
  static const String bioLabel = 'Bio';
  static const String tradeLabel = 'Trade';
  static const String primarySpecialtyLabel = 'Primary';
  static const String secondarySpecialtyLabel = 'Secondary';
  static const String skillsTitle = 'Skills';
  static String yearsOfExperience(int years) => '$years Years';

  static const String verifiedTitle = 'Verified';
  static const String verifiedBody =
      'Your expertise has been verified and your mechanic profile is live.';
  static const String verificationDocuments = 'VERIFICATION DOCUMENTS';
  static const String documentVerified = 'Verified';
  static const String pendingReviewTitle = 'Pending Review';
  static const String pendingReviewBody =
      'Your verification documents have been submitted and are awaiting review.';
  static const String documentsSubmitted = 'DOCUMENTS SUBMITTED';

  static const String pricingTiersTitle = 'Pricing Tiers';
  static const String addCustomTier = 'Add Custom Tier';
  static const String minimumChargeTitle = 'Minimum Charge';
  static const String minimumServiceFee = 'Minimum service fee';
  static const String minimumFeeBody =
      'Applies when the final diagnostic session is under 30 minutes.';
  static const String newTierTitle = 'New pricing tier';
  static const String tierNameLabel = 'Tier name';
  static const String tierNameHint = 'For example, Weekend Call';
  static const String tierPriceLabel = 'Price';
  static const String tierPriceHint = 'Price in dollars';
  static const String tierDescriptionLabel = 'Description';
  static const String tierDescriptionHint = 'What the customer gets';
  static const String addTier = 'Add Tier';
  static const String editMinimumTitle = 'Minimum service fee';
  static const String saveFee = 'Save Fee';
  static const String priceInvalid = 'Enter a price above zero';
  static const String pricingSaved = 'Pricing saved.';

  static const String currentCertificationsTitle = 'Current Certifications';
  static const String addCertificationTitle = 'Add Certification';
  static const String uploadCertificate = 'Upload Certificate';
  static const String uploadCertificateHint = 'PDF, JPG, or PNG up to 10 MB';
  static const String enterManually = 'Enter Manually';
  static const String enterManuallyHint = 'Type in your certification details';
  static const String writeInTitle = 'Write-In Certification';
  static const String writeInHint = 'Other certification not listed above...';
  static const String submitForReview = 'Submit for Review';
  static const String certVerified = 'Verified';
  static const String certPending = 'Pending Review';
  static String certExpires(String date) => 'Expires: $date';
  static String certSubmitted(String date) => 'Submitted: $date';
  static const String removeCertification = 'Remove certification';
  static const String certificationSubmitted = 'Submitted for review.';
  static const String certificationRemoved = 'Certification removed.';

  static const List<String> monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}
