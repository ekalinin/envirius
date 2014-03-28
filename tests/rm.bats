#!/usr/bin/env bats

load test_helper

@test "rm: all" {
    run nv mk test_env1 --no-meta
    assert_success

    run nv mk test_env2 --no-meta
    assert_success

    run nv rm --all
    assert_success

    run nv ls
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "" ]
}

@test "rm: one" {
    run nv mk test_env1 --no-meta
    assert_success

    run nv mk test_env2 --no-meta
    assert_success

    run nv rm test_env1
    assert_success

    run nv ls
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "test_env2" ]
    [ "${lines[2]}"  = "" ]
}
