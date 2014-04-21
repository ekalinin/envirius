#!/usr/bin/env bats

load test_helper

@test "plugin: scala" {
    run nv mk scala_test_env --scala=2.10.4
    assert_success

    nv on --same-shell scala_test_env

    run scalac -version
    assert_success "Scala compiler version 2.10.4 -- Copyright 2002-2013, LAMP/EPFL"
}
