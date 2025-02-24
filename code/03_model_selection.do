*Hausman检验
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN, fe
est store fe_1
*esttab fe_1, keep(lnfdi) mtitle
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN, fe
est store fe_2 
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN, re
est store re_1
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN, re
est store re_2 
hausman fe_1 re_1 //p=0.0452<0.05，拒绝原假设，固定效应模型更好（如果大于0.05，选择随机效应）
hausman fe_2 re_2 //0.0002

*基于bootstrap的hausman检验
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
