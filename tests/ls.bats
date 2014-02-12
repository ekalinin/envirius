#!/usr/bin/env bats

load test_helper

@test "ls: empty list" {
    run mem ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "" "${lines[1]}"
}

@test "ls: with one environment" {
    run mem mk empty_env
    assert_success

    run mem ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "empty_env" "${lines[1]}"
    assert_equal "" "${lines[2]}"
}
