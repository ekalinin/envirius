#!/usr/bin/env bats

load test_helper

@test "plugin: node.js" {
    run nv mk node_test_env --node=0.10.26
    assert_success

    nv on node_test_env

    run node -v
    assert_success "v0.10.26"

    run npm -v
    assert_success "1.4.3"
}
