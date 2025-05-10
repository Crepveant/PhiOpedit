cmake_minimum_required(VERSION 3.16)

project(PhiOpedit VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Quick
    ShaderTools
)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(PhiOpedit
    main.cpp
)

# QML & code
qt_add_qml_module(PhiOpedit
    URI PhiOpedit
    VERSION 1.0
    QML_FILES
        Main.qml
        SongHighlightBox.qml
        SongStrip.qml

    RESOURCES
        resources.qrc
    SOURCES
        SongLoader.h
        SongLoader.cpp
        RESOURCES README.md
        RESOURCES LICENSE
)

set_target_properties(PhiOpedit PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(PhiOpedit PRIVATE
    Qt6::Quick
    Qt6::ShaderTools
)

include(GNUInstallDirs)
install(TARGETS PhiOpedit
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
