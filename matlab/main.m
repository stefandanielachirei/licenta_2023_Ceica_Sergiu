clear all % sterge toate variabilele din memorie
close all % inchide toate ferstrele figure
clc       %sterge mesajele afisate in fereastra de comanda


%% Citire date 

% citire date train.csv
dataRawTrain=readtable('train.csv'); % citesc fisierul de date train.csv
                                     % dataRawTrain va fi de tip table

% afisare informatii despre datele din train.csv 
fprintf(1,'\n\n=====TRAIN=====\n')
[missedValuesTrainIdx, missedValuesTrain, values, listCategoricalTrain] = infoData(dataRawTrain);


% citire date test.csv
dataRawTest=readtable('test.csv');

% afisare informatii despre datele din train.csv 
fprintf(1,'\n\n=====TEST=====\n')
[missedValuesTestIdx, missedValuesTest, values, listCategoricalTest]= infoData(dataRawTest);

%conversie variabile de tip string - > categorical
dataRawTrain=convertvars(dataRawTrain,listCategoricalTrain,'categorical');
dataRawTest=convertvars(dataRawTest,listCategoricalTrain,'categorical');

%classUndef=table2array(dataRawTrain(2,2));