set(viewport_h
    viewport/iviewport_tool_context.h
    viewport/tool_settings_view.h
    viewport/viewport_widget.h
    viewport/viewport_gl_widget.h
    viewport/viewport_ui_draw_manager.h
    viewport/viewport_hydra_engine.h
    viewport/ui_camera_mapper.h
    viewport/viewport_refine_manager.h
    viewport/shadow_matrix.h
    viewport/hd_selection_ext.h
    viewport/def_cam_settings.h
    viewport/viewport_render_settings_dialog.h
    viewport/viewport_scene_delegate.h
    viewport/viewport_scene_context.h
    viewport/viewport_usd_delegate.h
    viewport/viewport_dnd_callback_registry.h
    viewport/viewport_context_menu_registry.h
    viewport/viewport_dnd_callback.h
    viewport/viewport_dnd_controller.h
    viewport/viewport_view.h
    viewport/viewport_camera_mapper_factory.h
    viewport/viewport_camera_controller.h
    viewport/viewport_camera_mapper.h
    viewport/viewport_camera_menu_controller.h
    viewport/viewport_manipulator.h
    viewport/viewport_background_filler.h
    viewport/viewport_grid.h
    viewport/viewport_isolate_selection_command.h
    viewport/viewport_color_correction.h
    viewport/viewport_move_manipulator.h
    viewport/viewport_move_snap_strategy.h
    viewport/viewport_rotate_manipulator.h
    viewport/viewport_scale_manipulator.h
    viewport/viewport_manipulator_utils.h
    viewport/viewport_overlay.h
    viewport/iviewport_ui_extension.h
    viewport/iviewport_draw_extension.h
    viewport/prim_material_override.h
    viewport/hydra_render_settings.h
    viewport/istage_resolver.h
    viewport/usd_render.h
    viewport/viewport_usd_camera_mapper.h
    viewport/visibility_mask.h
    viewport/texture_plugin.h
    viewport/persistent_material_override.h
    viewport/render_process.h
    viewport/usd_viewport_locator_data.h
    viewport/viewport_camera_locator.h
    viewport/viewport_light_locators.h
    viewport/viewport_locator_data.h
    viewport/viewport_locator_delegate.h
    viewport/viewport_usd_locator.h
    viewport/viewport_usd_locator_registry.h
    viewport/viewport_volume_locator.h)

set(scene_indices_h viewport/scene_indices/hydra_engine_scene_indices_notifier.h
                    viewport/scene_indices/prune_scene_index_plugin.h)

set(scene_indices_cpp viewport/scene_indices/hydra_engine_scene_indices_notifier.cpp
                      viewport/scene_indices/prune_scene_index_plugin.cpp)

set(viewport_cpp
    viewport/iviewport_tool_context.cpp
    viewport/tool_settings_view.cpp
    viewport/viewport_widget.cpp
    viewport/viewport_gl_widget.cpp
    viewport/viewport_ui_draw_manager.cpp
    viewport/viewport_hydra_engine.cpp
    viewport/viewport_engine_proxy.cpp
    viewport/ui_camera_mapper.cpp
    viewport/viewport_refine_manager.cpp
    viewport/hd_selection_ext.cpp
    viewport/def_cam_settings.cpp
    viewport/viewport_render_settings_dialog.cpp
    viewport/viewport_scene_context.cpp
    viewport/viewport_scene_delegate.cpp
    viewport/viewport_usd_delegate.cpp
    viewport/viewport_dnd_callback_registry.cpp
    viewport/viewport_dnd_controller.cpp
    viewport/viewport_context_menu_registry.cpp
    viewport/viewport_view.cpp
    viewport/viewport_camera_mapper_factory.cpp
    viewport/viewport_camera_controller.cpp
    viewport/viewport_camera_menu_controller.cpp
    viewport/viewport_background_filler.cpp
    viewport/viewport_grid.cpp
    viewport/viewport_color_correction.cpp
    viewport/viewport_move_manipulator.cpp
    viewport/viewport_move_snap_strategy.cpp
    viewport/viewport_rotate_manipulator.cpp
    viewport/viewport_scale_manipulator.cpp
    viewport/viewport_manipulator_utils.cpp
    viewport/viewport_isolate_selection_command.cpp
    viewport/viewport_usd_camera_mapper.cpp
    viewport/iviewport_ui_extension.cpp
    viewport/prim_material_override.cpp
    viewport/hydra_render_settings.cpp
    viewport/usd_render.cpp
    viewport/visibility_mask.cpp
    viewport/texture_plugin.cpp
    viewport/persistent_material_override.cpp
    viewport/render_process.cpp
    viewport/usd_viewport_locator_data.cpp
    viewport/viewport_camera_locator.cpp
    viewport/viewport_camera_locator.h
    viewport/viewport_light_locators.cpp
    viewport/viewport_locator_data.cpp
    viewport/viewport_locator_delegate.cpp
    viewport/viewport_usd_locator.cpp
    viewport/viewport_usd_locator_registry.cpp
    viewport/viewport_volume_locator.cpp)

set(python_headers
    ui/wrap_shiboken.h
    core/wrap_session.h
    ui/wrap_panel.h
    core/wrap_application.h
    core/wrap_usd_clipboard.h
    viewport/wrap_prim_refine_manager.h
    viewport/wrap_def_cam_settings.h
    core/wrap_settings.h
    core/wrap_undo.h
    core/wrap_selection_list.h
    viewport/wrap_tool_context.h
    viewport/wrap_tool_settings_registry.h
    ui/wrap_node_icon_registry.h
    viewport/wrap_dnd_callback.h
    viewport/wrap_viewport_context_menu.h
    viewport/wrap_viewport_view.h
    ui/wrap_shader_node_registry.h)

set(python_src
    ui/wrap_shiboken.cpp
    core/wrap_session.cpp
    ui/wrap_panel.cpp
    core/wrap_application.cpp
    core/wrap_usd_clipboard.cpp
    viewport/wrap_prim_refine_manager.cpp
    viewport/wrap_def_cam_settings.cpp
    core/wrap_settings.cpp
    core/wrap_undo.cpp
    core/wrap_selection_list.cpp
    viewport/wrap_tool_context.cpp
    viewport/wrap_tool_settings_registry.cpp
    ui/wrap_node_icon_registry.cpp
    viewport/wrap_dnd_callback.cpp
    viewport/wrap_viewport_context_menu.cpp
    viewport/wrap_viewport_view.cpp
    ui/wrap_shader_node_registry.cpp)

set(undo_h core/undo/state_delegate.h core/undo/router.h core/undo/inverse.h core/undo/block.h core/undo/stack.h)

set(undo_cpp core/undo/state_delegate.cpp core/undo/router.cpp core/undo/inverse.cpp core/undo/block.cpp
             core/undo/stack.cpp)

set(logger_h ui/logger/usd_logging_delegate.h ui/logger/render_catalog.h ui/logger/render_log.h)

set(logger_cpp ui/logger/render_catalog.cpp ui/logger/render_log.cpp ui/logger/usd_logging_delegate.cpp)

set(headers_core
    core/api.h
    core/application.h
    core/session.h
    core/stage_watcher.h
    core/usd_edit_undo_watcher.h
    core/usd_edit_undo_command.h
    core/command_utils.h
    core/usd_clipboard.h
    core/settings.h
    core/selection_list.h
    core/rich_selection.h
    core/topology_cache.h
    core/half_edge_cache.h
    core/point_cloud_bvh.h
    core/mesh_bvh.h
    core/interval_vector.h
    core/sentry_logging_delegate.h
    core/py_interp.h)

set(src_core
    core/application.cpp
    core/session.cpp
    core/stage_watcher.cpp
    core/usd_edit_undo_watcher.cpp
    core/usd_edit_undo_command.cpp
    core/command_utils.cpp
    core/usd_clipboard.cpp
    core/settings.cpp
    core/selection_list.cpp
    core/rich_selection.cpp
    core/topology_cache.cpp
    core/half_edge_cache.cpp
    core/point_cloud_bvh.cpp
    core/mesh_bvh.cpp
    core/interval_vector.cpp
    core/sentry_logging_delegate.cpp
    core/py_interp.cpp)

set(headers_ui
    ui/application_ui.h
    ui/main_window.h
    ui/panel_factory.h
    ui/global_event_filter.h
    ui/qt_utils.h
    ui/node_icon_registry.h
    ui/shader_node_registry.h)

set(src_ui
    ui/application_ui.cpp
    ui/main_window.cpp
    ui/panel_factory.cpp
    ui/main_window_timeline.cpp
    ui/global_event_filter.cpp
    ui/qt_utils.cpp
    ui/node_icon_registry.cpp
    ui/shader_node_registry.cpp)


list(APPEND viewport_cpp viewport/viewport_overlay.cpp)

if(USD_VERSION VERSION_GREATER 0.19.11)
    # Offscreen render
    list(APPEND viewport_h viewport/offscreen_render.h viewport/viewport_render_frame_processor.h
         viewport/viewport_render_aovs.h viewport/usd_render_control.h)
    list(APPEND viewport_cpp viewport/offscreen_render.cpp viewport/viewport_render_aovs.cpp
         viewport/usd_render_control.cpp)

endif()

# canvas
if(USD_VERSION VERSION_GREATER_EQUAL 0.22.05)
    list(APPEND viewport_h viewport/iviewport_compositing_extension.h)
    list(APPEND viewport_cpp viewport/iviewport_compositing_extension.cpp)
endif()

if(USD_VERSION VERSION_GREATER_EQUAL 0.25.02)
    list(APPEND viewport_h viewport/hydra_ext_render_session_api_adapter.h
         viewport/hydra_ext_render_session_api_schema.h)
    list(APPEND viewport_cpp viewport/hydra_ext_render_session_api_adapter.cpp
         viewport/hydra_ext_render_session_api_schema.cpp)
endif()

qt5_add_resources(resources ${PROJECT_SOURCE_DIR}/icons/icons.qrc)

qt5_add_resources(resources ${CMAKE_CURRENT_SOURCE_DIR}/ui/resources/stylesheets.qrc)

source_group(
    TREE ${CMAKE_CURRENT_SOURCE_DIR}
    FILES ${src_core}
          ${headers_core}
          ${src_ui}
          ${headers_ui}
          ${viewport_h}
          ${viewport_cpp}
          ${python_headers}
          ${python_src}
          ${undo_h}
          ${undo_cpp}
          ${logger_h}
          ${logger_cpp})

setup_update_translations(qm_files)

add_library(
    opendcc_lib SHARED
    ${src_core}
    ${headers_core}
    ${src_ui}
    ${headers_ui}
    ${viewport_h}
    ${viewport_cpp}
    ${resources}
    ${qm_files}
    ${undo_h}
    ${undo_cpp}
    ${logger_h}
    ${logger_cpp}
    ${scene_indices_h}
    ${scene_indices_cpp})

if(DCC_EMBEDDED_PYTHON_HOME)
    target_compile_definitions(opendcc_lib PRIVATE -DOPENDCC_EMBEDDED_PYTHON_HOME)
endif()

target_include_directories(
    opendcc_lib
    PRIVATE "${PROJECT_SOURCE_DIR}/src/lib/"
            "${PROJECT_SOURCE_DIR}/src/lib/usd"
            ${TBB_INCLUDE_DIRS}
            ${Boost_INCLUDE_DIRS}
            ${PYTHON_INCLUDE_DIRS}
            ${PXR_INCLUDE_DIRS}
            ${EMBREE_INCLUDE_DIR})

set_property(TARGET opendcc_lib PROPERTY AUTOMOC ON)
target_compile_definitions(opendcc_lib PRIVATE -DOPENDCC_EXPORT -DBOOST_ALL_DYN_LINK -DBOOST_ALL_NO_LIB
                                               $<$<BOOL:${DCC_USE_HYDRA_FRAMING_API}>:OPENDCC_USE_HYDRA_FRAMING_API>)

get_target_property(PySide2_INCLUDE_DIR PySide2::pyside2 INTERFACE_INCLUDE_DIRECTORIES)
include_directories(${PySide2_INCLUDE_DIR}/QtCore/)
include_directories(${PySide2_INCLUDE_DIR}/QtGui/)
include_directories(${PySide2_INCLUDE_DIR}/QtWidgets/)
include_directories(${PySide2_INCLUDE_DIR})
include_directories(${python_include_dir})
include_directories(${shiboken_include_dir})

if(USD_VERSION VERSION_GREATER_EQUAL 0.22.05)
    target_link_libraries(opendcc_lib compositing)
endif()

target_link_libraries(opendcc_lib Shiboken2::libshiboken PySide2::pyside2)
target_link_libraries(opendcc_lib app_version app_config color_theme)
set_target_properties(opendcc_lib PROPERTIES OUTPUT_NAME opendcc_core)

include_directories(${OPENMESH_INCLUDE_DIRS})
target_link_libraries(opendcc_lib ${OPENMESH_LIBRARIES})

target_link_libraries(opendcc_lib crash_reporting Qt5::Network)

if(USD_VERSION VERSION_LESS_EQUAL 0.20.08)
    target_link_libraries(opendcc_lib ${GLEW_LIBRARY})
    target_include_directories(opendcc_lib PUBLIC ${GLEW_INCLUDE_DIR})
endif()

target_link_libraries(
    opendcc_lib
    ads::qtadvanceddocking
    test_runner
    packaging
    common_widgets
    timeline_widget
    layer_tree_watcher
    usd_ipc_serialization
    utils
    ipc_commands_api
    usd_fallback_proxy
    usd_live_share
    logger_panel
    $<$<BOOL:${DCC_BUILD_RENDER_VIEW}>:render_view_display_driver_api>
    render_system
    opendcc_base_tiny_process
    ocio_color_widgets
    hydra_render_session_api
    utils
    Qt5::Core
    Qt5::Gui
    Qt5::Svg
    Qt5::Widgets
    Qt5::OpenGL
    $<$<BOOL:${DCC_HOUDINI_SUPPORT}>:OpenGL::GL>
    $<$<BOOL:${DCC_KATANA_SUPPORT}>:OpenGL::GL>
    Qt5::Multimedia
    pybind11::pybind11
    ${Boost_PYTHON_LIBRARY}
    ${Boost_SYSTEM_LIBRARY}
    ${PYTHON_LIBRARY}
    ${TBB_LIBRARIES}
    ${OCIO_LIBRARIES}
    ${EMBREE_LIBRARY}
    ${OIIO_OpenImageIO_LIBRARY}
    ${OIIO_OpenImageIO_Util_LIBRARY}
    py_commands_api
    ar
    arch
    cameraUtil
    garch
    gf
    glf
    hd
    kind
    plug
    sdf
    tf
    usd
    usdGeom
    usdHydra
    usdImaging
    usdImagingGL
    usdRender
    usdUtils
    usdVol
    usdLux
    vt
    hdx
    jsoncpp
    opendcc.usd_editor.scene_indices)

target_include_directories(opendcc_lib PUBLIC ${OCIO_INCLUDE_DIRS} ${OIIO_INCLUDE_DIR} ${ILMBASE_INCLUDE_DIR}
                                              ${ILMBASE_INCLUDE_DIR}/OpenEXR ${ILMBASE_INCLUDE_DIR}/Imath)

if(WIN32)

    file(RELATIVE_PATH LIBRARY_LOCATION ${CMAKE_INSTALL_PREFIX}/plugin/opendcc/core_extension/resources/..
         ${CMAKE_INSTALL_PREFIX}/bin/)
else()
    file(RELATIVE_PATH LIBRARY_LOCATION ${CMAKE_INSTALL_PREFIX}/plugin/opendcc/core_extension/resources/..
         ${CMAKE_INSTALL_PREFIX}/lib/)
endif()

if(USD_VERSION VERSION_GREATER_EQUAL 0.21.08)
    set(TEXTURE_PLUGIN_BASE HioImage)
else()
    set(TEXTURE_PLUGIN_BASE GlfImage)
endif()
configure_file("${CMAKE_CURRENT_SOURCE_DIR}/core/plugInfo.json.in" "${CMAKE_CURRENT_BINARY_DIR}/core/plugInfo.json"
               @ONLY)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/core/plugInfo.json
        DESTINATION ${CMAKE_INSTALL_PREFIX}/plugin/opendcc/core_extension/resources/)

configure_file("${CMAKE_CURRENT_SOURCE_DIR}/viewport/shaders/depth_compositor.glslfx.in"
               "${CMAKE_CURRENT_BINARY_DIR}/viewport/shaders/depth_compositor.glslfx" @ONLY)

install(DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/viewport/shaders"
        DESTINATION "${CMAKE_INSTALL_PREFIX}/plugin/opendcc/core_extension/resources/")

add_library(opendcc_lib_python_core SHARED core/python_module.cpp ${python_headers} ${python_src})
target_link_libraries(opendcc_lib_python_core py_utils opendcc_lib)

if(MSVC)
    set_target_properties(opendcc_lib_python_core PROPERTIES SUFFIX ".pyd")
else()
    set_target_properties(opendcc_lib_python_core PROPERTIES SUFFIX ".so")
endif()

set_target_properties(opendcc_lib_python_core PROPERTIES PREFIX "" OUTPUT_NAME _core)

install(
    TARGETS opendcc_lib_python_core
    RUNTIME DESTINATION ${DCC_PYTHON_INSTALL_SITE_PACKAGES_ROOT}/opendcc/core
    LIBRARY DESTINATION ${DCC_PYTHON_INSTALL_SITE_PACKAGES_ROOT}/opendcc/core)

if(MSVC)
    install(
        FILES $<TARGET_PDB_FILE:opendcc_lib_python_core>
        DESTINATION ${DCC_PYTHON_INSTALL_SITE_PACKAGES_ROOT}/opendcc/core
        OPTIONAL)
endif()

install(
    TARGETS opendcc_lib
    # EXPORT opendcc_lib-targets
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    INCLUDES
    DESTINATION include/opendcc)

install(
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/" # source directory
    DESTINATION "${CMAKE_INSTALL_PREFIX}/include/opendcc" # target directory
    FILES_MATCHING # install only matched files
    PATTERN "*.h" # select header files
)

if(MSVC)
    install(
        FILES $<TARGET_PDB_FILE:opendcc_lib>
        DESTINATION bin
        OPTIONAL)
endif()

install(
    CODE "file(WRITE \"${CMAKE_INSTALL_PREFIX}/plugin/opendcc/plugInfo.json\" \"{\n    \\\"Includes\\\": [ \\\"*/resources/\\\" ]\n}\")"
)