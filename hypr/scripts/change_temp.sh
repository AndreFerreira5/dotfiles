config_file="$HOME/.config/gammastep/config.ini"
temp_change=100

increment_temp(){
	awk -F'=' -v increment="$temp_change" '
    $1=="temp-day" { 
        $2=$2+increment; 
        if ($2 > 8000) $2 = 8000;
        print $1"="$2; 
        next 
    }
    {print}' $config_file > temp_file && mv temp_file $config_file

    awk -F'=' -v increment="$temp_change" '
    $1=="temp-night" { 
        $2=$2+increment; 
        if ($2 > 8000) $2 = 8000;
        print $1"="$2; 
        next 
    }
    {print}' $config_file > temp_file && mv temp_file $config_file
}


decrement_temp(){
	awk -F'=' -v decrement="$temp_change" '
    $1=="temp-day" { 
        $2=$2-decrement; 
        if ($2 < 0) $2 = 0;
        print $1"="$2; 
        next 
    }
    {print}' $config_file > temp_file && mv temp_file $config_file

    awk -F'=' -v decrement="$temp_change" '
    $1=="temp-night" { 
        $2=$2-decrement; 
        if ($2 < 0) $2 = 0;
        print $1"="$2; 
        next 
    }
    {print}' $config_file > temp_file && mv temp_file $config_file
}

if [ "$1" == "increase" ]; then
    increment_temp
elif [ "$1" == "decrease" ]; then
    decrement_temp
fi

pkill gammastep
gammastep > /dev/null 2>&1 &
disown
