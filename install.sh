#!/bin/bash
install_path="~"

declare -a machines=("https://github.com/galencm/ma"
                "https://github.com/galencm/machinic-env"
                "https://github.com/galencm/machinic-core"
                "https://github.com/galencm/machinic-image"
                )

declare -a packages=("ma-cli"
                )

declare -a programs=("https://github.com/galencm/fold-lattice-ui"
                "https://github.com/galencm/dss-ui"
                #"https://github.com/galencm/qma-ui" 
                )
    
for machine in "${machines[@]}"
do
    cd "$install_path"
    git clone "$machine"
    cd "$install_path"/"${machine##*/}"/env
    ./environment.sh
    echo
done

for package in "${packages[@]}"
do
    pip3 install "$package" --user
done

for program in "${programs[@]}"
do 
    pip3 install git+"$programs" --user
done