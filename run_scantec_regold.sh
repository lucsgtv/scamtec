! /bin/bash -x

Regs=(gl hn tr hs as)

lpath=/scripts/das/${USER}/SCANTEC-2.1.0/bin
scantecbin=${lpath}/scantec.x

for reg in ${Regs{@}}
do

  mkdir ${lpath}/${reg}
  cp -v ${scantecbin} ${lpath}/${reg}
  
  cd ${lpath}/${reg}
  
  if [ ${reg} == as]
  then
    cat ${lpath}/scantec.conf-template | sed "s,#LOWLEFTLAT#,-49.875,g" > ${lpath}/${reg}/scantec.conf
    sed -i "s,#LOWLEFTLON#,-82.625,g" ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLAT#,11.375,g"  ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLON#,-35.375,g" ${lpath}/${reg}/scantec.conf
  elif [ ${reg} == gl]
   cat ${lpath}/scantec.conf-template | sed "s,#LOWLEFTLAT#,-80,g" > ${lpath}/${reg}/scantec.conf
    sed -i "s,#LOWLEFTLON#,0,g" ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLAT#,80,g"  ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLON#,360,g" ${lpath}/${reg}/scantec.conf
    elif [ ${reg} == hn]
   cat ${lpath}/scantec.conf-template | sed "s,#LOWLEFTLAT#,20,g" > ${lpath}/${reg}/scantec.conf
    sed -i "s,#LOWLEFTLON#,0,g" ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLAT#,80,g" ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLON#,360,g" ${lpath}/${reg}/scantec.conf
  elif [ ${reg} == tr]   
  cat ${lpath}/scantec.conf-template | sed "s,#LOWLEFTLAT#,-20,g" > ${lpath}/${reg}/scantec.conf
    sed -i "s,#LOWLEFTLON#,0,g" ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLAT#,20,g"  ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLON#,360,g" ${lpath}/${reg}/scantec.conf
  elif [ ${reg} == hs]
   cat ${lpath}/scantec.conf-template | sed "s,#LOWLEFTLAT#,-80,g" > ${lpath}/${reg}/scantec.conf
    sed -i "s,#LOWLEFTLON#,0,g" ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLAT#,-20,g"  ${lpath}/${reg}/scantec.conf
    sed -i "s,#UPRIGHTLON#,360,g" ${lpath}/${reg}/scantec.conf
  else
  echo "Região não encontrada"
  fi
# nohup ${scantecbin} > ${lpath}/${reg}/${reg}.log &

done

exit 0 
