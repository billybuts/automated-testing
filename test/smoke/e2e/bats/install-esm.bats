#!/usr/bin/env bats

load helpers

ESM_HOME=/appl/builddir/esm

@test "${ESM_HOME} exists" {
    [[ -d "${ESM_HOME}" ]]
}

@test "${ESM_HOME}/ExternalServicesMock-${ESM_VERSION}.jar exists" {
    [[ -f "${ESM_HOME}/ExternalServicesMock-${ESM_VERSION}.jar" ]]
}

@test "${ESM_HOME}/ExternalServicesMock-${ESM_VERSION}.sh exists" {
    [[ -f "${ESM_HOME}/ExternalServicesMock-${ESM_VERSION}.sh" ]]
}

@test "${ESM_HOME}/ExternalServicesMock-${ESM_VERSION}.jar is readable" {
    [[ -r "${ESM_HOME}/ExternalServicesMock-${ESM_VERSION}.jar" ]]
}

@test "${ESM_HOME}/config.properties exists" {
    [[ -f "${ESM_HOME}/config.properties" ]]
}

@test "${ESM_HOME}/config.properties is readable" {
    [[ -r "${ESM_HOME}/config.properties" ]]
}

@test "${ESM_HOME} owned by fuseadm" {
    run stat -c %U ${ESM_HOME}
    [[ "$output" = "fuseadm" ]]
}

@test "${ESM_HOME} has fuseadm group" {
    run stat -c %G ${ESM_HOME}
    [[ "$output" = "fuseadm" ]]
}

@test "${ESM_HOME} has 770 permission" {
        run stat -c %a ${ESM_HOME}
        [[ $output -eq 770 ]]
}

@test "Mock Thaler should return soap fault" {
    run curl -X POST http://127.0.0.1:7000/ParameterWebServiceImpl
    [[ "$output" =~ "<faultstring>Error reading XMLStreamReader" ]]
}

@test "Mock Postcodeanywhere should return soap fault" {
    curl -X POST http://127.0.0.1:7002/BankAccountValidationService
    [[ "$output" =~ "<faultstring>Error reading XMLStreamReader" ]]
}
