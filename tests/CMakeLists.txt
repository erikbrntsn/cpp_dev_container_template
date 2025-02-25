include(GoogleTest)

file(GLOB TEST_FILES "*.cpp")
add_executable(unit_tests ${TEST_FILES})

target_include_directories(unit_tests PRIVATE ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(unit_tests
    PRIVATE
    ${PROJECT_NAME}_lib
    GTest::gmock_main
)

gtest_discover_tests(unit_tests DISCOVER_MORE_PRE_TEST)