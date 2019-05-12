#!/bin/bash

help(){
	cat<<EOF
	实现对worldcupplayerinfo.tsv的相关统计工作
		- 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员**数量**、**百分比**
	    - 统计不同场上位置的球员**数量**、**百分比**
	    - 名字最长的球员是谁？名字最短的球员是谁？
	    - 年龄最大的球员是谁？年龄最小的球员是谁？
	参数：
	-h 打印帮助信息
	-c|-compute 输出统计内容
EOF
	
}
compute(){
	# 名字最长的球员是谁？名字最短的球员是谁？
	# sort -t $'\t' -k 9 -u worldcupplayerinfo.tsv\
	sed -e '1d' worldcupplayerinfo.tsv\
	|awk -F '\t''!a[$9]++{print}' worldcupplayerinfo.tsv\
	|awk -F '\t' \
	'BEGIN{max=0;min=100;mark_max="";mark_min=""}\
	{if(length($9)>max){max=length($9);mark_max=$9};if(length($9)<min){min=length($9);mark_min=$9}}\
END{printf("名字最长的球员是%s,名字最短的球员是%s\n",mark_max,mark_min)}' worldcupplayerinfo.tsv
	
	#  统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
	# 年龄最大的球员是谁？年龄最小的球员是谁？
	awk -F '\t' 'BEGIN{a=0;b=0;c=0;min=199;max=0}\
	NR>1 {age[$9]=$6;if($6<20){a++;}else if($6<=30){b++;}else {c++;}if($6<min){min=$6};if($6>max){max=$6}}\
  	END{all=a+b+c;printf("统计不同年龄区间范围的球员数量、百分比:\n20岁以下\t%d\t%.5f\t\n",a,a/all);printf("20至30岁\t%d\t%.5f\t\n",b,b/all);printf("30岁以上\t%d\t%.5f\t\n",c,c/all);\
  	print "年龄最小的是:";for(i in age){if(age[i]==min){printf("%s\t%d\n",i,age[i])}};\
	print "年龄最大的是:";for(i in age){if(age[i]==max){printf("%s\t%d\n",i,age[i])}};\
  	}' worldcupplayerinfo.tsv

  	# 统计不同场上位置的球员数量、百分比
  	awk -F '\t' 'BEGIN{all=0;}\
  	NR>1{position[$5]++;all++;}\
    END{printf("统计不同场上位置的球员数量、百分比:\n");for(i in position){printf("%s:\t%d\t%.5f\t\n",i,position[i],position[i]/all);}}' worldcupplayerinfo.tsv

	# echo "test"
}



while true
do 
	if [ "$1" = "" ]
	then
		break
	fi
	case "$1" in
		-h) 
			shift 1
			help ;;	
		-c|-compute) 
			shift 1
			compute ;;
	esac
done 

exit 0		



