
#emmax workflow#
==============
为了简化本实验gwas工作而写的一个小的shell脚本，仅仅是将PLINK和EMMAX这两款优秀的软件结合起来使用。
PLINK用来转化文件格式和生成covariate文件，GWAS计算过程由EMMAX完成，作图过程由R完成。

##EMMAX (Efficient Mixed-Model Association eXpedited)##
混合线性模型全基因组关联分析GWAS	
  EMMAX的链接：http://genetics.cs.ucla.edu/emmax/
###emmax.sh 的使用方法###
1、下载emmax_workflow文件夹，目录下包括bin文件夹和emmax.sh文件。

2、准备PLINK的bed/bim/fam文件（example.bed example.bim example.fam），放在emmax_workflow目录下。

3、linux终端操作，
	
	$ ./emmax.sh -i <plink_bedformat_prefix> -o <output_dir>
	$ ./emmax.sh -i example -o out
	
4、在emmax_workflow目录下会生成example和out两个文件夹，out文件夹内包括emmax的计算结果和绘图结果（manhattan plot和QQ-plot）

###注意事项###
如需要对执行脚本和程序添加可执行权限：
	$chmod +x <filename>
	
	
如有使用问题，可联系 yyzhang@cau.edu.cn。


