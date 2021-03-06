function(run_tests)
  execute_process(COMMAND ${TEST_EXECUTABLE} ${ARGN} RESULT_VARIABLE result ECHO_OUTPUT_VARIABLE COMMAND_ECHO STDOUT)
  if(NOT "${result}" STREQUAL "0")
    message(FATAL_ERROR "Test failed with return value '${result}'")
  endif()              
endfunction()

if(NOT DEFINED ENV{TESTS_ARGUMENTS})
  set(TESTS_ARGUMENTS "-R unit")
else()
  set(TESTS_ARGUMENTS $ENV{TESTS_ARGUMENTS})
endif()
separate_arguments(TESTS_ARGUMENTS_LIST UNIX_COMMAND ${TESTS_ARGUMENTS})
run_tests("${TESTS_ARGUMENTS_LIST}")
