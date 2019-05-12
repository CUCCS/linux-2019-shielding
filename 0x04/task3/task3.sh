#!/bin/bash

help(){
	cat<<EOF
	参数信息：
	-1 功能1:统计访问来源主机TOP 100和分别对应出现的总次数
	-2 功能2:统计访问来源主机TOP 100 IP和分别对应出现的总次数
	-3 功能3:统计最频繁被访问的URL TOP 100"
	-4 功能4:统计不同响应状态码的出现次数和对应百分比
	-5 功能5:分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
	-6 <URL> 功能6:给定URL输出TOP 100访问来源主机
EOF
}

compute_1(){
	echo "统计访问来源主机TOP 100和分别对应出现的总次数"
	sed -e '1d' web_log.tsv|awk -F '\t' '{a[$1]++} END {for(i in a) {print i,a[i]}}'|sort -nr -k2|head -n 100
	echo "统计1完成"
}

compute_2(){
	echo "统计访问来源主机TOP 100 IP和分别对应出现的总次数"
	sed -e '1d' web_log.tsv|awk -F '\t' '{if($1~/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/) print $1}'|awk '{a[$1]++} END {for(i in a){print i,a[i]}}'|sort -nr -k2|head -n 100
	echo "统计2完成"
}

compute_3(){
	echo "统计最频繁被访问的URL TOP 100"
	sed -e '1d' web_log.tsv|awk -F '\t' '{a[$6]++} END {for(i in a) {print i,a[i]}}' |sort -nr -k2|head -n 100
	echo "统计3完成"
}

compute_4(){
	echo "统计不同响应状态码的出现次数和对应百分比"
	sed -e '1d' web_log.tsv|awk -F '\t' '{a[$6]++;c++} END {for(i in a) {printf("%d 数量为：%-10d 所占比例为：%.5f%\n",i,a[i],a[i]*100/c)}}'
	echo "统计4完成"
}

compute_5(){
	echo "分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数"
	a=$(sed -e '1d' 'web_log.tsv'|awk -F '\t' '{if($6~/^4+/) a[$6]++} END {for(i in a) print i}')
    for i in $a
    do
        sed -e '1d' web_log.tsv|awk -F '\t' '{if($6~/^'$i'/) a[$6][$5]++} END {for(i in a){for(j in a[i]){print i,j,a[i][j]}}}'|sort -nr -k3|head -n 10
    done
    echo "统计5完成"
}

compute_6(){
	ehco "给定URL输出TOP 100访问来源主机"
	sed -e '1d' web_log.tsv|awk -F '\t' '{if($5=="$1") a[$1]++} END {for(i in a){print i,a[i]}}'|sort -nr -k2|head -n 100
	echo "统计6完成"
}

while true
do 
	if [ "$1" = "" ]
	then
		break
	fi
	case "$1" in
		-1)
			shift 1
			compute_1 ;;
		-2) 
			shift 1
			compute_2 ;;
		-3)
			shift 1
			compute_3 ;;
		-4)
			shift 1
			compute_4 ;;
		-5)
			shift 1
			compute_5 ;;
		-6)
			shift 1
			compute_6 "$1" ;;
		-h)
			shift 1
			help ;;
		*)
			shift 1 ;;
	esac
done

exit 0