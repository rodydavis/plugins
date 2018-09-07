// Copyright 2017 Michael Goderbauer. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "ContactPickerPlugin.h"
@import ContactsUI;

@interface ContactPickerPlugin ()<CNContactPickerDelegate>
@end

@implementation ContactPickerPlugin {
  FlutterResult _result;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel =
  [FlutterMethodChannel methodChannelWithName:@"contact_picker"
                              binaryMessenger:[registrar messenger]];
  ContactPickerPlugin *instance = [[ContactPickerPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  if ([@"selectContact" isEqualToString:call.method]) {
    if (_result) {
      _result([FlutterError errorWithCode:@"multiple_requests"
                                  message:@"Cancelled by a second request."
                                  details:nil]);
      _result = nil;
    }
    _result = result;

    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    //        contactPicker.displayedPropertyKeys = @[ CNContactPhoneNumbersKey ];

    UIViewController *viewController =
    [UIApplication sharedApplication].delegate.window.rootViewController;
    [viewController presentViewController:contactPicker animated:YES completion:nil];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
  NSString *fullName = [CNContactFormatter stringFromContact:contact
                                                       style:CNContactFormatterStyleFullName];
  NSString * identifier =  contact.identifier;
  NSString * displayName =  [CNContactFormatter stringFromContact:contact
                                                       style:CNContactFormatterStyleFullName];
  NSString * givenName =  contact.givenName;
  NSString * middleName =  contact.middleName;
  NSString * familyName =  contact.familyName;
  NSString * prefix =  contact.namePrefix;
  NSString * suffix =  contact.nameSuffix;
  NSString * company =  contact.organizationName;
  NSString * jobTitle =  contact.jobTitle;
//  NSData * avatar =  contact.imageData;
  NSMutableArray *emails = [NSMutableArray array];
  NSMutableArray *phones = [NSMutableArray array];
  NSMutableArray *addresses = [NSMutableArray array];
  NSMutableArray *ims = [NSMutableArray array];

  for (CNLabeledValue<NSString*> * email in contact.emailAddresses) {
    [emails addObject:@{ @"label": [CNLabeledValue localizedStringForLabel: email.label],
                         @"email": email.value }];
  }

  for (CNLabeledValue<CNPhoneNumber*> * phone in contact.phoneNumbers) {
    [phones addObject:@{ @"label": [CNLabeledValue localizedStringForLabel: phone.label],
                         @"phone": phone.value.stringValue }];
  }

  // for (CNLabeledValue<CNInstantMessageAddress*> * im in contact.instantMessageAddresses) {
  //   [ims addObject:@{ @"label": [CNLabeledValue localizedStringForLabel: im.label],
  //                     @"im": im.value.username,
  //                     @"protocol": im.value.service
  //                     }];
  // }
  for (CNLabeledValue<CNPostalAddress*> * address in contact.postalAddresses) {
    if (@available(iOS 10.3, *)) {
      [addresses addObject:@{ @"label": [CNLabeledValue localizedStringForLabel: address.label],
                              @"street": address.value.street,
                              @"neighborhood": address.value.subLocality,
                              @"city": address.value.city,
                              @"region": address.value.subAdministrativeArea,
                              @"state": address.value.state,
                              @"postcode": address.value.postalCode,
                              @"country": address.value.country
                              }];
    } else {
      [addresses addObject:@{ @"label": [CNLabeledValue localizedStringForLabel: address.label],
                              @"street": address.value.street,
                              @"city": address.value.city,
                              @"state": address.value.state,
                              @"postcode": address.value.postalCode,
                              @"country": address.value.country
                              }];
    }
  }

  if (!fullName) {
    fullName = [emails.firstObject valueForKeyPath:@"email"];
  }
  if (!fullName) {
    fullName = [phones.firstObject valueForKeyPath:@"phone"];
  }

  _result(@{ @"fullName": fullName, @"identifier": identifier, @"displayName": displayName, @"givenName": givenName, @"middleName": middleName, @"familyName": familyName, @"prefix": prefix, @"suffix": suffix, @"company": company, @"jobTitle": jobTitle, @"emails": emails, @"phones": phones, @"addresses": addresses });
  _result = nil;

  NSLog(@"contact: %@", contact);
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
  _result(nil);
  _result = nil;
}
@end
