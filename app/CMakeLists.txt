file(GLOB APP_FILES "*.cpp")

foreach(app_file ${APP_FILES})
    get_filename_component(executable_name ${app_file} NAME_WE)
    add_executable(${executable_name} ${app_file})
    target_link_libraries(${executable_name} ${PROJECT_NAME}_lib)
    target_include_directories(${executable_name} PRIVATE ${PROJECT_SOURCE_DIR}/src)
endforeach()

