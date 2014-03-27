#!/usr/bin/env bats

load test_helper

@test "plugin: go" {
    run nv mk go_test_env --go=1.2.1
    assert_success

    nv on go_test_env

    run go version
    assert_success "go version go1.2.1 linux/386"
}

@test "plugin: restore old values for the GOROOT/GOPATH" {
    run nv mk go_test_env --go=1.2.1
    assert_success

    GOROOT="test_GOROOT"
    GOPATH="test_GOPATH"

    nv on go_test_env
    nv off

    [ "$GOROOT" = "test_GOROOT" ]
    [ "$GOPATH" = "test_GOPATH" ]

}
