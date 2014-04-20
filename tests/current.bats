#!/usr/bin/env bats

load test_helper

@test "current: mk empty env & activate it & check current" {
    run nv mk empty_env2
    assert_success
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]

    nv on --same-shell test_empty_env2
    assert_success
    [ "`echo $NV_USED_ENV`" = "test_empty_env2" ]

    run nv current
    assert_success
    [ "${lines[0]}"  = "test_empty_env2" ]
}
