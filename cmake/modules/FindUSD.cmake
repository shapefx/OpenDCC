if(DCC_HOUDINI_SUPPORT)
    include("${CMAKE_CURRENT_LIST_DIR}/FindHoudiniUSD.cmake")
elseif(DCC_KATANA_SUPPORT)
    if(UNIX)
        set(PXR_LIB_PREFIX libfn)
    else()
        set(PXR_LIB_PREFIX fn)
    endif()
    include("${CMAKE_CURRENT_LIST_DIR}/FindKatanaUSD.cmake")
else()
    include("${CMAKE_CURRENT_LIST_DIR}/FindPxrUSD.cmake")
    include(${USD_CONFIG_FILE})
    link_directories(${USD_LIBRARY_DIR})
endif()
