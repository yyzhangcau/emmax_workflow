#!/usr/bin/Rscript
cd<-getwd()
source(paste(cd,"/bin/manhattan.R",sep=""))
args<-commandArgs(TRUE)#传递2个参数：工作目录 原始文件名（不加后缀）
map_file<-paste(args[2],".bim",sep="")
map<-read.table(map_file,header=F)[,1:4]
wd<-paste(cd,"/",args[1],sep="")
setwd(wd)#进入当前目录
filename=args[2]
name<-c(paste(filename,".hIBS.ps",sep=""),paste(filename,".hBN.ps",sep=""))
for (i in name){
df<-read.table(i,header=F)
df<-df[match(map[,2],df[,1]),]
df[,4]<-map[,1]
df[,5]<-map[,4]
names(df)<-c("SNP","NA","P","CHR","BP")
df<-df[!is.na(df[,3]),]
p<-df[,3]
png(paste(i,".png",sep=""),width=800,height=400)
manhattan(df,pch=20,suggestiveline=F,genomewideline=F)
dev.off()
observed_p <- sort(p) 
log_observed_p <- -(log10(observed_p))
log_observed_p<-log_observed_p[!is.na(log_observed_p)]
m=length(log_observed_p)
log_expected_p <- -(log10(1:m/(m+1)))
z=qnorm(p/2)
lambda = round(median(z^2)/qchisq(0.5,1),3)
#lambda=median(log_observed_p)/median(log_expected_p)
png(paste(i,"_qqplot.png",sep=""))
plot ( c(0,7), c(0,7),col = 'red', lwd =3, type = 'l', xlab = "expected (-logP)",
	ylab = "Observed (-logP)", xlim = c(0,7), ylim = c(0,7), las = 1, xaxs = "i", bty = "l",	
	sub=paste("lambda=",signif(lambda,3)))
points( log_expected_p, log_observed_p, pch =20, cex = 0.5)
dev.off()
}
