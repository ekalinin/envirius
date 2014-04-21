#!/usr/bin/env bats

load test_helper

@test "ls-cache: arc/src/build" {
    local cache_target_size=$(ls -l $NV_HOME/cache/arc | wc -l)
    cache_size=$(nv ls-cache --arc | wc -l)
    [ "$cache_target_size" = "$cache_size" ]

    local cache_target_size=$(ls -l $NV_HOME/cache/src | wc -l)
    cache_size=$(nv ls-cache --src | wc -l)
    [ "$cache_target_size" = "$cache_size" ]

    local cache_target_size=$(ls -l $NV_HOME/cache/build | wc -l)
    cache_size=$(nv ls-cache --build | wc -l)
    [ "$cache_target_size" = "$cache_size" ]
}
