#!/usr/bin/env bats

load test_helper

@test "plugin: php" {
    run nv mk php_test_env --php=5.5.11
    assert_success

    nv on --same-shell php_test_env

    run php -v
    assert_success

    declare php_ver=$(echo "${lines[0]}" | egrep -o '[0-9]+\.[0-9]+\.[0-9]+')
    assert_equal "5.5.11" "$php_ver"
    assert_equal "Copyright (c) 1997-2014 The PHP Group" "${lines[1]}"

    run phar version
    assert_success

    declare php_ver=$(echo "${lines[0]}" | egrep -o '[0-9]+\.[0-9]+\.[0-9]+')
    declare ext_ver=$(echo "${lines[2]}" | egrep -o '[0-9]+\.[0-9]+\.[0-9]+')
    declare api_ver=$(echo "${lines[3]}" | egrep -o '[0-9]+\.[0-9]+\.[0-9]+')
    assert_equal "5.5.11" "$php_ver"
    assert_equal "2.0.2" "$ext_ver"
    assert_equal "1.1.1" "$api_ver"
}
