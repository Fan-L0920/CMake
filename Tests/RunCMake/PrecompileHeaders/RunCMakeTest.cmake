cmake_policy(SET CMP0057 NEW)
include(RunCMake)

function(run_test name)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/${name}-build)
  run_cmake(${name})
  # Precompiled headers are not supported with multiple architectures.
  if(NOT "$ENV{CMAKE_OSX_ARCHITECTURES}" MATCHES "[;$]")
    set(RunCMake_TEST_NO_CLEAN 1)
    run_cmake_command(${name}-build ${CMAKE_COMMAND} --build . --config Debug)
    run_cmake_command(${name}-test ${CMAKE_CTEST_COMMAND} -C Debug)
  endif()
endfunction()

run_cmake(DisabledPch)
run_test(PchInterface)
run_cmake(PchPrologueEpilogue)
run_test(SkipPrecompileHeaders)
