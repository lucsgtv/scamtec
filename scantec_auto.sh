#!/bin/bash

lpath="/scripts/das/${USER}/SCANTEC-2.1.0/bin"
opath="/scripts/das/${USER}/SCANTEC-2.1.0/dataout/SMNA-Oper"
template_path="${lpath}/scantec.conf-template"

data_inicial="2024081500"
datas=()

for i in {1..4}; do
    ano=$(echo $data_inicial | cut -c1-4)
    mes=$(echo $data_inicial | cut -c5-6)
    dia="15"
    hora="00"

    mes=$((10#$mes + 1))
    if [ $mes -gt 12 ]; then
        mes=1
        ano=$((ano + 1))
    fi

    data_final=$(printf "%04d%02d%s%s" "$ano" "$mes" "$dia" "$hora")
    datas+=("$data_final")
    data_inicial=$data_final  # Correção aqui
done

Regs=("gl" "hn" "tr" "hs" "as")

for data in "${datas[@]}"; do
    for reg in "${Regs[@]}"; do
        scantecbin="${lpath}/${reg}/scantec.x"
        mkdir -p "${lpath}/${reg}"
        cp -v "${scantecbin}" "${lpath}/${reg}"
        cd "${lpath}/${reg}" || exit 1

        case "$reg" in
            "as")
                sed "s,#LOWLEFTLAT#,-49.875,g" "$template_path" > scantec.conf
                sed -i "s,#LOWLEFTLON#,-82.625,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,11.375,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,-35.375,g" scantec.conf
                ;;
            "gl")
                sed "s,#LOWLEFTLAT#,-80,g" "$template_path" > scantec.conf
                sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,80,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
                ;;
            "hn")
                sed "s,#LOWLEFTLAT#,20,g" "$template_path" > scantec.conf
                sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,80,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
                ;;
            "tr")
                sed "s,#LOWLEFTLAT#,-20,g" "$template_path" > scantec.conf
                sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,20,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
                ;;
            "hs")
                sed "s,#LOWLEFTLAT#,-80,g" "$template_path" > scantec.conf
                sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
                sed -i "s,#UPRIGHTLAT#,-20,g" scantec.conf
                sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
                ;;
        esac

        sed -i "s,#REG#,$reg,g" scantec.conf
        sed -i "s,Starting Time:.*,Starting Time: $data,g" scantec.conf
        sed -i "s,Ending Time:.*,Ending Time: $(date -d "$data +1 month" +"%Y%m%d00"),g" scantec.conf

        mkdir -p "${opath}/${reg}"
        nohup "${scantecbin}" > "${lpath}/${reg}/${reg}.log" &
    done
done

exit 0

