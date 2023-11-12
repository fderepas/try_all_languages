#!/bin/bash
# ps aux | sort -nrk 3,3 | head -n 5
# ps -ejH
topLine=`ps aux | sort -nrk 3,3 | head -n 1`
pid=`echo $topLine | tr -s ' ' | cut -d ' ' -f 2`
cpuf=`echo $topLine | tr -s ' ' | cut -d ' ' -f 3`
cpu=${cpuf%.*}
if (( $cpu>50 )); then
    # cpu above 50%
    cpulimitLaunched=`ps aux | grep $pid | grep cpulimit | wc -l`
    if [[ "$cpulimitLaunched" != "0" ]]; then
        # cpulimit alread launched, so now killing it
        sudo kill -9 $pid
    fi
fi
if (( $cpu>70 )); then
    # Warning cpu above 70% --> forcing it under 60%
    sudo cpulimit -p $pid -l 60 -b
fi
