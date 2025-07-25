set(TARGET_NAME usd_ipc_broker)

set(BIN_NAME ${TARGET_NAME})
if(UNIX AND NOT APPLE)
    set(BIN_NAME "${BIN_NAME}.bin")
endif()
add_executable(${BIN_NAME} main.cpp)
if(WIN32)
    target_sources(${BIN_NAME} PRIVATE ${WIN32_MANIFEST})
endif()
make_folder("usd" ${TARGET_NAME})
target_link_libraries(${BIN_NAME} ${ZMQ_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})

target_include_directories(${BIN_NAME} PUBLIC ${ZMQ_INCLUDE_DIRS})

install(TARGETS ${BIN_NAME} RUNTIME DESTINATION bin)
if(MSVC)
    set_target_properties(
        ${BIN_NAME} PROPERTIES VS_DEBUGGER_COMMAND "${CMAKE_INSTALL_PREFIX}/bin/$<TARGET_FILE_NAME:${BIN_NAME}>"
                               VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_INSTALL_PREFIX}/bin")
    if(DCC_MAKE_VSDEBUG_LAUNCHER)
        set_target_properties(${BIN_NAME} PROPERTIES VS_DEBUGGER_ENVIRONMENT "${VS_ENVIRONMENT}")
    endif()
    install(
        FILES $<TARGET_PDB_FILE:${BIN_NAME}>
        DESTINATION bin
        OPTIONAL)
elseif(UNIX AND NOT APPLE)
    install(
        PROGRAMS ${PROJECT_SOURCE_DIR}/cmake/macros/launch_script.sh
        DESTINATION bin
        RENAME ${TARGET_NAME})
endif()
