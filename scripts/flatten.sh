#! /bin/bash
function read_dir(){
    for file in `ls $1`       #注意此处这是两个反引号，表示运行系统命令
    do
        if [ -d $1"/"$file ]  #注意此处之间一定要加上空格，否则会报错
        then
            read_dir $1"/"$file
        else
            file_path=$1"/"$file   #在此处处理文件即可
            flatten_file_path=$flatten_dir"/"$file
            echo flatten $file_path to $flatten_file_path
            forge flatten $file_path > $flatten_file_path
        fi
    done
}

root=`pwd`
contracts_dir=$root/contracts/src
flatten_dir=$root/flatten
echo flatten contracts in $contracts_dir
#读取第一个参数
rm -rf $flatten_dir
mkdir $flatten_dir

read_dir $contracts_dir
