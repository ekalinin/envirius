setup() {
    export MEM_PATH="$BATS_TEST_DIRNAME/../src"
    export MEM_HOME="$HOME/tmp/mem-tests-home"
    mkdir -p $MEM_HOME
    . $BATS_TEST_DIRNAME/../src/mem
    mem rm --all
}

assert_equal() {
  if [ "$1" != "$2" ]; then
    echo "expected: $1"
    echo "actual:   $2"
    return 1
  fi
}

assert_output() {
    assert_equal "$1" "$output"
}

assert_success() {
  if [ "$status" -ne 0 ]; then
    echo "command failed with exit status $status"
    return 1
  elif [ "$#" -gt 0 ]; then
    assert_output "$1"
  fi
}
