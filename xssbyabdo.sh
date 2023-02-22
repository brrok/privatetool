function kget(){
        parm='<'$(echo $1 | awk -F= '{$1=$1; print $2}')'>'
        parm="=<XSS>"
        file=`date | cut -d ' ' -f4 | cut -d ':' -f1`
        url=`echo $1 | awk -F= -v parm=$parm '{$2=parm; print $0}' | tr -d ' '`
        result=$(curl -s $url | egrep '<XSS>' | wc -l)

       if ! [[ $result == "0" ]];then
                printf "\e[1;92m~\e[0m $url : (\e[1;92m XSS \e[0m)\n"
                echo $url >> $file".true"

        else
                echo $url >> $file".false"; fi
}


echo
echo "       this tool by abdo r. b."
echo "          ----- start ---- "
echo
process=50
export -f kget
cat $1 | xargs -n1 -P$process bash -c 'kget "$@"' _
