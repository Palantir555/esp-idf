#
# Component Makefile
#

ifdef CONFIG_XIVELY_CLIENT

#Debug config
ifdef CONFIG_XI_DEBUG_OUTPUT
CPPFLAGS += -DXI_DEBUG_OUTPUT=1
else
CPPFLAGS += -DXI_DEBUG_OUTPUT=0
endif

ifdef CONFIG_XI_DEBUG_EXTRA_INFO
CPPFLAGS += -DXI_DEBUG_EXTRA_INFO=1
else
CPPFLAGS += -DXI_DEBUG_EXTRA_INFO=0
endif

ifdef CONFIG_XI_DEBUG_ASSERT
CPPFLAGS += -DXI_DEBUG_ASSERT=1
else
CPPFLAGS += -DXI_DEBUG_ASSERT=0
endif

#SFT config
ifdef CONFIG_XI_SECURE_FILE_TRANSFER_ENABLED
CPPFLAGS +=                           \
    -DXI_SECURE_FILE_TRANSFER_ENABLED \
    -DXI_FS_MEMORY                    \
    -DUSE_CBOR_CONTEXT                \
    -DXI_CONTROL_TOPIC_ENABLED
endif

#CPPFLAGS +=                                             \
#    -DXI_DEBUG_OUTPUT=$(CONFIG_XI_DEBUG_OUTPUT)         \
#    -DXI_DEBUG_ASSERT=$(CONFIG_XI_DEBUG_ASSERT)         \
#    -DXI_DEBUG_EXTRA_INFO=$(CONFIG_XI_DEBUG_EXTRA_INFO) \
#                                      \
#    -DXI_SECURE_FILE_TRANSFER_ENABLED \
#    -DXI_FS_MEMORY                    \
#    -DUSE_CBOR_CONTEXT                \
#    -DXI_CONTROL_TOPIC_ENABLED

XI_CLIENT_C_PATH_RELATIVE = xively-client-c

COMPONENT_ADD_INCLUDEDIRS :=                                      \
    $(XI_CLIENT_C_PATH_RELATIVE)/include                          \
    $(XI_CLIENT_C_PATH_RELATIVE)/include/bsp                      \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/bsp                          \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/bsp/platform/esp32           \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively                    \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/memory             \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/datastructures     \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/event_dispatcher   \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/platform/xi_thread \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/cbor               \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/io/net             \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/io/fs              \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/event_loop         \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/control_topic      \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/protobuf-generated \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/tls                \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/tls/certs          \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/sft                \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/mqtt/codec         \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/mqtt/logic         \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/import/cn-cbor/src           \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/import/cn-cbor/include       \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/import/protobuf-c/library

COMPONENT_SRCDIRS :=                                              \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively                    \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/cbor               \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/control_topic      \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/datastructures     \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/debug_extensions   \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/event_dispatcher   \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/event_loop         \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/io                 \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/io/fs              \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/io/fs/memory       \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/io/net             \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/memory             \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/mqtt               \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/mqtt/codec         \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/mqtt/logic         \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/protobuf-generated \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/sft                \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/tls                \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/libxively/tls/certs          \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/import/cn-cbor/src           \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/import/protobuf-c/library    \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/bsp/tls/mbedtls              \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/bsp/platform/esp32/xi_esp32_bsp_component

# Check the submodule is initialised
COMPONENT_SUBMODULES := $(XI_CLIENT_C_PATH_RELATIVE)

else # CONFIG_XIVELY_CLIENT
COMPONENT_ADD_INCLUDEDIRS :=
COMPONENT_ADD_LDFLAGS :=
COMPONENT_SRCDIRS :=
endif # CONFIG_XIVELY_CLIENT
