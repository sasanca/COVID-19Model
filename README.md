# COVID-19Model
The forecast model for the COVID-19 epidemic is presented in the paper [**An Efficient COVID-19 Prediction Model Validated with the Cases of China, Italy and Spain: Total or Partial Lockdowns?**](https://www.mdpi.com/2077-0383/9/5/1547/pdf) which is published in open access. The model is available for China, Italy, Spain, Germany, France and the UK and soon will be available for other countries. The commits in this git represent the data and prediction considering the data series from the beginning to the described day. The code is written in Matlab and requires the Matlab fit toobox. To run the code just write evolution_XXXX.m in the matlab command line, where XXX is the country name. 

The number of infected people has been obtained from the [**John Hopkins**](https://github.com/CSSEGISandData/COVID-19) database for all countries. The PCR+ data for Spain has been obtained from the  [**Carlos III Institute**](https://cnecovid.isciii.es/covid19/resources/agregados.csv) 

## Files description:

| File | Description |
| ------------- | ------------- |
 |evolution_china.m | Generates the forecast model for China |
| evolution_italy.m  | Generates the forecast model evolution for Italy| 
| forecast_italy.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for Italy| 
| evolution_spain.m | Generates the forecast model evolution for Spain|
| evolution_spain_PCR.m | Generates the forecast model evolution for Spain (only PCR+)|
| forecast_spain.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for Spain| 
| evolution_germany.m | Generates the forecast model evolution for Germany|
| forecast_germany.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for Germany| 
| evolution_france.m | Generates the forecast model evolution for France|
| forecast_france.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for France| 
| evolution_uk.m | Generates the forecast model evolution for the UK|
| forecast_uk.m  | Generates forecasts for a 13 or 19 days-to-peak scenario for the UK| 
| comparison.m  |  Generates a forecast comparison, at the equivalent epidemic time,  among countries|
| extractor.m | Script to extract PCR+ data from the [**Carlos III Institute**](https://cnecovid.isciii.es/covid19/resources/agregados.csv) |
| china.mat  | Data for China|
| italy.mat | Data for Italy|
| spain.mat | Data for Spain|
| spain.mat | Data for Spain (only PCR+)|
| germany.mat | Data for Germany|
| france.mat | Data for France|
| UK.mat | Data for the United Kingdom|
