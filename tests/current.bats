#!/usr/bin/env bats

load test_helper

@test "current: mk empty env & activate it & check current" {
    run mem mk empty_env2
    assert_success
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]

    mem activate test_empty_env2
    assert_success
    [ "`echo $MEM_USED_ENV`" = "test_empty_env2" ]

    run mem current
    assert_success
    [ "${lines[0]}"  = "test_empty_env2" ]
}
