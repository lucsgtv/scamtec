#!/bin/bash -x

Regs=("gl" "hn" "tr" "hs" "as")

lpath="/scripts/das/${USER}/SCANTEC-2.1.0/bin"
opath="/scripts/das/${USER}/SCANTEC-2.1.0/dataout/SMNA-Oper"

for reg in "${Regs[@]}"
do
  scantecbin="${lpath}/${reg}/scantec.x"
  mkdir -p "${lpath}/${reg}"
  cp -v "${scantecbin}" "${lpath}/${reg}"

  cd "${lpath}/${reg}" || exit 1

  case "$reg" in
    "as")
      sed "s,#LOWLEFTLAT#,-49.875,g" "${lpath}/scantec.conf-template" > scantec.conf
      sed -i "s,#LOWLEFTLON#,-82.625,g" scantec.conf
      sed -i "s,#UPRIGHTLAT#,11.375,g" scantec.conf
      sed -i "s,#UPRIGHTLON#,-35.375,g" scantec.conf
      sed -i "s,#REG#,${reg},g" "${lpath}/${reg}/scantec.conf"      
      ;;
    "gl")
      sed "s,#LOWLEFTLAT#,-80,g" "${lpath}/scantec.conf-template" > scantec.conf
      sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
      sed -i "s,#UPRIGHTLAT#,80,g" scantec.conf
      sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
      sed -i "s,#REG#,${reg},g" "${lpath}/${reg}/scantec.conf"      
      ;;
    "hn")
      sed "s,#LOWLEFTLAT#,20,g" "${lpath}/scantec.conf-template" > scantec.conf
      sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
      sed -i "s,#UPRIGHTLAT#,80,g" scantec.conf
      sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
      sed -i "s,#REG#,${reg},g" "${lpath}/${reg}/scantec.conf"      
      ;;
    "tr")
      sed "s,#LOWLEFTLAT#,-20,g" "${lpath}/scantec.conf-template" > scantec.conf
      sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
      sed -i "s,#UPRIGHTLAT#,20,g" scantec.conf
      sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
      sed -i "s,#REG#,${reg},g" "${lpath}/${reg}/scantec.conf"
      ;;
    "hs")
      sed "s,#LOWLEFTLAT#,-80,g" "${lpath}/scantec.conf-template" > scantec.conf
      sed -i "s,#LOWLEFTLON#,0,g" scantec.conf
      sed -i "s,#UPRIGHTLAT#,-20,g" scantec.conf
      sed -i "s,#UPRIGHTLON#,360,g" scantec.conf
      sed -i "s,#REG#,${reg},g" "${lpath}/${reg}/scantec.conf"
      ;;
    *)
      echo "Região não encontrada: $reg"
      ;;
  esac
  mkdir -p "${opath}/${reg}"
  nohup "${scantecbin}" > "${lpath}/${reg}/${reg}.log" &
done

exit 0

