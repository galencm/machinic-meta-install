#!/bin/bash
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2017, Galen Curwen-McAdams

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