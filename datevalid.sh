usage="usage - ksh datevalid.sh YYYY MM DD"
#! /usr/bin/ksh
lastday()  {
        integer year month leap
        set -A mdays sp 31 28 31 30 31 30 31 31 30 31 30 31

        year=$1
        if ((${#year} != 4)) ; then
                return 1
        fi
        month=$2
        if ((month<1 || month> 12)) ; then
                return 1
        fi

        if ((month != 2)) ; then
        			print ${mdays[month]}
                return 0
        fi

        leap=0
        if ((!(year%100))); then
                ((!(year%400))) && leap=1
        else
                ((!(year%4))) && leap=1
        fi

        feblength=28
        ((leap)) && feblength=29
        print $feblength
        return 0
}

    if (($# == 3)) ; then
                year=$1;month=$2;day=$3;
                echo $year | grep -Eq '[0-9]+$'
                int_year=$?
                if ((int_year != 0)); then
                        return 1
                fi
                echo $month | grep -Eq '[0-9]+$'
                int_month=$?
                 if ((int_month != 0)); then
                        return 1
                fi
                echo $day | grep -Eq '[0-9]+$'
                int_day=$?
                if ((int_day != 0)); then
                        return 1
                fi
                #echo "$int_year $int_day $int_month"
                if ((int_year<=0 && int_day<=0 && int_month<=0)) ; then
						lday=`lastday $year $month`
                                                val=`echo $?`
							
					if [ $val=0 -a "$lday" -gt $month ];then
						return 0
					else
						return 1
					fi
					
				else 
                 return 1
                fi
        else
                print -u2 - "$usage"
                exit 1
    fi