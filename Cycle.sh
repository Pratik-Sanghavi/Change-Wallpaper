#!/bin/bash
set_wallpaper(){
    wallpapers=()
    curr_wallpaper=$(get_curr_wallpaper)
    i=0
    for file in ./Wallpapers/*.jpg
    do
        wallpapers=(${wallpapers[@]} "$file")
        if [[ "${curr_wallpaper:12:${#curr_wallpaper}}" == "${file:13:${#file}}" ]]
        then
            index=$i
        fi
        i=`expr $i + 1`
    done
    index=`expr $index + 1`
    if [ $index -ge $(find ./Wallpapers/*.jpg|wc -l) ]
    then
        index=0
    fi

    # On all days except Sundays, cycle through the pictures. On Sundays, select a random picture
    if [ $(date +%u) -eq 7 ]
    then
        rand=$(random_generator)
        preprocess=${wallpapers[$rand]}
        echo $preprocess|tr '/' '\\'|cut -c 2-${#preprocess}>curr_wallpaper.txt
        # Built as a failsafe in case wallpaper does not change
        $(xdg-open ${wallpapers[$rand]})
    else
        preprocess=${wallpapers[$index]}
        echo $preprocess|tr '/' '\\'|cut -c 2-${#preprocess}>curr_wallpaper.txt
        # Built as a failsafe in case wallpaper does not change
        $(xdg-open ${wallpapers[$index]})
    fi
}

random_generator(){
    rand=$RANDOM
    echo `expr $rand % $(find ./Wallpapers/*.jpg|wc -l)`
}

get_curr_wallpaper()
{
    name=$(cat curr_wallpaper.txt)
    echo $name
}

$(set_wallpaper)