// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `user name (phone number)`
  String get loginUserName {
    return Intl.message(
      'user name (phone number)',
      name: 'loginUserName',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get loginPassword {
    return Intl.message(
      'password',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  /// `save user name`
  String get saveUserName {
    return Intl.message(
      'save user name',
      name: 'saveUserName',
      desc: '',
      args: [],
    );
  }

  /// `activate`
  String get activate {
    return Intl.message(
      'activate',
      name: 'activate',
      desc: '',
      args: [],
    );
  }

  /// `reset password`
  String get resetPassword {
    return Intl.message(
      'reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `login`
  String get login {
    return Intl.message(
      'login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `biometric login`
  String get biometricLogin {
    return Intl.message(
      'biometric login',
      name: 'biometricLogin',
      desc: '',
      args: [],
    );
  }

  /// `car model`
  String get carModel {
    return Intl.message(
      'car model',
      name: 'carModel',
      desc: '',
      args: [],
    );
  }

  /// `car year`
  String get carYear {
    return Intl.message(
      'car year',
      name: 'carYear',
      desc: '',
      args: [],
    );
  }

  /// `car type`
  String get carType {
    return Intl.message(
      'car type',
      name: 'carType',
      desc: '',
      args: [],
    );
  }

  /// `national number of car owner`
  String get nationalNumberOfCarOwner {
    return Intl.message(
      'national number of car owner',
      name: 'nationalNumberOfCarOwner',
      desc: '',
      args: [],
    );
  }

  /// `car vin code`
  String get carVinCode {
    return Intl.message(
      'car vin code',
      name: 'carVinCode',
      desc: '',
      args: [],
    );
  }

  /// `subscription number`
  String get subscriptionNumber {
    return Intl.message(
      'subscription number',
      name: 'subscriptionNumber',
      desc: '',
      args: [],
    );
  }

  /// `SMS was sent to the announced number during the entry stage`
  String get smsWasSentToTheAnnouncedNumberDuringTheEntryStage {
    return Intl.message(
      'SMS was sent to the announced number during the entry stage',
      name: 'smsWasSentToTheAnnouncedNumberDuringTheEntryStage',
      desc: '',
      args: [],
    );
  }

  /// `submit`
  String get submit {
    return Intl.message(
      'submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `add car`
  String get addCar {
    return Intl.message(
      'add car',
      name: 'addCar',
      desc: '',
      args: [],
    );
  }

  /// `details of the car owner`
  String get detailsOfTheCarOwner {
    return Intl.message(
      'details of the car owner',
      name: 'detailsOfTheCarOwner',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `last name`
  String get lastName {
    return Intl.message(
      'last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `state`
  String get state {
    return Intl.message(
      'state',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `city`
  String get city {
    return Intl.message(
      'city',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `no item found`
  String get noItemFound {
    return Intl.message(
      'no item found',
      name: 'noItemFound',
      desc: '',
      args: [],
    );
  }

  /// `car details`
  String get carDetails {
    return Intl.message(
      'car details',
      name: 'carDetails',
      desc: '',
      args: [],
    );
  }

  /// `brand`
  String get brand {
    return Intl.message(
      'brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `model`
  String get model {
    return Intl.message(
      'model',
      name: 'model',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `work hours`
  String get workHours {
    return Intl.message(
      'work hours',
      name: 'workHours',
      desc: '',
      args: [],
    );
  }

  /// `kilometers traveled`
  String get kilometersTraveled {
    return Intl.message(
      'kilometers traveled',
      name: 'kilometersTraveled',
      desc: '',
      args: [],
    );
  }

  /// `distance to destination`
  String get distanceToDestination {
    return Intl.message(
      'distance to destination',
      name: 'distanceToDestination',
      desc: '',
      args: [],
    );
  }

  /// `on`
  String get on {
    return Intl.message(
      'on',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `off`
  String get off {
    return Intl.message(
      'off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `Opening and closing the car door`
  String get openingAndClosingTheCarDoor {
    return Intl.message(
      'Opening and closing the car door',
      name: 'openingAndClosingTheCarDoor',
      desc: '',
      args: [],
    );
  }

  /// `Turn the lights on and off`
  String get turnTheLightsOnAndOff {
    return Intl.message(
      'Turn the lights on and off',
      name: 'turnTheLightsOnAndOff',
      desc: '',
      args: [],
    );
  }

  /// `Stop the car`
  String get stopTheCar {
    return Intl.message(
      'Stop the car',
      name: 'stopTheCar',
      desc: '',
      args: [],
    );
  }

  /// `Car power cut`
  String get carPowerCut {
    return Intl.message(
      'Car power cut',
      name: 'carPowerCut',
      desc: '',
      args: [],
    );
  }

  /// `Car internal listening`
  String get carInternalListening {
    return Intl.message(
      'Car internal listening',
      name: 'carInternalListening',
      desc: '',
      args: [],
    );
  }

  /// `Car ignition warning`
  String get carIgnitionWarning {
    return Intl.message(
      'Car ignition warning',
      name: 'carIgnitionWarning',
      desc: '',
      args: [],
    );
  }

  /// `Switch opening warning`
  String get switchOpeningWarning {
    return Intl.message(
      'Switch opening warning',
      name: 'switchOpeningWarning',
      desc: '',
      args: [],
    );
  }

  /// `Motion warning`
  String get motionWarning {
    return Intl.message(
      'Motion warning',
      name: 'motionWarning',
      desc: '',
      args: [],
    );
  }

  /// `Impact warning`
  String get impactWarning {
    return Intl.message(
      'Impact warning',
      name: 'impactWarning',
      desc: '',
      args: [],
    );
  }

  /// `GPS blind spot warning`
  String get gpsBlindSpotWarning {
    return Intl.message(
      'GPS blind spot warning',
      name: 'gpsBlindSpotWarning',
      desc: '',
      args: [],
    );
  }

  /// `Disconnecting the device warning`
  String get disconnectingTheDeviceWarning {
    return Intl.message(
      'Disconnecting the device warning',
      name: 'disconnectingTheDeviceWarning',
      desc: '',
      args: [],
    );
  }

  /// `Battery theft warning`
  String get batteryTheftWarning {
    return Intl.message(
      'Battery theft warning',
      name: 'batteryTheftWarning',
      desc: '',
      args: [],
    );
  }

  /// `Low battery warning`
  String get lowBatteryWarning {
    return Intl.message(
      'Low battery warning',
      name: 'lowBatteryWarning',
      desc: '',
      args: [],
    );
  }

  /// `Oil change warning`
  String get oilChangeWarning {
    return Intl.message(
      'Oil change warning',
      name: 'oilChangeWarning',
      desc: '',
      args: [],
    );
  }

  /// `External power failure warning`
  String get externalPowerFailureWarning {
    return Intl.message(
      'External power failure warning',
      name: 'externalPowerFailureWarning',
      desc: '',
      args: [],
    );
  }

  /// `SOS alert`
  String get sosAlert {
    return Intl.message(
      'SOS alert',
      name: 'sosAlert',
      desc: '',
      args: [],
    );
  }

  /// `Speed warning`
  String get speedWarning {
    return Intl.message(
      'Speed warning',
      name: 'speedWarning',
      desc: '',
      args: [],
    );
  }

  /// `Low fuel warning`
  String get lowFuelWarning {
    return Intl.message(
      'Low fuel warning',
      name: 'lowFuelWarning',
      desc: '',
      args: [],
    );
  }

  /// `Spark plug replacement warning`
  String get sparkPlugReplacementWarning {
    return Intl.message(
      'Spark plug replacement warning',
      name: 'sparkPlugReplacementWarning',
      desc: '',
      args: [],
    );
  }

  /// `Pad replacement warning`
  String get padReplacementWarning {
    return Intl.message(
      'Pad replacement warning',
      name: 'padReplacementWarning',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth disconnection warning`
  String get bluetoothDisconnectionWarning {
    return Intl.message(
      'Bluetooth disconnection warning',
      name: 'bluetoothDisconnectionWarning',
      desc: '',
      args: [],
    );
  }

  /// `Verify identity`
  String get verifyIdentity {
    return Intl.message(
      'Verify identity',
      name: 'verifyIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Authentication required`
  String get authenticationRequired {
    return Intl.message(
      'Authentication required',
      name: 'authenticationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Choose an authentication method`
  String get chooseAnAuthenticationMethod {
    return Intl.message(
      'Choose an authentication method',
      name: 'chooseAnAuthenticationMethod',
      desc: '',
      args: [],
    );
  }

  /// `Enter mobile number`
  String get enterMobileNumber {
    return Intl.message(
      'Enter mobile number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `PhoneNumberIsNotValid`
  String get phoneNumberIsNotValid {
    return Intl.message(
      'PhoneNumberIsNotValid',
      name: 'phoneNumberIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code`
  String get enterVerificationCode {
    return Intl.message(
      'Enter verification code',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Change phone number`
  String get changePhoneNumber {
    return Intl.message(
      'Change phone number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next {
    return Intl.message(
      'next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Remove the car?`
  String get removeTheCarAlert {
    return Intl.message(
      'Remove the car?',
      name: 'removeTheCarAlert',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Default car`
  String get defaultCar {
    return Intl.message(
      'Default car',
      name: 'defaultCar',
      desc: '',
      args: [],
    );
  }

  /// `You can change the default car by moving cars`
  String get changeDefaultCar {
    return Intl.message(
      'You can change the default car by moving cars',
      name: 'changeDefaultCar',
      desc: '',
      args: [],
    );
  }

  /// `Add device`
  String get addDevice {
    return Intl.message(
      'Add device',
      name: 'addDevice',
      desc: '',
      args: [],
    );
  }

  /// `By moving the desired car to the right or left, you can remove the desired car`
  String get removeCar {
    return Intl.message(
      'By moving the desired car to the right or left, you can remove the desired car',
      name: 'removeCar',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Communication error`
  String get communicationError {
    return Intl.message(
      'Communication error',
      name: 'communicationError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get enterName {
    return Intl.message(
      'Please enter your name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get enterLName {
    return Intl.message(
      'Please enter your last name',
      name: 'enterLName',
      desc: '',
      args: [],
    );
  }

  /// `Please select your state`
  String get selectState {
    return Intl.message(
      'Please select your state',
      name: 'selectState',
      desc: '',
      args: [],
    );
  }

  /// `Please select your city`
  String get selectCity {
    return Intl.message(
      'Please select your city',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Please select state and city`
  String get selectStateCity {
    return Intl.message(
      'Please select state and city',
      name: 'selectStateCity',
      desc: '',
      args: [],
    );
  }

  /// `Alias`
  String get alias {
    return Intl.message(
      'Alias',
      name: 'alias',
      desc: '',
      args: [],
    );
  }

  /// `Serial number`
  String get serialNumber {
    return Intl.message(
      'Serial number',
      name: 'serialNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please select the brand`
  String get selectBrand {
    return Intl.message(
      'Please select the brand',
      name: 'selectBrand',
      desc: '',
      args: [],
    );
  }

  /// `Please select the model`
  String get selectModel {
    return Intl.message(
      'Please select the model',
      name: 'selectModel',
      desc: '',
      args: [],
    );
  }

  /// `Please select the production year`
  String get selectYear {
    return Intl.message(
      'Please select the production year',
      name: 'selectYear',
      desc: '',
      args: [],
    );
  }

  /// `Please add device`
  String get addDeviceError {
    return Intl.message(
      'Please add device',
      name: 'addDeviceError',
      desc: '',
      args: [],
    );
  }

  /// `Before`
  String get before {
    return Intl.message(
      'Before',
      name: 'before',
      desc: '',
      args: [],
    );
  }

  /// `Car`
  String get car {
    return Intl.message(
      'Car',
      name: 'car',
      desc: '',
      args: [],
    );
  }

  /// `Production year`
  String get productionYear {
    return Intl.message(
      'Production year',
      name: 'productionYear',
      desc: '',
      args: [],
    );
  }

  /// `My cars`
  String get myCars {
    return Intl.message(
      'My cars',
      name: 'myCars',
      desc: '',
      args: [],
    );
  }

  /// `My profile`
  String get myProfile {
    return Intl.message(
      'My profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Persian (فارسی)`
  String get persian {
    return Intl.message(
      'Persian (فارسی)',
      name: 'persian',
      desc: '',
      args: [],
    );
  }

  /// `English (انگلیسی)`
  String get english {
    return Intl.message(
      'English (انگلیسی)',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Marked locations`
  String get markedLocations {
    return Intl.message(
      'Marked locations',
      name: 'markedLocations',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get latitude {
    return Intl.message(
      'Latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `Longitude`
  String get longitude {
    return Intl.message(
      'Longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add to marked list`
  String get addToMarkedList {
    return Intl.message(
      'Add to marked list',
      name: 'addToMarkedList',
      desc: '',
      args: [],
    );
  }

  /// `There is no item`
  String get noItem {
    return Intl.message(
      'There is no item',
      name: 'noItem',
      desc: '',
      args: [],
    );
  }

  /// `Delete marked item`
  String get deleteMarkedItem {
    return Intl.message(
      'Delete marked item',
      name: 'deleteMarkedItem',
      desc: '',
      args: [],
    );
  }

  /// `be deleted?`
  String get delete {
    return Intl.message(
      'be deleted?',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Please add your car from settings, my cars`
  String get pleaseAddYourCarFromSettingsMyCars {
    return Intl.message(
      'Please add your car from settings, my cars',
      name: 'pleaseAddYourCarFromSettingsMyCars',
      desc: '',
      args: [],
    );
  }

  /// `History of routes`
  String get historyOfRoutes {
    return Intl.message(
      'History of routes',
      name: 'historyOfRoutes',
      desc: '',
      args: [],
    );
  }

  /// `Select a time frame`
  String get selectATimeFrame {
    return Intl.message(
      'Select a time frame',
      name: 'selectATimeFrame',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get startDate {
    return Intl.message(
      'Start date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `End date`
  String get endDate {
    return Intl.message(
      'End date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Please select the car`
  String get pleaseSelectTheCar {
    return Intl.message(
      'Please select the car',
      name: 'pleaseSelectTheCar',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `The car door opened`
  String get theCarDoorOpened {
    return Intl.message(
      'The car door opened',
      name: 'theCarDoorOpened',
      desc: '',
      args: [],
    );
  }

  /// `The car door closed`
  String get theCarDoorClosed {
    return Intl.message(
      'The car door closed',
      name: 'theCarDoorClosed',
      desc: '',
      args: [],
    );
  }

  /// `Allow the vehicle to start`
  String get allowTheVehicleToStart {
    return Intl.message(
      'Allow the vehicle to start',
      name: 'allowTheVehicleToStart',
      desc: '',
      args: [],
    );
  }

  /// `The car can be started`
  String get theCarCanBeStarted {
    return Intl.message(
      'The car can be started',
      name: 'theCarCanBeStarted',
      desc: '',
      args: [],
    );
  }

  /// `The car cannot be started`
  String get theCarCannotBeStarted {
    return Intl.message(
      'The car cannot be started',
      name: 'theCarCannotBeStarted',
      desc: '',
      args: [],
    );
  }

  /// `Turn off the car?`
  String get turnOffTheCar {
    return Intl.message(
      'Turn off the car?',
      name: 'turnOffTheCar',
      desc: '',
      args: [],
    );
  }

  /// `The car turned off`
  String get theCarTurnedOff {
    return Intl.message(
      'The car turned off',
      name: 'theCarTurnedOff',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `User info updated successfully`
  String get userInfoUpdatedSuccessfully {
    return Intl.message(
      'User info updated successfully',
      name: 'userInfoUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No location has been registered for this car`
  String get noLocationHasBeenRegisteredForThisCar {
    return Intl.message(
      'No location has been registered for this car',
      name: 'noLocationHasBeenRegisteredForThisCar',
      desc: '',
      args: [],
    );
  }

  /// `Parameter`
  String get parameter {
    return Intl.message(
      'Parameter',
      name: 'parameter',
      desc: '',
      args: [],
    );
  }

  /// `fault`
  String get fault {
    return Intl.message(
      'fault',
      name: 'fault',
      desc: '',
      args: [],
    );
  }

  /// `15 minutes ago`
  String get minutesAgo {
    return Intl.message(
      '15 minutes ago',
      name: 'minutesAgo',
      desc: '',
      args: [],
    );
  }

  /// `2 hours ago`
  String get hoursAgo {
    return Intl.message(
      '2 hours ago',
      name: 'hoursAgo',
      desc: '',
      args: [],
    );
  }

  /// `previous`
  String get previous {
    return Intl.message(
      'previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Your information is encrypted`
  String get yourInformationIsEncrypted {
    return Intl.message(
      'Your information is encrypted',
      name: 'yourInformationIsEncrypted',
      desc: '',
      args: [],
    );
  }

  /// `We are always with you`
  String get weAreAlwaysWithYou {
    return Intl.message(
      'We are always with you',
      name: 'weAreAlwaysWithYou',
      desc: '',
      args: [],
    );
  }

  /// `Are you interested in periodic services?\nWe call it...`
  String get periodicServices {
    return Intl.message(
      'Are you interested in periodic services?\nWe call it...',
      name: 'periodicServices',
      desc: '',
      args: [],
    );
  }

  /// `Why is the check light on?!\nWe tell you...`
  String get checkLight {
    return Intl.message(
      'Why is the check light on?!\nWe tell you...',
      name: 'checkLight',
      desc: '',
      args: [],
    );
  }

  /// `Where is your device now?!\nWe tell you...`
  String get whereIsYourDeviceNow {
    return Intl.message(
      'Where is your device now?!\nWe tell you...',
      name: 'whereIsYourDeviceNow',
      desc: '',
      args: [],
    );
  }

  /// `Kilometers`
  String get kilometers {
    return Intl.message(
      'Kilometers',
      name: 'kilometers',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Remote`
  String get remote {
    return Intl.message(
      'Remote',
      name: 'remote',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
