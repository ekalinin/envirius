#!/usr/bin/env bats

load test_helper

@test "export: default archive name" {
    rm -f test_env.tar
    run nv mk test_env --node-prebuilt=0.10.26
    assert_success
    run nv export test_env
    assert_success
    assert_equal "1" "$(ls -l test_env.tar | wc -l)"
    rm test_env.tar
}

@test "export: explicit arhcive path" {
    local tar_path=/tmp/test_env_X
    rm -f ${tar_path}
    run nv mk test_env --node-prebuilt=0.10.26
    assert_success
    run nv export ${tar_path}
    assert_success
    assert_equal "1" "$(ls -l ${tar_path}.tar | wc -l)"
    rm ${tar_path}.tar
}

@test "export: failed without env name" {
    run nv mk test_env --node-prebuilt=0.10.26
    assert_success
    run nv export
    #assert_fail
    [ "${lines[0]}"  = "Please, enter a name for a source environment" ]
}
