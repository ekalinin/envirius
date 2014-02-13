#!/usr/bin/env bats

load test_helper

@test "plugin: erlang" {
    run nv rm --all
    assert_success

    run nv mk erlang_test_env --erlang=17.0-rc1
    assert_success

    nv on erlang_test_env
    # http://stackoverflow.com/a/9561362
    run erl -noshell -eval \
        'io:fwrite("~s\n", [erlang:system_info(otp_release)]).' \
        -s erlang halt
    assert_success
    assert_output '17'
}
