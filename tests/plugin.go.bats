#!/usr/bin/env bats

load test_helper

@test "plugin: go" {
    run nv mk go_test_env --go=1.2.1
    assert_success

    nv on go_test_env

    run go version
    assert_success "go version go1.2.1 linux/386"
}
