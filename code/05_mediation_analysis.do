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
