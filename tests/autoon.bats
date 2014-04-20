#!/usr/bin/env bats

load test_helper

@test "autoon: file with explicity entered env" {
    rm -f ./.envirius

    run nv autoon test_env1
    assert_success

    # file should be created
    [ -e ./.envirius ]
    # file should content environment name
    assert_equal "test_env1" "`cat ./.envirius`"

    rm ./.envirius
}

@test "autoon: show help if env not activated, file not created" {
    rm -f ./.envirius

    run nv autoon
    assert_success

    # file should not be created
    [ ! -e ./.envirius ]
    [ "${lines[0]}" = "`nv_bold Usage`: nv autoon [<env-name>]" ]
    [ "${lines[1]}" = "`nv_bold Description`: Mark current directory for environment auto activating" ]
    [ "${lines[2]}" = "    If environment's name is not entered then used current" ]
    [ "${lines[3]}" = "    (active) environment. If environment is not activated" ]
    [ "${lines[4]}" = "    then environment's name is required." ]

    rm -f ./.envirius
}

@test "autoon: file with activated environment name" {
    rm -f ./.envirius

    nv mk empty_env
    nv on empty_env --same-shell
    nv autoon

    # file should be created
    [ -e ./.envirius ]
    # file should content environment name
    assert_equal "empty_env" "`cat ./.envirius`"

    rm ./.envirius
}
