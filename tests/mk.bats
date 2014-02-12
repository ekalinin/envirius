#!/usr/bin/env bats

load test_helper

@test "mk: empty environment" {
    run mem mk test_env1
    assert_success

    run mem ls
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "test_env1" ]
}

@test "mk: with disabled plugin" {
    run mem mk test_env --go=1.2rc5
    assert_success
    assert_equal "Creating environment: test_env ..." "${lines[0]}"
    assert_equal " * installing go==1.2rc5 ..." "${lines[1]}"
    assert_equal " - plugin disabled." "${lines[2]}"

    run mem ls
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "test_env" ]
}
