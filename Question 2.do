clear all
cd "C:\Users\agwww\OneDrive\Documents\MSc\Empirical Finance"
cap log using "dofileq2.txt", append
use "dataq2"

//Part A - Stationarity Test

//ADF test. The ", trend" is included as there is a trend over time of the variable. 

dfuller lnpce, trend
dfuller lnpce, lags(1) trend 
dfuller lnpce, lags(2) trend

dfuller lnpnfi, trend
dfuller lnpnfi, lags(1) trend
dfuller lnpnfi, lags(2) trend

dfuller lngdp, trend
dfuller lngdp, lags(1) trend
dfuller lngdp, lags(2) trend

twoway (line lnpce qdate), xlabel(, format(%tq) nogrid angle(45)) ylabel(, nogrid) xtitle("Date - Quarterly") ytitle("Natural Logarithm of Consumption - Ln(pce)") legend(off) graphregion(color(white)) plotregion(style(none))

//Part B - Cointegration test

//There is no working direct command in stata so this is done manually. The two variables suspected to be cointegrated are regressed upon each other, the residuals saved, and an ADF test imparted on these residuals. If the residuals are stationary we have a cointegrating relationship, otherwise we do not.

regress lngdp lnpce
predict resid1, residuals
varsoc resid1
dfuller resid1, lags(1)

regress lnpce lnpnfi
predict resid2, residuals
varsoc resid2
dfuller resid2, lags(3)

regress lngdp lnpnfi
predict resid3, residuals 
varsoc resid3
dfuller resid3, lags(2)

//Part C - DONE IN MATLAB - CODE IN ZIP FILE

//Graph is below

gen ymin = .
gen ymax = .
gen ymin1 = .
gen ymax1 = .
gen ymin2 = .
gen ymax2 = .
gen ymin3 = .
gen ymax3 = .
gen ymin4 = .
gen ymax4 = .
gen ymin5 = .
gen ymax5 = .
gen ymin6 = .
gen ymax6 = .
gen ymin7 = .
gen ymax7 = .

replace ymin = 0 if missing(ymin) & inrange(qdate, tq(1969q2), tq(1971q1))
replace ymax = 4.2  if missing(ymax) & inrange(qdate, tq(1969q2), tq(1971q1))

replace ymin1 = 0 if missing(ymin) & inrange(qdate, tq(1973q4), tq(1975q2))
replace ymax1 = 4.2  if missing(ymax) & inrange(qdate, tq(1973q4), tq(1975q2))

replace ymin2 = 0 if missing(ymin) & inrange(qdate, tq(1979q2), tq(1980q3))
replace ymax2 = 4.2  if missing(ymax) & inrange(qdate, tq(1979q2), tq(1980q3))

replace ymin3 = 0 if missing(ymin) & inrange(qdate, tq(1982q2), tq(1982q3))
replace ymax3 = 4.2  if missing(ymax) & inrange(qdate, tq(1982q2), tq(1982q3))

replace ymin4 = 0 if missing(ymin) & inrange(qdate, tq(1989q4), tq(1991q2))
replace ymax4 = 4.2  if missing(ymax) & inrange(qdate, tq(1989q4), tq(1991q2))

replace ymin5 = 0 if missing(ymin) & inrange(qdate, tq(2001q1), tq(2001q4))
replace ymax5 = 4.2  if missing(ymax) & inrange(qdate, tq(2001q1), tq(2001q4))

replace ymin6 = 0 if missing(ymin) & inrange(qdate, tq(2007q4), tq(2009q3))
replace ymax6 = 4.2  if missing(ymax) & inrange(qdate, tq(2007q4), tq(2009q3))

replace ymin7 = 0 if missing(ymin) & inrange(qdate, tq(2020q1), tq(2020q3))
replace ymax7 = 4.2  if missing(ymax) & inrange(qdate, tq(2020q1), tq(2020q3))

twoway  (rarea ymin1 ymax1 qdate, color(gs14)) (rarea ymin2 ymax2 qdate, color(gs14)) (rarea ymin3 ymax3 qdate, color(gs14)) (rarea ymin4 ymax4 qdate, color(gs14)) (rarea ymin5 ymax5 qdate, color(gs14)) (rarea ymin6 ymax6 qdate, color(gs14)) (rarea ymin7 ymax7 qdate, color(gs14)) (rarea ymin ymax qdate, color(gs14)) (line volatility qdate, lcolor(blue)), xlabel(, angle(45) format(%tq) nogrid) ylabel(, nogrid) xtitle("Date (Quarters)") ytitle("Quarterly Volatility") legend(off) graphregion(color(white)) 

//Part D - Predictive Regressions

//Generating the first difference of the three main variables. These are growth rates. ADF test of these shows them to be stationary, as expected.

gen fdlnpce = D.lnpce
gen fdlnpnfi = D.lnpnfi
gen fdlngdp = D.lngdp

dfuller fdlnpce
dfuller fdlnpnfi
dfuller fdlngdp

twoway (line fdlnpce qdate), xlabel(, format(%tq) nogrid) ylabel(, nogrid) xtitle("Date - Quarters") ytitle("First Difference of Ln(pce)") legend(off) graphregion(color(white)) plotregion(style(none))

//Generating a forward variable at the reuqired lags of 1 quarter (1q), 2 quarters (2q), 1 year (1y), 2 years (2y) and 4 years (4y). The command "FX." generates this forward by X amount of data periods. So, 4 years is 16 quarters so "F16."

gen gdpgrowth1q  = F1.fdlngdp 
gen gdpgrowth2q  = F2.fdlngdp
gen gdpgrowth1y = F4.fdlngdp
gen gdpgrowth2y = F8.fdlngdp
gen gdpgrowth4y = F16.fdlngdp

gen pcegrowth1q  = F1.fdlnpce
gen pcegrowth2q  = F2.fdlnpce
gen pcegrowth1y = F4.fdlnpce
gen pcegrowth2y = F8.fdlnpce
gen pcegrowth4y = F16.fdlnpce

gen pnfigrowth1q  = F1.fdlnpnfi
gen pnfigrowth2q  = F2.fdlnpnfi
gen pnfigrowth1y = F4.fdlnpnfi
gen pnfigrowth2y = F8.fdlnpnfi
gen pnfigrowth4y = F16.fdlnpnfi

gen volatility1q  = F1.volatility
gen volatility2q  = F2.volatility
gen volatility1y = F4.volatility
gen volatility2y = F8.volatility
gen volatility4y = F16.volatility

gen credspread1q  = F1.credspread
gen credspread2q  = F2.credspread
gen credspread1y = F4.credspread
gen credspread2y = F8.credspread
gen credspread4y = F16.credspread

//Predictive Regressions

reg gdpgrowth1q credspread1q pnfigrowth1q pcegrowth1q, robust
outreg2 using "result.tex", append dec(3)

reg gdpgrowth2q credspread2q pnfigrowth2q pcegrowth2q, robust
outreg2 using "result.tex", append dec(3)

reg gdpgrowth1y credspread1y pnfigrowth1y pcegrowth1y, robust
outreg2 using "result.tex", append dec(3)
 
reg gdpgrowth2y credspread2y pnfigrowth2y pcegrowth2y, robust
outreg2 using "result.tex", append dec(3)

reg gdpgrowth4y credspread4y pnfigrowth4y pcegrowth4y, robust
outreg2 using "result.tex", append dec(3)

reg gdpgrowth1q volatility1q pnfigrowth1q pcegrowth1q, robust
outreg2 using "result1.tex", append dec(3)

reg gdpgrowth2q volatility2q pnfigrowth2q pcegrowth2q, robust
outreg2 using "result1.tex", append dec(3)

reg gdpgrowth1y volatility1y pnfigrowth1y pcegrowth1y, robust
outreg2 using "result1.tex", append dec(3)

reg gdpgrowth2y volatility2y pnfigrowth2y pcegrowth2y, robust
outreg2 using "result1.tex", append dec(3)

reg gdpgrowth4y volatility4y pnfigrowth4y pcegrowth4y, robust
outreg2 using "result1.tex", append dec(3)



