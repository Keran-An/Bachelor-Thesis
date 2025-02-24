* Importing raw data, data cleaning, handling missing and abnormal values
clear
cd "F:\毕业论文\数据\数据整合"
import excel using "bachelor_thesis_data_sum.xlsx", first clear
browse

* Logarithmic transformation of variables
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

* Constructing panel data structure (xtset)
encode 省份, gen(PROVINCE)
xtset PROVINCE YEAR

