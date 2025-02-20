package com.example.parental_control_plugin

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.app.AlertDialog
import android.content.pm.PackageManager
import android.view.LayoutInflater
import android.widget.EditText
import android.widget.TextView
import androidx.annotation.NonNull
import com.google.firebase.firestore.FirebaseFirestore
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class ParentalControlPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private val db = FirebaseFirestore.getInstance()

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "parental_control_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "blockApp" -> {
        val packageName = call.argument<String>("packageName")
        if (packageName != null) {
          val success = blockApp(packageName)
          logActionToFirebase("block", packageName)
          result.success(success)
        } else {
          result.error("INVALID_ARGUMENT", "Package name is required", null)
        }
      }
      "unblockApp" -> {
        val packageName = call.argument<String>("packageName")
        if (packageName != null) {
          val success = unblockApp(packageName)
          logActionToFirebase("unblock", packageName)
          result.success(success)
        } else {
          result.error("INVALID_ARGUMENT", "Package name is required", null)
        }
      }
      "showQuizDialog" -> {
        val packageName = call.argument<String>("packageName")
        if (packageName != null) {
          showQuizDialog(packageName, result)
        } else {
          result.error("INVALID_ARGUMENT", "Package name is required", null)
        }
      }
      "logActionToFirebase" -> {
        val action = call.argument<String>("action")
        val packageName = call.argument<String>("packageName")
        if (action != null && packageName != null) {
          logActionToFirebase(action, packageName)
          result.success(true)
        } else {
          result.error("INVALID_ARGUMENT", "Action and package name are required", null)
        }
      }
      "enableDeviceAdmin" -> {
        enableDeviceAdmin()
        result.success(true)
      }
      else -> result.notImplemented()
    }
  }

  private fun enableDeviceAdmin() {
    val componentName = ComponentName(context, AdminReceiver::class.java)
    val intent = Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN)
    intent.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, componentName)
    intent.putExtra(DevicePolicyManager.EXTRA_ADD_EXPLANATION, "This app requires device admin permission to prevent uninstallation.")
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    context.startActivity(intent)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}