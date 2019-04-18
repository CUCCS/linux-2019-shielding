# vimtutor 

#### 实验环境 Ubuntu18.04 Server

#### Lesson-1
[![Lesson-1](https://asciinema.org/a/237492.png)](https://asciinema.org/a/237492)

#### Lesson-2
[![Lesson-2](https://asciinema.org/a/237510.png)](https://asciinema.org/a/237510)

#### Lesson-3
[![Lesson-3](https://asciinema.org/a/237512.png)](https://asciinema.org/a/237512)

#### Lesson-4
[![Lesson-4](https://asciinema.org/a/241522.png)](https://asciinema.org/a/241522)

#### Lesson-5
[![Lesson-5](https://asciinema.org/a/241523.png)](https://asciinema.org/a/241523)

#### Lesson-6
[![Lesson-6](https://asciinema.org/a/241525.png)](https://asciinema.org/a/241525)

#### Lesson-7
[![Lesson-7](https://asciinema.org/a/241527.png)](https://asciinema.org/a/241527)


# vimtutor完成后的自查清单

* 你了解vim有哪几种工作模式？
	* Normal
	* Insert
	* Visual
	* select
	* command-line 
	* ex-mode 
	* 更全面的工作模式总结：```:help mode```
* Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？
	* 光标向下移动10行：```10j```
	* 开始行：```gg```
	* 结束行：```G```
   * 第N行：```Ngg``` 或者 ```NG``` 
* Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？
	* 删除单个字符：```x```
	* 删除单个单词：```dw```
	* 删除到行尾：```d$```
	* 删除单行：```dd```	
	* 删除往下N行：```dNd```
* 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？
	* 插入N个空行：```No ESC```
* 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？
	* 撤销：```u```撤销上次编辑 ```U```撤销整行改动
	* 重做：```Ctrl+R```
* vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？
	* 剪切单个字符：```x```
	* 剪切单个单词：```dw```
	* 剪切单行：```d$```
	* 还可以先通过v进入visual mode，高亮选中需要复制的部分后```y```
	* 粘贴：```p```
	
---

* 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？
	* ```Ctrl+G```
* 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？
	* ```/keyword```从头开始查找 ```?keyword```从尾开始查找 ```n```或者```N```查找下一个
	* ```:set ic``` 	或者```/keyword\c``` 查找keyword时忽略大小写（ignore case）
	* ```:set hls``` 设置高亮查找（hlsearch）
	* ```:%s/old/new/g```  将当前文件中所有old替换为new
* 在文件中最近编辑过的位置来回快速跳转的方法？```Ctrl+O``````Ctrl+I```
* 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or } ```%```
* 在不退出vim的情况下执行一个外部程序的方法？ ```:!```
* 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？
	* ```:help 快捷键```
	* ```Ctrl+W```







