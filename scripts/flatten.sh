#! /bin/bash

#This function reads a directory and calls the forge flatten command to flatten the contract
function flatten_all(){
    #Loop through each file in the directory
    for file in `ls $1`
    do
        #Check if the file is a directory
        if [ -d $1"/"$file ]
        then
            #If the file is a directory, call the flatten_all function again
            flatten_all $1"/"$file
        else
            #If the file is not a directory, store the file path
            file_path=$1"/"$file
            #Store the flatten file path
            flatten_file_path=$flatten_dir"/"$file
            #Print out the flatten command
            echo flatten $file_path to $flatten_file_path
            #Call the forge flatten command
            forge flatten $file_path > $flatten_file_path
        fi
    done
}

root=`pwd`
contracts_dir=$root/contracts/src
flatten_dir=$root/flatten

echo flatten contracts in $contracts_dir

#Remove the flatten directory if it exists
rm -rf $flatten_dir
#Create the flatten directory
mkdir $flatten_dir

#Call the read_dir function to read the contracts directory
flatten_all $contracts_dir