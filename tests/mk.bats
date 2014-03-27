#!/usr/bin/env bats

load test_helper

@test "mk: empty environment" {
    run nv mk test_env1 --no-meta
    assert_success

    run nv ls-envs
    assert_success
    [ "${lines[0]}"  = "Available environment(s):" ]
    [ "${lines[1]}"  = "test_env1" ]
}

@test "mk: with disabled plugin" {
    #TODO: add fake disabled plugin after python will be enable
    run nv mk test_env --stub=3.2 --no-meta
    assert_success
    assert_equal "Creating environment: test_env ..." "${lines[0]}"
    assert_equal " * installing stub==3.2 ..." "${lines[1]}"
    assert_equal " - plugin disabled." "${lines[2]}"

    run nv ls-envs
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "test_env" "${lines[1]}"
}

@test "mk: with name" {
    run nv mk test_env --erlang=17.0-rc1 --rust=0.9 --no-meta
    assert_success
    [ "${lines[0]}"  = "Creating environment: test_env ..." ]
    [ "${lines[1]}"  = " * installing erlang==17.0-rc1 ..." ]
    [ "${lines[3]}"  = " * installing rust==0.9 ..." ]

    run nv ls-envs
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "test_env" "${lines[1]}"
}

@test "mk: without name" {
    run nv mk --no-meta --erlang=17.0-rc1 --rust=0.9
    assert_success
    assert_equal "Creating environment: erlang-17.0-rc1-rust-0.9 ..." "${lines[0]}"
    assert_equal " * installing erlang==17.0-rc1 ..." "${lines[1]}"
    assert_equal " * installing rust==0.9 ..." "${lines[3]}"

    run nv ls-envs
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "erlang-17.0-rc1-rust-0.9" "${lines[1]}"
}

@test "mk: without name & meta" {
    run nv mk --erlang=17.0-rc1 --rust=0.9
    assert_success
    assert_equal "Creating environment: erlang-17.0-rc1-rust-0.9 ..." "${lines[0]}"
    assert_equal " * installing erlang==17.0-rc1 ..." "${lines[1]}"
    assert_equal " * installing rust==0.9 ..." "${lines[3]}"

    run nv ls-envs
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "erlang-17.0-rc1-rust-0.9 (erlang==17.0-rc1, rust==0.9)" "${lines[1]}"
}

@test "mk: with name & meta" {
    run nv mk test_env --erlang=17.0-rc1 --rust=0.9
    assert_success
    [ "${lines[0]}"  = "Creating environment: test_env ..." ]
    [ "${lines[1]}"  = " * installing erlang==17.0-rc1 ..." ]
    [ "${lines[3]}"  = " * installing rust==0.9 ..." ]

    run nv ls-envs
    assert_success
    assert_equal "Available environment(s):" "${lines[0]}"
    assert_equal "test_env (erlang==17.0-rc1, rust==0.9)" "${lines[1]}"
}
