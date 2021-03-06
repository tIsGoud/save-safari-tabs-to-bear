JsOsaDAS1.001.00bplist00�Vscript_�/************************

Export Safari tabs to a Bear note
Version 1.0
November 28, 2017 

Usage:
	Run the script when Safari is open. 
	The x-callback-url mechanism is used to create a new Bear note.

Customization:
	By default the new note is tagged with "bookmarks".

Requirements:
	- Safari installed
	- Bear installed
 
Changelog:
	1.00 by @tisgoud
		First public version

************************/

// Declare the global variables
var title = ""
var tags = "bookmarks"
var text = ""

// Get the Computer Name via the Standard Additions of the current app
currentApp = Application.currentApplication()
currentApp.includeStandardAdditions = true

title = "Safari tabs on " + currentApp.systemInfo().computerName

getBookmarks()

bearCreateNote(title, text, tags)

function getBookmarks() {
	var window = {}, tab = {}
	var numberOfWindows = 0, numberOfTabs = 0
	var totalTabs = 0
	var i,j
	
	browser = Application('Safari')

    if (browser.running()) {
		for (i = 0, numberOfWindows = browser.windows.length; i < numberOfWindows; i++) {
			window = browser.windows[i]
	
			for (j = 0, numberOfTabs = window.tabs.length; j < numberOfTabs; j++) {
				tab = window.tabs[j]
		
				// Convert title and URL to markdown, empty name(title) is replaced by the URL
				text += '- [' + (tab.name().length != 0 ? tab.name() : tab.url()) + ']' + '(' + tab.url() + ')\n'
			}
			totalTabs += numberOfTabs
			// Add a line between the different windows
			text += '---\n\n'
		}
		// Add a sub-tile with the number of windows and tabs.
		text = totalTabs + ' tabs in ' + numberOfWindows + ' windows\n\n' + text
	}
	else {
		text = "no browser running"
	}
}

function bearCreateNote(title, text, tags) {
	var xUrl = ""
	var bear = {}

	// Constructing the bear callback-url
	xUrl = 'bear://x-callback-url/create?title=' + encodeURIComponent(title) + '&text=' + encodeURIComponent(text) + '&tags=' + tags

	bear = Application('Bear')
	bear.includeStandardAdditions = true
	bear.openLocation(xUrl)
}
                              �jscr  ��ޭ