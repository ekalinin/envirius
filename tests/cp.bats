#!/usr/bin/env bats

load test_helper

@test "cp: without src name" {
    run nv cp
    assert_fail
    [ "${lines[0]}"  = "Please, enter a name for a source environment" ]
}

@test "cp: without dst name" {
    run nv cp test_env
    assert_fail
    [ "${lines[0]}"  = "Please, enter a name for a destination environment" ]
}

@test "cp: dst already exists" {
    run nv mk test_env
    assert_success

    run nv cp test_env test_env
    assert_fail
    assert_output "Target directory already exists (test_env)."
}

@test "cp: src not exists" {
    run nv cp "some-test-env" test_env
    assert_fail
    assert_output "Source directory does not exist (some-test-env)."
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
