cmake_minimum_required(VERSION 3.17)

project(MusiQ)

set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_STANDARD_REQUIRED true)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(MUSIQ_SOURCES
    source/main.cpp
    source/roundedrect.cpp
    source/appsetting.cpp
    source/backend.cpp
    source/dataprovider.cpp
    source/dbmanager.cpp
    source/liveimageprovider.cpp
    source/mostplayedlist.cpp
    source/simpleqabstractlist.cpp
    source/songitemmodeler.cpp
    source/tools.cpp
    )

set(MUSIQ_HEADERS
    include/roundedrect.h
    include/appsetting.h
    include/backend.h
    include/dataprovider.h
    include/dbmanager.h
    include/liveimageprovider.h
    include/mostplayedlist.h
    include/simpleqabstractlist.h
    include/songitemmodeler.h
    include/tools.h
    include/structures.h
    )

set(QRC_FILE
    qml.qrc
    icons.qrc
    files.qrc
    )

find_package(Qt5 COMPONENTS Quick Quick Sql Multimedia QuickControls2 AndroidExtras REQUIRED)


if (WIN32)
    add_executable(MusiQ ${MUSIQ_SOURCES} ${QRC_FILE} ${MUSIQ_HEADERS})
    target_link_libraries(MusiQ "${CMAKE_CURRENT_SOURCE_DIR}/Dependencies/TagLib/lib/tagd.lib")
    target_link_libraries(MusiQ "${CMAKE_CURRENT_SOURCE_DIR}/Dependencies/zlib/lib/zlibd.lib")
elseif(UNIX AND NOT ANDROID)
    add_executable(MusiQ ${MUSIQ_SOURCES} ${QRC_FILE} ${MUSIQ_HEADERS})
    target_link_libraries(MusiQ -ltag)
elseif(ANDROID)
    find_package(AndroidExtras)
    add_library(MusiQ SHARED
        ${MUSIQ_SOURCES} ${QRC_FILE} ${MUSIQ_HEADERS}
    )
    message("BUILD FOR ANDROID ...")
    target_link_libraries(MusiQ "${CMAKE_CURRENT_SOURCE_DIR}/Dependencies/TagLib/lib/libtag.a"
        "${CMAKE_CURRENT_SOURCE_DIR}/Dependencies/zlib/lib/libz.a")
endif()

target_include_directories(MusiQ PUBLIC "./include/" ${CMAKE_CURRENT_SOURCE_DIR}/Dependencies/TagLib/include)
target_include_directories(MusiQ PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/Dependencies/zlib/include/)
target_include_directories(MusiQ PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/Dependencies/TagLib/include/mpeg/id3v1/)
target_include_directories(MusiQ PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/Dependencies/TagLib/include/mpeg/id3v2)

target_link_libraries(MusiQ Qt5::Quick)
target_link_libraries(MusiQ Qt5::Core)
target_link_libraries(MusiQ Qt5::Sql)
target_link_libraries(MusiQ Qt5::Multimedia)
target_link_libraries(MusiQ Qt5::QuickControls2)

if (ANDROID)
    target_link_libraries(MusiQ Qt5::AndroidExtras)
endif()
