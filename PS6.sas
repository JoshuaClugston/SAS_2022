/*Exercise 13.5*/

data auto;
title 'Automobile Purchase Data';
infile 'Exercise135.csv' firstobs = 2 dlm = ',';
input y x1 x2;
label y = 'Automobile Sold in 6 Months (1=yes,0=no)', x1 = 'Family Income',
	  x2 = 'Age of Oldest Family Vehicle';
run;

ods graphics on;

proc logistic data=auto plots=all;
model y(ref='0') = x1 x2/  plcl plrl waldcl waldrl  
outroc=roc influence iplots ctable ; 
output out=prob predicted=predicted resdev=residual;
run;  

proc print data=prob;
run;

data newobs;
input x1 x2;
datalines;
45000 5
;
run;

data autonew;
set auto newobs;
run;

proc logistic data=autonew plots=all;
model y(ref='0') = x1 x2/  plcl plrl waldcl waldrl  
outroc=roc influence iplots ctable ; 
output out=prob2 predicted=predicted resdev=residual;
run;  

proc print data=prob2;
run;

/* Exercise 14.9 */
data peaches;
title 'Market Share and Price of Canned Peaches';
infile 'Exercise149.csv' firstobs = 2 dlm = ',';
input t xt yt;
label t = 'time', xt = 'Selling Price',
	  yt = 'Market Percentage Share for Brand of Canned Peaches (15 months)';
run;


proc autoreg data=peaches;
title "AR(1) Model for Peaches Data";
model yt= xt/ DWPROB nlag=1;
run;

/* Exercise 14.11 */
data cosmetic;
title 'Cosmetic Sales Data';
infile 'cosmetic.csv' firstobs = 2 dlm = ',';
input t xt yt;
label t = 'time' xt = 'Monthl Sales for Cosmetic Industry'
	  yt = 'Monthly Sales for a Cosmetic Manufacturer';
run;

proc print data=cosmetic;
run;

proc autoreg data=cosmetic;
title "AR(1) Model for Cosmetic Sales Data";
model yt= xt/ DWPROB nlag=1;
run;

/* Exercise 13.25 */

data oring;
title 'Space Shuttle O-Ring Failure Data';
infile 'oring.csv' firstobs=2 dlm=',';
input x1 y;
label x1 = 'Temperatute at Launch' y = 'At Least One O-Ring Failure';
run;
  
proc logistic data=oring plots=all;
model y(ref='1') = x1/ plcl plrl waldcl waldrl  
outroc=roc influence iplots ctable; 
output out=probs predicted=predicted resdev=residual;
run;

symbol1 interpol=spline v=star
c=red;
proc gplot data=probs;
plot predicted*x1;
run;
quit;



proc print data=probs;
run;


data oringnewobs;
input x1;
datalines;
35
50
;
run;

data oringnew;
set oring oringnewobs;
run;

proc logistic data=oringnew plots=all;
model y(ref='1') = x1/ plcl plrl waldcl waldrl  
outroc=roc influence iplots ctable; 
output out=probs2 predicted=predicted resdev=residual;
run;

proc print data=probs2;
run;
