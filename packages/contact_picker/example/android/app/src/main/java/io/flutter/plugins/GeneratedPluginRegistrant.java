package io.flutter.plugins;

import com.appleeducate.flutter.contactpicker.ContactPickerPlugin;
import com.ethras.simplepermissions.SimplePermissionsPlugin;
import io.flutter.plugin.common.PluginRegistry;

/** Generated file. Do not edit. */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    ContactPickerPlugin.registerWith(
        registry.registrarFor("com.appleeducate.flutter.contactpicker.ContactPickerPlugin"));
    SimplePermissionsPlugin.registerWith(
        registry.registrarFor("com.ethras.simplepermissions.SimplePermissionsPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
