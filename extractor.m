clc; clear all; close all;
agregados= readtable('agregados.csv');
grupos=findgroups(agregados.FECHA);
Yinfected= splitapply(@sum,agregados.PCR_,grupos);
dates=unique(agregados.FECHA);
dates=dates(~isnat(dates));
dates=datetime(dates,'Format','MMM dd');
clear agregados grupos
save('spain_PCR.mat')