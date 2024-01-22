config_file="$HOME/.config/gammastep/config.ini"
brightness_change=.05

increment_brightness(){
	awk -F'=' -v increment="$brightness_change" '
    $1=="brightness" { 
        $2=$2+increment; 
        if ($2 > 1) $2 = 1;
        print $1"="$2; 
        next 
    }
    {print}' $config_file > temp_file && mv temp_file $config_file
}


decrement_brightness(){
	awk -F'=' -v decrement="$brightness_change" '
    $1=="brightness" { 
        $2=$2-decrement; 
        if ($2 < 0) $2 = 0;
        print $1"="$2; 
        next 
    }
    {print}' $config_file > temp_file && mv temp_file $config_file
}

if [ "$1" == "increase" ]; then
    increment_brightness
elif [ "$1" == "decrease" ]; then
    decrement_brightness
fi

pkill gammastep
gammastep > /dev/null 2>&1 &
disown
