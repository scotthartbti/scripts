#!/bin/bash

cd $(dirname $0)"/../"
HOME=$(pwd)

REPOS="bs7/device/oneplus/oneplus3 \
       bs7/device/oppo/common \
       bs7/device/qcom/common \
       bs7/device/qcom/sepolicy \
       bs7/kernel/oneplus/msm8996"

for x in $REPOS
do
    cd $x
    (git checkout bs7 || git checkout -b bs7) > /dev/null 2>&1
    git pull cm cm-14.0 2>err.txt
    if [ $? != 0 ]; then
        echo -e "\n### MERGE of \"$x\" FAILED ###\n"
        cat err.txt
        break
    fi
    echo -e "\n### MERGE of \"$x\" SUCCESSFUL ###\n"
    git push scott bs7 2>err.txt
    if [ $? != 0 ]; then
        echo -e "\n### PUSHING of \"$x\" TO GITHUB FAILED ###\n"
        cat err.txt
        break
    fi
    echo -e "\n### PUSHING of \"$x\" TO GITHUB SUCCESSFUL ###\n"
    rm -f err.txt
    cd $HOME
done

rm -f err.txt
