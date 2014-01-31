#!/usr/bin/env bats

load test_helper

@test "current: mk empty env & activate it & check current" {
    # same as in test for 'on' command
    run mem rm --all
    [ "$status" -eq 0 ]
    run mem mk empty_env2
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "Creating environment: empty_env2 ..." ]
    mem activate test_empty_env2
    [ "$status" -eq 0 ]
    [ "`echo $MEM_USED_ENV`" = "test_empty_env2" ]
    run mem current
    [ "$status" -eq 0 ]
    [ "${lines[0]}"  = "test_empty_env2" ]
}
