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
