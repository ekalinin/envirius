#!/usr/bin/env bats

load test_helper

@test "ls: empty list" {
    run nv ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "" "${lines[1]}"
}

@test "ls: with one environment" {
    run nv mk empty_env
    assert_success

    run nv ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "empty_env" "${lines[1]}"
    assert_equal "" "${lines[2]}"
}

@test "ls: with/without meta information" {
    run nv mk --node=0.10.26
    assert_success

    run nv ls
    assert_success
    assert_equal "Available environment(s):"    "${lines[0]}"
    assert_equal "node-0.10.26 (node==0.10.26)" "${lines[1]}"
    assert_equal ""                             "${lines[2]}"

    run nv ls --no-meta
    assert_success
    assert_equal "Available environment(s):"    "${lines[0]}"
    assert_equal "node-0.10.26"                 "${lines[1]}"
    assert_equal ""                             "${lines[2]}"
}
