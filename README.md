# COVID-19Model
The forecast model for the COVID-19 epidemic is available for China, Italy, Spain, Germany, France and the UK and soon will be available for other countries. The commits in this git represent the data and prediction considering the data series from the beginning to the described day. The code is written in matlab and requires the matlab fit toobox. To run the code just write evolution_XXXX.m in the matlab command line, where XXX is the country name. 

## Files description:

| File | Description |
| ------------- | ------------- |
 |evolution_china.m | Generates the forecast model for China |
| evolution_italy.m  | Generates the forecast model evolution for Italy| 
| forecast_italy.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for Italy| 
| evolution_spain.m | Generates the forecast model evolution for Spain|
| forecast_spain.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for Spain| 
| evolution_germany.m | Generates the forecast model evolution for Germany|
| forecast_germany.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for Germany| 
| evolution_france.m | Generates the forecast model evolution for France|
| forecast_france.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for France| 
| evolution_uk.m | Generates the forecast model evolution for the UK|
| forecast_uk.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for the UK| 
| comparison.m  |  Generates a forecast comparison, at the equivalent epicemic time,  among countries|
| china.mat  | Data for China|
| italy.mat | Data for Italy|
| spain.mat | Data for Spain|
| germany.mat | Data for Germany|
| france.mat | Data for France|
| UK.mat | Data for the United Kingdom|
