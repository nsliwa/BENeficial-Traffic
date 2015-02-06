Team B.E.N.
Nicole Sliwa
Bre’Shard Busby
Ender Barillas

Project Requirements:
Automatic Layout - yes
Buttons - in setting (triggers immediate location update); in map view to trigger modal view
Sliders - in setting; set radius to search for incidents
Labels - lots of places; some dynamic
Stepper - in settings; set max incidents to display
Switch - in settings; enable / disable location update
Picker - in settings; pick which type of incidents to display in incident list view
Segmented Control - in settings; for minimum severity of incidents displayed in incident list
Timer - updates location data every 60 seconds (unless user-disabled / initiated earlier)
ScrollView - in Incident detail view (to scroll through text under image); map view
Image View - used in incident list view, IncidentDetail view, Map view, Collection view
Navigation Controller - used throughout
Collection View Controller - displays thumbMaps for each incident; can click in to go to IncidentDetail view
Table View Controller with dynamic prototype cells
(E.C.) Modal View - relationship between MapView and CityView; modal works (but in later function prevents UI update - but no crash)

These were primary resources for us:

// The class relationship / structure for the MapQuest API parsing / interface was inspired by a tutorial on AppCoda:
//  http://www.appcoda.com/fetch-parse-json-ios-programming-tutorial/
// A lot of the core-functions for these classes came / was adapted from there:
//  TrafficIncident
//  TrafficIncidentModel
//  MapQuestCommunicator
//  MapQuestCommunicatorDelegate
//  IncidentManager
//  IncidentManagerDelegate
//
// We used these tutorials form Use Your Loaf to help us implement the modal view:
//  http://useyourloaf.com/blog/2010/05/03/ipad-modal-view-controllers.html
//  http://useyourloaf.com/blog/2012/10/08/presenting-view-controllers.html