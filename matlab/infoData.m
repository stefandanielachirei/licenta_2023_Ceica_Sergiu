% informatii despre date - valori lipsa, varaibile de tip string/ categorical
% 
% [missedValuesIdx, missedValues, values,listCategorical]= infoData(dataRaw)
%
% IN: dataRaw - table creat prin citirea unui fisier de date train.csv sau test.csv
%
% OUT:
%
% missedValuesIdx = array de celule cu indecsii exemplelor (liniilor cuvalori lipsa) pentru fiecare variabila
%  missedValuesIdx{i} pentru coloana i
%
% missedValues = array cu nr total valori lipsa  pentru fiecare variabila
%  missedValues(i) pentru coloana i
%
% values = array de celule cu distrbutia pe clase
%   values(i) pentru coloana i
%
% listCategorical = array de celule care indica ce coloane/variabile sunt
%    de tip string si trebuie convertite la categorical

function [missedValuesIdx, missedValues, values,listCategorical] = infoData(dataRaw)

listCategorical=[]; %initializare - niciun element

% parcurgere table pe coloane pentru gasirea valorilor lipsa etc
for i=2:size(dataRaw,2) %prima colaona este ID pacient - nu trebuie folosita in model
    thisCol = table2array(dataRaw(:,i)); %coloana curenta

    %depisteaza tip data pentru coloana curenta: numeric, sir, categorical
    
    if iscategorical(thisCol) % variabila de tip categorical
        
        missedValuesdx{i}=isundefined(thisCol); % obtine un vector care indica exemplele/liniile cu valori nedefinite
                                                % vectorul are lungimea egala cu nr exemplelor,
                                                % avand elemente egale cu 1 la exemplele undefined si 0 in rest 
        
        missedValues(i)=sum(missedValuesIdx{i});% cate exemple au valoarea nedefinita pentru aceasta variabila

        fprintf(1,'%s, column %g (cat)', dataRaw.Properties.VariableNames{i},i); %afisare informatii pe ecran pentru acesata coloana

        values{i}=tabulate(thisCol); %afiseaza distributia pe categorii/ clase

        fprintf(1,', %g missing values, %g categories  \n', missedValues(i), size(values{i},1)); %afisare informatii pe ecran pentru acesata coloana

    elseif isnumeric(thisCol) % variabila de tip numeric

        for j=1:size(thisCol,1)
            missIdx(j,1)=isempty(thisCol(j)); % obtine un vector care indica exemplele/liniile cu valori lipsa
                                                % vectorul are lungimea egala cu nr exemplelor,
                                                % avand elemente egale cu 1 la exemplele undefined si 0 in rest 


            nanIdx(j,1)=isnan(thisCol(j)); %idem pentru valori nan ("not a number")
        end

        missedValuesIdx{i}= missIdx | nanIdx;
        missedValues(i)=sum(missedValuesIdx{i}); % cate exemple au valoarea nan sau lipsesc pentru aceasta variabila

        fprintf(1,'%s, column %g (num)',dataRaw.Properties.VariableNames{i}, i); %afisare informatii pe ecran pentru acesata coloana
        
        values{i}=[min(thisCol); max(thisCol); mean(thisCol); std(thisCol)]; %in ce interval ia valori aceasta variabila, valoarea medie, std, etc
        
        fprintf(1,', %g wrong values, range [%g, %g],  \n', missedValues(i), min(thisCol),max(thisCol));%afisare informatii pe ecran pentru acesata coloana

    else %string
        listCategorical=[listCategorical,{dataRaw.Properties.VariableNames{i}}]; %adauga numele acestei variabile in listCategorical
        
        thisCol=categorical(thisCol); %converteste la tip categorical
     
        missedValuesIdx{i}=isundefined(thisCol);% obtine un vector care indica exemplele/liniile cu valori nedefinite
                                                % vectorul are lungimea egala cu nr exemplelor,
                                                % avand elemente egale cu 1 la exemplele undefined si 0 in rest 

        missedValues(i)=sum(missedValuesIdx{i}); % cate exemple au valoarea nedefinita pentru aceasta variabila
        
        fprintf(1,'%s, column %g (str)', dataRaw.Properties.VariableNames{i}, i);%afisare informatii pe ecran pentru acesata coloana
       
        values{i}=tabulate(thisCol); %afiseaza distributia pe categorii/ clase
        
        fprintf(1,', %g missing values, %g categories  \n', missedValues(i), size(values{i},1));%afisare informatii pe ecran pentru acesata coloana
    end

end
end