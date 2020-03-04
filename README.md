# RoutesCheck

iOS app to check road status based on [this API call](https://api.tfl.gov.uk/swagger/ui/index.html?url=/swagger/docs/v1#!/Road/Road_Get).

## Adding appId and appKey

To add the TfL API appId and appKey you need to go to the "Info.plist" file and find the "TFL Keys" dictionary, open it and add 
the corresponding values.

# Building the project

This project doesn't include external libraries, you can build and run it on the simulator just pushing play.

# Find a road

To find a road, you need to tap the Search Field and type one or more roads separated by **","** and press **"Intro"**
* Ex: "A1"
* Ex: "A1,A2"
* Ex: "A1,A2,A3,A4,A10"

> If the Search Field sent is empty the road list will be cleaned.

# Unit tests

* To run the unit tests go to "TfL Coding ChallengeTests" folder, select "StatusViewModelTests.swift" file and choose Product > Perform Action > Test (or "Test Again" in case it was tested before).
* To run an individual test method, click the arrow to the right of the method name in the "StatusViewModelTests.swift" file.

# Folder structure

* **Utils**: I added some useful classes here like a "Box" to bind view model elements with the view controller, preset colors, custom errors and InfoPlistHelper to get the app id and key.
* **Networking**: I added a RequestBuilder to build the URLRequest with a configured scheme, host, path and queryItems and a ServiceLayer to manage the requests.
* **Managers**: I added a RoadManager to ask for the status of a road.
* **Model**: I added some useful models here.
* **Views**: Here I have the table view cell to show the road status.
* **Root**: In the root directory I have the ViewController that I'm using and its ViewModel (StatusViewModel).



