#!/usr/bin/env bats

load test_helper

@test "plugin: node" {
    run nv mk node_test_env --node=0.10.26
    assert_success

    nv on --same-shell node_test_env

    run node -v
    assert_success "v0.10.26"

    run npm -v
    assert_success "1.4.3"
}

@test "plugin: node-prebuilt" {
    run nv mk node_test_env --node-prebuilt=0.10.26
    assert_success

    nv on --same-shell node_test_env

    run node -v
    assert_success "v0.10.26"

    run npm -v
    assert_success "1.4.3"
}

@test "plugin: node, check paths" {
    run nv mk node_test_env --node=0.10.26
    assert_success

    nv on --same-shell node_test_env
    local env_full_path=$(nv_get_env_full_path "node_test_env")
    local wrong_path_cnt=$(find "$env_full_path" -type f \
                            -iname "*.*" -print0 | \
                            xargs -0 grep -i "node-0.10.26" | \
                            grep "cache" | wc -l)

    assert_equal "0" "$wrong_path_cnt"
}
