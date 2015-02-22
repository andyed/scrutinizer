// ActionScript file
import com.adobe.images.JPGEncoder;
import com.adobe.images.PNGEncoder;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.filesystem.*;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.setTimeout;
			
			private var file:File;
			private var curHeight:Number = 0;
			private var docsDir:File = File.documentsDirectory;//File.applicationStorageDirectory;//
			private var saveData:BitmapData;
			private var htmlOffscreen:HTMLLoader = new HTMLLoader();

			private function captureScreen(event:Event):void {
				systemManager.removeEventListener(MouseEvent.MOUSE_MOVE ,mousemove,true);
				if(prefAutozoom) {
					trace(">>>> Invoking zoomback remove <<<<<");
					//removeZoomback();
				}
				//curHeight = stage.nativeWindow.height;
				saveFile();
				
			}
			
			private function captureVisibleRegion(event:Event):void
			{
				var bitmapData:BitmapData = new BitmapData(htmlControl.width,htmlControl.height);
				bitmapData.draw(htmlControl,new Matrix());			
				saveCapture(bitmapData);
			}
			
			private function captureEntirePage(event:Event):void
			{
				var vMax:Number = htmlControl.contentHeight;
				var hMax:Number = htmlContainer.width;
				var urlReq:URLRequest = new URLRequest(htmlControl.location);
				htmlOffscreen.addEventListener(Event.COMPLETE,captureEntirePageComplete);
				htmlOffscreen.width = hMax;
				htmlOffscreen.height = vMax;
				htmlOffscreen.load(urlReq);
				
			}
			private function captureEntirePageComplete(event:Event):void
			{
				// Note: Even though COMPLETE has fired (body.onload for new web page) the page may still not be rendered
				htmlOffscreen.removeEventListener(Event.COMPLETE,captureEntirePageComplete);
//				mx.controls.Alert.show(htmlOffscreen.window.document.innerHTML);
				flash.utils.setTimeout(performEntirePageCapture,1000);
				
			}
			private function performEntirePageCapture():void {
				var vMax:Number = htmlControl.contentHeight;
				var hMax:Number = htmlContainer.width;
				var bitmapData:BitmapData = new BitmapData(hMax,vMax);
				bitmapData.draw(htmlOffscreen,new Matrix());			
				saveCapture(bitmapData);
			}
			
			private function captureSelection(event:Event):void
			{
				var vMax:Number = htmlControl.contentHeight;
				var hMax:Number = htmlContainer.width
				var urlReq:URLRequest = new URLRequest(htmlControl.location);
				htmlOffscreen.addEventListener(Event.COMPLETE,captureEntirePageComplete);
				htmlOffscreen.width = hMax;
				htmlOffscreen.height = vMax;
				htmlOffscreen.load(urlReq);
				
			}


			private function saveCapture(data:BitmapData):void 
			{
				try
				{	
					saveData = data;		
				    docsDir.browseForSave("Save As .PNG");
				    docsDir.addEventListener(Event.SELECT, saveCaptureComplete);
				}
				catch (error:Error)
				{
				    trace("Failed:", error.message)
				}
			}
			private function saveCaptureComplete(event:Event) :void 
			{
//				var bitmap : Bitmap = new Bitmap(saveData);
//				stage.addChild(bitmap);
				// Note: JPG Encoding is VERY slow ... implemented in inefficient AS3 port of C code
//				var jpg:JPGEncoder = new JPGEncoder(97);
				var ba:ByteArray = PNGEncoder.encode(saveData);
				var file:File = event.target as File;
				var fileStream :FileStream= new FileStream();
   				fileStream.open(file, FileMode.UPDATE);
				fileStream.writeBytes(ba);
				fileStream.close();
			}
			
			private function saveFile():Boolean
			{
				
				try
				{	
					
				    docsDir.browseForSave("Save As .PNG");
				    docsDir.addEventListener(Event.SELECT, handle_saveFileSelect);
				}
				catch (error:Error)
				{
				    trace("Failed:", error.message)
				}

				return true;
			}	
			
			private function handle_saveFileSelect( event:Event ):void
			{
				var newFile:File = event.target as File;
				
				writeFileToDisk( newFile );
				
			}
			
			private function writeFileToDisk( file:File ):void
			{
				
				var bitmapData:BitmapData = new BitmapData(stage.stageWidth,stage.stageHeight);
				bitmapData.draw(stage,new Matrix());			
				var bitmap : Bitmap = new Bitmap(bitmapData);
				//var jpg:JPGEncoder = new JPGEncoder(97);
				var ba:ByteArray = PNGEncoder.encode(bitmapData);
				//var newImage:File = File.applicationStorageDirectory.resolvePath("Images/" + fileName + ".jpg");
				//trace("creating filestream with " + " " + file.nativePath)
				var fileStream :FileStream= new FileStream();
				//trace("opening file");
   				fileStream.open(file, FileMode.UPDATE);
    	
			//	trace("Writing");
				fileStream.writeBytes(ba);
				//trace("closing");
				//fileStream.writeUTF( saveText.text );
				fileStream.close();
				systemManager.addEventListener(MouseEvent.MOUSE_MOVE ,mousemove,true);
				trace("Reattached mouse listener");
				
			}
			

			