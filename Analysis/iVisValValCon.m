clear 

%% Values Context increased 
iValCon        =    [1:2];
indexValCon = iValCon;
indexValCon( all(~indexValCon,2), : )  =   [];


clear i
save('iVisiValiValCon.mat')