#!/bin/bash

help(){
	cat<<EOF
	可选参数：
		-h|-help 打印帮助信息
		-d|-directory 指定目录；判断目录是否存在
		-q|-quality 对jpeg格式图片进行图片质量压缩
		-r|resize 对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
		-w|-watermark 对图片批量添加自定义文本水印
		-p|-prefix 批量添加文件名前缀
		-s|-suffic 批量添加文件名后缀（不影响扩展名）
		-c 将png/svg图片统一转换为jpg格式
EOF

}

file_path="/home/shielding/try/img"
quality=80
scale="50x50"
watermark="watermark"
prefix="prefix"
suffix="suffix"

check_path(){
	file_path="$1"
	# echo "${file_path}"
	# shift 1
	if [ ! -d "$file_path" ]
	then 
		echo "${file_path}: no such directory" 
	exit 0
	fi
}

# 支持对jpeg格式图片进行图片质量压缩
quality(){
	tmp="$1"
	if [[ ! "${tmp:0:1}" = "-" && ! "${tmp:0:1}" = "" ]]
	then
		quality=tmp
		# shift 1
	fi
	for file in $(find "$file_path" \( -name "*.jpg" \))
	do
		 # 调用imagemagick 
		convert -quality $quality "$file" "${file%.jpg}_quality.jpg"
	done

}

# 支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
resize(){
	tmp="$1"
	if [[ ! "${tmp:0:1}" = "-" && ! "${tmp:0:1}" = "" ]]
	then
		scale=tmp
		# shift 1
	fi
	for file in $(find "$file_path"  -name "*.jpg" -or -name "*.png" -or -name "*.svg")
	do
		 # 调用imagemagick 
			convert -resize $scale "$file" "${file%.*}_resize.${file#*.}"
	done
}

# 支持对图片批量添加自定义文本水印
watermark(){
	tmp="$1"
	# echo $tmp
	if [[ ! "${tmp:0:1}" = "-" && ! "${tmp:0:1}" = "" ]]
	then
		watermark=tmp
		# shift 1
	fi
	for file in $(find "$file_path" \( -name "*.jpg" -or -name "*.png"\))
	do
		 # 调用imagemagick 
		convert -draw "text 10,10 '$watermark'" -gravity NorthWest -pointsize 35 "$file" "${file%.*}_watermark.${file#*.}"
	done

}

# 支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
prefix(){
	tmp="$1"
	if [[ ! "${tmp:0:1}" = "-" && ! "${tmp:0:1}" = "" ]]
	then
		prefix=tmp
		# shift 1
	fi
	for file in $file_path 
	do
		# 修改文件名
		mv "$file" "${file%%/*}${prefix}_${file##*/}"
	done
}

suffix(){
	tmp="$1"
	if [[ ! "${tmp:0:1}" = "-" && ! "${tmp:0:1}" = "" ]]
	then
		suffix=tmp
		# shift 1
	fi
	for file in $file_path
	do
		# 修改文件名
		mv "$file" "${file%.*}_${suffix}.${file#*.}"
	done
}

# 支持将png/svg图片统一转换为jpg格式
change_to_jpg(){
	for file in $(find "$file_path" \( -name "*.svg" -or -name "*.png"\))
	do 
		# 调用imagemagick 一定要加上-flatten！！
		convert -background white "$file" -flatten "${file%.*}.jpg"
	done
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
		-d|-directory) 
			shift 1
			check_path "$1" ;;
		-q|-quality)
			shift 1
			quality "$1" ;;
		-r|resize)
			shift 1
			resize "$1" ;;
		-w|-watermark)
			shift 1
			watermark "$1" ;;
		-p|-prefix)
			shift 1 
			prefix "$1" ;;
		-s|-suffic)
			shift 1
			suffix "$1" ;;
		-c)
			shift 1
			change_to_jpg ;;
		*)
			shift 1 ;;
	esac
done

exit 0