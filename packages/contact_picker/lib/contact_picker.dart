import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class ContactPicker {
  static const MethodChannel _channel = MethodChannel('contact_picker');

  Future<Contact> selectContact() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('selectContact');
    if (result == null) {
      return null;
    }
    return new Contact.fromMap(result);
  }
}

class Contact {
  Contact(
      {this.fullName,
      this.identifier,
      this.displayName,
      this.givenName,
      this.middleName,
      this.familyName,
      this.prefix,
      this.suffix,
      this.company,
      this.jobTitle,
      this.avatar,
      this.phones,
      this.emails,
      this.postalAddresses
      // this.ims
      });

  factory Contact.fromMap(Map<dynamic, dynamic> map) => new Contact(
      fullName: map['fullName'],
      identifier: map['identifier'],
      displayName: map['displayName'],
      givenName: map['givenName'],
      middleName: map['middleName'],
      familyName: map['familyName'],
      prefix: map['prefix'],
      suffix: map['suffix'],
      company: map['company'],
      jobTitle: map['jobTitle'],
      avatar: map['avatar'],
      phones: List<PhoneNumber>.from((map['phones'])
          .map<PhoneNumber>((dynamic i) => PhoneNumber.fromMap(i))),
      emails: List<Email>.from(
          (map['emails']).map<Email>((dynamic i) => Email.fromMap(i))),
      postalAddresses: List<PostalAddress>.from((map['addresses'])
          .map<PostalAddress>((dynamic i) => PostalAddress.fromMap(i)))
      // ims: List<Im>.from((map['ims']).map<Im>((dynamic i) => Im.fromMap(i))),
      );

  /// Identifer
  final String identifier;

  /// Name for Contact
  final String displayName;

  /// First Name
  final String givenName;

  /// Middle Name
  final String middleName;

  /// Mr. Mrs. Ms. Miss. Dr.
  final String prefix;

  /// Sr. Jr. M.D.
  final String suffix;

  /// Last Name
  final String familyName;

  /// Company
  final String company;

  /// Job Title
  final String jobTitle;

  /// Avatar of Contact
  final Uint8List avatar;

  /// The full name of the contact, e.g. "Dr. Daniel Higgens Jr.".
  final String fullName;

  /// The phone numbers of the contact.
  final List<PhoneNumber> phones;

  /// The emails of the contact.
  final List<Email> emails;

  /// The addresses of the contact.
  final List<PostalAddress> postalAddresses;

  /// The instant messengers of the contact
  // final List<Im> ims;

  @override
  String toString() => '$fullName';
}

class PostalAddress {
  PostalAddress(
      {this.pobox,
      this.neighborhood,
      this.label,
      this.street,
      this.city,
      this.postcode,
      this.region,
      this.country});

  factory PostalAddress.fromMap(Map<dynamic, dynamic> m) => new PostalAddress(
      label: m["label"],
      street: m["street"],
      city: m["city"],
      postcode: m["postcode"],
      region: m["region"],
      country: m["country"],
      pobox: m['pobox'],
      neighborhood: m['neighborhood']);

  // String pobox, neighborhood, label, street, city, postcode, region, country;

  /// Address
  final String pobox;

  /// The label associated with the phone number, e.g. "home" or "work".
  final String label;

  /// Address
  final String neighborhood;

  /// Address
  final String street;

  /// Address
  final String city;

  /// Address
  final String postcode;

  /// Address
  final String region;

  /// Address
  final String country;

  @override
  String toString() => '$street $city $region $postcode ($label)';
}

/// Represents a phone number selected by the user.
class PhoneNumber {
  PhoneNumber({this.number, this.label});

  factory PhoneNumber.fromMap(Map<dynamic, dynamic> map) =>
      new PhoneNumber(number: map['phone'], label: map['label']);

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String number;

  /// The label associated with the phone number, e.g. "home" or "work".
  final String label;

  @override
  String toString() => '$number ($label)';
}

/// Represents a email address
class Email {
  Email({this.email, this.label});

  factory Email.fromMap(Map<dynamic, dynamic> map) =>
      new Email(email: map['email'], label: map['label']);

  /// The raw email address
  final String email;

  /// The label associated with the email, e.g. "home" or "work".
  final String label;

  @override
  String toString() => '$email ($label)';
}

// /// Represents a instant messaging endpoint
// class Im {
//   Im({this.value, this.label, this.protocol});

//   factory Im.fromMap(Map<dynamic, dynamic> map) =>
//       new Im(value: map['im'], label: map['label'], protocol: map['protocol']);

//   /// The IM endpoint
//   final String value;

//   /// The label associated with the endpoint, e.g. "home" or "work".
//   final String label;

//   /// The IM protocol, e.g. Skype, Hangouts ...
//   final String protocol;

//   @override
//   String toString() => '$value $protocol ($label)';
// }
