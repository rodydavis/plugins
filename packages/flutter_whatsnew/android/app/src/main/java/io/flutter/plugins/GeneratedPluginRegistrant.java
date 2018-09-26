package io.flutter.plugins;

import com.appleeducate.getversion.GetVersionPlugin;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.packageinfo.PackageInfoPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;

/** Generated file. Do not edit. */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    GetVersionPlugin.registerWith(
        registry.registrarFor("com.appleeducate.getversion.GetVersionPlugin"));
    PackageInfoPlugin.registerWith(
        registry.registrarFor("io.flutter.plugins.packageinfo.PackageInfoPlugin"));
    SharedPreferencesPlugin.registerWith(
        registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
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
