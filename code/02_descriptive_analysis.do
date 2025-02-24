*Descriptive statistics and correlation analysis
sum inno fdi odi finance transport industry info lnOPEN
logout, save(Descriptive statistics) word replace:sum inno fdi ///
odi finance transport rd industry info OPEN

logout, save(correlation analysis)word replace: pwcorr_a lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN

*Multicollinearity check (Variance Inflation Factor - VIF)
reg lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN
vif
logout, save(VIF)word replace: vif //VIF<10，then can be regressed

*winsorization
winsor2 lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN, replace cuts(1 99)
su lninno lnfdi lnodi lnfinance lntran lnrd lnindustry lninfo lnOPEN
