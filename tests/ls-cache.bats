#!/usr/bin/env bats

load test_helper

@test "ls-cache: it has to be non empty (as previus tests filled it)" {
    cache_size=$(nv ls-cache | wc -l)
    [ $cache_size != "0" ]
}
