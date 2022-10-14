option(BUILD_SHARED_LIBS "" 0)

macro(bazel)
    execute_process(COMMAND bazel ${ARGN} COMMAND_ERROR_IS_FATAL ANY OUTPUT_STRIP_TRAILING_WHITESPACE)
endmacro()

bazel(info workspace OUTPUT_VARIABLE BAZEL_WORKSPACE)

bazel(info output_base OUTPUT_VARIABLE BAZEL_OUTPUT_BASE)
string(REPLACE "-" "_" BAZEL_EXEC_ROOT ${PROJECT_NAME})
set(BAZEL_EXEC_ROOT ${BAZEL_OUTPUT_BASE}/execroot/${BAZEL_EXEC_ROOT})

bazel(query "kind(generate_cmake, //...)" OUTPUT_VARIABLE BAZEL_GENERATE_CMAKE_TARGETS)
bazel(build ${BAZEL_GENERATE_CMAKE_TARGETS})

string(REPLACE "//" "" BAZEL_GENERATE_CMAKE_TARGETS "${BAZEL_GENERATE_CMAKE_TARGETS}")
string(REPLACE ":" "/" BAZEL_GENERATE_CMAKE_TARGETS "${BAZEL_GENERATE_CMAKE_TARGETS}")

foreach (target ${BAZEL_GENERATE_CMAKE_TARGETS})
    include(${BAZEL_WORKSPACE}/bazel-bin/${target}.cmake)
endforeach ()

if (CMAKE_EXPORT_COMPILE_COMMANDS)
    file(CREATE_LINK ${PROJECT_BINARY_DIR}/compile_commands.json ${PROJECT_SOURCE_DIR}/compile_commands.json)
endif ()
