#!/bin/bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2017, Galen Curwen-McAdams

install_path=$HOME
development_install=false
start_machines=true
# --develop flag installs python packages in editable/develop mode
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    --develop)
    development_install=true
    shift
    ;;
    --no-machine-start)
    start_machines=false
    shift
    ;;
esac
done

declare -a machines=("https://github.com/galencm/ma"
                "https://github.com/galencm/machinic-env"
                "https://github.com/galencm/machinic-core"
                "https://github.com/galencm/machinic-image"
                )

declare -a packages=("https://github.com/galencm/ma-cli"
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
    cd ..
    ./regenerate.sh
    if [ "$start_machines" = true ]; then
        ./start.sh
    fi
done

for package in "${packages[@]}"
do
    if [ "$development_install" = true ]; then
        cd "$install_path"
        git clone "$package"
        cd "$install_path"/"${package##*/}"
        pip3 install --editable ./ --user --process-dependency-links
        cd ..
    else
        pip3 install git+"$package" --user --process-dependency-links
    fi
done

for program in "${programs[@]}"
do 
    if [ "$development_install" = true ]; then
        cd "$install_path"
        git clone "$program"
        cd "$install_path"/"${program##*/}"
        pip3 install --editable ./ --user --process-dependency-links
        cd ..
    else
        pip3 install git+"$program" --user --process-dependency-links
    fi
done
