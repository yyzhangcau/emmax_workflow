#!/bin/bash
#using method: ./emmax.sh -i input -o output
while getopts "i:o:" arg #选项后面的冒号表示该选项需要参数
do
        case $arg in
             i)
                input=$OPTARG 
                ;;
             o)
                out=$OPTARG 
                ;;
             ?)  #当有不认识的选项的时候arg为?
            echo "unkonw argument"
        exit 1
        ;;
        esac
done

path=`pwd`
mkdir $input
$path/bin/plink --bfile $input --chr-set 32 --allow-extra-chr --recode 12 transpose --output-missing-genotype 0 --out $path/$input/$input
$path/bin/plink --bfile $input --chr-set 32 --allow-extra-chr --pca --out $path/$input/$input
# generate tped/tfam and eigenvec
#make phenotype file
awk '{print $1,$2,$6}' $path/$input/$input.tfam > $path/$input/$input.pheno

awk 'BEGIN{a=1}{printf("%s %s ",$1,$2);printf("%s ",a);for(i=3;i<6;i++){printf("%s ",$i)}printf("%s","\n")}' $path/$input/$input.eigenvec > $path/$input/$input.cov
#ibs-kinship
$path/bin/emmax-kin -v -h -s -d 10 $path/$input/$input #(will generate [tped_prefix].hIBS.kinf)
#BN-kinship
$path/bin/emmax-kin -v -h -d 10 $path/$input/$input #(will generate [tped_prefix].hBN.kinf)

mkdir $out
$path/bin/emmax -v -d 10 -t $path/$input/$input -p $path/$input/$input.pheno -k $path/$input/$input.hIBS.kinf -c $path/$input/$input.cov -o $path/$out/$input.hIBS
$path/bin/emmax -v -d 10 -t $path/$input/$input -p $path/$input/$input.pheno -k $path/$input/$input.hBN.kinf -c $path/$input/$input.cov -o $path/$out/$input.hBN

$path/bin/plot_emmax.R $out $input

