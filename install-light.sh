#!/bin/bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2018, Galen Curwen-McAdams

install_path=$HOME
development_install=false
environment_install=true

# --develop flag installs python packages in editable/develop mode
# --no-env flag disables running environment scripts
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --develop)
            development_install=true
            shift
            ;;
        --no-env)
            environment_install=false
            shift
            ;;
    esac
done

declare -a packages=("https://github.com/galencm/ma-cli"
)

declare -a programs=("https://github.com/galencm/fold-lattice-ui"
    "https://github.com/galencm/dzz-ui"
    "https://github.com/galencm/enn-ui"
    "https://github.com/galencm/machinic-tangle"
)

# run environment script(s) first
if [ "$environment_install" = true ]; then
    cd ./env/ || exit
    ./environment.sh
    cd ..
fi

for package in "${packages[@]}"
do
    if [ "$development_install" = true ]; then
        cd "$install_path" || exit
        git clone "$package"
        cd "$install_path"/"${package##*/}" || exit
        pip3 install --editable ./ --user --process-dependency-links
        cd ..
    else
        pip3 install git+"$package" --user --process-dependency-links
    fi
done

for program in "${programs[@]}"
do
    if [ "$development_install" = true ]; then
        cd "$install_path" || exit
        git clone "$program"
        cd "$install_path"/"${program##*/}" || exit
        pip3 install --editable ./ --user --process-dependency-links
        cd ..
    else
        pip3 install git+"$program" --user --process-dependency-links
    fi
done
