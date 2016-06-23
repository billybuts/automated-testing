#!/usr/bin/env bats

load helpers

CCPIMPORT_TEMP_DIR=/appl/builddir/ccpimport

CCPIMPORT_DIR=/appl/tfc/portal/ccpimport

CCPIMPORT_TESTFILES_ARCHIVE_DIR=${CCPIMPORT_DIR}

@test "${CCPIMPORT_TEMP_DIR} must exist" {
    [[ -d "${CCPIMPORT_TEMP_DIR}" ]]
}

@test "ccpimport jar has read permisons" {
    [[ -r "${CCPIMPORT_TEMP_DIR}/ccpimport-${CCPIMPORT_VERSION}.jar" ]]
}

@test "${CCPIMPORT_DIR}/scripts/logs must exist" {
    [[ -d "${CCPIMPORT_DIR}/scripts/logs" ]]
}

@test "${CCPIMPORT_DIR}/scripts/testfiles/ARCHIVE must exist" {
    [[ -d "${CCPIMPORT_DIR}/scripts/testfiles/ARCHIVE" ]]
}

@test "fuseadm has ownership of /appl/tfc/portal" {
    run stat -c %U /appl/tfc/portal
    [[ "$output" = "fuseadm" ]]
}

@test "/appl/tfc/portal has fuseadm group" {
    run stat -c %G /appl/tfc/portal
    [[ "$output" = "fuseadm" ]]
}

@test "/appl/tfc/portal has 770 permissions" {
    run stat -c %a /appl/tfc/portal
    [[ $output -eq 770 ]]
}

@test "ccpimport-${CCPIMPORT_VERSION}.jar exists in ${CCPIMPORT_DIR}" {
    [[ -f "${CCPIMPORT_DIR}/ccpimport-${CCPIMPORT_VERSION}.jar" ]]
}

@test "ccpimport.properties exists in ${CCPIMPORT_DIR}" {
     [[ -f "${CCPIMPORT_DIR}/ccpimport.properties" ]]
}

@test "ccpimport.sh exists in ${CCPIMPORT_DIR}/scripts" {
    [[ -f "${CCPIMPORT_DIR}/scripts/ccpimport.sh" ]]
}

@test "${CCPIMPORT_DIR}/ccpimport-${CCPIMPORT_VERSION}.jar has 770 permissions" {
    run stat -c %a ${CCPIMPORT_DIR}/ccpimport-${CCPIMPORT_VERSION}.jar
    [[ $output -eq 770 ]]
}

@test "${CCPIMPORT_DIR}/ccpimport.properties has 660 permissions" {
    run stat -c %a ${CCPIMPORT_DIR}/ccpimport.properties
    [[ $output -eq 660 ]]
}

@test "${CCPIMPORT_DIR}/scripts/ccpimport.sh has 770 permissions" {
    run stat -c %a ${CCPIMPORT_DIR}/scripts/ccpimport.sh
    [[ $output -eq 770 ]]
}
