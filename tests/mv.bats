#!/usr/bin/env bats

load test_helper

@test "mv: without src name" {
    run nv mv
    assert_fail
    [ "${lines[0]}"  = "Please, enter a name for a source environment" ]
}

@test "mv: without dst name" {
    run nv mv test_env
    assert_fail
    [ "${lines[0]}"  = "Please, enter a name for a destination environment" ]
}

@test "mv: dst already exists" {
    run nv mk test_env
    assert_success

    run nv mv test_env test_env
    assert_fail "Target directory already exists (test_env)."
}

@test "mv: src not exists" {
    run nv mv "some-test-env" test_env
    assert_fail "Source directory does not exist (some-test-env)."
}

@test "mv: rename env" {
    run nv mk test_env --rust=0.9 --no-meta
    assert_success

    run nv mv test_env test_env_copy
    assert_success

    run nv ls
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "test_env_copy" "${lines[1]}"

    nv on test_env_copy

    run rustc -v
    assert_success
    assert_equal "${lines[0]}" "rustc 0.9"
}
