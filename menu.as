// ActionScript file
// 	<menuitem label="Quit" data="exit"/>
// 	<menuitem label="Multi-Resolution Preview" data="resolutionPreview"/>
// 	<menuitem type="separator"/>
public var menuBarXML:XMLList = <>
<menuitem label="File">
	<menuitem label="Open Location..." data="openLocation"/>
</menuitem>
<menuitem label="Bookmarks">
	<menuitem label="Add Bookmark" data="addBookmark"/>
	<menuitem label="Delete All Bookmarks" data="deleteBookmarks"/>
	<menuitem type="separator"/>
</menuitem>
<menuitem label="Tools">
	<menuitem label="Capture Screenshot" data="captureScreen"/>
	<menuitem label="Visible Region" data="captureVisibleRegion"/>
	<menuitem label="Entire Page" data="captureEntirePage"/>
	<menuitem label="Selection" data="captureSelection"/>
</menuitem>
<menuitem label="View">
	<menuitem label="Toggle Visualization" id="toggleViz" data="toggleVis" toggled="true" type="check"/>
	<menuitem label="AutoZoom" data="autoZoom" id="toggleZoom" toggled="true" type="check"/>
	<menuitem label="Resize To...">
		<menuitem label="800 x 600" data="resize" w="800" h="600"/>
		<menuitem label="1024 x 768" data="resize" w="1024" h="768"/>
		<menuitem label="1280 x 1024" data="resize"  w="1280" h="1024"/>
		<menuitem label="1600 x 1200" data="resize"  w="1600" h="1200"/>
		<menuitem label="1280 x 720" data="resize"  w="1280" h="720"/>
		<menuitem label="1440 x 990" data="resize"  w="1440" h="990"/>
		<menuitem label="1650 x 1080" data="resize"  w="1650" h="1080"/>
	</menuitem>
</menuitem>
<menuitem label="Help">
	<menuitem label="Getting Started" data="getStarted"/>
	<menuitem label="Top Ten Uses" data="topTen"/>
	<menuitem type="separator"/>
	<menuitem label="About Stomper Scrutinizer" data="about"/>
	<menuitem type="separator"/>
	<menuitem label="Register Scrutinizer" data="registerScrutinizer"/>
	
</menuitem>
</>;

//menuBarXML.appendChild(<menuitem label="Evan"></menuitem>);
 var menuBarCollection = new XMLListCollection(menuBarXML);
/* id="menubar" labelField="@label"
   itemClick="invokeMenuItem(event.item as XML)" */
   var bookmarksAdded = addAllBookmarksToMenu();
   //Append All Bookmarks in the SO to the menu
   private function addAllBookmarksToMenu () {
   	if (myLocalSO.data.totalBookmarks > 0) {
   		for (var i:Number = 1; i<=myLocalSO.data.totalBookmarks; i++) {
   			var newNode:XML = <menuitem/>;
    		newNode.@label = myLocalSO.data["bm"+i].title;
    		newNode.@data = "link";
    		newNode.@url = myLocalSO.data["bm"+i].path;
    		//trace(newNode.toXMLString());
    		var newBM:XMLList = menuBarXML.(@label == "Bookmarks");
    		if( newBM.length() > 0 ) {
    		    newBM[0].appendChild(newNode);
    		}
   		}
   	}    
   }
   //Remove Bookmarks from menu when deleted.
   private function removeBookmarksFromMenu() {
   	var newNode:XML = <menuitem/>;
   	newNode.@label = "Add Bookmark";
	newNode.@data = "addBookmark";
	var newNode2:XML = <menuitem/>;
   	newNode2.@label = "Delete All Bookmarks";
	newNode2.@data = "deleteBookmarks";
	var newNode3:XML = <menuitem/>;
   	newNode3.@type = "separator";
    //<menuitem label="Add Bookmark" data="addBookmark"/>
    //<menuitem label="Delete All Bookmarks" data="deleteBookmarks"></menuitem>
   	//<menuitem type="separator"></menuitem>;
   	var newBM:XMLList = menuBarXML.(@label == "Bookmarks");
    newBM.setChildren(newNode);
    newBM[0].appendChild(newNode2);
    newBM[0].appendChild(newNode3);
   }
   
   
   
   //Append bookmark to the menu xml
   private function addBookmarkToMenu(bm:Object):void {
    var newNode:XML = <menuitem/>;
    newNode.@label = bm.title;
    newNode.@data = "link";
    newNode.@url = bm.path;
    //trace(newNode.toXMLString());
    var newBM:XMLList = menuBarXML.(@label == "Bookmarks");
    if( newBM.length() > 0 ) {
        newBM[0].appendChild(newNode);
    }
}

   function addBookmark():void {
   	var docURL:String = htmlControl.htmlLoader.location;
   	var docTitle:String = htmlControl.htmlLoader.window.document.title;
   	addBookmarkToSO(makeBookmark(docURL, docTitle));
   	addBookmarkToMenu(makeBookmark(docURL, docTitle));
   	//trace("At " + docURL + " with title: " + docTitle);
   	//makeXMLFromBookmarks();
   }
   function deleteBookmarks():void {
   	emptySO();
   	removeBookmarksFromMenu();
   }
   function bookmarkLink(loc:String):void {
	htmlControl.location = loc;
}

private function fileMenuHandler(event:MenuEvent):void
{
	trace("file menu handler invoked");
	//for(var i in event) trace(i);
	trace(event.item.@data);

	var action:String = event.item.@data;
	switch(action) {
		case "openLocation":
			trace("Opening loc");
			urlTxt.text = "";
			urlTxt.focusManager.setFocus(urlTxt);
					
			break;
		case "autoZoom":
			//trace("Auto zoom " + event.item.@toggled);
			/*if( event.item.@toggled) {
				prefAutozoom =true;
			} else {
				prefAutozoom = false;
				
			} */
			prefAutozoom = !prefAutozoom;
			trace("Pref autozoom " + prefAutozoom);
			//toggleZoom.toggled = prefAutozoom;
			toggleOverlay();
			toggleOverlay();
			break;
		case "about":
			showAbout();
		case "toggleVis":
			toggleOverlay();
			break;
		case "resize": 
			stage.nativeWindow.height = event.item.@h;
			stage.nativeWindow.width = event.item.@w;
			grabScreen();
			break;
		case "captureScreen": 
			captureScreen(event);
			break;
		case "captureVisibleRegion": 
			captureVisibleRegion(event);
			break;
		case "captureEntirePage": 
			captureEntirePage(event);
			break;
		case "captureSelection": 
			captureSelection(event);
			break;
		case "exit":
			
			break;
		case "addBookmark":
			addBookmark();
			break;
		case "deleteBookmarks":
			deleteBookmarks();
			break;
		case "getStarted":
			htmlControl.location = "http://about.stompernet.com/scrutinizer/gettingstarted?src=help";
			break;
		case "topTen":
			htmlControl.location = "http://about.stompernet.com/scrutinizer/topten?src=help";
			break;
		case "link":
			bookmarkLink(event.item.@url);
			break;
	}
}

function createContextMenu(fsCM):ContextMenu {
		fsCM.addEventListener(ContextMenuEvent.MENU_SELECT, menuHandler);
				fsCM.hideBuiltInItems();
				

				fs = new ContextMenuItem("Go Back" );
			
				fs.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, goBackContext);
				fsCM.customItems.push( fs );
				
				fs = new ContextMenuItem("Capture Screenshot" );
				fs.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, captureScreen);
				fs.keyEquivalent = "S";
				fsCM.customItems.push( fs );
				
			
				
				fs = new ContextMenuItem("Go Full Screen" );
				fs.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, goFullScreen);
				fsCM.customItems.push( fs );
				
				xfs = new ContextMenuItem("Exit Full Screen");
				xfs.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, exitFullScreen);
				fsCM.customItems.push( xfs );
return fsCM;
}
