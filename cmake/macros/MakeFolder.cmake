function(make_folder FOLDER_NAME)
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        foreach(PROJ ${ARGN})
            set_property(TARGET ${PROJ} PROPERTY FOLDER ${FOLDER_NAME})
        endforeach(PROJ)
    endif()
endfunction(make_folder)
