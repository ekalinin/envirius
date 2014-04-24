#!/usr/bin/env bats

load test_helper

@test "common: nv_cmd_name" {
    run nv_cmd_name
    assert_success
    assert_output "nv"
}

@test "common: nv_bold" {
    run nv_bold "test-string"
    assert_success
    assert_output "`tput bold`test-string`tput sgr0`"
}

@test "common: nv_show_usage" {
    run nv_show_usage "test_cmd"
    assert_success
    assert_output "`nv_bold 'Usage'`: `nv_cmd_name` test_cmd"

    SUBCOMMAND="test_cmd" run nv_show_usage "--help"
    assert_success
    assert_output "`nv_bold 'Usage'`: `nv_cmd_name` test_cmd --help"
}

@test "common: nv_show_desc" {
    run nv_show_desc "testing with bats"
    assert_success
    assert_output "`nv_bold 'Description'`: testing with bats"
}

@test "common: nv_lpad" {
    run nv_lpad "cmd" 5
    assert_success
    assert_output "  cmd"

    run nv_lpad "cmd" 5 "+"
    assert_success
    assert_output "++cmd"
}

@test "common: nv_rpad" {
    run nv_rpad "cmd" 5
    assert_success
    assert_output "cmd  "

    run nv_rpad "cmd" 5 "+"
    assert_success
    assert_output "cmd++"
}

@test "common: nv_get_plugin_name" {
    run nv_get_plugin_name "--rust=0.9"
    assert_success
    assert_output "rust"

    run nv_get_plugin_name "--go=1.2rc4"
    assert_success
    assert_output "go"

    run nv_get_plugin_name "--erlang=17.0-rc1"
    assert_success
    assert_output "erlang"
}

@test "common: nv_get_plugin_version" {
    run nv_get_plugin_version "--rust=0.9"
    assert_success "0.9"

    run nv_get_plugin_version "--go=1.2rc4"
    assert_success "1.2rc4"

    run nv_get_plugin_version "--erlang=17.0-rc1"
    assert_success "17.0-rc1"

    run nv_get_plugin_version "--erlang"
    assert_success ""
}

@test "common: nv_get_cpu_count" {
    run nv_get_cpu_count
    assert_success
    assert_range "${output}" 1 1024
}

@test "common: nv_get_time_diff" {
    local start_dt=$(nv_get_time)
    local timeout=2
    sleep $timeout
    run nv_get_time_diff $start_dt
    assert_success
    assert_output "$timeout"
}

@test "common: nv_get_env_full_path" {
    # see setup in "test_helper.bash"
    local TEST_HOME="$HOME/tmp/envirius-tests/envs"

    run nv_get_env_full_path
    assert_success
    assert_output "$TEST_HOME"

    run nv_get_env_full_path "test-env"
    assert_success
    assert_output "$TEST_HOME/test-env"
}

@test "common: nv_get_plugin_full_path" {
    # see setup in "test_helper.bash"
    local TEST_PATH="$BATS_TEST_DIRNAME/../src/nv-plugins"

    run nv_get_plugin_full_path
    assert_success
    assert_output "$TEST_PATH"

    run nv_get_plugin_full_path "test-plugin"
    assert_success
    assert_output "$TEST_PATH/test-plugin"
}

@test "common: nv_get_command_full_path" {
    # see setup in "test_helper.bash"
    local TEST_PATH="$BATS_TEST_DIRNAME/../src/nv-commands"

    run nv_get_command_full_path
    assert_success
    assert_output "$TEST_PATH"

    run nv_get_command_full_path "test-command"
    assert_success
    assert_output "$TEST_PATH/test-command"
}

@test "common: nv_get_cache_full_path" {
    # see setup in "test_helper.bash"
    local TEST_HOME="$HOME/tmp/envirius-tests/cache"

    run nv_get_cache_full_path
    assert_success
    assert_output "$TEST_HOME"

    run nv_get_cache_full_path "test-cache-entry"
    assert_success
    assert_output "$TEST_HOME/test-cache-entry"
}

@test "common: nv_get_first_non_opt_value" {
    run nv_get_first_non_opt_value "--opt1=v1" "name" "--opt2=v3"
    assert_success
    assert_output "name"

    run nv_get_first_non_opt_value "name" "name2"
    assert_success
    assert_output "name"

    run nv_get_first_non_opt_value "--opt1=v1"
    assert_success
    assert_output ""
}

@test "common: nv_get_filename (fs path)" {
    run nv_get_filename "/some/path/to/file.txt"
    assert_success
    assert_output "file.txt"
}

@test "common: nv_get_filename (url)" {
    run nv_get_filename "http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-src.tar.bz2"
    assert_success
    assert_output "ghc-7.6.3-src.tar.bz2"
}

@test "common: nv_get_filename_ext" {
    run nv_get_filename_ext "ghc-7.6.3-src.tar.bz2"
    assert_success
    assert_output "tar.bz2"
}

@test "common: nv_get_system_arch" {
    run nv_get_system_arch "32bit" "64bit"
    assert_success
    if [ "`uname -m`" = "i686" ]; then
        assert_output "32bit"
    else
        assert_output "64bit"
    fi
}

@test "common: nv_get_system" {
    run nv_get_system "linux" "osx"
    assert_success
    if [ "`uname`" = "Linux" ]; then
        assert_output "linux"
    else
        assert_output "osx"
    fi
}

@test "common: nv_get_build_path" {
    run nv_get_build_path "new-plugin" "version1"
    assert_success
    assert_output "`nv_get_cache_full_path "build/new-plugin-version1-build"`"

    run nv_get_build_path
    assert_success
    assert_output "`nv_get_cache_full_path "build/"`"
}

@test "common: nv_get_src_path" {
    run nv_get_src_path "new-plugin" "version1"
    assert_success
    assert_output "`nv_get_cache_full_path "src/new-plugin-version1-src"`"

    run nv_get_src_path
    assert_success
    assert_output "`nv_get_cache_full_path "src/"`"
}

@test "common: nv_get_arc_path" {
    run nv_get_arc_path "new-plugin-source.tar.gz"
    assert_success
    assert_output "`nv_get_cache_full_path "arc/new-plugin-source.tar.gz"`"

    run nv_get_arc_path
    assert_success
    assert_output "`nv_get_cache_full_path "arc/"`"
}

@test "common: nv_get_env_info_path" {
    local target="$NV_HOME/envs/test_env/envirius.info"
    local actual=$(nv_get_env_info_path "test_env")
    assert_equal "$target" "$actual"
}

@test "common: nv_semver_get_major" {
    assert_equal "$(nv_semver_get_major '2.1.0')" "2"
}

@test "common: nv_semver_get_minor" {
    assert_equal "$(nv_semver_get_minor '2.1.0')" "1"
}

@test "common: nv_semver_get_patch" {
    assert_equal "$(nv_semver_get_patch '2.1.0')" "0"
}

@test "common: nv_semver_get_special" {
    assert_equal "$(nv_semver_get_special '2.1.0-RC1')" "-RC1"
}
