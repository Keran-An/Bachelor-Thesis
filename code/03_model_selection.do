*Hausman test
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN, fe
est store fe_1
*esttab fe_1, keep(lnfdi) mtitle
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN, fe
est store fe_2 
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN, re
est store re_1
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN, re
est store re_2 
hausman fe_1 re_1 //p=0.0452<0.05，reject h0，fixed effect(FE) model is better（if bigger than 0.05，choose RE Model）
hausman fe_2 re_2 //p=0.0002

*Bootstrap-based Hausman robustness check
xtreg lninno lnfdi lnfinance lntran lnrd lnindustry lninfo lnOPEN, fe
est store fe_1
*esttab fe_1, keep(lnfdi) mtitle
xtreg lninno lnodi lnfinance lntran lnrd lnindustry lninfo lnOPEN, fe
est store fe_2 
xtreg lninno lnfdi lnfinance lntran lnrd lnindustry lninfo lnOPEN, re
est store re_1
xtreg lninno lnodi lnfinance lntran lnrd lnindustry lninfo lnOPEN, re
est store re_2 
rhausman fe_1 re_1, reps(200) cluster 
rhausman fe_2 re_2, reps(200) cluster 
