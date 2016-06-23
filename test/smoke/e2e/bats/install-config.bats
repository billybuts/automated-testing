#!/usr/bin/env bats

CONFIG_DIR=/appl/builddir/config

CONFIG_FILES=(application-cic.conf
application.conf
ccpimport.properties
cic.conf
ext-services-mock.properties
mockservice.conf
tfc-properties.karaf
e2e-config.zip)

@test "Check config directory exists" {
    [[ -d "$CONFIG_DIR" ]]
}


@test "Check correct config files exist" {
    local count=0

    cd /appl/builddir/config

    for file in *; do
        if [[ " ${CONFIG_FILES[@]} " =~ " $file " ]]; then
            count=$((count + 1))
        fi
    done

    [[ $count -eq 8 ]]
}

