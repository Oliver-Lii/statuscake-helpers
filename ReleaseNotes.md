# Release Notes

## Release 4.0

This release makes changes to the authentication parameters used by the functions, standardizes the outputs, brings more of the code in-line with Powershell conventions and implements a number of PSScript Analyzer recommendations.

## All sections

*  Username and ApiKey parameters have been replaced by APICredential parameter
*  baseURL parameter has been removed
*  Calls to StatusCake API are carried out by Invoke-RestMethod instead of Invoke-WebRequest
*  Parameter names have standardized to Pascal case and the previous parameter names have been configured as aliases
*  All parameter variables are strongly typed
*  Outputs from New and Set functions are consistent with outputs from equivalent Get function or Get*-*Detail function

## Summary of function changes

| Function name                             	| Status                                                                    	|
|-------------------------------------------	|---------------------------------------------------------------------------	|
| Get-StatusCakeHelperSentAlerts            	| Renamed - Get-StatusCakeHelperSentAlert                                   	|
| Get-StatusCakeHelperAllContactGroups      	| Deprecated - functionality moved to Get-StatusCakeHelperContactGroup      	|
| Get-StatusCakeHelperAllMaintenanceWindows 	| Deprecated - functionality moved to Get-StatusCakeHelperMaintenanceWindow 	|
| Get-StatusCakeHelperAllPageSpeedTests     	| Deprecated - functionality moved to Get-StatusCakeHelperPageSpeedTest     	|
| Get-StatusCakeHelperProbes                	| Renamed - Get-StatusCakeHelperProbe                                       	|
| Get-StatusCakeHelperRegionProbes          	| Renamed - Get-StatusCakeHelperRegionProbe                                 	|
| Get-StatusCakeHelperAllSSLTests           	| Deprecated - functionality moved to Get-StatusCakeHelperSSLTest           	|
|                                           	|                                                                           	|
| Add-StatusCakeHelperTestNodeLocations     	| Renamed - Add-StatusCakeHelperTestNodeLocation                            	|
| Add-StatusCakeHelperTestStatusCodes       	| Renamed - Add-StatusCakeHelperTestStatusCode                              	|
| Add-StatusCakeHelperTestTags              	| Renamed - Add-StatusCakeHelperTestTag                                     	|
| Get-StatusCakeHelperAllTests              	| Deprecated - functionality moved to Get-StatusCakeHelperTest              	|
| Get-StatusCakeHelperPausedTests           	| Renamed - Get-StatusCakeHelperPausedTest                                  	|
| Get-StatusCakeHelperDetailedTestData      	| Renamed - Get-StatusCakeHelperTestDetail                                  	|
| Remove-StatusCakeHelperTestNodeLocations  	| Renamed - Remove-StatusCakeHelperTestNodeLocation                         	|
| Remove-StatusCakeHelperTestStatusCodes    	| Renamed - Remove-StatusCakeHelperTestStatusCode                           	|
| Remove-StatusCakeHelperTestTags           	| Renamed - Remove-StatusCakeHelperTestTag                                  	|

## Authentication

### Set-StatusCakeHelperAPIAuth
*  Credentials for the StatusCake API can now be set per session to avoid credentials being stored on disk using the session switch
*  Credential parameter has been renamed from Credentials to Credential
*  The credential location on disk has moved from \statuscake-helpers to \.statuscake-helpers

## Alerts

### Get-StatusCakeHelperSentAlerts
*  Function renamed to Get-StatusCakeHelperSentAlert

## ContactGroups

### Copy-StatusCakeHelperContactGroup
*  ContactID parameter is now cast to integer
*  GroupName and NewGroupName parameters are cast to string

### Get-StatusCakeHelperContactGroup
*  All contact groups can be retrieved when function is called with no parameters

### Get-StatusCakeHelperAllContactGroups
*  Function has been removed and functionality moved to Get-StatusCakeHelperContactGroup

### New-StatusCakeHelperContactGroup
*  Email and Mobile parameters are cast to string array
*  GroupName and PingURL parameters are cast to string
*  DesktopAlert parameter is now cast to boolean
*  Output from this function is now consistent with an object returned from Get-StatusCakeHelperContactGroup

### Remove-StatusCakeHelperContactGroup
*  Output from this function is now consistent with an object returned from Get-StatusCakeHelperContactGroup when PassThru switch is used

### Set-StatusCakeHelperContactGroup
*  Output from this function is now consistent with an object returned from Get-StatusCakeHelperContactGroup

## Maintenance Windows

### Clear-StatusCakeHelperMaintenanceWindow
*  Remove ByName switch which was not used

### Get-StatusCakeHelperMaintenanceWindow
*  All maintenance windows can be retrieved when function is called with no parameters

### Get-StatusCakeHelperAllMaintenanceWindows
*  Function has been removed and functionality moved to Get-StatusCakeHelperMaintenanceWindow

### New-StatusCakeHelperMaintenanceWindow
*  Create alias for raw_tests and raw_tags as TestIDs and TestTags respectively
*  TestIDs parameter is cast to integer array
*  TestTags parameters is cast to string array
*  FollowDST parameter is now cast to boolean
*  RecurEvery parameter is now cast to integer
*  Output from this function is now consistent with an object returned from Get-StatusCakeHelperMaintenanceWindow

### Remove-StatusCakeHelperMaintenanceWindow
*  Add Passthru switch
*  Change Series parameter from boolean to switch
*  When Passthru switch is used output from this function is now consistent with an object returned from Get-StatusCakeHelperMaintenanceWindow

### Update-StatusCakeHelperMaintenanceWindow
*  Create alias for raw_tests and raw_tags as TestIDs and TestTags respectively
*  TestIDs parameter is cast to integer array
*  TestTags parameters is cast to string array
*  FollowDST parameter is now cast to boolean
*  RecurEvery parameter is now cast to integer
*  Output from this function is now consistent with an object returned from Get-StatusCakeHelperMaintenanceWindow

## PageSpeed

### Copy-StatusCakeHelperPageSpeedTest
*  Update variable types for Name, NewName and WebsiteURL parameters to string
*  Update variable types for ID parameter to int

### Get-StatusCakeHelperAllPageSpeedTests
*  Removed function. Functionality has been moved to Get-StatusCakeHelperPageSpeedTest

### Get-StatusCakeHelperPageSpeedTest
*  All maintenance windows can be retrieved when function is called with no parameters
*  Add Detailed parameter to allow detailed information about a test to be retrieved
*  Add functionality to collate detailed responses for each test returned if detailed switch is used

### Get-StatusCakeHelperPageSpeedTestDetail
*  Function added to retrieve detailed data about a page speed test by ID

### New-StatusCakeHelperPageSpeedTest
*  Change output to return page speed object consistent with Get-StatusCakeHelperPageSpeedTestDetail

### Remove-StatusCakeHelperPageSpeedTest
*  Add Passthru switch to return Page Speed object

### Set-StatusCakeHelperPageSpeedTest
*  Update variable types for Name and LocationISO parameters to string
*  Update variable types for ID and Checkrate parameters to integer
*  Create alias for contact_groups parameter as ContactIDs
*  Update variable types for ContactIDs parameter to int array
*  Change output to return page speed object consistent with Get-StatusCakeHelperPageSpeedTestDetail

## PerformanceData

### Get-StatusCakeHelperPerformanceData
*  Update variable type for Fields parameter to string array
*  Update variable type for Limit parameter to integer
*  Change output to return a list object when the start switch is not used

## Probes

### Get-StatusCakeHelperProbes
* Renamed to Get-StatusCakeHelperProbe as per PS Script Analyzer recommendations
* Removed StatusCakeXMLURL parameter
* Change output to return a List object with the list of probes

### Get-StatusCakeHelperRegionProbes
* Renamed to Get-StatusCakeHelperRegionProbe as per PS Script Analyzer recommendations

## PublicReporting

### Copy-StatusCakeHelperPublicReportingPage
*  Update variable types for Title, Id and NewTitle parameters to string

### Get-StatusCakeHelperPublicReportingPage
*  Add Detailed parameter to allow detailed information about a public page to be retrieved
*  Add functionality to collate detailed responses for each public page returned if detailed switch is used

### Get-StatusCakeHelperPublicReportingPageDetail
*  Function added to retrieve detailed data about a public reporting page

### New-StatusCakeHelperPublicReportingPage
*  Update variable types for Title and CName parameters to string
*  Update variable types for DisplayAnnotations, DisplayOrbs, SearchIndexing, SortAlphabetical, TagsInclusive to boolean
*  Remove use_tags and tests_or_tags parameters
*  Add parameters TestTags and TestIDs
*  Function should be called with TestTags or TestIDs parameters to associate tests with Public Reporting page. Previously use_tags switch was required to set whether tags or test IDs were being sent to be associated with public reporting page
*  Change output to return a object consistent with Get-StatusCakeHelperPublicReportingPageDetail

### Remove-StatusCakeHelperPublicReportingPage
* Add Passthru switch to return public reporting page

### Set-StatusCakeHelperPublicReportingPage
*  Update variable types for Title and CName parameters to string
*  Update variable types for DisplayAnnotations, DisplayOrbs, SearchIndexing, SortAlphabetical, TagsInclusive to boolean
*  Remove use_tags and tests_or_tags parameters
*  Add parameters TestTags and TestIDs
*  Function should be called with TestTags or TestIDs parameters to associate tests with Public Reporting page. Previously use_tags switch was required to set whether tags or test IDs were being sent to be associated with public reporting page
*  Change output to return a object consistent with Get-StatusCakeHelperPublicReportingPageDetail

## SSL

### Copy-StatusCakeHelperSSLTest
*  Update variable types for ID and Checkrate to integer
*  Update variable types for Domain and NewDomain to string

### Get-StatusCakeHelperAllSSLTests
*  Function removed. Functionality has been moved to Get-StatusCakeHelperSSLTest

### Get-StatusCakeHelperSSLTest
*  All SSL Tests can be retrieved when function is called with no parameters

### New-StatusCakeHelperSSLTest
*  Create alias for contact_groups parameter as ContactIDs
*  Update variable type of ContactIDs and AlertAt parameters to integer array
*  Update variable type of AlertExpiry, AlertReminder, AlertBroken, AlertMixed parameters to boolean
*  Change output to return a object consistent with Get-StatusCakeHelperSSLTest

### Set-StatusCakeHelperSSLTest
*  Update variable type of Checkrate parameter to integer
*  Create alias for contact_groups parameter as ContactIDs
*  Update variable type of ContactIDs and AlertAt parameters to integer array
*  Update variable type of AlertExpiry, AlertReminder, AlertBroken, AlertMixed parameters to boolean
*  Change output to return a object consistent with Get-StatusCakeHelperSSLTest

## Tests

### Add-StatusCakeHelperTestNodeLocations
*  Renamed function to Add-StatusCakeHelperTestNodeLocation to remove use of plural noun as per PS script analyzer recommendations
*  Update variable type for TestID parameter to integer
*  Update variable type for variable TestName parameter to string

### Add-StatusCakeHelperTestStatusCodes
*  Renamed function to Add-StatusCakeHelperTestStatusCode to remove use of plural noun as per PS script analyzer recommendations
*  Update variable type for TestID parameter to integer
*  Update variable type for TestName parameter to string

### Add-StatusCakeHelperTestTags
*  Renamed function to Add-StatusCakeHelperTestTag to remove use of plural noun as per PS script analyzer recommendations
*  Update variable type for TestID parameter to integer
*  Update variable type for TestName parameter to string

### Copy-StatusCakeHelperTest
*  Update variable type of TestId parameter to integer
*  Update variable type of TestName, TestURL, NewTestName, AlertMixed parameters to String
*  Update variable type of Paused to Boolean

### Get-StatusCakeHelperAllTests
*  Removed function. Functionality has been moved to Get-StatusCakeHelperTest

### Get-StatusCakeHelperTest
*  Add Detailed parameter to allow detailed information about a test to be retrieved
*  Add parameters ContactID, Status, Tags, MatchAny for to support handling capability from the Get-StatusCakeHelperAllTests function
*  Update function to utilize Get-StatusCakeHelperParameterValue and Get-StatusCakeHelperAPIParameter parameter handling functions

### Get-StatusCakeHelperPausedTests
*  Renamed function to Get-StatusCakeHelperPausedTest to remove use of plural noun as per PS script analyzer recommendations
*  Update function to utilize Get-StatusCakeHelperParameterValue and Get-StatusCakeHelperAPIParameter parameter handling functions

### Get-StatusCakeHelperDetailedTestData
*  Function has been renamed to Get-StatusCakeHelperTestDetail

### New-StatusCakeHelperTest
*  Update variable type of TestName, TestURL, LogoImage, PingURL parameters to string
*  Update variable type of CheckRate, Confirmation and Port parameters to Int
*  Update variable type of ContactGroup, StatusCodes parameters to integer array
*  Update variable type of Branding, DoNotFind, EnableSSLWarning, FollowRedirect, Paused, Public, RealBrowser, Virus parameters to boolean
*  Update variable type of NodeLocations and Tags parameters to string array
*  Change output to return a object consistent with Get-StatusCakeHelperTestDetail

### Remove-StatusCakeHelperTest
*  Retrieve detailed test object to return object consistent with Get-StatusCakeHelperTestDetail

### Remove-StatusCakeHelperTestNodeLocations
*  Renamed function to Remove-StatusCakeHelperTestNodeLocation to remove use of plural noun as per PS script analyzer recommendations
*  Update variable type for TestID parameter to integer
*  Update variable type for TestName parameter to string

### Remove-StatusCakeHelperTestStatusCodes
*  Renamed function to Remove-StatusCakeHelperTestStatusCode to remove use of plural noun as per PS script analyzer recommendations
*  Update variable type for TestID parameter to integer
*  Update variable type for TestName parameter to string

### Remove-StatusCakeHelperTestTags
*  Renamed function to Remove-StatusCakeHelperTestTag to remove use of plural noun as per PS script analyzer recommendations
*  Update variable type for TestID parameter to integer
*  Update variable type for TestName parameter to string

### Resume-StatusCakeHelperTest
*  Update variable type for TestID parameter to integer
*  Update variable type for TestName parameter to string

### Set-StatusCakeHelperTest
*  Update variable type of TestName, TestURL, LogoImage, PingURL parameter to string
*  Update variable type of CheckRate, Confirmation and Port parameter to Int
*  Update variable type of ContactGroup, StatusCodes parameter to integer array
*  Update variable type of Branding, DoNotFind, EnableSSLWarning, FollowRedirect, Paused, Public, RealBrowser, Virus parameter to boolean
*  Update variable type of NodeLocations and Tags parameter to string array
*  Change output to return a object consistent with Get-StatusCakeHelperTestDetail

### Suspend-StatusCakeHelperTest
*  Update variable type for TestID parameter to integer
*  Update variable type for TestName parameter to string

