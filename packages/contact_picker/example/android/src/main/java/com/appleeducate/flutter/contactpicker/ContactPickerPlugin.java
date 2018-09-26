// Copyright 2017 Michael Goderbauer. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package com.appleeducate.flutter.contactpicker;

import static android.app.Activity.RESULT_OK;

import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.provider.ContactsContract;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ContactPickerPlugin
    implements MethodCallHandler, PluginRegistry.ActivityResultListener {
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "contact_picker");
    ContactPickerPlugin instance = new ContactPickerPlugin(registrar.activity());
    registrar.addActivityResultListener(instance);
    channel.setMethodCallHandler(instance);
  }

  private ContactPickerPlugin(Activity activity) {
    this.activity = activity;
  }

  private static int PICK_CONTACT = 2015;

  private Activity activity;
  private Result pendingResult;

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("selectContact")) {
      if (pendingResult != null) {
        pendingResult.error("multiple_requests", "Cancelled by a second request.", null);
        pendingResult = null;
      }
      pendingResult = result;

      Intent i = new Intent(Intent.ACTION_PICK, ContactsContract.Contacts.CONTENT_URI);
      activity.startActivityForResult(i, PICK_CONTACT);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode != PICK_CONTACT) {
      return false;
    }

    if (resultCode != RESULT_OK || data.getData() == null) {
      pendingResult.success(null);
      pendingResult = null;
      return true;
    }

    Uri contactUri = data.getData();
    Cursor cursor = null;

    try {
      cursor = activity.getContentResolver().query(contactUri, null, null, null, null);

      if (cursor == null || !cursor.moveToFirst()) {
        pendingResult.success(null);
        pendingResult = null;
        return true;
      }

      long contactId = cursor.getLong(cursor.getColumnIndex(ContactsContract.Contacts._ID));

      // List<Map<String, Object>> ims = new ArrayList<>();
      List<Map<String, Object>> emails = new ArrayList<>();
      List<Map<String, Object>> phones = new ArrayList<>();
      List<Map<String, Object>> addresses = new ArrayList<>();

      String displayName = "";
      String givenName = "";
      String middleName = "";
      String familyName = "";
      String prefix = "";
      String suffix = "";
      String company = "";
      String jobTitle = "";

      Cursor rawCursor = null;
      try {
        rawCursor =
            activity
                .getContentResolver()
                .query(
                    ContactsContract.RawContactsEntity.CONTENT_URI,
                    null,
                    ContactsContract.CommonDataKinds.Email.CONTACT_ID + " = ?",
                    new String[] {Long.toString(contactId)},
                    null,
                    null);

        if (rawCursor != null && rawCursor.moveToFirst()) {
          do {
            Map<String, Object> row = new HashMap<>();

            String mimeType =
                rawCursor.getString(
                    rawCursor.getColumnIndex(ContactsContract.RawContactsEntity.MIMETYPE));
            switch (mimeType) {
              case ContactsContract.CommonDataKinds.StructuredName.CONTENT_ITEM_TYPE:
                {
                  displayName =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredName.DISPLAY_NAME));
                  givenName =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredName.GIVEN_NAME));
                  middleName =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredName.MIDDLE_NAME));
                  familyName =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredName.FAMILY_NAME));
                  prefix =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredName.PREFIX));
                  suffix =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredName.SUFFIX));
                  break;
                }
              case ContactsContract.CommonDataKinds.Organization.CONTENT_ITEM_TYPE:
                {
                  company =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.Organization.COMPANY));
                  jobTitle =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.Organization.TITLE));
                  break;
                }
                // case ContactsContract.CommonDataKinds.Im.CONTENT_ITEM_TYPE: {
                //   int type = rawCursor.getInt(rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Im.TYPE));
                //   String customLabel = rawCursor.getString(rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Im.LABEL));

                //   row.put("label", ContactsContract.CommonDataKinds.Im.getTypeLabel(activity.getResources(), type, customLabel));
                //   row.put("im", rawCursor.getString(rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Im.DATA)));

                //   int protocol = rawCursor.getInt(rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Im.PROTOCOL));
                //   String customProtocol = rawCursor.getString(rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Im.CUSTOM_PROTOCOL));
                //   row.put("protocol", ContactsContract.CommonDataKinds.Im.getProtocolLabel(activity.getResources(), protocol, customProtocol));

                //   ims.add(row);
                //   break;
                // }
              case ContactsContract.CommonDataKinds.Email.CONTENT_ITEM_TYPE:
                {
                  int type =
                      rawCursor.getInt(
                          rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Email.TYPE));
                  String customLabel =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Email.LABEL));

                  row.put(
                      "label",
                      ContactsContract.CommonDataKinds.Email.getTypeLabel(
                          activity.getResources(), type, customLabel));
                  row.put(
                      "email",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.Email.ADDRESS)));

                  emails.add(row);
                  break;
                }
              case ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE:
                {
                  int type =
                      rawCursor.getInt(
                          rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.TYPE));
                  String customLabel =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.LABEL));

                  row.put(
                      "label",
                      ContactsContract.CommonDataKinds.Phone.getTypeLabel(
                          activity.getResources(), type, customLabel));
                  row.put(
                      "phone",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER)));

                  phones.add(row);
                  break;
                }
              case ContactsContract.CommonDataKinds.StructuredPostal.CONTENT_ITEM_TYPE:
                {
                  int type =
                      rawCursor.getInt(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.TYPE));
                  String customLabel =
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.LABEL));

                  row.put(
                      "label",
                      ContactsContract.CommonDataKinds.StructuredPostal.getTypeLabel(
                          activity.getResources(), type, customLabel));
                  row.put(
                      "street",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.STREET)));
                  row.put(
                      "pobox",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.POBOX)));
                  row.put(
                      "neighborhood",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.NEIGHBORHOOD)));
                  row.put(
                      "city",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.CITY)));
                  row.put(
                      "region",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.REGION)));
                  row.put(
                      "postcode",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.POSTCODE)));
                  row.put(
                      "country",
                      rawCursor.getString(
                          rawCursor.getColumnIndex(
                              ContactsContract.CommonDataKinds.StructuredPostal.COUNTRY)));

                  addresses.add(row);
                  break;
                }
            }
          } while (rawCursor.moveToNext());
        }
      } finally {
        if (rawCursor != null) {
          rawCursor.close();
        }
      }

      String fullName =
          cursor.getString(cursor.getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME));
      //String identifier = cursor.getString(cursor.getColumnIndex(ContactsContract.Data.CONTACT_ID));
      // String avatar = cursor.getString(cursor.getColumnIndex(ContactsContract.CommonDataKinds.StructuredName.DISPLAY_NAME));

      HashMap<String, Object> contact = new HashMap<>();
      contact.put("fullName", fullName);
      contact.put("identifier", "");
      contact.put("displayName", displayName);
      contact.put("givenName", givenName);
      contact.put("middleName", middleName);
      contact.put("familyName", familyName);
      contact.put("prefix", prefix);
      contact.put("suffix", suffix);
      contact.put("company", company);
      contact.put("jobTitle", jobTitle);
      // contact.put("avatar", avatar);

      contact.put("emails", emails);
      contact.put("phones", phones);
      contact.put("addresses", addresses);
      // contact.put("ims", ims);

      pendingResult.success(contact);
      pendingResult = null;
    } finally {
      if (cursor != null) {
        cursor.close();
      }
    }
    return true;
  }
}
