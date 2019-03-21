package io.flutter.plugins;

import android.content.Context;
import android.widget.Toast;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

public class FlutterToastPlugin implements MethodChannel.MethodCallHandler {

    private final Context context;

    public FlutterToastPlugin(Context context){
        this.context = context;
    }

    public static  void regiester(FlutterView registrar,Context context){
        final  MethodChannel channel = new MethodChannel(registrar,"my/toast");
        channel.setMethodCallHandler(new FlutterToastPlugin(context));
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

        if (methodCall.method.equals("toast")){
            String content = methodCall.argument("content");
            Toast.makeText(context,content,Toast.LENGTH_SHORT).show();
            result.success(true);
        }else{
            result.notImplemented();
        }



    }
}
