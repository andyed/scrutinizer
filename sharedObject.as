// ActionScript file
import flash.external.*;

//create the local Shared Objects
public var myLocalSO:SharedObject = SharedObject.getLocal("scrutinizerPrefs"); 


//creates and returns a bookmark object with a title and a path
public function makeBookmark(p:String, t:String):Object {
	var temp:Object = new Object();
	temp.path = p;
	temp.title = t;
	return temp;
}


//adds a bookmark object to the shared object
public function addBookmarkToSO(bm:Object): void {
	//keep count of number of bookmarks
	if (myLocalSO.data.totalBookmarks > 0) {
		myLocalSO.data.totalBookmarks++;
	}
	else {
		myLocalSO.data.totalBookmarks = 1;
	}
	//name of this bookmark is bm+'count of bookmarks'
	myLocalSO.data["bm"+myLocalSO.data.totalBookmarks] = bm;
	//trace("bm"+myLocalSO.data.totalBookmarks+" '"+myLocalSO.data["bm"+myLocalSO.data.totalBookmarks].title+"'\n\t at "+myLocalSO.data["bm"+myLocalSO.data.totalBookmarks].path);
	myLocalSO.flush();
	//seeAllBookmarks();
}

public function seeAllBookmarks() :void{
		trace("Listing Bookmarks...");
		for (var i:Number=1; i<=myLocalSO.data.totalBookmarks; i++) {
			trace("Bookmark #"+i+": "+myLocalSO.data["bm"+i].title+"'\n\t"+myLocalSO.data["bm"+i].path);
		}
}
public function emptySO():void {
	myLocalSO.data.totalBookmarks = 0;
	trace("All Bookmarks Deleted");
}
