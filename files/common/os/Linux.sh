# alias
alias ls='ls -h --color=auto'
alias open='xdg-open'

# env vars
export MAN_POSIXLY_CORRECT=1

# convenience commands
dureadable() {
    if [ -z "$1" ]
    then
        duresults=`du --max-depth=1 -k .`
    else
        duresults=`du --max-depth=1 -k $1`
    fi

    echo $duresults | sort -nr | awk '{ if($1>=1024*1024) {size=$1/1024/1024; unit="G"} else if($1>=1024) {size=$1/1024; unit="M"} else {size=$1; unit="K"}; if(size<10) format="%.1f%s"; else format="%.0f%s"; res=sprintf(format,size,unit); printf "%-8s %s\n",res,$2 $3 $4 $5 $6 $7 $8 $9}'
}
