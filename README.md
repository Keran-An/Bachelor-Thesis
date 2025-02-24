# Bachelor-Thesis: Study on the Impact of Two-way FDI on China's Innovation Capability

# Description
In the process of deepening Reform and Opening up, China’s development strategy of "Bring in and Go out" has made significant progress, and the scale of utilizing Foreign Direct Investment and Outward Foreign Direct Investment has been increasing, with remarkable achievements in economic development. In order to further enhance its competitive advantage in the world market, China has repeatedly emphasized the strategy of "Scientific and Technological Powerhouse", actively developing high-tech industries and improving its independent R&D capability. As an important channel for China to contact with the world's frontier technology, two-way FDI is always important for the improvement of China's innovation ability. The study of how to improve China's innovation capability through two-way FDI is of strong practical significance to release the technological dividend of two-way FDI and promote China's technological progress.

# Data Resource
- (Raw data not publicly available due to restrictions.)
- The total amount of Inward Foreign Direct Investment (IFDI) for each province (including municipalities and autonomous regions) was obtained from statistical data provided by the Ministry of Commerce of the People's Republic of China.
- Data on outward non-financial direct investment flows was collected from the Statistical Bulletin of China's Outward Foreign Direct Investment. - Provincial patent applications and the number of personnel involved in R&D activities were sourced from the annual editions of the China Statistical Yearbook on Science and Technology.
- Annual average RMB exchange rates, total imports and exports, industrial value-added, regional GDP, and the number of broadband internet subscribers for each province were taken from the China Statistical Yearbook.
- Data on total lengths of highways and railways, as well as provincial land area sizes, were acquired from the official website of the National Bureau of Statistics of China.
- Finally, outstanding loans of financial institutions for each province were sourced from the China Financial Yearbook and the People's Bank of China.

  
clear
cd "F:\毕业论文\数据\数据整合"
import excel using "数据集.xlsx", first clear
browse

# Data Cleaning
*对数处理
gen lninno=ln(inno)
gen lnfdi=ln(fdi)
gen lnodi=ln(odi)
gen lnfinance=ln(finance)
gen lntran=ln(transport)
*gen lnrd=ln(rd)
gen lnindustry=ln(industry)
gen lninfo=ln(info)
gen lnhcapital=ln(hcapital)
gen lnOPEN=ln(OPEN)

*面板
encode 省份, gen(PROVINCE)
xtset PROVINCE YEAR
*描述统计
 sum inno fdi odi finance transport industry info lnOPEN
logout, save(描述性统计) word replace:sum inno fdi ///
odi finance transport rd industry info OPEN

*相关性分析
logout, save(相关分析)word replace: pwcorr_a lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN

*共线性检验/多重共线性
reg lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN
vif
logout, save(共线性检验)word replace: vif //VIF结果小于10，就可以做回归分析

*缩尾
winsor2 lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN, replace cuts(1 99)
su lninno lnfdi lnodi lnfinance lntran lnrd lnindustry lninfo lnOPEN

# Basic Model
This model provides a brief overview of two-way FDI and innovation capability and the transmission mechanism between them, adopts a research method combining theory and practice, selects panel data of 30 provinces (municipalities or autonomous regions) in China except Tibet from 2008-2019, takes two-way FDI as the explanatory variable, takes China's innovation capability as the explanatory variable, introduces industrialization level, financial development level, openness to the outside world, transportation infrastructure construction and information level as control variables, and construct a fixed-effects model for overall regression and group regression. 

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

*输出
outreg2 [fe_1 re_1 fe_2 re_2] using 回归结果.doc,replace


*各省份分别做回归，找到在不同省份之间，各个变量的重要程度
*缩尾
winsor2 lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN, replace cuts(1 99)
su lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN
*东中西部分组
bysort PROVINCE: xtreg lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN,re
*进行回归
gen 东部 = 0
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

gen 中部 = 0
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

gen 西部 = 0
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

# Mediating Model
At the same time, human capital level is used as the mediating variable to construct a mediating model to analyze how two-way FDI affects China's human capital level and thus improves China's innovation capability.
*中介效应
*fdi 三步回归和sobel
**三步回归
reg lninno lnfdi lnfinance lntran lnindustry lninfo lnOPEN //y=cX+e1, y与x的回归
est store zhubu1
reg lnhcapital lnfdi lnfinance lntran lnindustry lninfo lnOPEN //M=aX+e2，中介变量M与x的回归
est store zhubu2
reg lninno lnhcapital lnfdi lnfinance lntran lnindustry lninfo lnOPEN //y=c‘X+bM+e3，所有的回归
est store zhubu3
**sobel检验
sgmediation lninno,iv(lnfdi) mv(lnhcapital) cv(lnfinance lntran lnindustry lninfo lnOPEN)
est store sobel_1
**结果导出
outreg2 [zhubu1 zhubu2 zhubu3 sobel_1] using zhubufdi.doc, replace

*ofdi 三步回归和sobel
**三步回归
reg lninno lnodi lnfinance lntran lnindustry lninfo lnOPEN //y=cX+e1, y与x的回归
est store zhubu4
reg lnhcapital lnodi lnfinance lntran lnindustry lninfo lnOPEN //M=aX+e2，中介变量M与x的回归
est store zhubu5
reg lninno lnhcapital lnodi lnfinance lntran lnindustry lninfo lnOPEN //y=c‘X+bM+e3，所有的回归
est store zhubu6
**sobel检验
sgmediation lninno,iv(lnodi) mv(lnhcapital) cv(lnfinance lntran lnindustry lninfo lnOPEN)
est store sobel_2
**结果导出
outreg2 [zhubu4 zhubu5 zhubu6 sobel_2] using zhubuodi.doc, replace

quietly reg lninno lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN
est store zhubu1
quietly reg lnhcapital lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN
est store zhubu2
quietly reg lninno lnhcapital lnfdi lnodi lnfinance lntran lnindustry lninfo lnOPEN
est store zhubu3
outreg2 [zhubu1 zhubu2 zhubu3] using zhubu.doc, replace

**sobel检验
sgmediation lninno,iv(lnfdi) mv(lnhcapital) cv(lnfinance lntran lnindustry lninfo lnOPEN)
est store sobel_1
sgmediation lninno,iv(lnodi) mv(lnhcapital) cv(lnfinance lntran lnindustry lninfo lnOPEN) 
est store sobel_2
outreg2 [sobel_1 sobel_2] using sobel.doc,replace

//人力资本水平做中介变量时fdi和ofdi都显著（做）
quietly sgmediation lninno,iv(lnfdi) mv(lnhcapital) cv(lnfinance lntran lnindustry lninfo lnOPEN)
outreg2 using sobelfdi, word replace
quietly sgmediation lninno,iv(lnodi) mv(lnhcapital) cv(lnfinance lntran lnindustry lninfo lnOPEN) 
outreg2 using sobelodi, word replace

# Resutls
The research results show that two-way FDI has a positive effect on innovation capability, among which FDI has a more obvious role in promoting China's innovation capability. Meanwhile, the developments of two-way FDI in the east, middle and west regions of China differ significantly, among which the eastern region, as the main undertaking and origin of two-way FDI, is also in the leading position in terms of innovation level. The results of the intermediary effect model show that the human capital enhancement effect is one of the important channels for two-way FDI to play a role in promoting innovation capability. Taking into account the current economic background, this paper proposes to strengthen policy support, encourage enterprises to be globalization, pay attention to the quality of FDI, and attract high-level capital inflows. Each region should also develop two-way FDI according to local conditions, pay attention to talent cultivation, strengthen the construction of intellectual property rights system, and enhance their competitiveness. The findings of the article may provide insights for advancing China's goal of forming a new era of opening up to the outside world and achieving a strong science and technology nation.

