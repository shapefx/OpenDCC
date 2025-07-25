# Module to find IlmBase
#
# This module will first look into the directories defined by the variables: - ILMBASE_HOME, ILMBASE_VERSION,
# ILMBASE_LIB_AREA
#
# It also supports non-standard names for the library components.
#
# To use a custom IlmBase: - Set the variable ILMBASE_CUSTOM to True - Set the variable ILMBASE_CUSTOM_LIBRARIES to a
# list of the libraries to use, e.g. "SpiImath SpiHalf SpiIlmThread SpiIex" - Optionally set the variable
# ILMBASE_CUSTOM_INCLUDE_DIR to any particularly weird place that the OpenEXR/*.h files may be found - Optionally set
# the variable ILMBASE_CUSTOM_LIB_DIR to any particularly weird place that the libraries files may be found
#
# This module defines the following variables:
#
# ILMBASE_INCLUDE_DIR - where to find half.h, IlmBaseConfig.h, etc. ILMBASE_LIBRARIES   - list of libraries to link
# against when using IlmBase. ILMBASE_FOUND       - True if IlmBase was found.

# Other standarnd issue macros
include(FindPackageHandleStandardArgs)
include(FindPackageMessage)
include(SelectLibraryConfigurations)

if(ILMBASE_USE_STATIC_LIBS)
    set(_ilmbase_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES})
    if(WIN32)
        set(CMAKE_FIND_LIBRARY_SUFFIXES .lib .a ${CMAKE_FIND_LIBRARY_SUFFIXES})
    else()
        set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
    endif()
endif()

# Macro to assemble a helper state variable
macro(SET_STATE_VAR varname)
    set(tmp_ilmbaselibs ${ILMBASE_CUSTOM_LIBRARIES})
    separate_arguments(tmp_ilmbaselibs)
    set(tmp_lst
        ${ILMBASE_CUSTOM}
        |
        ${tmp_ilmbaselibs}
        |
        ${ILMBASE_HOME}
        |
        ${ILMBASE_VERSION}
        |
        ${ILMBASE_LIB_AREA})
    set(${varname} "${tmp_lst}")
    unset(tmp_ilmbaselibs)
    unset(tmp_lst)
endmacro()

# To enforce that find_* functions do not use inadvertently existing versions
if(ILMBASE_CUSTOM)
    set(ILMBASE_FIND_OPTIONS "NO_DEFAULT_PATH")
endif()

# Macro to search for an include directory
macro(PREFIX_FIND_INCLUDE_DIR prefix includefile libpath_var)
    string(TOUPPER ${prefix}_INCLUDE_DIR tmp_varname)
    find_path(
        ${tmp_varname} ${includefile}
        HINTS ${${libpath_var}}
        PATH_SUFFIXES include ${ILMBASE_FIND_OPTIONS})
    if(${tmp_varname})
        mark_as_advanced(${tmp_varname})
    endif()
    unset(tmp_varname)
endmacro()

# Macro to search for the given library and adds the cached variable names to the specified list
macro(PREFIX_FIND_LIB prefix libname libpath_var liblist_var cachelist_var)
    string(TOUPPER ${prefix}_${libname} tmp_prefix)
    # Handle new library names for OpenEXR 2.1 build via cmake
    string(REPLACE "." "_" _ILMBASE_VERSION ${ILMBASE_VERSION})
    string(SUBSTRING ${_ILMBASE_VERSION} 0 3 _ILMBASE_VERSION)

    find_library(
        ${tmp_prefix}_LIBRARY_RELEASE
        NAMES ${libname}${ILMBASE_LIB_POSTFIX} ${libname}-${_ILMBASE_VERSION}${ILMBASE_LIB_POSTFIX}
        HINTS ${${libpath_var}}
        PATH_SUFFIXES lib ${ILMBASE_FIND_OPTIONS})
    find_library(
        ${tmp_prefix}_LIBRARY_DEBUG
        NAMES ${libname}d${ILMBASE_LIB_POSTFIX} ${libname}_d${ILMBASE_LIB_POSTFIX} ${libname}debug${ILMBASE_LIB_POSTFIX}
              ${libname}_debug${ILMBASE_LIB_POSTFIX}
        HINTS ${${libpath_var}}
        PATH_SUFFIXES lib ${ILMBASE_FIND_OPTIONS})
    # Properly define ${tmp_prefix}_LIBRARY (cached) and ${tmp_prefix}_LIBRARIES
    select_library_configurations(${tmp_prefix})
    list(APPEND ${liblist_var} ${tmp_prefix}_LIBRARIES)

    # Add to the list of variables which should be reset
    list(APPEND ${cachelist_var} ${tmp_prefix}_LIBRARY ${tmp_prefix}_LIBRARY_RELEASE ${tmp_prefix}_LIBRARY_DEBUG)
    mark_as_advanced(${tmp_prefix}_LIBRARY ${tmp_prefix}_LIBRARY_RELEASE ${tmp_prefix}_LIBRARY_DEBUG)
    unset(tmp_prefix)
endmacro()

# Encode the current state of the external variables into a string
set_state_var(ILMBASE_CURRENT_STATE)

# If the state has changed, clear the cached variables
if(ILMBASE_CACHED_STATE AND NOT ILMBASE_CACHED_STATE STREQUAL ILMBASE_CURRENT_STATE)

    foreach(libvar ${ILMBASE_CACHED_VARS})
        unset(${libvar} CACHE)
    endforeach()
endif()

# Generic search paths
set(IlmBase_generic_include_paths ${ILMBASE_CUSTOM_INCLUDE_DIR} /usr/include /usr/include/${CMAKE_LIBRARY_ARCHITECTURE}
                                  /usr/local/include /sw/include /opt/local/include)
set(IlmBase_generic_library_paths
    ${ILMBASE_CUSTOM_LIB_DIR}
    /usr/lib
    /usr/lib/${CMAKE_LIBRARY_ARCHITECTURE}
    /usr/local/lib
    /usr/local/lib/${CMAKE_LIBRARY_ARCHITECTURE}
    /sw/lib
    /opt/local/lib)
set(ILMBASE_LIB_POSTFIX
    ""
    CACHE STRING "ILMBASE library postfix")

# Search paths for the IlmBase files
if(ILMBASE_HOME)
    if(ILMBASE_VERSION)
        set(IlmBase_include_paths ${ILMBASE_HOME}/ilmbase-${ILMBASE_VERSION}/include
                                  ${ILMBASE_HOME}/include/ilmbase-${ILMBASE_VERSION})
        set(IlmBase_library_paths ${ILMBASE_HOME}/ilmbase-${ILMBASE_VERSION}/lib
                                  ${ILMBASE_HOME}/lib/ilmbase-${ILMBASE_VERSION})
    endif()
    list(APPEND IlmBase_include_paths ${ILMBASE_HOME}/include)
    set(IlmBase_library_paths ${ILMBASE_HOME}/lib ${ILMBASE_HOME}/lib64 ${ILMBASE_LIB_AREA} ${IlmBase_library_paths})
endif()
list(APPEND IlmBase_include_paths ${IlmBase_generic_include_paths})
list(APPEND IlmBase_library_paths ${IlmBase_generic_library_paths})

# Locate the header files
prefix_find_include_dir(IlmBase OpenEXR/IlmBaseConfig.h IlmBase_include_paths)

if(NOT ILMBASE_INCLUDE_DIR)
    prefix_find_include_dir(IlmBase OpenEXR/OpenEXRConfig.h IlmBase_include_paths)
endif()

if(ILMBASE_INCLUDE_DIR)
    # Get the version from config file, if not already set.
    if(NOT ILMBASE_VERSION)
        if(EXISTS "${ILMBASE_INCLUDE_DIR}/OpenEXR/IlmBaseConfig.h")
            set(ILMBASE_VERSION_STRING ILMBASE_VERSION_STRING)
            file(STRINGS "${ILMBASE_INCLUDE_DIR}/OpenEXR/IlmBaseConfig.h" ILMBASE_BUILD_SPECIFICATION
                 REGEX "^[ \t]*#define[ \t]+${ILMBASE_VERSION_STRING}[ \t]+\"[.0-9]+\".*$")
        else()
            set(ILMBASE_VERSION_STRING OPENEXR_VERSION_STRING)
            file(STRINGS "${ILMBASE_INCLUDE_DIR}/OpenEXR/OpenEXRConfig.h" ILMBASE_BUILD_SPECIFICATION
                 REGEX "^[ \t]*#define[ \t]+${ILMBASE_VERSION_STRING}[ \t]+\"[.0-9]+\".*$")
        endif()

        if(ILMBASE_BUILD_SPECIFICATION)
            if(NOT IlmBase_FIND_QUIETLY)
                message(STATUS "${ILMBASE_BUILD_SPECIFICATION}")
            endif()
            string(REGEX REPLACE ".*#define[ \t]+${ILMBASE_VERSION_STRING}[ \t]+\"([.0-9]+)\".*" "\\1" XYZ
                                 ${ILMBASE_BUILD_SPECIFICATION})
            set("ILMBASE_VERSION"
                ${XYZ}
                CACHE STRING "Version of ILMBase lib")
        else()
            # Old versions (before 2.0?) do not have any version string, just assuming 2.0 should be fine though.
            message(WARNING "Could not determine ILMBase library version, assuming 2.0.")
            set("ILMBASE_VERSION"
                "2.0"
                CACHE STRING "Version of ILMBase lib")
        endif()
    endif()
endif()

if(ILMBASE_CUSTOM)
    if(NOT ILMBASE_CUSTOM_LIBRARIES)
        message(FATAL_ERROR "Custom IlmBase libraries requested but ILMBASE_CUSTOM_LIBRARIES is not set.")
    endif()
    set(IlmBase_Libraries ${ILMBASE_CUSTOM_LIBRARIES})
    separate_arguments(IlmBase_Libraries)
elseif(ILMBASE_VERSION VERSION_LESS "3.0.0")
    set(IlmBase_Libraries Half Iex Imath IlmThread)
else()
    set(IlmBase_Libraries Iex Imath IlmThread)
endif()

# Locate the IlmBase libraries
set(IlmBase_libvars "")
set(IlmBase_cachevars "")
foreach(ilmbase_lib ${IlmBase_Libraries})
    prefix_find_lib(IlmBase ${ilmbase_lib} IlmBase_library_paths IlmBase_libvars IlmBase_cachevars)
endforeach()
# Create the list of variables that might need to be cleared
set(ILMBASE_CACHED_VARS
    ILMBASE_INCLUDE_DIR ${IlmBase_cachevars}
    CACHE INTERNAL "Variables set by FindIlmBase.cmake" FORCE)

# Store the current state so that variables might be cleared if required
set(ILMBASE_CACHED_STATE
    ${ILMBASE_CURRENT_STATE}
    CACHE INTERNAL "State last seen by FindIlmBase.cmake" FORCE)

# Link with pthreads if required
if(NOT WIN32 AND EXISTS ${ILMBASE_INCLUDE_DIR}/OpenEXR/IlmBaseConfig.h)
    file(STRINGS ${ILMBASE_INCLUDE_DIR}/OpenEXR/IlmBaseConfig.h ILMBASE_HAVE_PTHREAD
         REGEX "^[ \\t]*#define[ \\t]+HAVE_PTHREAD[ \\t]1[ \\t]*\$")
    if(ILMBASE_HAVE_PTHREAD)
        find_package(Threads)
        if(CMAKE_USE_PTHREADS_INIT)
            set(ILMBASE_PTHREADS ${CMAKE_THREAD_LIBS_INIT})
        endif()
    endif()
endif()

# Use the standard function to handle ILMBASE_FOUND
find_package_handle_standard_args(IlmBase DEFAULT_MSG ILMBASE_INCLUDE_DIR ${IlmBase_libvars})

if(ILMBASE_FOUND)
    set(ILMBASE_LIBRARIES "")
    foreach(tmplib ${IlmBase_libvars})
        list(APPEND ILMBASE_LIBRARIES ${${tmplib}})
    endforeach()
    list(APPEND ILMBASE_LIBRARIES ${ILMBASE_PTHREADS})
    if(NOT IlmBase_FIND_QUIETLY)
        find_package_message(ILMBASE "Found IlmBase: ${ILMBASE_LIBRARIES}"
                             "[${ILMBASE_INCLUDE_DIR}][${ILMBASE_LIBRARIES}][${ILMBASE_CURRENT_STATE}]")
    endif()
endif()

# Restore the original find library ordering
if(ILMBASE_USE_STATIC_LIBS)
    set(CMAKE_FIND_LIBRARY_SUFFIXES ${_ilmbase_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES})
endif()

# Unset the helper variables to avoid pollution
unset(ILMBASE_CURRENT_STATE)
unset(IlmBase_include_paths)
unset(IlmBase_library_paths)
unset(IlmBase_generic_include_paths)
unset(IlmBase_generic_library_paths)
unset(IlmBase_libvars)
unset(IlmBase_cachevars)
unset(ILMBASE_PTHREADS)
