#!/bin/bash

lpath="/scripts/das/${USER}/SCANTEC-2.1.0/bin"
opath="/scripts/das/${USER}/SCANTEC-2.1.0/dataout/SMNA-Oper"
template_path="${lpath}/scantec.conf-template"

datas=("2024081500" "2024091500" "2024101500" "2024111500")

Regs=("gl" "hn" "tr" "hs" "as")

for data in "${datas[@]}"; do
    
    data_fim=$(date -d "${data:0:8} +1 month" +"%Y%m%d")00

    for reg in "${Regs[@]}"; do
        scantecbin="${lpath}/${reg}/scantec.x"
        mkdir -p "${lpath}/${reg}"
        cp -v "${scantecbin}" "${lpath}/${reg}"
        cd "${lpath}/${reg}" || exit 1

        
        sed "s,#STARTTIME#,$data,g" "$template_path" > scantec.conf
        sed -i "s,#ENDTIME#,$data_fim,g" scantec.conf

        case "$reg" in
            "as")
                sed -i "s,#LOWLEFTLAT#,-49.875,g" scantec.conf
                sed -i "s,#LOWLEFTLON#,-82.625,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,11.375,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,-35.375,g" scantec.conf
                ;;
            "gl")
                sed -i "s,#LOWLEFTLAT#,-80,g" scantec.conf
                sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,80,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
                ;;
            "hn")
                sed -i "s,#LOWLEFTLAT#,20,g" scantec.conf
                sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,80,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
                ;;
            "tr")
                sed -i "s,#LOWLEFTLAT#,-20,g" scantec.conf
                sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,20,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
                ;;
            "hs")
                sed -i "s,#LOWLEFTLAT#,-80,g" scantec.conf
                sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,-20,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
                ;;
        esac

        sed -i "s,#REG#,$reg,g" scantec.conf

        mkdir -p "${opath}/${reg}"
        nohup "${scantecbin}" > "${lpath}/${reg}/${reg}.log" &
    done
done

wait

exit 0

