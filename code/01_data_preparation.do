clear
cd "F:\毕业论文\数据\数据整合"
import excel using "bachelor_thesis_data_sum.xlsx", first clear
browse

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
