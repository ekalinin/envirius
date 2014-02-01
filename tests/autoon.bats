#!/usr/bin/env bats

load test_helper

@test "autoon: file with explicity entered env" {
    if [ -e ./.mem ]; then
        rm ./.mem
    fi
    run mem autoon test_env1
    [ "$status" -eq 0 ]
    # file should be created
    [ -e ./.mem ]
    # file should content environment name
    [ "`cat ./.mem`" = "test_env1" ]
    rm ./.mem
}

@test "autoon: show help if env not activated, file not created" {
    if [ -e ./.mem ]; then
        rm ./.mem
    fi
    run mem autoon
    [ "$status" -eq 0 ]
    # file should not be created
    [ ! -e ./.mem ]
    [ "${lines[0]}" = "`bold Usage`: mem autoon [<env-name>]" ]
    [ "${lines[1]}" = "`bold Description`: Mark current directory for environment auto activating" ]
    [ "${lines[2]}" = "    If environment's name is not entered then used current" ]
    [ "${lines[3]}" = "    (active) environment. If environment is not activated" ]
    [ "${lines[4]}" = "    then environment's name is required." ]
}

@test "autoon: file with activated environment name" {
    if [ -e ./.mem ]; then
        rm ./.mem
    fi
    mem rm --all
    mem mk empty_env
    mem on empty_env
    mem autoon
    # file should be created
    [ -e ./.mem ]
    # file should content environment name
    [ "`cat ./.mem`" = "empty_env" ]
    rm ./.mem
}
