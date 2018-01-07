# Performance Data

The following are the functions which work against the StatusCake API  

### Get-StatusCakeHelperPerformanceData
This cmdlet retrieves a list of tests that have been carried out for a given uptime test. 

```powershell
Get-StatusCakeHelperPerformanceData @StatusCakeAuth -TestID 123456 -Limit 5 -Start "2018-01-07 10:14:00"
```
![get-statuscakehelperperformancedata](https://user-images.githubusercontent.com/30263630/34648658-92e6e36c-f395-11e7-8122-ac9a5bbe000a.png)

Not specifying a start date will return the results collated by unix time

```powershell
Get-StatusCakeHelperPerformanceData @StatusCakeAuth -TestID 123456 -Limit 5
```
![get-statuscakehelperperformancedata2](https://user-images.githubusercontent.com/30263630/34648672-f1951b18-f395-11e7-9b3f-80691d96c6ff.png)


# Authors
- Oliver Li