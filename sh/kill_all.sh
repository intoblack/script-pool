#!/bin/sh
#循环所有列表中 查看qq进程 不包含有 grep使用的进程 进程号在第二列 awk 执行  
for i in $(ps aux | grep qq | grep -v "grep" | awk {'print $2'});do kill -9 $i; done
