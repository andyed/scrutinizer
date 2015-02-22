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


