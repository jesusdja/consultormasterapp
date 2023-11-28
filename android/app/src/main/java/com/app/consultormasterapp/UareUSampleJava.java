/* 
 * File: 		UareUSampleJava.java
 * Created:		2013/05/03
 * 
 * copyright (c) 2013 DigitalPersona Inc.
 */

package com.app.consultormasterapp;

import android.app.ActionBar;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.digitalpersona.uareu.*;
import com.digitalpersona.uareu.Reader.Priority;
import com.digitalpersona.uareu.dpfpddusbhost.DPFPDDUsbException;
import com.digitalpersona.uareu.dpfpddusbhost.DPFPDDUsbHost;

public class UareUSampleJava extends Activity
{
	private final int GENERAL_ACTIVITY_RESULT = 1;
	private final int GENERAL_ACTIVITY_RESULT_2 = 2;
	private static final int SCAN_FINGER = 3;

	private static final String ACTION_USB_PERMISSION = "com.digitalpersona.uareu.dpfpddusbhost.USB_PERMISSION";
	
	private TextView m_selectedDevice;
	private Button m_getReader;
	private Button m_captureFingerprint;
	private String m_deviceName = "";
	private String m_versionName = "";

	private final String tag = "UareUSampleJava2";

	Reader m_reader;

	@Override
	public void onStop()
	{
		// reset you to initial state when activity stops
		m_selectedDevice.setText("Device: (No Reader Selected)");
		setButtonsEnabled(false);
		super.onStop();
	}

	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		System.setProperty("DPTRACE_ON", "1");
		
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		m_getReader = (Button) findViewById(R.id.get_reader);
		m_captureFingerprint = (Button) findViewById(R.id.capture_fingerprint);
		m_selectedDevice = (TextView) findViewById(R.id.selected_device);

		setButtonsEnabled(false);

		// register handler for UI elements
		m_getReader.setOnClickListener(new View.OnClickListener()
		{
			public void onClick(View v)
			{
				launchGetReader();
			}
		});

		m_captureFingerprint.setOnClickListener(new View.OnClickListener()
		{
			public void onClick(View v)
			{
				launchCaptureFingerprint();
			}
		});

		// get the version name
		try
		{
			m_versionName = this.getPackageManager().getPackageInfo(this.getPackageName(), 0).versionName;
		}
		catch (PackageManager.NameNotFoundException e)
		{
			Log.e(tag, e.getMessage());
		}

		ActionBar ab = getActionBar();
		ab.setTitle("DigitalPersona U are U SDK Sample" + " v" + m_versionName);
	}

	protected void launchGetReader()
	{
		Intent i = new Intent(UareUSampleJava.this, GetReaderActivity.class);
		i.putExtra("device_name", m_deviceName);
		startActivityForResult(i, 1);
	}

	protected void launchCaptureFingerprint()
	{

		setButtonsEnabled(false);
		Intent i = new Intent(UareUSampleJava.this,CaptureFingerprintActivity.class);
		i.putExtra("device_name", m_deviceName);
		startActivityForResult(i, GENERAL_ACTIVITY_RESULT_2);
	}

	@Override
	public void onBackPressed()
	{
		super.onBackPressed();
	}

	protected void setButtonsEnabled(Boolean enabled)
	{
		m_captureFingerprint.setEnabled(enabled);
	}

	protected void setButtonsEnabled_Capture(Boolean enabled)
	{
		m_captureFingerprint.setEnabled(enabled);
	}


	protected void CheckDevice()
	{
		try
		{
			m_reader.Open(Priority.EXCLUSIVE);
			Reader.Capabilities cap = m_reader.GetCapabilities();
			setButtonsEnabled(true);
			setButtonsEnabled_Capture(cap.can_capture);
			m_reader.Close();
		} 
		catch (UareUException e1)
		{
			displayReaderNotFound();
		}
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data)
	{
		if (data == null)
		{
			displayReaderNotFound();
			return;
		}
		
		Globals.ClearLastBitmap();
		m_deviceName = (String) data.getExtras().get("device_name");
		Log.e(tag, "ERROR ENCONTRADO2 : " + requestCode + "  -  " + resultCode + "  -  " + data);
		String dataSt = "";
		try{
			dataSt = (String) data.getExtras().get("errorMessage");
		} catch (Exception e1){
			System.out.println("errorMessage tonny");
			e1.printStackTrace();
		}


		switch (requestCode)
		{
		case GENERAL_ACTIVITY_RESULT_2:
			if(!dataSt.isEmpty()){
				Log.e("SCAN_FINGER","1");
//				Intent intent = new Intent();
//				intent.putExtra("errorMessage", "true");
				setResult(SCAN_FINGER, data);
				finish();
			}
		case GENERAL_ACTIVITY_RESULT:

			if((m_deviceName != null) && !m_deviceName.isEmpty())
			{
				m_selectedDevice.setText("Device: " + m_deviceName);

				try {
					Context applContext = getApplicationContext();
					m_reader = Globals.getInstance().getReader(m_deviceName, applContext);

					{
						PendingIntent mPermissionIntent;
						mPermissionIntent = PendingIntent.getBroadcast(applContext, 0, new Intent(ACTION_USB_PERMISSION), PendingIntent.FLAG_MUTABLE);
						IntentFilter filter = new IntentFilter(ACTION_USB_PERMISSION);
						applContext.registerReceiver(mUsbReceiver, filter);

						if(DPFPDDUsbHost.DPFPDDUsbCheckAndRequestPermissions(applContext, mPermissionIntent, m_deviceName))
						{
							CheckDevice();
						}
					}
				} catch (UareUException e1)
				{
					displayReaderNotFound();
				}
				catch (DPFPDDUsbException e)
				{
					displayReaderNotFound();
				}

			} else
			{ 
				displayReaderNotFound();
			}

			break;
		}
	}

	private void displayReaderNotFound()
	{
		m_selectedDevice.setText("Device: (No Reader Selected)");
		setButtonsEnabled(false);
		AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(this);
		alertDialogBuilder.setTitle("Reader Not Found");
		alertDialogBuilder.setMessage("Plug in a reader and try again.").setCancelable(false).setPositiveButton("Ok",
				new DialogInterface.OnClickListener() 
		{
			public void onClick(DialogInterface dialog,int id) {}
		});

		AlertDialog alertDialog = alertDialogBuilder.create();
		if(!isFinishing()) {
			alertDialog.show();
		}
	}

	private final BroadcastReceiver mUsbReceiver = new BroadcastReceiver() 
	{
		public void onReceive(Context context, Intent intent) 
		{
			String action = intent.getAction();
			if (ACTION_USB_PERMISSION.equals(action))
			{
				synchronized (this)
				{
					UsbDevice device = (UsbDevice)intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
					if (intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false))
					{
						if(device != null)
						{
							//call method to set up device communication
							CheckDevice();
						}
					}
	    			else
	    			{
	    				setButtonsEnabled(false);
	    			}
	    		}
	    	}
	    }
	};
}
