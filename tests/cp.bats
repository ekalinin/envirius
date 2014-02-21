#!/usr/bin/env bats

load test_helper

@test "cp: without src name" {
    run nv cp
    [ "${lines[0]}"  = "Please, enter a name for a source environment" ]
    [ "$status" = 1 ]
}

@test "cp: without dst name" {
    run nv cp test_env
    [ "${lines[0]}"  = "Please, enter a name for a destination environment" ]
    [ "$status" = 1 ]
}

@test "cp: dst already exists" {
    run nv mk test_env
    assert_success

    run nv cp test_env test_env
    [ "$status" = 1 ]
    [ "${lines[0]}"  = "Target directory already exists (test_env)." ]
    [ "${lines[1]}"  = "Please, choose another name for it and try again." ]
}

@test "cp: copy env" {
    run nv mk test_env --rust=0.9
    assert_success

    run nv cp test_env test_env_copy
    assert_success

    run nv ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "test_env" "${lines[1]}"
    assert_equal "test_env_copy" "${lines[2]}"

    nv on test_env

    run rustc -v
    assert_success
    assert_equal "${lines[0]}" "rustc 0.9"
}
