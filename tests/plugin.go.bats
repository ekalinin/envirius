#!/usr/bin/env bats

load test_helper

@test "plugin: go-prebuilt" {
    run nv mk go_test_env --go-prebuilt=1.2.1
    assert_success

    nv on --same-shell go_test_env

    run go version
    assert_success "go version go1.2.1 linux/386"
}

@test "plugin: go, restore old values for the GOROOT/GOPATH" {
    run nv mk go_test_env --go-prebuilt=1.2.1
    assert_success

    GOROOT="test_GOROOT"
    GOPATH="test_GOPATH"

    nv on --same-shell go_test_env
    nv off

    [ "$GOROOT" = "test_GOROOT" ]
    [ "$GOPATH" = "test_GOPATH" ]
}

@test "plugin: go, GOROOT/GOPATH after copy" {
    run nv mk go_test_env --go-prebuilt=1.2.1
    assert_success

    run nv cp go_test_env go_test_env_copy
    assert_success

    nv on --same-shell go_test_env_copy

    [ "$GOROOT" = "$NV_HOME/envs/go_test_env_copy/go" ]
    [ "$GOPATH" = "$NV_HOME/envs/go_test_env_copy/gocode" ]
}
