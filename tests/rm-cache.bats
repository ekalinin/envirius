#!/usr/bin/env bats

load test_helper

@test "rm-cache: check remove on entry" {
    cache_size_init=$(nv ls-cache --arc| wc -l)
    first_entry=$(nv ls-cache --arc | head -n 2 | tail -n 1)

    run nv rm-cache --arc "$first_entry"
    assert_success

    cache_size=$(nv ls-cache --arc | wc -l)
    cache_size_should_be=`expr $cache_size_init - 1`
    assert_equal "$cache_size_should_be" "$cache_size"
}
