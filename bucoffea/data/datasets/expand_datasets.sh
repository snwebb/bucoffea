#!/bin/bash


expand(){
    INFILE=${1}
    COND=${2}
    # for STUB in $(cat ${INFILE}); do
    while read STUB; do
        if [[ $STUB = \#* ]]; then
            echo $STUB
        elif [ -z "${STUB}" ]; then
            echo ""
        else
            # echo $STUB
            dasgoclient --query="dataset=/${STUB}/${COND}/NANOAOD*"
        fi
    done < ${INFILE}
}

INFILE="dataset_names_mc.txt"
expand "${INFILE}" "RunIISummer16*1June*" | tee datasets_2016.txt
expand "${INFILE}" "RunIIFall17*1June*" | tee datasets_2017.txt
expand "${INFILE}" "RunIIAutumn18*1June*" | tee datasets_2018.txt

INFILE="dataset_names_data.txt"
expand "${INFILE}" "Run2016*1June*" | tee -a datasets_2016.txt
expand "${INFILE}" "Run2017*1June*" | tee -a datasets_2017.txt
expand "${INFILE}" "Run2018*1June*" | tee -a datasets_2018.txt

sed -i '/BGen/d' datasets_201*.txt
sed -i '/DYBBJet/d' datasets_201*.txt
sed -i '/DoubleEMEnriched/d' datasets_201*.txt

sed -i '/WJetsToLNu_.*J_.*2017.*/d' datasets_2017.txt
sed -i '/.*LHEWpT_0-50.*/d' datasets_201*.txt
sed -i '/.*LHEWpT_50-150.*/d' datasets_201*.txt
sed -i '/.*CP5up.*/d' datasets_201*.txt
sed -i '/.*CP5down.*/d' datasets_201*.txt

sed '/\(Run2016\|\/G.*Jet\)/!d' -i datasets_2016.txt
sed -i '/.*JetHT.*/d' datasets_2016.txt
sed -i '/.*SingleMuon.*/d' datasets_2016.txt
