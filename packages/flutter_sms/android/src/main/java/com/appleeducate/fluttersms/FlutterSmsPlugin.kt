package com.appleeducate.fluttersms

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.Settings
import android.util.Log

import java.util.ArrayList

import androidx.core.app.ActivityCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutterSmsPlugin  */
class FlutterSmsPlugin private constructor(internal var activity: Activity) : MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "sendSMS") {
            val message = call.argument<String>("message")
            val recipients = call.argument<ArrayList<String>>("recipients")
            val smsPermission = "SEND_SMS"
            if (!checkPermission(smsPermission)) {
                requestPermission(smsPermission)
                if (!checkPermission(smsPermission)) {
                    openSettings()
                } else {
                    sendSMS(recipients, message)
                }
            } else {
                sendSMS(recipients, message)
            }
            result.success("Sent!")
        } else {
            result.notImplemented()
        }
    }

    private fun sendSMS(phones: ArrayList<String>?, message: String?) {
        val sendIntent = Intent(Intent.ACTION_VIEW)
        sendIntent.putExtra("sms_body", message)
        sendIntent.data = Uri.parse("sms:" + phones!!)
        activity.startActivity(sendIntent)
    }

    private fun checkPermission(permission: String): Boolean {
        var permission = permission
        permission = getManifestPermission(permission)
        Log.i("SimplePermission", "Checking permission : $permission")
        return PackageManager.PERMISSION_GRANTED == ActivityCompat.checkSelfPermission(activity, permission)
    }

    private fun requestPermission(permission: String) {
        var permission = permission
        permission = getManifestPermission(permission)
        Log.i("SimplePermission", "Requesting permission : $permission")
        val perm = arrayOf(permission)
        ActivityCompat.requestPermissions(activity, perm, 0)
    }

    private fun getManifestPermission(permission: String): String {
        val res: String
        when (permission) {
            "SEND_SMS" -> res = Manifest.permission.SEND_SMS
            else -> res = "ERROR"
        }
        return res
    }

    private fun openSettings() {
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                Uri.parse("package:" + activity.packageName))
        intent.addCategory(Intent.CATEGORY_DEFAULT)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        activity.startActivity(intent)
    }

    companion object {

        /** Plugin registration.  */
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_sms")
            channel.setMethodCallHandler(FlutterSmsPlugin(registrar.activity()))
        }
    }
}
