* Main regression analysis using fixed/random effects models
outreg2 [fe_1 re_1 fe_2 re_2] using 回归结果.doc,replace

* Subgroup regression analyses and comparative results

** Winsorization
winsor2 lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN, replace cuts(1 99)
su lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN

** According to geographical locations, provinces were classified into Eastern, Central, and Western regions.
bysort PROVINCE: xtreg lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN,re

** Subgroup regression
gen 东部 = 0  // Eastern provinces
replace 东部 = 1 if 省份=="北京市" | 省份=="天津市" | 省份=="河北省" | 省份=="上海市" | ///
省份=="江苏省" | 省份=="浙江省" | 省份=="福建省" | 省份=="山东省" | ///
省份=="广东省" | 省份=="海南省" | 省份=="辽宁省"
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN if 东部 == 1, fe
est store dfe_1
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN if 东部 == 1, re
est store dre_2
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN if 东部 == 1, fe
est store dfe_3
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN if 东部 == 1, re
est store dre_4
hausman dfe_1 dre_2
hausman dfe_3 dre_4

gen 中部 = 0 // Central provinces
replace 中部 = 1 if 省份=="山西省" | 省份=="安徽省" | 省份=="江西省" | 省份=="河南省" | 省份=="湖北省" | ///
省份=="湖南省" | 省份=="吉林省" | 省份=="黑龙江省"
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN if 中部 == 1, fe
est store dfe_5
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN if 中部 == 1, re
est store dre_6
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN if 中部 == 1, fe
est store dfe_7
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN if 中部 == 1, re
est store dre_8
hausman dfe_5 dre_6
hausman dfe_7 dre_8

gen 西部 = 0 // Western provinces
replace 西部 = 1 if 省份=="广西壮族自治区" | 省份=="四川省" | 省份=="贵州省" | 省份=="云南省" | 省份=="陕西省" | ///
省份=="甘肃省" | 省份=="内蒙古自治区"| 省份=="重庆市"| 省份=="青海省"| 省份=="新疆维吾尔自治区"| 省份=="宁夏回族自治区" 
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN if 西部 == 1, fe
est store dfe_9
xtreg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN if 西部 == 1, re
est store dre_10
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN if 西部 == 1, fe
est store dfe_11
xtreg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN if 西部 == 1, re
est store dre_12
hausman dfe_9 dre_10
hausman dfe_11 dre_12,sigmamore

outreg2 [dfe_1 dre_2 dfe_5 dre_6 dfe_9 dre_10] using fdi分组回归.doc,replace
outreg2 [dfe_3 dre_4 dfe_7 dre_8 dfe_11 dre_12] using ofdi分组回归.doc,replace

