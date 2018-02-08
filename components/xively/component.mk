#
# Component Makefile
#

ifdef CONFIG_XIVELY_CLIENT

XI_CLIENT_C_PATH_RELATIVE = xively-client-c

#Debug config
ifdef CONFIG_XI_DEBUG_OUTPUT
CPPFLAGS += -DXI_DEBUG_OUTPUT=1
else
CPPFLAGS += -DXI_DEBUG_OUTPUT=0
endif

ifdef CONFIG_XI_BSP_DEBUG_OUTPUT
CPPFLAGS += -DBSP_DEBUG_LOG=1
else
CPPFLAGS += -DBSP_DEBUG_LOG=0
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
    $(XI_CLIENT_C_PATH_RELATIVE)/src/import/protobuf-c/library    \
    $(XI_CLIENT_C_PATH_RELATIVE)/src/bsp/platform/esp32/xi_esp32_bsp_component/include

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
    $(XI_CLIENT_C_PATH_RELATIVE)/src/bsp/platform/esp32/xi_esp32_bsp_component

ifeq ($(CONFIG_XI_TLS_BSP),"mbedtls")
CPPFLAGS += -DXI_BSP_TLS=mbedtls
COMPONENT_SRCDIRS += $(XI_CLIENT_C_PATH_RELATIVE)/src/bsp/tls/mbedtls
else

ifeq ($(CONFIG_XI_TLS_BSP),"wolfssl")

CPPFLAGS +=                           \
    -DSIZEOF_LONG_LONG=8              \
    -DSMALL_SESSION_CACHE             \
    -DTIME_OVERRIDES                  \
    -DNO_DES                          \
    -DNO_DES3                         \
    -DNO_DSA                          \
    -DNO_ERROR_STRINGS                \
    -DNO_HC128                        \
    -DNO_MD4                          \
    -DNO_OLD_TLS                      \
    -DNO_PSK                          \
    -DNO_PWDBASED                     \
    -DNO_RC4                          \
    -DNO_RABBIT                       \
    -DNO_SHA512                       \
    -DNO_STDIO_FILESYSTEM             \
    -DNO_WOLFSSL_DIR                  \
    -DNO_DH                           \
    -DWOLFSSL_STATIC_RSA              \
    -DHAVE_TLS_EXTENSIONS             \
    -DHAVE_OCSP                       \
    -DHAVE_SNI                        \
    -DHAVE_CERTIFICATE_STATUS_REQUEST \
    -DCUSTOM_RAND_GENERATE_SEED=xi_bsp_rng_generate_wolfssl_seed

#Wolf's settings.h BSP configuration:
CPPFLAGS +=    \
    -DHAVE_LWIP_NATIVE \
    #-DFREERTOS        \
    #-DWOLFSSL_IAR_ARM

CPPFLAGS += -DXI_BSP_TLS=wolfssl
CPPFLAGS += -DHAVE_LWIP_NATIVE
CPPFLAGS += -DXI_PROVIDE_WOLFSSL_SEED_GENERATOR
CPPFLAGS += -DXI_PROVIDE_WOLFSSL_XTIME_XGMTIME
COMPONENT_ADD_INCLUDEDIRS += $(XI_CLIENT_C_PATH_RELATIVE)/src/import/tls/wolfssl
COMPONENT_SRCDIRS         += $(XI_CLIENT_C_PATH_RELATIVE)/src/bsp/tls/wolfssl

else
$(error Unrecognised Xi TLS BSP. Expected "mbedtls"/"wolfssl". Got [$(CONFIG_XI_TLS_BSP)])
endif
endif

# Check the submodule is initialised
COMPONENT_SUBMODULES := $(XI_CLIENT_C_PATH_RELATIVE)

else # CONFIG_XIVELY_CLIENT
COMPONENT_ADD_INCLUDEDIRS :=
COMPONENT_ADD_LDFLAGS :=
COMPONENT_SRCDIRS :=
endif # CONFIG_XIVELY_CLIENT
