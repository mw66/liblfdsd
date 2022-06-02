
/* Copyright (C) 1991-2021 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <https://www.gnu.org/licenses/>.  */




/* This header is separate from features.h so that the compiler can
   include it implicitly at the start of every compilation.  It must
   not itself include <features.h> or any other header that includes
   <features.h> because the implicit include comes before any feature
   test macros that may be defined in a source file before it first
   explicitly includes a system header.  GCC knows the name of this
   header in order to preinclude it.  */

/* glibc's intent is to support the IEC 559 math functionality, real
   and complex.  If the GCC (4.9 and later) predefined macros
   specifying compiler intent are available, use them to determine
   whether the overall intent is to support these features; otherwise,
   presume an older compiler has intent to support these features and
   define these macros by default.  */
/* wchar_t uses Unicode 10.0.0.  Version 10.0 of the Unicode Standard is
   synchronized with ISO/IEC 10646:2017, fifth edition, plus
   the following additions from Amendment 1 to the fifth edition:
   - 56 emoji characters
   - 285 hentaigana
   - 3 additional Zanabazar Square characters */



        
       import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; } // FIXME



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }
    // Replacement for the gcc/clang intrinsic
    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }
    // dmd bug causes a crash if T is passed by value.
    // Works fine with ldc.
    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{

    alias wchar_t = int;

    alias size_t = c_ulong;

    alias fsfilcnt_t = c_ulong;

    alias fsblkcnt_t = c_ulong;

    alias blkcnt_t = c_long;

    alias blksize_t = c_long;

    alias register_t = c_long;

    alias u_int64_t = c_ulong;

    alias u_int32_t = uint;

    alias u_int16_t = ushort;

    alias u_int8_t = ubyte;

    alias key_t = int;

    alias caddr_t = char*;

    alias daddr_t = int;

    alias ssize_t = c_long;

    alias id_t = uint;

    alias pid_t = int;

    alias off_t = c_long;

    alias uid_t = uint;

    alias nlink_t = c_ulong;

    alias mode_t = uint;

    alias gid_t = uint;

    alias dev_t = c_ulong;

    alias ino_t = c_ulong;

    alias loff_t = c_long;

    alias fsid_t = __fsid_t;

    alias u_quad_t = c_ulong;

    alias quad_t = c_long;

    alias u_long = c_ulong;

    alias u_int = uint;

    alias u_short = ushort;

    alias u_char = ubyte;

    int pselect(int, fd_set*, fd_set*, fd_set*, const(timespec)*, const(__sigset_t)*) @nogc nothrow;

    int select(int, fd_set*, fd_set*, fd_set*, timeval*) @nogc nothrow;

    alias fd_mask = c_long;

    struct fd_set
    {

        c_long[16] __fds_bits;
    }

    alias __fd_mask = c_long;

    alias suseconds_t = c_long;

    static c_ulong __uint64_identity(c_ulong) @nogc nothrow;

    static uint __uint32_identity(uint) @nogc nothrow;

    static ushort __uint16_identity(ushort) @nogc nothrow;

    alias timer_t = void*;

    alias time_t = c_long;

    struct timeval
    {

        c_long tv_sec;

        c_long tv_usec;
    }

    struct timespec
    {

        c_long tv_sec;

        c_long tv_nsec;
    }

    alias sigset_t = __sigset_t;

    alias clockid_t = int;

    alias clock_t = c_long;

    struct __sigset_t
    {

        c_ulong[16] __val;
    }

    alias __sig_atomic_t = int;

    alias __socklen_t = uint;

    alias __intptr_t = c_long;

    alias __caddr_t = char*;

    alias __loff_t = c_long;

    alias __syscall_ulong_t = c_ulong;

    alias __syscall_slong_t = c_long;

    alias __ssize_t = c_long;

    alias __fsword_t = c_long;

    alias __fsfilcnt64_t = c_ulong;

    alias __fsfilcnt_t = c_ulong;

    alias __fsblkcnt64_t = c_ulong;

    alias __fsblkcnt_t = c_ulong;

    alias __blkcnt64_t = c_long;

    alias __blkcnt_t = c_long;

    alias __blksize_t = c_long;

    alias __timer_t = void*;

    alias __clockid_t = int;

    alias __key_t = int;

    alias __daddr_t = int;

    alias __suseconds64_t = c_long;

    alias __suseconds_t = c_long;

    alias __useconds_t = uint;

    alias __time_t = c_long;

    alias __id_t = uint;

    alias __rlim64_t = c_ulong;

    alias __rlim_t = c_ulong;

    alias __clock_t = c_long;

    struct __fsid_t
    {

        int[2] __val;
    }

    alias __pid_t = int;

    alias __off64_t = c_long;

    alias __off_t = c_long;

    alias __nlink_t = c_ulong;

    alias __mode_t = uint;

    alias __ino64_t = c_ulong;

    alias __ino_t = c_ulong;

    alias __gid_t = uint;

    alias __uid_t = uint;

    alias __dev_t = c_ulong;

    alias __uintmax_t = c_ulong;

    alias __intmax_t = c_long;

    alias __u_quad_t = c_ulong;

    alias __quad_t = c_long;

    alias __uint_least64_t = c_ulong;

    alias __int_least64_t = c_long;

    alias __uint_least32_t = uint;

    alias __int_least32_t = int;
    /***** enums *****/
    enum lfds711_btree_au_absolute_position
    {

        LFDS711_BTREE_AU_ABSOLUTE_POSITION_ROOT = 0,

        LFDS711_BTREE_AU_ABSOLUTE_POSITION_SMALLEST_IN_TREE = 1,

        LFDS711_BTREE_AU_ABSOLUTE_POSITION_LARGEST_IN_TREE = 2,
    }
    enum LFDS711_BTREE_AU_ABSOLUTE_POSITION_ROOT = lfds711_btree_au_absolute_position.LFDS711_BTREE_AU_ABSOLUTE_POSITION_ROOT;
    enum LFDS711_BTREE_AU_ABSOLUTE_POSITION_SMALLEST_IN_TREE = lfds711_btree_au_absolute_position.LFDS711_BTREE_AU_ABSOLUTE_POSITION_SMALLEST_IN_TREE;
    enum LFDS711_BTREE_AU_ABSOLUTE_POSITION_LARGEST_IN_TREE = lfds711_btree_au_absolute_position.LFDS711_BTREE_AU_ABSOLUTE_POSITION_LARGEST_IN_TREE;

    enum lfds711_btree_au_existing_key
    {

        LFDS711_BTREE_AU_EXISTING_KEY_OVERWRITE = 0,

        LFDS711_BTREE_AU_EXISTING_KEY_FAIL = 1,
    }
    enum LFDS711_BTREE_AU_EXISTING_KEY_OVERWRITE = lfds711_btree_au_existing_key.LFDS711_BTREE_AU_EXISTING_KEY_OVERWRITE;
    enum LFDS711_BTREE_AU_EXISTING_KEY_FAIL = lfds711_btree_au_existing_key.LFDS711_BTREE_AU_EXISTING_KEY_FAIL;

    enum lfds711_btree_au_insert_result
    {

        LFDS711_BTREE_AU_INSERT_RESULT_FAILURE_EXISTING_KEY = 0,

        LFDS711_BTREE_AU_INSERT_RESULT_SUCCESS_OVERWRITE = 1,

        LFDS711_BTREE_AU_INSERT_RESULT_SUCCESS = 2,
    }
    enum LFDS711_BTREE_AU_INSERT_RESULT_FAILURE_EXISTING_KEY = lfds711_btree_au_insert_result.LFDS711_BTREE_AU_INSERT_RESULT_FAILURE_EXISTING_KEY;
    enum LFDS711_BTREE_AU_INSERT_RESULT_SUCCESS_OVERWRITE = lfds711_btree_au_insert_result.LFDS711_BTREE_AU_INSERT_RESULT_SUCCESS_OVERWRITE;
    enum LFDS711_BTREE_AU_INSERT_RESULT_SUCCESS = lfds711_btree_au_insert_result.LFDS711_BTREE_AU_INSERT_RESULT_SUCCESS;

    enum lfds711_btree_au_query
    {

        LFDS711_BTREE_AU_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = 0,

        LFDS711_BTREE_AU_QUERY_SINGLETHREADED_VALIDATE = 1,
    }
    enum LFDS711_BTREE_AU_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = lfds711_btree_au_query.LFDS711_BTREE_AU_QUERY_GET_POTENTIALLY_INACCURATE_COUNT;
    enum LFDS711_BTREE_AU_QUERY_SINGLETHREADED_VALIDATE = lfds711_btree_au_query.LFDS711_BTREE_AU_QUERY_SINGLETHREADED_VALIDATE;

    enum lfds711_btree_au_relative_position
    {

        LFDS711_BTREE_AU_RELATIVE_POSITION_UP = 0,

        LFDS711_BTREE_AU_RELATIVE_POSITION_LEFT = 1,

        LFDS711_BTREE_AU_RELATIVE_POSITION_RIGHT = 2,

        LFDS711_BTREE_AU_RELATIVE_POSITION_SMALLEST_ELEMENT_BELOW_CURRENT_ELEMENT = 3,

        LFDS711_BTREE_AU_RELATIVE_POSITION_LARGEST_ELEMENT_BELOW_CURRENT_ELEMENT = 4,

        LFDS711_BTREE_AU_RELATIVE_POSITION_NEXT_SMALLER_ELEMENT_IN_ENTIRE_TREE = 5,

        LFDS711_BTREE_AU_RELATIVE_POSITION_NEXT_LARGER_ELEMENT_IN_ENTIRE_TREE = 6,
    }
    enum LFDS711_BTREE_AU_RELATIVE_POSITION_UP = lfds711_btree_au_relative_position.LFDS711_BTREE_AU_RELATIVE_POSITION_UP;
    enum LFDS711_BTREE_AU_RELATIVE_POSITION_LEFT = lfds711_btree_au_relative_position.LFDS711_BTREE_AU_RELATIVE_POSITION_LEFT;
    enum LFDS711_BTREE_AU_RELATIVE_POSITION_RIGHT = lfds711_btree_au_relative_position.LFDS711_BTREE_AU_RELATIVE_POSITION_RIGHT;
    enum LFDS711_BTREE_AU_RELATIVE_POSITION_SMALLEST_ELEMENT_BELOW_CURRENT_ELEMENT = lfds711_btree_au_relative_position.LFDS711_BTREE_AU_RELATIVE_POSITION_SMALLEST_ELEMENT_BELOW_CURRENT_ELEMENT;
    enum LFDS711_BTREE_AU_RELATIVE_POSITION_LARGEST_ELEMENT_BELOW_CURRENT_ELEMENT = lfds711_btree_au_relative_position.LFDS711_BTREE_AU_RELATIVE_POSITION_LARGEST_ELEMENT_BELOW_CURRENT_ELEMENT;
    enum LFDS711_BTREE_AU_RELATIVE_POSITION_NEXT_SMALLER_ELEMENT_IN_ENTIRE_TREE = lfds711_btree_au_relative_position.LFDS711_BTREE_AU_RELATIVE_POSITION_NEXT_SMALLER_ELEMENT_IN_ENTIRE_TREE;
    enum LFDS711_BTREE_AU_RELATIVE_POSITION_NEXT_LARGER_ELEMENT_IN_ENTIRE_TREE = lfds711_btree_au_relative_position.LFDS711_BTREE_AU_RELATIVE_POSITION_NEXT_LARGER_ELEMENT_IN_ENTIRE_TREE;
    /***** structs *****/
    struct lfds711_btree_au_element
    {

        lfds711_btree_au_element* left;

        lfds711_btree_au_element* right;

        lfds711_btree_au_element* up;

        void* value;

        void* key;
    }

    struct lfds711_btree_au_state
    {

        lfds711_btree_au_element* root;

        int function(const(void)*, const(void)*) key_compare_function;

        lfds711_btree_au_existing_key existing_key;

        void* user_state;

        lfds711_misc_backoff_state insert_backoff;
    }
    /***** public prototypes *****/
    void lfds711_btree_au_init_valid_on_current_logical_core(lfds711_btree_au_state*, int function(const(void)*, const(void)*), lfds711_btree_au_existing_key, void*) @nogc nothrow;

    void lfds711_btree_au_cleanup(lfds711_btree_au_state*, void function(lfds711_btree_au_state*, lfds711_btree_au_element*)) @nogc nothrow;

    lfds711_btree_au_insert_result lfds711_btree_au_insert(lfds711_btree_au_state*, lfds711_btree_au_element*, lfds711_btree_au_element**) @nogc nothrow;

    int lfds711_btree_au_get_by_key(lfds711_btree_au_state*, int function(const(void)*, const(void)*), void*, lfds711_btree_au_element**) @nogc nothrow;

    int lfds711_btree_au_get_by_absolute_position_and_then_by_relative_position(lfds711_btree_au_state*, lfds711_btree_au_element**, lfds711_btree_au_absolute_position, lfds711_btree_au_relative_position) @nogc nothrow;

    int lfds711_btree_au_get_by_absolute_position(lfds711_btree_au_state*, lfds711_btree_au_element**, lfds711_btree_au_absolute_position) @nogc nothrow;

    int lfds711_btree_au_get_by_relative_position(lfds711_btree_au_element**, lfds711_btree_au_relative_position) @nogc nothrow;

    pragma(mangle, "lfds711_btree_au_query") void lfds711_btree_au_query_(lfds711_btree_au_state*, lfds711_btree_au_query, void*, void*) @nogc nothrow;

    alias __uint_least16_t = ushort;

    alias __int_least16_t = short;

    alias __uint_least8_t = ubyte;

    alias __int_least8_t = byte;

    alias __uint64_t = c_ulong;

    alias __int64_t = c_long;
    /***** enums *****/
    enum lfds711_freelist_query
    {

        LFDS711_FREELIST_QUERY_SINGLETHREADED_GET_COUNT = 0,

        LFDS711_FREELIST_QUERY_SINGLETHREADED_VALIDATE = 1,

        LFDS711_FREELIST_QUERY_GET_ELIMINATION_ARRAY_EXTRA_ELEMENTS_IN_FREELIST_ELEMENTS = 2,
    }
    enum LFDS711_FREELIST_QUERY_SINGLETHREADED_GET_COUNT = lfds711_freelist_query.LFDS711_FREELIST_QUERY_SINGLETHREADED_GET_COUNT;
    enum LFDS711_FREELIST_QUERY_SINGLETHREADED_VALIDATE = lfds711_freelist_query.LFDS711_FREELIST_QUERY_SINGLETHREADED_VALIDATE;
    enum LFDS711_FREELIST_QUERY_GET_ELIMINATION_ARRAY_EXTRA_ELEMENTS_IN_FREELIST_ELEMENTS = lfds711_freelist_query.LFDS711_FREELIST_QUERY_GET_ELIMINATION_ARRAY_EXTRA_ELEMENTS_IN_FREELIST_ELEMENTS;
    /***** structures *****/
    struct lfds711_freelist_element
    {

        lfds711_freelist_element* next;

        void* key;

        void* value;
    }

    struct lfds711_freelist_state
    {

        lfds711_freelist_element*[2] top;

        ulong elimination_array_size_in_elements;

        lfds711_freelist_element*** elimination_array;

        void* user_state;

        lfds711_misc_backoff_state pop_backoff;

        lfds711_misc_backoff_state push_backoff;
    }
    /***** public prototypes *****/
    void lfds711_freelist_init_valid_on_current_logical_core(lfds711_freelist_state*, lfds711_freelist_element***, ulong, void*) @nogc nothrow;

    void lfds711_freelist_cleanup(lfds711_freelist_state*, void function(lfds711_freelist_state*, lfds711_freelist_element*)) @nogc nothrow;

    void lfds711_freelist_push(lfds711_freelist_state*, lfds711_freelist_element*, lfds711_prng_st_state*) @nogc nothrow;

    int lfds711_freelist_pop(lfds711_freelist_state*, lfds711_freelist_element**, lfds711_prng_st_state*) @nogc nothrow;

    pragma(mangle, "lfds711_freelist_query") void lfds711_freelist_query_(lfds711_freelist_state*, lfds711_freelist_query, void*, void*) @nogc nothrow;

    alias __uint32_t = uint;

    alias __int32_t = int;

    alias __uint16_t = ushort;

    alias __int16_t = short;

    alias __uint8_t = ubyte;
    /***** enums *****/
    enum lfds711_hash_a_existing_key
    {

        LFDS711_HASH_A_EXISTING_KEY_OVERWRITE = 0,

        LFDS711_HASH_A_EXISTING_KEY_FAIL = 1,
    }
    enum LFDS711_HASH_A_EXISTING_KEY_OVERWRITE = lfds711_hash_a_existing_key.LFDS711_HASH_A_EXISTING_KEY_OVERWRITE;
    enum LFDS711_HASH_A_EXISTING_KEY_FAIL = lfds711_hash_a_existing_key.LFDS711_HASH_A_EXISTING_KEY_FAIL;

    enum lfds711_hash_a_insert_result
    {

        LFDS711_HASH_A_PUT_RESULT_FAILURE_EXISTING_KEY = 0,

        LFDS711_HASH_A_PUT_RESULT_SUCCESS_OVERWRITE = 1,

        LFDS711_HASH_A_PUT_RESULT_SUCCESS = 2,
    }
    enum LFDS711_HASH_A_PUT_RESULT_FAILURE_EXISTING_KEY = lfds711_hash_a_insert_result.LFDS711_HASH_A_PUT_RESULT_FAILURE_EXISTING_KEY;
    enum LFDS711_HASH_A_PUT_RESULT_SUCCESS_OVERWRITE = lfds711_hash_a_insert_result.LFDS711_HASH_A_PUT_RESULT_SUCCESS_OVERWRITE;
    enum LFDS711_HASH_A_PUT_RESULT_SUCCESS = lfds711_hash_a_insert_result.LFDS711_HASH_A_PUT_RESULT_SUCCESS;

    enum lfds711_hash_a_query
    {

        LFDS711_HASH_A_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = 0,

        LFDS711_HASH_A_QUERY_SINGLETHREADED_VALIDATE = 1,
    }
    enum LFDS711_HASH_A_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = lfds711_hash_a_query.LFDS711_HASH_A_QUERY_GET_POTENTIALLY_INACCURATE_COUNT;
    enum LFDS711_HASH_A_QUERY_SINGLETHREADED_VALIDATE = lfds711_hash_a_query.LFDS711_HASH_A_QUERY_SINGLETHREADED_VALIDATE;
    /***** structs *****/
    struct lfds711_hash_a_element
    {

        lfds711_btree_au_element baue;

        void* key;

        void* value;
    }

    struct lfds711_hash_a_iterate
    {

        lfds711_btree_au_element* baue;

        lfds711_btree_au_state* baus;

        lfds711_btree_au_state* baus_end;
    }

    struct lfds711_hash_a_state
    {

        lfds711_hash_a_existing_key existing_key;

        int function(const(void)*, const(void)*) key_compare_function;

        ulong array_size;

        lfds711_btree_au_state* baus_array;

        void function(lfds711_hash_a_state*, lfds711_hash_a_element*) element_cleanup_callback;

        void function(const(void)*, ulong*) key_hash_function;

        void* user_state;
    }
    /***** public prototypes *****/
    void lfds711_hash_a_init_valid_on_current_logical_core(lfds711_hash_a_state*, lfds711_btree_au_state*, ulong, int function(const(void)*, const(void)*), void function(const(void)*, ulong*), lfds711_hash_a_existing_key, void*) @nogc nothrow;

    void lfds711_hash_a_cleanup(lfds711_hash_a_state*, void function(lfds711_hash_a_state*, lfds711_hash_a_element*)) @nogc nothrow;

    lfds711_hash_a_insert_result lfds711_hash_a_insert(lfds711_hash_a_state*, lfds711_hash_a_element*, lfds711_hash_a_element**) @nogc nothrow;

    int lfds711_hash_a_get_by_key(lfds711_hash_a_state*, int function(const(void)*, const(void)*), void function(const(void)*, ulong*), void*, lfds711_hash_a_element**) @nogc nothrow;

    void lfds711_hash_a_iterate_init(lfds711_hash_a_state*, lfds711_hash_a_iterate*) @nogc nothrow;

    pragma(mangle, "lfds711_hash_a_iterate") int lfds711_hash_a_iterate_(lfds711_hash_a_iterate*, lfds711_hash_a_element**) @nogc nothrow;

    pragma(mangle, "lfds711_hash_a_query") void lfds711_hash_a_query_(lfds711_hash_a_state*, lfds711_hash_a_query, void*, void*) @nogc nothrow;

    alias __int8_t = byte;

    alias __u_long = c_ulong;

    alias __u_int = uint;

    alias __u_short = ushort;

    alias __u_char = ubyte;
    /***** enums *****/
    enum lfds711_list_aso_existing_key
    {

        LFDS711_LIST_ASO_EXISTING_KEY_OVERWRITE = 0,

        LFDS711_LIST_ASO_EXISTING_KEY_FAIL = 1,
    }
    enum LFDS711_LIST_ASO_EXISTING_KEY_OVERWRITE = lfds711_list_aso_existing_key.LFDS711_LIST_ASO_EXISTING_KEY_OVERWRITE;
    enum LFDS711_LIST_ASO_EXISTING_KEY_FAIL = lfds711_list_aso_existing_key.LFDS711_LIST_ASO_EXISTING_KEY_FAIL;

    enum lfds711_list_aso_insert_result
    {

        LFDS711_LIST_ASO_INSERT_RESULT_FAILURE_EXISTING_KEY = 0,

        LFDS711_LIST_ASO_INSERT_RESULT_SUCCESS_OVERWRITE = 1,

        LFDS711_LIST_ASO_INSERT_RESULT_SUCCESS = 2,
    }
    enum LFDS711_LIST_ASO_INSERT_RESULT_FAILURE_EXISTING_KEY = lfds711_list_aso_insert_result.LFDS711_LIST_ASO_INSERT_RESULT_FAILURE_EXISTING_KEY;
    enum LFDS711_LIST_ASO_INSERT_RESULT_SUCCESS_OVERWRITE = lfds711_list_aso_insert_result.LFDS711_LIST_ASO_INSERT_RESULT_SUCCESS_OVERWRITE;
    enum LFDS711_LIST_ASO_INSERT_RESULT_SUCCESS = lfds711_list_aso_insert_result.LFDS711_LIST_ASO_INSERT_RESULT_SUCCESS;

    enum lfds711_list_aso_query
    {

        LFDS711_LIST_ASO_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = 0,

        LFDS711_LIST_ASO_QUERY_SINGLETHREADED_VALIDATE = 1,
    }
    enum LFDS711_LIST_ASO_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = lfds711_list_aso_query.LFDS711_LIST_ASO_QUERY_GET_POTENTIALLY_INACCURATE_COUNT;
    enum LFDS711_LIST_ASO_QUERY_SINGLETHREADED_VALIDATE = lfds711_list_aso_query.LFDS711_LIST_ASO_QUERY_SINGLETHREADED_VALIDATE;
    /***** structures *****/
    struct lfds711_list_aso_element
    {

        lfds711_list_aso_element* next;

        void* value;

        void* key;
    }

    struct lfds711_list_aso_state
    {

        lfds711_list_aso_element dummy_element;

        lfds711_list_aso_element* start;

        int function(const(void)*, const(void)*) key_compare_function;

        lfds711_list_aso_existing_key existing_key;

        void* user_state;

        lfds711_misc_backoff_state insert_backoff;
    }
    /***** public prototypes *****/
    void lfds711_list_aso_init_valid_on_current_logical_core(lfds711_list_aso_state*, int function(const(void)*, const(void)*), lfds711_list_aso_existing_key, void*) @nogc nothrow;

    void lfds711_list_aso_cleanup(lfds711_list_aso_state*, void function(lfds711_list_aso_state*, lfds711_list_aso_element*)) @nogc nothrow;

    lfds711_list_aso_insert_result lfds711_list_aso_insert(lfds711_list_aso_state*, lfds711_list_aso_element*, lfds711_list_aso_element**) @nogc nothrow;

    int lfds711_list_aso_get_by_key(lfds711_list_aso_state*, void*, lfds711_list_aso_element**) @nogc nothrow;

    pragma(mangle, "lfds711_list_aso_query") void lfds711_list_aso_query_(lfds711_list_aso_state*, lfds711_list_aso_query, void*, void*) @nogc nothrow;

    struct __once_flag
    {

        int __data;
    }

    alias __thrd_t = c_ulong;

    alias __tss_t = uint;
    /***** enums *****/
    enum lfds711_list_asu_position
    {

        LFDS711_LIST_ASU_POSITION_START = 0,

        LFDS711_LIST_ASU_POSITION_END = 1,

        LFDS711_LIST_ASU_POSITION_AFTER = 2,
    }
    enum LFDS711_LIST_ASU_POSITION_START = lfds711_list_asu_position.LFDS711_LIST_ASU_POSITION_START;
    enum LFDS711_LIST_ASU_POSITION_END = lfds711_list_asu_position.LFDS711_LIST_ASU_POSITION_END;
    enum LFDS711_LIST_ASU_POSITION_AFTER = lfds711_list_asu_position.LFDS711_LIST_ASU_POSITION_AFTER;

    enum lfds711_list_asu_query
    {

        LFDS711_LIST_ASU_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = 0,

        LFDS711_LIST_ASU_QUERY_SINGLETHREADED_VALIDATE = 1,
    }
    enum LFDS711_LIST_ASU_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = lfds711_list_asu_query.LFDS711_LIST_ASU_QUERY_GET_POTENTIALLY_INACCURATE_COUNT;
    enum LFDS711_LIST_ASU_QUERY_SINGLETHREADED_VALIDATE = lfds711_list_asu_query.LFDS711_LIST_ASU_QUERY_SINGLETHREADED_VALIDATE;
    /***** structures *****/
    struct lfds711_list_asu_element
    {

        lfds711_list_asu_element* next;

        void* value;

        void* key;
    }

    struct lfds711_list_asu_state
    {

        lfds711_list_asu_element dummy_element;

        lfds711_list_asu_element* end;

        lfds711_list_asu_element* start;

        void* user_state;

        lfds711_misc_backoff_state after_backoff;

        lfds711_misc_backoff_state end_backoff;

        lfds711_misc_backoff_state start_backoff;
    }
    /***** public prototypes *****/
    void lfds711_list_asu_init_valid_on_current_logical_core(lfds711_list_asu_state*, void*) @nogc nothrow;

    void lfds711_list_asu_cleanup(lfds711_list_asu_state*, void function(lfds711_list_asu_state*, lfds711_list_asu_element*)) @nogc nothrow;

    void lfds711_list_asu_insert_at_position(lfds711_list_asu_state*, lfds711_list_asu_element*, lfds711_list_asu_element*, lfds711_list_asu_position) @nogc nothrow;

    void lfds711_list_asu_insert_at_start(lfds711_list_asu_state*, lfds711_list_asu_element*) @nogc nothrow;

    void lfds711_list_asu_insert_at_end(lfds711_list_asu_state*, lfds711_list_asu_element*) @nogc nothrow;

    void lfds711_list_asu_insert_after_element(lfds711_list_asu_state*, lfds711_list_asu_element*, lfds711_list_asu_element*) @nogc nothrow;

    int lfds711_list_asu_get_by_key(lfds711_list_asu_state*, int function(const(void)*, const(void)*), void*, lfds711_list_asu_element**) @nogc nothrow;

    pragma(mangle, "lfds711_list_asu_query") void lfds711_list_asu_query_(lfds711_list_asu_state*, lfds711_list_asu_query, void*, void*) @nogc nothrow;

    struct __pthread_cond_s
    {

        static union _Anonymous_0
        {

            ulong __wseq;

            static struct _Anonymous_1
            {

                uint __low;

                uint __high;
            }

            _Anonymous_1 __wseq32;
        }
        _Anonymous_0 _anonymous_2;
        ref auto __wseq() @property @nogc pure nothrow { return _anonymous_2.__wseq; }
        void __wseq(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_2.__wseq = val; }
        ref auto __wseq32() @property @nogc pure nothrow { return _anonymous_2.__wseq32; }
        void __wseq32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_2.__wseq32 = val; }

        static union _Anonymous_3
        {

            ulong __g1_start;

            static struct _Anonymous_4
            {

                uint __low;

                uint __high;
            }

            _Anonymous_4 __g1_start32;
        }
        _Anonymous_3 _anonymous_5;
        ref auto __g1_start() @property @nogc pure nothrow { return _anonymous_5.__g1_start; }
        void __g1_start(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_5.__g1_start = val; }
        ref auto __g1_start32() @property @nogc pure nothrow { return _anonymous_5.__g1_start32; }
        void __g1_start32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_5.__g1_start32 = val; }

        uint[2] __g_refs;

        uint[2] __g_size;

        uint __g1_orig_size;

        uint __wrefs;

        uint[2] __g_signals;
    }

    struct __pthread_internal_slist
    {

        __pthread_internal_slist* __next;
    }

    alias __pthread_slist_t = __pthread_internal_slist;

    struct __pthread_internal_list
    {

        __pthread_internal_list* __prev;

        __pthread_internal_list* __next;
    }

    alias __pthread_list_t = __pthread_internal_list;

    struct __pthread_rwlock_arch_t
    {

        uint __readers;

        uint __writers;

        uint __wrphase_futex;

        uint __writers_futex;

        uint __pad3;

        uint __pad4;

        int __cur_writer;

        int __shared;

        byte __rwelision;

        ubyte[7] __pad1;

        c_ulong __pad2;

        uint __flags;
    }

    struct __pthread_mutex_s
    {

        int __lock;

        uint __count;

        int __owner;

        uint __nusers;

        int __kind;

        short __spins;

        short __elision;

        __pthread_internal_list __list;
    }

    alias int64_t = c_long;
    /***** enums *****/
    enum lfds711_misc_cas_strength
    {

        LFDS711_MISC_CAS_STRENGTH_STRONG = 0,

        LFDS711_MISC_CAS_STRENGTH_WEAK = 1,
    }
    enum LFDS711_MISC_CAS_STRENGTH_STRONG = lfds711_misc_cas_strength.LFDS711_MISC_CAS_STRENGTH_STRONG;
    enum LFDS711_MISC_CAS_STRENGTH_WEAK = lfds711_misc_cas_strength.LFDS711_MISC_CAS_STRENGTH_WEAK;

    enum lfds711_misc_validity
    {

        LFDS711_MISC_VALIDITY_UNKNOWN = 0,

        LFDS711_MISC_VALIDITY_VALID = 1,

        LFDS711_MISC_VALIDITY_INVALID_LOOP = 2,

        LFDS711_MISC_VALIDITY_INVALID_MISSING_ELEMENTS = 3,

        LFDS711_MISC_VALIDITY_INVALID_ADDITIONAL_ELEMENTS = 4,

        LFDS711_MISC_VALIDITY_INVALID_TEST_DATA = 5,

        LFDS711_MISC_VALIDITY_INVALID_ORDER = 6,

        LFDS711_MISC_VALIDITY_INVALID_ATOMIC_FAILED = 7,

        LFDS711_MISC_VALIDITY_INDETERMINATE_NONATOMIC_PASSED = 8,
    }
    enum LFDS711_MISC_VALIDITY_UNKNOWN = lfds711_misc_validity.LFDS711_MISC_VALIDITY_UNKNOWN;
    enum LFDS711_MISC_VALIDITY_VALID = lfds711_misc_validity.LFDS711_MISC_VALIDITY_VALID;
    enum LFDS711_MISC_VALIDITY_INVALID_LOOP = lfds711_misc_validity.LFDS711_MISC_VALIDITY_INVALID_LOOP;
    enum LFDS711_MISC_VALIDITY_INVALID_MISSING_ELEMENTS = lfds711_misc_validity.LFDS711_MISC_VALIDITY_INVALID_MISSING_ELEMENTS;
    enum LFDS711_MISC_VALIDITY_INVALID_ADDITIONAL_ELEMENTS = lfds711_misc_validity.LFDS711_MISC_VALIDITY_INVALID_ADDITIONAL_ELEMENTS;
    enum LFDS711_MISC_VALIDITY_INVALID_TEST_DATA = lfds711_misc_validity.LFDS711_MISC_VALIDITY_INVALID_TEST_DATA;
    enum LFDS711_MISC_VALIDITY_INVALID_ORDER = lfds711_misc_validity.LFDS711_MISC_VALIDITY_INVALID_ORDER;
    enum LFDS711_MISC_VALIDITY_INVALID_ATOMIC_FAILED = lfds711_misc_validity.LFDS711_MISC_VALIDITY_INVALID_ATOMIC_FAILED;
    enum LFDS711_MISC_VALIDITY_INDETERMINATE_NONATOMIC_PASSED = lfds711_misc_validity.LFDS711_MISC_VALIDITY_INDETERMINATE_NONATOMIC_PASSED;

    enum lfds711_misc_flag
    {

        LFDS711_MISC_FLAG_LOWERED = 0,

        LFDS711_MISC_FLAG_RAISED = 1,
    }
    enum LFDS711_MISC_FLAG_LOWERED = lfds711_misc_flag.LFDS711_MISC_FLAG_LOWERED;
    enum LFDS711_MISC_FLAG_RAISED = lfds711_misc_flag.LFDS711_MISC_FLAG_RAISED;

    enum lfds711_misc_query
    {

        LFDS711_MISC_QUERY_GET_BUILD_AND_VERSION_STRING = 0,
    }
    enum LFDS711_MISC_QUERY_GET_BUILD_AND_VERSION_STRING = lfds711_misc_query.LFDS711_MISC_QUERY_GET_BUILD_AND_VERSION_STRING;

    enum lfds711_misc_data_structure
    {

        LFDS711_MISC_DATA_STRUCTURE_BTREE_AU = 0,

        LFDS711_MISC_DATA_STRUCTURE_FREELIST = 1,

        LFDS711_MISC_DATA_STRUCTURE_HASH_A = 2,

        LFDS711_MISC_DATA_STRUCTURE_LIST_AOS = 3,

        LFDS711_MISC_DATA_STRUCTURE_LIST_ASU = 4,

        LFDS711_MISC_DATA_STRUCTURE_QUEUE_BMM = 5,

        LFDS711_MISC_DATA_STRUCTURE_QUEUE_BSS = 6,

        LFDS711_MISC_DATA_STRUCTURE_QUEUE_UMM = 7,

        LFDS711_MISC_DATA_STRUCTURE_RINGBUFFER = 8,

        LFDS711_MISC_DATA_STRUCTURE_STACK = 9,

        LFDS711_MISC_DATA_STRUCTURE_COUNT = 10,
    }
    enum LFDS711_MISC_DATA_STRUCTURE_BTREE_AU = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_BTREE_AU;
    enum LFDS711_MISC_DATA_STRUCTURE_FREELIST = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_FREELIST;
    enum LFDS711_MISC_DATA_STRUCTURE_HASH_A = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_HASH_A;
    enum LFDS711_MISC_DATA_STRUCTURE_LIST_AOS = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_LIST_AOS;
    enum LFDS711_MISC_DATA_STRUCTURE_LIST_ASU = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_LIST_ASU;
    enum LFDS711_MISC_DATA_STRUCTURE_QUEUE_BMM = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_QUEUE_BMM;
    enum LFDS711_MISC_DATA_STRUCTURE_QUEUE_BSS = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_QUEUE_BSS;
    enum LFDS711_MISC_DATA_STRUCTURE_QUEUE_UMM = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_QUEUE_UMM;
    enum LFDS711_MISC_DATA_STRUCTURE_RINGBUFFER = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_RINGBUFFER;
    enum LFDS711_MISC_DATA_STRUCTURE_STACK = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_STACK;
    enum LFDS711_MISC_DATA_STRUCTURE_COUNT = lfds711_misc_data_structure.LFDS711_MISC_DATA_STRUCTURE_COUNT;
    /***** struct *****/
    struct lfds711_misc_backoff_state
    {

        ulong lock;

        ulong[2] backoff_iteration_frequency_counters;

        ulong metric;

        ulong total_operations;
    }

    struct lfds711_misc_globals
    {

        lfds711_prng_state ps;
    }

    struct lfds711_misc_validation_info
    {

        ulong min_elements;

        ulong max_elements;
    }
    /***** externs *****/
    pragma(mangle, "lfds711_misc_globals") extern __gshared lfds711_misc_globals lfds711_misc_globals_;
    /***** public prototypes *****/
    static void lfds711_misc_force_store() @nogc nothrow;

    pragma(mangle, "lfds711_misc_query") void lfds711_misc_query_(lfds711_misc_query, void*, void*) @nogc nothrow;

    alias int32_t = int;

    alias int16_t = short;

    alias int8_t = byte;

    static void lfds711_pal_barrier_compiler() @nogc nothrow;

    union pthread_barrierattr_t
    {

        char[4] __size;

        int __align;
    }

    union pthread_barrier_t
    {

        char[32] __size;

        c_long __align;
    }

    alias pthread_spinlock_t = int;

    union pthread_rwlockattr_t
    {

        char[8] __size;

        c_long __align;
    }

    union pthread_rwlock_t
    {

        __pthread_rwlock_arch_t __data;

        char[56] __size;

        c_long __align;
    }

    alias lfds711_pal_int_t = long;

    alias lfds711_pal_uint_t = ulong;

    union pthread_cond_t
    {

        __pthread_cond_s __data;

        char[48] __size;

        long __align;
    }

    union pthread_mutex_t
    {

        __pthread_mutex_s __data;

        char[40] __size;

        c_long __align;
    }

    union pthread_attr_t
    {

        char[56] __size;

        c_long __align;
    }

    alias pthread_once_t = int;

    alias pthread_key_t = uint;

    union pthread_condattr_t
    {

        char[4] __size;

        int __align;
    }
    /***** structs *****/
    struct lfds711_prng_state
    {

        ulong entropy;
    }

    struct lfds711_prng_st_state
    {

        ulong entropy;
    }
    /***** public prototypes *****/
    void lfds711_prng_init_valid_on_current_logical_core(lfds711_prng_state*, ulong) @nogc nothrow;

    void lfds711_prng_st_init(lfds711_prng_st_state*, ulong) @nogc nothrow;
    /***** enums *****/
    enum lfds711_queue_bmm_query
    {

        LFDS711_QUEUE_BMM_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = 0,

        LFDS711_QUEUE_BMM_QUERY_SINGLETHREADED_VALIDATE = 1,
    }
    enum LFDS711_QUEUE_BMM_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = lfds711_queue_bmm_query.LFDS711_QUEUE_BMM_QUERY_GET_POTENTIALLY_INACCURATE_COUNT;
    enum LFDS711_QUEUE_BMM_QUERY_SINGLETHREADED_VALIDATE = lfds711_queue_bmm_query.LFDS711_QUEUE_BMM_QUERY_SINGLETHREADED_VALIDATE;
    /***** structures *****/
    struct lfds711_queue_bmm_element
    {

        ulong sequence_number;

        void* key;

        void* value;
    }

    struct lfds711_queue_bmm_state
    {

        ulong number_elements;

        ulong mask;

        ulong read_index;

        ulong write_index;

        lfds711_queue_bmm_element* element_array;

        void* user_state;

        lfds711_misc_backoff_state dequeue_backoff;

        lfds711_misc_backoff_state enqueue_backoff;
    }
    /***** public prototypes *****/
    void lfds711_queue_bmm_init_valid_on_current_logical_core(lfds711_queue_bmm_state*, lfds711_queue_bmm_element*, ulong, void*) @nogc nothrow;

    void lfds711_queue_bmm_cleanup(lfds711_queue_bmm_state*, void function(lfds711_queue_bmm_state*, void*, void*)) @nogc nothrow;

    int lfds711_queue_bmm_enqueue(lfds711_queue_bmm_state*, void*, void*) @nogc nothrow;

    int lfds711_queue_bmm_dequeue(lfds711_queue_bmm_state*, void**, void**) @nogc nothrow;

    pragma(mangle, "lfds711_queue_bmm_query") void lfds711_queue_bmm_query_(lfds711_queue_bmm_state*, lfds711_queue_bmm_query, void*, void*) @nogc nothrow;
    /***** enums *****/
    enum lfds711_queue_bss_query
    {

        LFDS711_QUEUE_BSS_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = 0,

        LFDS711_QUEUE_BSS_QUERY_VALIDATE = 1,
    }
    enum LFDS711_QUEUE_BSS_QUERY_GET_POTENTIALLY_INACCURATE_COUNT = lfds711_queue_bss_query.LFDS711_QUEUE_BSS_QUERY_GET_POTENTIALLY_INACCURATE_COUNT;
    enum LFDS711_QUEUE_BSS_QUERY_VALIDATE = lfds711_queue_bss_query.LFDS711_QUEUE_BSS_QUERY_VALIDATE;
    /***** structures *****/
    struct lfds711_queue_bss_element
    {

        void* key;

        void* value;
    }

    struct lfds711_queue_bss_state
    {

        ulong number_elements;

        ulong mask;

        ulong read_index;

        ulong write_index;

        lfds711_queue_bss_element* element_array;

        void* user_state;
    }
    /***** public prototypes *****/
    void lfds711_queue_bss_init_valid_on_current_logical_core(lfds711_queue_bss_state*, lfds711_queue_bss_element*, ulong, void*) @nogc nothrow;

    void lfds711_queue_bss_cleanup(lfds711_queue_bss_state*, void function(lfds711_queue_bss_state*, void*, void*)) @nogc nothrow;

    int lfds711_queue_bss_enqueue(lfds711_queue_bss_state*, void*, void*) @nogc nothrow;

    int lfds711_queue_bss_dequeue(lfds711_queue_bss_state*, void**, void**) @nogc nothrow;

    pragma(mangle, "lfds711_queue_bss_query") void lfds711_queue_bss_query_(lfds711_queue_bss_state*, lfds711_queue_bss_query, void*, void*) @nogc nothrow;

    union pthread_mutexattr_t
    {

        char[4] __size;

        int __align;
    }

    alias pthread_t = c_ulong;
    /***** enums *****/
    enum lfds711_queue_umm_query
    {

        LFDS711_QUEUE_UMM_QUERY_SINGLETHREADED_GET_COUNT = 0,

        LFDS711_QUEUE_UMM_QUERY_SINGLETHREADED_VALIDATE = 1,
    }
    enum LFDS711_QUEUE_UMM_QUERY_SINGLETHREADED_GET_COUNT = lfds711_queue_umm_query.LFDS711_QUEUE_UMM_QUERY_SINGLETHREADED_GET_COUNT;
    enum LFDS711_QUEUE_UMM_QUERY_SINGLETHREADED_VALIDATE = lfds711_queue_umm_query.LFDS711_QUEUE_UMM_QUERY_SINGLETHREADED_VALIDATE;
    /***** structures *****/
    struct lfds711_queue_umm_element
    {

        lfds711_queue_umm_element*[2] next;

        void* key;

        void* value;
    }

    struct lfds711_queue_umm_state
    {

        lfds711_queue_umm_element*[2] enqueue;

        lfds711_queue_umm_element*[2] dequeue;

        ulong aba_counter;

        void* user_state;

        lfds711_misc_backoff_state dequeue_backoff;

        lfds711_misc_backoff_state enqueue_backoff;
    }
    /***** public prototypes *****/
    void lfds711_queue_umm_init_valid_on_current_logical_core(lfds711_queue_umm_state*, lfds711_queue_umm_element*, void*) @nogc nothrow;

    void lfds711_queue_umm_cleanup(lfds711_queue_umm_state*, void function(lfds711_queue_umm_state*, lfds711_queue_umm_element*, lfds711_misc_flag)) @nogc nothrow;

    void lfds711_queue_umm_enqueue(lfds711_queue_umm_state*, lfds711_queue_umm_element*) @nogc nothrow;

    int lfds711_queue_umm_dequeue(lfds711_queue_umm_state*, lfds711_queue_umm_element**) @nogc nothrow;

    pragma(mangle, "lfds711_queue_umm_query") void lfds711_queue_umm_query_(lfds711_queue_umm_state*, lfds711_queue_umm_query, void*, void*) @nogc nothrow;
    /***** enums *****/
    enum lfds711_ringbuffer_query
    {

        LFDS711_RINGBUFFER_QUERY_SINGLETHREADED_GET_COUNT = 0,

        LFDS711_RINGBUFFER_QUERY_SINGLETHREADED_VALIDATE = 1,
    }
    enum LFDS711_RINGBUFFER_QUERY_SINGLETHREADED_GET_COUNT = lfds711_ringbuffer_query.LFDS711_RINGBUFFER_QUERY_SINGLETHREADED_GET_COUNT;
    enum LFDS711_RINGBUFFER_QUERY_SINGLETHREADED_VALIDATE = lfds711_ringbuffer_query.LFDS711_RINGBUFFER_QUERY_SINGLETHREADED_VALIDATE;
    /***** structures *****/
    struct lfds711_ringbuffer_element
    {

        lfds711_freelist_element fe;

        lfds711_queue_umm_element qumme;

        lfds711_queue_umm_element* qumme_use;

        void* key;

        void* value;
    }

    struct lfds711_ringbuffer_state
    {

        lfds711_freelist_state fs;

        lfds711_queue_umm_state qumms;

        void function(lfds711_ringbuffer_state*, void*, void*, lfds711_misc_flag) element_cleanup_callback;

        void* user_state;
    }
    /***** public prototypes *****/
    void lfds711_ringbuffer_init_valid_on_current_logical_core(lfds711_ringbuffer_state*, lfds711_ringbuffer_element*, ulong, void*) @nogc nothrow;

    void lfds711_ringbuffer_cleanup(lfds711_ringbuffer_state*, void function(lfds711_ringbuffer_state*, void*, void*, lfds711_misc_flag)) @nogc nothrow;

    int lfds711_ringbuffer_read(lfds711_ringbuffer_state*, void**, void**) @nogc nothrow;

    void lfds711_ringbuffer_write(lfds711_ringbuffer_state*, void*, void*, lfds711_misc_flag*, void**, void**) @nogc nothrow;

    pragma(mangle, "lfds711_ringbuffer_query") void lfds711_ringbuffer_query_(lfds711_ringbuffer_state*, lfds711_ringbuffer_query, void*, void*) @nogc nothrow;
    /***** enums *****/
    enum lfds711_stack_query
    {

        LFDS711_STACK_QUERY_SINGLETHREADED_GET_COUNT = 0,

        LFDS711_STACK_QUERY_SINGLETHREADED_VALIDATE = 1,
    }
    enum LFDS711_STACK_QUERY_SINGLETHREADED_GET_COUNT = lfds711_stack_query.LFDS711_STACK_QUERY_SINGLETHREADED_GET_COUNT;
    enum LFDS711_STACK_QUERY_SINGLETHREADED_VALIDATE = lfds711_stack_query.LFDS711_STACK_QUERY_SINGLETHREADED_VALIDATE;
    /***** structures *****/
    struct lfds711_stack_element
    {

        lfds711_stack_element* next;

        void* key;

        void* value;
    }

    struct lfds711_stack_state
    {

        lfds711_stack_element*[2] top;

        void* user_state;

        lfds711_misc_backoff_state pop_backoff;

        lfds711_misc_backoff_state push_backoff;
    }
    /***** public prototypes *****/
    void lfds711_stack_init_valid_on_current_logical_core(lfds711_stack_state*, void*) @nogc nothrow;

    void lfds711_stack_cleanup(lfds711_stack_state*, void function(lfds711_stack_state*, lfds711_stack_element*)) @nogc nothrow;

    void lfds711_stack_push(lfds711_stack_state*, lfds711_stack_element*) @nogc nothrow;

    int lfds711_stack_pop(lfds711_stack_state*, lfds711_stack_element**) @nogc nothrow;

    pragma(mangle, "lfds711_stack_query") void lfds711_stack_query_(lfds711_stack_state*, lfds711_stack_query, void*, void*) @nogc nothrow;

    bool is_power_of_two(c_ulong) @nogc nothrow;

    void ensure_lfds_valid_init_on_current_logical_core() @nogc nothrow;

    struct c_queue_bmm
    {

        lfds711_queue_bmm_state qstate;

        lfds711_queue_bmm_element* element;

        ulong number_elements;

        void* user_state;
    }

    c_queue_bmm* queue_bmm_new(c_ulong) @nogc nothrow;

    bool queue_bmm_push(c_queue_bmm*, void*) @nogc nothrow;

    void* queue_bmm_pop(c_queue_bmm*, int*) @nogc nothrow;

    c_ulong queue_bmm_length(c_queue_bmm*) @nogc nothrow;

    void queue_bmm_destroy(c_queue_bmm*) @nogc nothrow;

    struct c_queue_bss
    {

        lfds711_queue_bss_state qstate;

        lfds711_queue_bss_element* element;

        ulong number_elements;

        void* user_state;
    }

    c_queue_bss* queue_bss_new(c_ulong) @nogc nothrow;

    bool queue_bss_push(c_queue_bss*, void*) @nogc nothrow;

    void* queue_bss_pop(c_queue_bss*, int*) @nogc nothrow;

    c_ulong queue_bss_length(c_queue_bss*) @nogc nothrow;

    void queue_bss_destroy(c_queue_bss*) @nogc nothrow;

    struct c_queue_umm
    {

        lfds711_queue_umm_state qstate;

        lfds711_queue_umm_element* element;

        ulong number_elements;

        void* user_state;
    }

    c_queue_umm* queue_umm_new(c_ulong) @nogc nothrow;

    bool queue_umm_push(c_queue_umm*, void*) @nogc nothrow;

    void* queue_umm_pop(c_queue_umm*, int*) @nogc nothrow;

    c_ulong queue_umm_length(c_queue_umm*) @nogc nothrow;

    void queue_umm_destroy(c_queue_umm*) @nogc nothrow;
    pragma(mangle, "alloca")
    void* alloca_(c_ulong) @nogc nothrow;

    alias _Float64x = real;

    alias _Float32x = double;

    alias _Float64 = double;

    alias _Float32 = float;

    static c_ulong __bswap_64(c_ulong) @nogc nothrow;

    static uint __bswap_32(uint) @nogc nothrow;

    static ushort __bswap_16(ushort) @nogc nothrow;

    struct div_t
    {

        int quot;

        int rem;
    }

    struct ldiv_t
    {

        c_long quot;

        c_long rem;
    }

    struct lldiv_t
    {

        long quot;

        long rem;
    }

    c_ulong __ctype_get_mb_cur_max() @nogc nothrow;

    double atof(const(char)*) @nogc nothrow;

    int atoi(const(char)*) @nogc nothrow;

    c_long atol(const(char)*) @nogc nothrow;

    long atoll(const(char)*) @nogc nothrow;

    double strtod(const(char)*, char**) @nogc nothrow;

    float strtof(const(char)*, char**) @nogc nothrow;

    real strtold(const(char)*, char**) @nogc nothrow;

    c_long strtol(const(char)*, char**, int) @nogc nothrow;

    c_ulong strtoul(const(char)*, char**, int) @nogc nothrow;

    long strtoq(const(char)*, char**, int) @nogc nothrow;

    ulong strtouq(const(char)*, char**, int) @nogc nothrow;

    long strtoll(const(char)*, char**, int) @nogc nothrow;

    ulong strtoull(const(char)*, char**, int) @nogc nothrow;

    char* l64a(c_long) @nogc nothrow;

    c_long a64l(const(char)*) @nogc nothrow;

    c_long random() @nogc nothrow;

    void srandom(uint) @nogc nothrow;

    char* initstate(uint, char*, c_ulong) @nogc nothrow;

    char* setstate(char*) @nogc nothrow;

    struct random_data
    {

        int* fptr;

        int* rptr;

        int* state;

        int rand_type;

        int rand_deg;

        int rand_sep;

        int* end_ptr;
    }

    int random_r(random_data*, int*) @nogc nothrow;

    int srandom_r(uint, random_data*) @nogc nothrow;

    int initstate_r(uint, char*, c_ulong, random_data*) @nogc nothrow;

    int setstate_r(char*, random_data*) @nogc nothrow;

    int rand() @nogc nothrow;

    void srand(uint) @nogc nothrow;

    int rand_r(uint*) @nogc nothrow;

    double drand48() @nogc nothrow;

    double erand48(ushort*) @nogc nothrow;

    c_long lrand48() @nogc nothrow;

    c_long nrand48(ushort*) @nogc nothrow;

    c_long mrand48() @nogc nothrow;

    c_long jrand48(ushort*) @nogc nothrow;

    void srand48(c_long) @nogc nothrow;

    ushort* seed48(ushort*) @nogc nothrow;

    void lcong48(ushort*) @nogc nothrow;

    struct drand48_data
    {

        ushort[3] __x;

        ushort[3] __old_x;

        ushort __c;

        ushort __init;

        ulong __a;
    }

    int drand48_r(drand48_data*, double*) @nogc nothrow;

    int erand48_r(ushort*, drand48_data*, double*) @nogc nothrow;

    int lrand48_r(drand48_data*, c_long*) @nogc nothrow;

    int nrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;

    int mrand48_r(drand48_data*, c_long*) @nogc nothrow;

    int jrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;

    int srand48_r(c_long, drand48_data*) @nogc nothrow;

    int seed48_r(ushort*, drand48_data*) @nogc nothrow;

    int lcong48_r(ushort*, drand48_data*) @nogc nothrow;

    void* malloc(c_ulong) @nogc nothrow;

    void* calloc(c_ulong, c_ulong) @nogc nothrow;

    void* realloc(void*, c_ulong) @nogc nothrow;

    void* reallocarray(void*, c_ulong, c_ulong) @nogc nothrow;

    void free(void*) @nogc nothrow;

    void* valloc(c_ulong) @nogc nothrow;

    int posix_memalign(void**, c_ulong, c_ulong) @nogc nothrow;

    void* aligned_alloc(c_ulong, c_ulong) @nogc nothrow;

    void abort() @nogc nothrow;

    int atexit(void function()) @nogc nothrow;

    int at_quick_exit(void function()) @nogc nothrow;

    int on_exit(void function(int, void*), void*) @nogc nothrow;

    void exit(int) @nogc nothrow;

    void quick_exit(int) @nogc nothrow;

    void _Exit(int) @nogc nothrow;

    char* getenv(const(char)*) @nogc nothrow;

    int putenv(char*) @nogc nothrow;

    int setenv(const(char)*, const(char)*, int) @nogc nothrow;

    int unsetenv(const(char)*) @nogc nothrow;

    int clearenv() @nogc nothrow;

    char* mktemp(char*) @nogc nothrow;

    int mkstemp(char*) @nogc nothrow;

    int mkstemps(char*, int) @nogc nothrow;

    char* mkdtemp(char*) @nogc nothrow;

    int system(const(char)*) @nogc nothrow;

    char* realpath(const(char)*, char*) @nogc nothrow;
    alias __compar_fn_t = int function(const(void)*, const(void)*);

    void* bsearch(const(void)*, const(void)*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;

    void qsort(void*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;

    int abs(int) @nogc nothrow;

    c_long labs(c_long) @nogc nothrow;

    long llabs(long) @nogc nothrow;

    div_t div(int, int) @nogc nothrow;

    ldiv_t ldiv(c_long, c_long) @nogc nothrow;

    lldiv_t lldiv(long, long) @nogc nothrow;

    char* ecvt(double, int, int*, int*) @nogc nothrow;

    char* fcvt(double, int, int*, int*) @nogc nothrow;

    char* gcvt(double, int, char*) @nogc nothrow;

    char* qecvt(real, int, int*, int*) @nogc nothrow;

    char* qfcvt(real, int, int*, int*) @nogc nothrow;

    char* qgcvt(real, int, char*) @nogc nothrow;

    int ecvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;

    int fcvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;

    int qecvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;

    int qfcvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;

    int mblen(const(char)*, c_ulong) @nogc nothrow;

    int mbtowc(int*, const(char)*, c_ulong) @nogc nothrow;

    int wctomb(char*, int) @nogc nothrow;

    c_ulong mbstowcs(int*, const(char)*, c_ulong) @nogc nothrow;

    c_ulong wcstombs(char*, const(int)*, c_ulong) @nogc nothrow;

    int rpmatch(const(char)*) @nogc nothrow;

    int getsubopt(char**, char**, char**) @nogc nothrow;

    int getloadavg(double*, int) @nogc nothrow;





    static if(!is(typeof(MB_CUR_MAX))) {
        private enum enumMixinStr_MB_CUR_MAX = `enum MB_CUR_MAX = ( __ctype_get_mb_cur_max ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr_MB_CUR_MAX); }))) {
            mixin(enumMixinStr_MB_CUR_MAX);
        }
    }




    static if(!is(typeof(EXIT_SUCCESS))) {
        private enum enumMixinStr_EXIT_SUCCESS = `enum EXIT_SUCCESS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_EXIT_SUCCESS); }))) {
            mixin(enumMixinStr_EXIT_SUCCESS);
        }
    }




    static if(!is(typeof(EXIT_FAILURE))) {
        private enum enumMixinStr_EXIT_FAILURE = `enum EXIT_FAILURE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_EXIT_FAILURE); }))) {
            mixin(enumMixinStr_EXIT_FAILURE);
        }
    }




    static if(!is(typeof(RAND_MAX))) {
        private enum enumMixinStr_RAND_MAX = `enum RAND_MAX = 2147483647;`;
        static if(is(typeof({ mixin(enumMixinStr_RAND_MAX); }))) {
            mixin(enumMixinStr_RAND_MAX);
        }
    }




    static if(!is(typeof(__lldiv_t_defined))) {
        private enum enumMixinStr___lldiv_t_defined = `enum __lldiv_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___lldiv_t_defined); }))) {
            mixin(enumMixinStr___lldiv_t_defined);
        }
    }




    static if(!is(typeof(__ldiv_t_defined))) {
        private enum enumMixinStr___ldiv_t_defined = `enum __ldiv_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___ldiv_t_defined); }))) {
            mixin(enumMixinStr___ldiv_t_defined);
        }
    }






    static if(!is(typeof(_BITS_BYTESWAP_H))) {
        private enum enumMixinStr__BITS_BYTESWAP_H = `enum _BITS_BYTESWAP_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_BYTESWAP_H); }))) {
            mixin(enumMixinStr__BITS_BYTESWAP_H);
        }
    }
    static if(!is(typeof(_STDLIB_H))) {
        private enum enumMixinStr__STDLIB_H = `enum _STDLIB_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDLIB_H); }))) {
            mixin(enumMixinStr__STDLIB_H);
        }
    }
    static if(!is(typeof(_BITS_ENDIAN_H))) {
        private enum enumMixinStr__BITS_ENDIAN_H = `enum _BITS_ENDIAN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_ENDIAN_H); }))) {
            mixin(enumMixinStr__BITS_ENDIAN_H);
        }
    }




    static if(!is(typeof(__LITTLE_ENDIAN))) {
        private enum enumMixinStr___LITTLE_ENDIAN = `enum __LITTLE_ENDIAN = 1234;`;
        static if(is(typeof({ mixin(enumMixinStr___LITTLE_ENDIAN); }))) {
            mixin(enumMixinStr___LITTLE_ENDIAN);
        }
    }




    static if(!is(typeof(__BIG_ENDIAN))) {
        private enum enumMixinStr___BIG_ENDIAN = `enum __BIG_ENDIAN = 4321;`;
        static if(is(typeof({ mixin(enumMixinStr___BIG_ENDIAN); }))) {
            mixin(enumMixinStr___BIG_ENDIAN);
        }
    }




    static if(!is(typeof(__PDP_ENDIAN))) {
        private enum enumMixinStr___PDP_ENDIAN = `enum __PDP_ENDIAN = 3412;`;
        static if(is(typeof({ mixin(enumMixinStr___PDP_ENDIAN); }))) {
            mixin(enumMixinStr___PDP_ENDIAN);
        }
    }




    static if(!is(typeof(__FLOAT_WORD_ORDER))) {
        private enum enumMixinStr___FLOAT_WORD_ORDER = `enum __FLOAT_WORD_ORDER = __BYTE_ORDER;`;
        static if(is(typeof({ mixin(enumMixinStr___FLOAT_WORD_ORDER); }))) {
            mixin(enumMixinStr___FLOAT_WORD_ORDER);
        }
    }






    static if(!is(typeof(_BITS_ENDIANNESS_H))) {
        private enum enumMixinStr__BITS_ENDIANNESS_H = `enum _BITS_ENDIANNESS_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_ENDIANNESS_H); }))) {
            mixin(enumMixinStr__BITS_ENDIANNESS_H);
        }
    }




    static if(!is(typeof(_STDC_PREDEF_H))) {
        private enum enumMixinStr__STDC_PREDEF_H = `enum _STDC_PREDEF_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDC_PREDEF_H); }))) {
            mixin(enumMixinStr__STDC_PREDEF_H);
        }
    }




    static if(!is(typeof(__BYTE_ORDER))) {
        private enum enumMixinStr___BYTE_ORDER = `enum __BYTE_ORDER = 1234;`;
        static if(is(typeof({ mixin(enumMixinStr___BYTE_ORDER); }))) {
            mixin(enumMixinStr___BYTE_ORDER);
        }
    }
    static if(!is(typeof(__GLIBC_MINOR__))) {
        private enum enumMixinStr___GLIBC_MINOR__ = `enum __GLIBC_MINOR__ = 33;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_MINOR__); }))) {
            mixin(enumMixinStr___GLIBC_MINOR__);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT16))) {
        private enum enumMixinStr___HAVE_FLOAT16 = `enum __HAVE_FLOAT16 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT16); }))) {
            mixin(enumMixinStr___HAVE_FLOAT16);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT32))) {
        private enum enumMixinStr___HAVE_FLOAT32 = `enum __HAVE_FLOAT32 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT32); }))) {
            mixin(enumMixinStr___HAVE_FLOAT32);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT64))) {
        private enum enumMixinStr___HAVE_FLOAT64 = `enum __HAVE_FLOAT64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT64); }))) {
            mixin(enumMixinStr___HAVE_FLOAT64);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT32X))) {
        private enum enumMixinStr___HAVE_FLOAT32X = `enum __HAVE_FLOAT32X = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT32X); }))) {
            mixin(enumMixinStr___HAVE_FLOAT32X);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT128X))) {
        private enum enumMixinStr___HAVE_FLOAT128X = `enum __HAVE_FLOAT128X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT128X); }))) {
            mixin(enumMixinStr___HAVE_FLOAT128X);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT16))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT16 = `enum __HAVE_DISTINCT_FLOAT16 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT16); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT16);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT32))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT32 = `enum __HAVE_DISTINCT_FLOAT32 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT32); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT32);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT64))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT64 = `enum __HAVE_DISTINCT_FLOAT64 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT64); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT64);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT32X))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT32X = `enum __HAVE_DISTINCT_FLOAT32X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT32X); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT32X);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT64X))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT64X = `enum __HAVE_DISTINCT_FLOAT64X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT64X); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT64X);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT128X))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT128X = `enum __HAVE_DISTINCT_FLOAT128X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT128X); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT128X);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT128_UNLIKE_LDBL))) {
        private enum enumMixinStr___HAVE_FLOAT128_UNLIKE_LDBL = `enum __HAVE_FLOAT128_UNLIKE_LDBL = ( __HAVE_DISTINCT_FLOAT128 && 64 != 113 );`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT128_UNLIKE_LDBL); }))) {
            mixin(enumMixinStr___HAVE_FLOAT128_UNLIKE_LDBL);
        }
    }




    static if(!is(typeof(__GLIBC__))) {
        private enum enumMixinStr___GLIBC__ = `enum __GLIBC__ = 2;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC__); }))) {
            mixin(enumMixinStr___GLIBC__);
        }
    }




    static if(!is(typeof(__HAVE_FLOATN_NOT_TYPEDEF))) {
        private enum enumMixinStr___HAVE_FLOATN_NOT_TYPEDEF = `enum __HAVE_FLOATN_NOT_TYPEDEF = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOATN_NOT_TYPEDEF); }))) {
            mixin(enumMixinStr___HAVE_FLOATN_NOT_TYPEDEF);
        }
    }




    static if(!is(typeof(__GNU_LIBRARY__))) {
        private enum enumMixinStr___GNU_LIBRARY__ = `enum __GNU_LIBRARY__ = 6;`;
        static if(is(typeof({ mixin(enumMixinStr___GNU_LIBRARY__); }))) {
            mixin(enumMixinStr___GNU_LIBRARY__);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_SCANF))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_SCANF = `enum __GLIBC_USE_DEPRECATED_SCANF = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_GETS))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_GETS = `enum __GLIBC_USE_DEPRECATED_GETS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS);
        }
    }






    static if(!is(typeof(__USE_FORTIFY_LEVEL))) {
        private enum enumMixinStr___USE_FORTIFY_LEVEL = `enum __USE_FORTIFY_LEVEL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_FORTIFY_LEVEL); }))) {
            mixin(enumMixinStr___USE_FORTIFY_LEVEL);
        }
    }




    static if(!is(typeof(__USE_ATFILE))) {
        private enum enumMixinStr___USE_ATFILE = `enum __USE_ATFILE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ATFILE); }))) {
            mixin(enumMixinStr___USE_ATFILE);
        }
    }






    static if(!is(typeof(__USE_MISC))) {
        private enum enumMixinStr___USE_MISC = `enum __USE_MISC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_MISC); }))) {
            mixin(enumMixinStr___USE_MISC);
        }
    }




    static if(!is(typeof(_ATFILE_SOURCE))) {
        private enum enumMixinStr__ATFILE_SOURCE = `enum _ATFILE_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ATFILE_SOURCE); }))) {
            mixin(enumMixinStr__ATFILE_SOURCE);
        }
    }






    static if(!is(typeof(__USE_XOPEN2K8))) {
        private enum enumMixinStr___USE_XOPEN2K8 = `enum __USE_XOPEN2K8 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K8); }))) {
            mixin(enumMixinStr___USE_XOPEN2K8);
        }
    }




    static if(!is(typeof(__USE_ISOC99))) {
        private enum enumMixinStr___USE_ISOC99 = `enum __USE_ISOC99 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC99); }))) {
            mixin(enumMixinStr___USE_ISOC99);
        }
    }




    static if(!is(typeof(__USE_ISOC95))) {
        private enum enumMixinStr___USE_ISOC95 = `enum __USE_ISOC95 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC95); }))) {
            mixin(enumMixinStr___USE_ISOC95);
        }
    }






    static if(!is(typeof(__USE_XOPEN2K))) {
        private enum enumMixinStr___USE_XOPEN2K = `enum __USE_XOPEN2K = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K); }))) {
            mixin(enumMixinStr___USE_XOPEN2K);
        }
    }




    static if(!is(typeof(__USE_POSIX199506))) {
        private enum enumMixinStr___USE_POSIX199506 = `enum __USE_POSIX199506 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199506); }))) {
            mixin(enumMixinStr___USE_POSIX199506);
        }
    }




    static if(!is(typeof(__USE_POSIX199309))) {
        private enum enumMixinStr___USE_POSIX199309 = `enum __USE_POSIX199309 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199309); }))) {
            mixin(enumMixinStr___USE_POSIX199309);
        }
    }




    static if(!is(typeof(__USE_POSIX2))) {
        private enum enumMixinStr___USE_POSIX2 = `enum __USE_POSIX2 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX2); }))) {
            mixin(enumMixinStr___USE_POSIX2);
        }
    }




    static if(!is(typeof(__CFLOAT32))) {
        private enum enumMixinStr___CFLOAT32 = `enum __CFLOAT32 = _Complex float;`;
        static if(is(typeof({ mixin(enumMixinStr___CFLOAT32); }))) {
            mixin(enumMixinStr___CFLOAT32);
        }
    }




    static if(!is(typeof(__USE_POSIX))) {
        private enum enumMixinStr___USE_POSIX = `enum __USE_POSIX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX); }))) {
            mixin(enumMixinStr___USE_POSIX);
        }
    }




    static if(!is(typeof(_POSIX_C_SOURCE))) {
        private enum enumMixinStr__POSIX_C_SOURCE = `enum _POSIX_C_SOURCE = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_C_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_C_SOURCE);
        }
    }




    static if(!is(typeof(__CFLOAT64))) {
        private enum enumMixinStr___CFLOAT64 = `enum __CFLOAT64 = _Complex double;`;
        static if(is(typeof({ mixin(enumMixinStr___CFLOAT64); }))) {
            mixin(enumMixinStr___CFLOAT64);
        }
    }




    static if(!is(typeof(_POSIX_SOURCE))) {
        private enum enumMixinStr__POSIX_SOURCE = `enum _POSIX_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_SOURCE);
        }
    }




    static if(!is(typeof(__USE_POSIX_IMPLICITLY))) {
        private enum enumMixinStr___USE_POSIX_IMPLICITLY = `enum __USE_POSIX_IMPLICITLY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX_IMPLICITLY); }))) {
            mixin(enumMixinStr___USE_POSIX_IMPLICITLY);
        }
    }




    static if(!is(typeof(__CFLOAT32X))) {
        private enum enumMixinStr___CFLOAT32X = `enum __CFLOAT32X = _Complex double;`;
        static if(is(typeof({ mixin(enumMixinStr___CFLOAT32X); }))) {
            mixin(enumMixinStr___CFLOAT32X);
        }
    }




    static if(!is(typeof(__USE_ISOC11))) {
        private enum enumMixinStr___USE_ISOC11 = `enum __USE_ISOC11 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC11); }))) {
            mixin(enumMixinStr___USE_ISOC11);
        }
    }




    static if(!is(typeof(__CFLOAT64X))) {
        private enum enumMixinStr___CFLOAT64X = `enum __CFLOAT64X = _Complex long double;`;
        static if(is(typeof({ mixin(enumMixinStr___CFLOAT64X); }))) {
            mixin(enumMixinStr___CFLOAT64X);
        }
    }




    static if(!is(typeof(__GLIBC_USE_ISOC2X))) {
        private enum enumMixinStr___GLIBC_USE_ISOC2X = `enum __GLIBC_USE_ISOC2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_ISOC2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_ISOC2X);
        }
    }




    static if(!is(typeof(_DEFAULT_SOURCE))) {
        private enum enumMixinStr__DEFAULT_SOURCE = `enum _DEFAULT_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__DEFAULT_SOURCE); }))) {
            mixin(enumMixinStr__DEFAULT_SOURCE);
        }
    }
    static if(!is(typeof(_FEATURES_H))) {
        private enum enumMixinStr__FEATURES_H = `enum _FEATURES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__FEATURES_H); }))) {
            mixin(enumMixinStr__FEATURES_H);
        }
    }
    static if(!is(typeof(BYTE_ORDER))) {
        private enum enumMixinStr_BYTE_ORDER = `enum BYTE_ORDER = 1234;`;
        static if(is(typeof({ mixin(enumMixinStr_BYTE_ORDER); }))) {
            mixin(enumMixinStr_BYTE_ORDER);
        }
    }






    static if(!is(typeof(PDP_ENDIAN))) {
        private enum enumMixinStr_PDP_ENDIAN = `enum PDP_ENDIAN = 3412;`;
        static if(is(typeof({ mixin(enumMixinStr_PDP_ENDIAN); }))) {
            mixin(enumMixinStr_PDP_ENDIAN);
        }
    }




    static if(!is(typeof(BIG_ENDIAN))) {
        private enum enumMixinStr_BIG_ENDIAN = `enum BIG_ENDIAN = 4321;`;
        static if(is(typeof({ mixin(enumMixinStr_BIG_ENDIAN); }))) {
            mixin(enumMixinStr_BIG_ENDIAN);
        }
    }




    static if(!is(typeof(LITTLE_ENDIAN))) {
        private enum enumMixinStr_LITTLE_ENDIAN = `enum LITTLE_ENDIAN = 1234;`;
        static if(is(typeof({ mixin(enumMixinStr_LITTLE_ENDIAN); }))) {
            mixin(enumMixinStr_LITTLE_ENDIAN);
        }
    }




    static if(!is(typeof(_ENDIAN_H))) {
        private enum enumMixinStr__ENDIAN_H = `enum _ENDIAN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ENDIAN_H); }))) {
            mixin(enumMixinStr__ENDIAN_H);
        }
    }






    static if(!is(typeof(__HAVE_FLOAT128))) {
        private enum enumMixinStr___HAVE_FLOAT128 = `enum __HAVE_FLOAT128 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT128); }))) {
            mixin(enumMixinStr___HAVE_FLOAT128);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT128))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT128 = `enum __HAVE_DISTINCT_FLOAT128 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT128); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT128);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT64X))) {
        private enum enumMixinStr___HAVE_FLOAT64X = `enum __HAVE_FLOAT64X = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT64X); }))) {
            mixin(enumMixinStr___HAVE_FLOAT64X);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT64X_LONG_DOUBLE))) {
        private enum enumMixinStr___HAVE_FLOAT64X_LONG_DOUBLE = `enum __HAVE_FLOAT64X_LONG_DOUBLE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT64X_LONG_DOUBLE); }))) {
            mixin(enumMixinStr___HAVE_FLOAT64X_LONG_DOUBLE);
        }
    }




    static if(!is(typeof(_ALLOCA_H))) {
        private enum enumMixinStr__ALLOCA_H = `enum _ALLOCA_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ALLOCA_H); }))) {
            mixin(enumMixinStr__ALLOCA_H);
        }
    }
    static if(!is(typeof(__GLIBC_USE_LIB_EXT2))) {
        private enum enumMixinStr___GLIBC_USE_LIB_EXT2 = `enum __GLIBC_USE_LIB_EXT2 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_LIB_EXT2); }))) {
            mixin(enumMixinStr___GLIBC_USE_LIB_EXT2);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT = `enum __GLIBC_USE_IEC_60559_BFP_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT);
        }
    }
    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT_C2X))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X = `enum __GLIBC_USE_IEC_60559_BFP_EXT_C2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT);
        }
    }
    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT_C2X))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_TYPES_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT = `enum __GLIBC_USE_IEC_60559_TYPES_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT);
        }
    }




    static if(!is(typeof(__LDOUBLE_REDIRECTS_TO_FLOAT128_ABI))) {
        private enum enumMixinStr___LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = `enum __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___LDOUBLE_REDIRECTS_TO_FLOAT128_ABI); }))) {
            mixin(enumMixinStr___LDOUBLE_REDIRECTS_TO_FLOAT128_ABI);
        }
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_ARCH_H))) {
        private enum enumMixinStr__BITS_PTHREADTYPES_ARCH_H = `enum _BITS_PTHREADTYPES_ARCH_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_PTHREADTYPES_ARCH_H); }))) {
            mixin(enumMixinStr__BITS_PTHREADTYPES_ARCH_H);
        }
    }
    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEX_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_MUTEX_T = `enum __SIZEOF_PTHREAD_MUTEX_T = 40;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEX_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEX_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_ATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_ATTR_T = `enum __SIZEOF_PTHREAD_ATTR_T = 56;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_ATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_ATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCK_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T = `enum __SIZEOF_PTHREAD_RWLOCK_T = 56;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIER_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_BARRIER_T = `enum __SIZEOF_PTHREAD_BARRIER_T = 32;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIER_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIER_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEXATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T = `enum __SIZEOF_PTHREAD_MUTEXATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_COND_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_COND_T = `enum __SIZEOF_PTHREAD_COND_T = 48;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_COND_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_COND_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_CONDATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T = `enum __SIZEOF_PTHREAD_CONDATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCKATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T = `enum __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIERATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T = `enum __SIZEOF_PTHREAD_BARRIERATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T);
        }
    }
    static if(!is(typeof(_BITS_PTHREADTYPES_COMMON_H))) {
        private enum enumMixinStr__BITS_PTHREADTYPES_COMMON_H = `enum _BITS_PTHREADTYPES_COMMON_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_PTHREADTYPES_COMMON_H); }))) {
            mixin(enumMixinStr__BITS_PTHREADTYPES_COMMON_H);
        }
    }
    static if(!is(typeof(LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_TWO))) {
        private enum enumMixinStr_LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_TWO = `enum LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_TWO = 0x94D049BB133111EBLU;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_TWO); }))) {
            mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_TWO);
        }
    }




    static if(!is(typeof(LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_ONE))) {
        private enum enumMixinStr_LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_ONE = `enum LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_ONE = 0xBF58476D1CE4E5B9LU;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_ONE); }))) {
            mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_MULTIPLY_CONSTANT_ONE);
        }
    }




    static if(!is(typeof(LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_THREE))) {
        private enum enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_THREE = `enum LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_THREE = 31;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_THREE); }))) {
            mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_THREE);
        }
    }




    static if(!is(typeof(LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_TWO))) {
        private enum enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_TWO = `enum LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_TWO = 27;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_TWO); }))) {
            mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_TWO);
        }
    }




    static if(!is(typeof(LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_ONE))) {
        private enum enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_ONE = `enum LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_ONE = 30;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_ONE); }))) {
            mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_SHIFT_CONSTANT_ONE);
        }
    }




    static if(!is(typeof(LFDS711_PRNG_SPLITMIX_MAGIC_RATIO))) {
        private enum enumMixinStr_LFDS711_PRNG_SPLITMIX_MAGIC_RATIO = `enum LFDS711_PRNG_SPLITMIX_MAGIC_RATIO = 0x9E3779B97F4A7C15LU;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_MAGIC_RATIO); }))) {
            mixin(enumMixinStr_LFDS711_PRNG_SPLITMIX_MAGIC_RATIO);
        }
    }




    static if(!is(typeof(__have_pthread_attr_t))) {
        private enum enumMixinStr___have_pthread_attr_t = `enum __have_pthread_attr_t = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___have_pthread_attr_t); }))) {
            mixin(enumMixinStr___have_pthread_attr_t);
        }
    }




    static if(!is(typeof(LFDS711_PRNG_SEED))) {
        private enum enumMixinStr_LFDS711_PRNG_SEED = `enum LFDS711_PRNG_SEED = 0x0a34655d34c092feLU;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PRNG_SEED); }))) {
            mixin(enumMixinStr_LFDS711_PRNG_SEED);
        }
    }




    static if(!is(typeof(LFDS711_PRNG_MAX))) {
        private enum enumMixinStr_LFDS711_PRNG_MAX = `enum LFDS711_PRNG_MAX = ( cast( lfds711_pal_uint_t ) - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PRNG_MAX); }))) {
            mixin(enumMixinStr_LFDS711_PRNG_MAX);
        }
    }




    static if(!is(typeof(LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES))) {
        private enum enumMixinStr_LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES = `enum LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES); }))) {
            mixin(enumMixinStr_LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES);
        }
    }




    static if(!is(typeof(LFDS711_PAL_ALIGN_DOUBLE_POINTER))) {
        private enum enumMixinStr_LFDS711_PAL_ALIGN_DOUBLE_POINTER = `enum LFDS711_PAL_ALIGN_DOUBLE_POINTER = 16;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_ALIGN_DOUBLE_POINTER); }))) {
            mixin(enumMixinStr_LFDS711_PAL_ALIGN_DOUBLE_POINTER);
        }
    }




    static if(!is(typeof(LFDS711_PAL_ALIGN_SINGLE_POINTER))) {
        private enum enumMixinStr_LFDS711_PAL_ALIGN_SINGLE_POINTER = `enum LFDS711_PAL_ALIGN_SINGLE_POINTER = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_ALIGN_SINGLE_POINTER); }))) {
            mixin(enumMixinStr_LFDS711_PAL_ALIGN_SINGLE_POINTER);
        }
    }




    static if(!is(typeof(LFDS711_PAL_PROCESSOR_STRING))) {
        private enum enumMixinStr_LFDS711_PAL_PROCESSOR_STRING = `enum LFDS711_PAL_PROCESSOR_STRING = "x64";`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_PROCESSOR_STRING); }))) {
            mixin(enumMixinStr_LFDS711_PAL_PROCESSOR_STRING);
        }
    }
    static if(!is(typeof(LFDS711_PAL_OS_STRING))) {
        private enum enumMixinStr_LFDS711_PAL_OS_STRING = `enum LFDS711_PAL_OS_STRING = "Linux";`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_OS_STRING); }))) {
            mixin(enumMixinStr_LFDS711_PAL_OS_STRING);
        }
    }
    static if(!is(typeof(LFDS711_PAL_BARRIER_PROCESSOR_FULL))) {
        private enum enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_FULL = `enum LFDS711_PAL_BARRIER_PROCESSOR_FULL = __sync_synchronize ( );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_FULL); }))) {
            mixin(enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_FULL);
        }
    }




    static if(!is(typeof(LFDS711_PAL_BARRIER_PROCESSOR_STORE))) {
        private enum enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_STORE = `enum LFDS711_PAL_BARRIER_PROCESSOR_STORE = __sync_synchronize ( );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_STORE); }))) {
            mixin(enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_STORE);
        }
    }




    static if(!is(typeof(LFDS711_PAL_BARRIER_PROCESSOR_LOAD))) {
        private enum enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_LOAD = `enum LFDS711_PAL_BARRIER_PROCESSOR_LOAD = __sync_synchronize ( );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_LOAD); }))) {
            mixin(enumMixinStr_LFDS711_PAL_BARRIER_PROCESSOR_LOAD);
        }
    }




    static if(!is(typeof(LFDS711_PAL_BARRIER_COMPILER_FULL))) {
        private enum enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_FULL = `enum LFDS711_PAL_BARRIER_COMPILER_FULL = lfds711_pal_barrier_compiler ( );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_FULL); }))) {
            mixin(enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_FULL);
        }
    }




    static if(!is(typeof(LFDS711_PAL_BARRIER_COMPILER_STORE))) {
        private enum enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_STORE = `enum LFDS711_PAL_BARRIER_COMPILER_STORE = lfds711_pal_barrier_compiler ( );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_STORE); }))) {
            mixin(enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_STORE);
        }
    }




    static if(!is(typeof(LFDS711_PAL_BARRIER_COMPILER_LOAD))) {
        private enum enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_LOAD = `enum LFDS711_PAL_BARRIER_COMPILER_LOAD = lfds711_pal_barrier_compiler ( );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_LOAD); }))) {
            mixin(enumMixinStr_LFDS711_PAL_BARRIER_COMPILER_LOAD);
        }
    }




    static if(!is(typeof(LFDS711_PAL_INLINE))) {
        private enum enumMixinStr_LFDS711_PAL_INLINE = `enum LFDS711_PAL_INLINE = inline;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_INLINE); }))) {
            mixin(enumMixinStr_LFDS711_PAL_INLINE);
        }
    }
    static if(!is(typeof(_BITS_STDINT_INTN_H))) {
        private enum enumMixinStr__BITS_STDINT_INTN_H = `enum _BITS_STDINT_INTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_INTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_INTN_H);
        }
    }






    static if(!is(typeof(LFDS711_PAL_COMPILER_STRING))) {
        private enum enumMixinStr_LFDS711_PAL_COMPILER_STRING = `enum LFDS711_PAL_COMPILER_STRING = "GCC < 4.7.3";`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_COMPILER_STRING); }))) {
            mixin(enumMixinStr_LFDS711_PAL_COMPILER_STRING);
        }
    }






    static if(!is(typeof(LFDS711_PAL_GCC_VERSION))) {
        private enum enumMixinStr_LFDS711_PAL_GCC_VERSION = `enum LFDS711_PAL_GCC_VERSION = ( 10 * 100 + 3 * 10 + 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_PAL_GCC_VERSION); }))) {
            mixin(enumMixinStr_LFDS711_PAL_GCC_VERSION);
        }
    }




    static if(!is(typeof(LFDS711_MISC_FLUSH))) {
        private enum enumMixinStr_LFDS711_MISC_FLUSH = `enum LFDS711_MISC_FLUSH = { LFDS711_MISC_BARRIER_STORE ; lfds711_misc_force_store ( ) ; };`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_FLUSH); }))) {
            mixin(enumMixinStr_LFDS711_MISC_FLUSH);
        }
    }




    static if(!is(typeof(LFDS711_MISC_MAKE_VALID_ON_CURRENT_LOGICAL_CORE_INITS_COMPLETED_BEFORE_NOW_ON_ANY_OTHER_LOGICAL_CORE))) {
        private enum enumMixinStr_LFDS711_MISC_MAKE_VALID_ON_CURRENT_LOGICAL_CORE_INITS_COMPLETED_BEFORE_NOW_ON_ANY_OTHER_LOGICAL_CORE = `enum LFDS711_MISC_MAKE_VALID_ON_CURRENT_LOGICAL_CORE_INITS_COMPLETED_BEFORE_NOW_ON_ANY_OTHER_LOGICAL_CORE = LFDS711_MISC_BARRIER_LOAD;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_MAKE_VALID_ON_CURRENT_LOGICAL_CORE_INITS_COMPLETED_BEFORE_NOW_ON_ANY_OTHER_LOGICAL_CORE); }))) {
            mixin(enumMixinStr_LFDS711_MISC_MAKE_VALID_ON_CURRENT_LOGICAL_CORE_INITS_COMPLETED_BEFORE_NOW_ON_ANY_OTHER_LOGICAL_CORE);
        }
    }




    static if(!is(typeof(_THREAD_MUTEX_INTERNAL_H))) {
        private enum enumMixinStr__THREAD_MUTEX_INTERNAL_H = `enum _THREAD_MUTEX_INTERNAL_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__THREAD_MUTEX_INTERNAL_H); }))) {
            mixin(enumMixinStr__THREAD_MUTEX_INTERNAL_H);
        }
    }




    static if(!is(typeof(LFDS711_MISC_ATOMIC_SUPPORT_PROCESSOR_BARRIERS))) {
        private enum enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_PROCESSOR_BARRIERS = `enum LFDS711_MISC_ATOMIC_SUPPORT_PROCESSOR_BARRIERS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_PROCESSOR_BARRIERS); }))) {
            mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_PROCESSOR_BARRIERS);
        }
    }




    static if(!is(typeof(LFDS711_MISC_ATOMIC_SUPPORT_COMPILER_BARRIERS))) {
        private enum enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_COMPILER_BARRIERS = `enum LFDS711_MISC_ATOMIC_SUPPORT_COMPILER_BARRIERS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_COMPILER_BARRIERS); }))) {
            mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_COMPILER_BARRIERS);
        }
    }




    static if(!is(typeof(LFDS711_MISC_BARRIER_FULL))) {
        private enum enumMixinStr_LFDS711_MISC_BARRIER_FULL = `enum LFDS711_MISC_BARRIER_FULL = ( lfds711_pal_barrier_compiler ( ) , __sync_synchronize ( ) , lfds711_pal_barrier_compiler ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_BARRIER_FULL); }))) {
            mixin(enumMixinStr_LFDS711_MISC_BARRIER_FULL);
        }
    }




    static if(!is(typeof(__PTHREAD_MUTEX_HAVE_PREV))) {
        private enum enumMixinStr___PTHREAD_MUTEX_HAVE_PREV = `enum __PTHREAD_MUTEX_HAVE_PREV = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_MUTEX_HAVE_PREV); }))) {
            mixin(enumMixinStr___PTHREAD_MUTEX_HAVE_PREV);
        }
    }




    static if(!is(typeof(LFDS711_MISC_BARRIER_STORE))) {
        private enum enumMixinStr_LFDS711_MISC_BARRIER_STORE = `enum LFDS711_MISC_BARRIER_STORE = ( lfds711_pal_barrier_compiler ( ) , __sync_synchronize ( ) , lfds711_pal_barrier_compiler ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_BARRIER_STORE); }))) {
            mixin(enumMixinStr_LFDS711_MISC_BARRIER_STORE);
        }
    }
    static if(!is(typeof(LFDS711_MISC_BARRIER_LOAD))) {
        private enum enumMixinStr_LFDS711_MISC_BARRIER_LOAD = `enum LFDS711_MISC_BARRIER_LOAD = ( lfds711_pal_barrier_compiler ( ) , __sync_synchronize ( ) , lfds711_pal_barrier_compiler ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_BARRIER_LOAD); }))) {
            mixin(enumMixinStr_LFDS711_MISC_BARRIER_LOAD);
        }
    }




    static if(!is(typeof(LFDS711_MISC_ATOMIC_SUPPORT_SET))) {
        private enum enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_SET = `enum LFDS711_MISC_ATOMIC_SUPPORT_SET = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_SET); }))) {
            mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_SET);
        }
    }




    static if(!is(typeof(__PTHREAD_RWLOCK_ELISION_EXTRA))) {
        private enum enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA = `enum __PTHREAD_RWLOCK_ELISION_EXTRA = 0 , { 0 , 0 , 0 , 0 , 0 , 0 , 0 };`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA); }))) {
            mixin(enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA);
        }
    }




    static if(!is(typeof(LFDS711_MISC_ATOMIC_SUPPORT_EXCHANGE))) {
        private enum enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_EXCHANGE = `enum LFDS711_MISC_ATOMIC_SUPPORT_EXCHANGE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_EXCHANGE); }))) {
            mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_EXCHANGE);
        }
    }






    static if(!is(typeof(_THREAD_SHARED_TYPES_H))) {
        private enum enumMixinStr__THREAD_SHARED_TYPES_H = `enum _THREAD_SHARED_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__THREAD_SHARED_TYPES_H); }))) {
            mixin(enumMixinStr__THREAD_SHARED_TYPES_H);
        }
    }




    static if(!is(typeof(LFDS711_MISC_ATOMIC_SUPPORT_DWCAS))) {
        private enum enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_DWCAS = `enum LFDS711_MISC_ATOMIC_SUPPORT_DWCAS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_DWCAS); }))) {
            mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_DWCAS);
        }
    }




    static if(!is(typeof(LFDS711_MISC_ATOMIC_SUPPORT_CAS))) {
        private enum enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_CAS = `enum LFDS711_MISC_ATOMIC_SUPPORT_CAS = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_CAS); }))) {
            mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_CAS);
        }
    }




    static if(!is(typeof(LFDS711_MISC_ATOMIC_SUPPORT_ADD))) {
        private enum enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_ADD = `enum LFDS711_MISC_ATOMIC_SUPPORT_ADD = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_ADD); }))) {
            mixin(enumMixinStr_LFDS711_MISC_ATOMIC_SUPPORT_ADD);
        }
    }




    static if(!is(typeof(LFDS711_MISC_DELIBERATELY_CRASH))) {
        private enum enumMixinStr_LFDS711_MISC_DELIBERATELY_CRASH = `enum LFDS711_MISC_DELIBERATELY_CRASH = { char * c = 0 ; * c = 0 ; };`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_DELIBERATELY_CRASH); }))) {
            mixin(enumMixinStr_LFDS711_MISC_DELIBERATELY_CRASH);
        }
    }




    static if(!is(typeof(PAC_SIZE))) {
        private enum enumMixinStr_PAC_SIZE = `enum PAC_SIZE = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_PAC_SIZE); }))) {
            mixin(enumMixinStr_PAC_SIZE);
        }
    }




    static if(!is(typeof(COUNTER))) {
        private enum enumMixinStr_COUNTER = `enum COUNTER = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_COUNTER); }))) {
            mixin(enumMixinStr_COUNTER);
        }
    }




    static if(!is(typeof(POINTER))) {
        private enum enumMixinStr_POINTER = `enum POINTER = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_POINTER); }))) {
            mixin(enumMixinStr_POINTER);
        }
    }




    static if(!is(typeof(LFDS711_MISC_VERSION_INTEGER))) {
        private enum enumMixinStr_LFDS711_MISC_VERSION_INTEGER = `enum LFDS711_MISC_VERSION_INTEGER = 711;`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_VERSION_INTEGER); }))) {
            mixin(enumMixinStr_LFDS711_MISC_VERSION_INTEGER);
        }
    }




    static if(!is(typeof(LFDS711_MISC_VERSION_STRING))) {
        private enum enumMixinStr_LFDS711_MISC_VERSION_STRING = `enum LFDS711_MISC_VERSION_STRING = "7.1.1";`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_MISC_VERSION_STRING); }))) {
            mixin(enumMixinStr_LFDS711_MISC_VERSION_STRING);
        }
    }
    static if(!is(typeof(__ONCE_FLAG_INIT))) {
        private enum enumMixinStr___ONCE_FLAG_INIT = `enum __ONCE_FLAG_INIT = { 0 };`;
        static if(is(typeof({ mixin(enumMixinStr___ONCE_FLAG_INIT); }))) {
            mixin(enumMixinStr___ONCE_FLAG_INIT);
        }
    }






    static if(!is(typeof(_BITS_TIME64_H))) {
        private enum enumMixinStr__BITS_TIME64_H = `enum _BITS_TIME64_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TIME64_H); }))) {
            mixin(enumMixinStr__BITS_TIME64_H);
        }
    }






    static if(!is(typeof(__TIME64_T_TYPE))) {
        private enum enumMixinStr___TIME64_T_TYPE = `enum __TIME64_T_TYPE = __TIME_T_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME64_T_TYPE); }))) {
            mixin(enumMixinStr___TIME64_T_TYPE);
        }
    }






    static if(!is(typeof(__TIMESIZE))) {
        private enum enumMixinStr___TIMESIZE = `enum __TIMESIZE = __WORDSIZE;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMESIZE); }))) {
            mixin(enumMixinStr___TIMESIZE);
        }
    }




    static if(!is(typeof(_BITS_TYPES_H))) {
        private enum enumMixinStr__BITS_TYPES_H = `enum _BITS_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPES_H); }))) {
            mixin(enumMixinStr__BITS_TYPES_H);
        }
    }
    static if(!is(typeof(LFDS711_FREELIST_ELIMINATION_ARRAY_ELEMENT_SIZE_IN_FREELIST_ELEMENTS))) {
        private enum enumMixinStr_LFDS711_FREELIST_ELIMINATION_ARRAY_ELEMENT_SIZE_IN_FREELIST_ELEMENTS = `enum LFDS711_FREELIST_ELIMINATION_ARRAY_ELEMENT_SIZE_IN_FREELIST_ELEMENTS = ( 128 / ( lfds711_freelist_element * ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr_LFDS711_FREELIST_ELIMINATION_ARRAY_ELEMENT_SIZE_IN_FREELIST_ELEMENTS); }))) {
            mixin(enumMixinStr_LFDS711_FREELIST_ELIMINATION_ARRAY_ELEMENT_SIZE_IN_FREELIST_ELEMENTS);
        }
    }
    static if(!is(typeof(__S16_TYPE))) {
        private enum enumMixinStr___S16_TYPE = `enum __S16_TYPE = short int;`;
        static if(is(typeof({ mixin(enumMixinStr___S16_TYPE); }))) {
            mixin(enumMixinStr___S16_TYPE);
        }
    }




    static if(!is(typeof(__U16_TYPE))) {
        private enum enumMixinStr___U16_TYPE = `enum __U16_TYPE = unsigned short int;`;
        static if(is(typeof({ mixin(enumMixinStr___U16_TYPE); }))) {
            mixin(enumMixinStr___U16_TYPE);
        }
    }




    static if(!is(typeof(__S32_TYPE))) {
        private enum enumMixinStr___S32_TYPE = `enum __S32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___S32_TYPE); }))) {
            mixin(enumMixinStr___S32_TYPE);
        }
    }




    static if(!is(typeof(__U32_TYPE))) {
        private enum enumMixinStr___U32_TYPE = `enum __U32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___U32_TYPE); }))) {
            mixin(enumMixinStr___U32_TYPE);
        }
    }




    static if(!is(typeof(__SLONGWORD_TYPE))) {
        private enum enumMixinStr___SLONGWORD_TYPE = `enum __SLONGWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONGWORD_TYPE); }))) {
            mixin(enumMixinStr___SLONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__ULONGWORD_TYPE))) {
        private enum enumMixinStr___ULONGWORD_TYPE = `enum __ULONGWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONGWORD_TYPE); }))) {
            mixin(enumMixinStr___ULONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__SQUAD_TYPE))) {
        private enum enumMixinStr___SQUAD_TYPE = `enum __SQUAD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SQUAD_TYPE); }))) {
            mixin(enumMixinStr___SQUAD_TYPE);
        }
    }




    static if(!is(typeof(__UQUAD_TYPE))) {
        private enum enumMixinStr___UQUAD_TYPE = `enum __UQUAD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UQUAD_TYPE); }))) {
            mixin(enumMixinStr___UQUAD_TYPE);
        }
    }




    static if(!is(typeof(__SWORD_TYPE))) {
        private enum enumMixinStr___SWORD_TYPE = `enum __SWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SWORD_TYPE); }))) {
            mixin(enumMixinStr___SWORD_TYPE);
        }
    }




    static if(!is(typeof(__UWORD_TYPE))) {
        private enum enumMixinStr___UWORD_TYPE = `enum __UWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UWORD_TYPE); }))) {
            mixin(enumMixinStr___UWORD_TYPE);
        }
    }




    static if(!is(typeof(__SLONG32_TYPE))) {
        private enum enumMixinStr___SLONG32_TYPE = `enum __SLONG32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONG32_TYPE); }))) {
            mixin(enumMixinStr___SLONG32_TYPE);
        }
    }




    static if(!is(typeof(__ULONG32_TYPE))) {
        private enum enumMixinStr___ULONG32_TYPE = `enum __ULONG32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONG32_TYPE); }))) {
            mixin(enumMixinStr___ULONG32_TYPE);
        }
    }




    static if(!is(typeof(__S64_TYPE))) {
        private enum enumMixinStr___S64_TYPE = `enum __S64_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___S64_TYPE); }))) {
            mixin(enumMixinStr___S64_TYPE);
        }
    }




    static if(!is(typeof(__U64_TYPE))) {
        private enum enumMixinStr___U64_TYPE = `enum __U64_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___U64_TYPE); }))) {
            mixin(enumMixinStr___U64_TYPE);
        }
    }




    static if(!is(typeof(__STD_TYPE))) {
        private enum enumMixinStr___STD_TYPE = `enum __STD_TYPE = typedef;`;
        static if(is(typeof({ mixin(enumMixinStr___STD_TYPE); }))) {
            mixin(enumMixinStr___STD_TYPE);
        }
    }






    static if(!is(typeof(_SIGSET_NWORDS))) {
        private enum enumMixinStr__SIGSET_NWORDS = `enum _SIGSET_NWORDS = ( 1024 / ( 8 * ( unsigned long int ) .sizeof ) );`;
        static if(is(typeof({ mixin(enumMixinStr__SIGSET_NWORDS); }))) {
            mixin(enumMixinStr__SIGSET_NWORDS);
        }
    }




    static if(!is(typeof(__clock_t_defined))) {
        private enum enumMixinStr___clock_t_defined = `enum __clock_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___clock_t_defined); }))) {
            mixin(enumMixinStr___clock_t_defined);
        }
    }




    static if(!is(typeof(__clockid_t_defined))) {
        private enum enumMixinStr___clockid_t_defined = `enum __clockid_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___clockid_t_defined); }))) {
            mixin(enumMixinStr___clockid_t_defined);
        }
    }




    static if(!is(typeof(__sigset_t_defined))) {
        private enum enumMixinStr___sigset_t_defined = `enum __sigset_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___sigset_t_defined); }))) {
            mixin(enumMixinStr___sigset_t_defined);
        }
    }




    static if(!is(typeof(_STRUCT_TIMESPEC))) {
        private enum enumMixinStr__STRUCT_TIMESPEC = `enum _STRUCT_TIMESPEC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STRUCT_TIMESPEC); }))) {
            mixin(enumMixinStr__STRUCT_TIMESPEC);
        }
    }




    static if(!is(typeof(__timeval_defined))) {
        private enum enumMixinStr___timeval_defined = `enum __timeval_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___timeval_defined); }))) {
            mixin(enumMixinStr___timeval_defined);
        }
    }




    static if(!is(typeof(__time_t_defined))) {
        private enum enumMixinStr___time_t_defined = `enum __time_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___time_t_defined); }))) {
            mixin(enumMixinStr___time_t_defined);
        }
    }




    static if(!is(typeof(__timer_t_defined))) {
        private enum enumMixinStr___timer_t_defined = `enum __timer_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___timer_t_defined); }))) {
            mixin(enumMixinStr___timer_t_defined);
        }
    }




    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        private enum enumMixinStr__BITS_TYPESIZES_H = `enum _BITS_TYPESIZES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPESIZES_H); }))) {
            mixin(enumMixinStr__BITS_TYPESIZES_H);
        }
    }




    static if(!is(typeof(__SYSCALL_SLONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_SLONG_TYPE = `enum __SYSCALL_SLONG_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_SLONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_SLONG_TYPE);
        }
    }




    static if(!is(typeof(__SYSCALL_ULONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_ULONG_TYPE = `enum __SYSCALL_ULONG_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_ULONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_ULONG_TYPE);
        }
    }




    static if(!is(typeof(__DEV_T_TYPE))) {
        private enum enumMixinStr___DEV_T_TYPE = `enum __DEV_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___DEV_T_TYPE); }))) {
            mixin(enumMixinStr___DEV_T_TYPE);
        }
    }




    static if(!is(typeof(__UID_T_TYPE))) {
        private enum enumMixinStr___UID_T_TYPE = `enum __UID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___UID_T_TYPE); }))) {
            mixin(enumMixinStr___UID_T_TYPE);
        }
    }




    static if(!is(typeof(__GID_T_TYPE))) {
        private enum enumMixinStr___GID_T_TYPE = `enum __GID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___GID_T_TYPE); }))) {
            mixin(enumMixinStr___GID_T_TYPE);
        }
    }




    static if(!is(typeof(__INO_T_TYPE))) {
        private enum enumMixinStr___INO_T_TYPE = `enum __INO_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_TYPE); }))) {
            mixin(enumMixinStr___INO_T_TYPE);
        }
    }




    static if(!is(typeof(__INO64_T_TYPE))) {
        private enum enumMixinStr___INO64_T_TYPE = `enum __INO64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___INO64_T_TYPE); }))) {
            mixin(enumMixinStr___INO64_T_TYPE);
        }
    }




    static if(!is(typeof(__MODE_T_TYPE))) {
        private enum enumMixinStr___MODE_T_TYPE = `enum __MODE_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___MODE_T_TYPE); }))) {
            mixin(enumMixinStr___MODE_T_TYPE);
        }
    }




    static if(!is(typeof(__NLINK_T_TYPE))) {
        private enum enumMixinStr___NLINK_T_TYPE = `enum __NLINK_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___NLINK_T_TYPE); }))) {
            mixin(enumMixinStr___NLINK_T_TYPE);
        }
    }




    static if(!is(typeof(__FSWORD_T_TYPE))) {
        private enum enumMixinStr___FSWORD_T_TYPE = `enum __FSWORD_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSWORD_T_TYPE); }))) {
            mixin(enumMixinStr___FSWORD_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF_T_TYPE))) {
        private enum enumMixinStr___OFF_T_TYPE = `enum __OFF_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_TYPE); }))) {
            mixin(enumMixinStr___OFF_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF64_T_TYPE))) {
        private enum enumMixinStr___OFF64_T_TYPE = `enum __OFF64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF64_T_TYPE); }))) {
            mixin(enumMixinStr___OFF64_T_TYPE);
        }
    }




    static if(!is(typeof(__PID_T_TYPE))) {
        private enum enumMixinStr___PID_T_TYPE = `enum __PID_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___PID_T_TYPE); }))) {
            mixin(enumMixinStr___PID_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM_T_TYPE))) {
        private enum enumMixinStr___RLIM_T_TYPE = `enum __RLIM_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM64_T_TYPE))) {
        private enum enumMixinStr___RLIM64_T_TYPE = `enum __RLIM64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM64_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM64_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT_T_TYPE))) {
        private enum enumMixinStr___BLKCNT_T_TYPE = `enum __BLKCNT_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT64_T_TYPE))) {
        private enum enumMixinStr___BLKCNT64_T_TYPE = `enum __BLKCNT64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT_T_TYPE = `enum __FSBLKCNT_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT64_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT64_T_TYPE = `enum __FSBLKCNT64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT_T_TYPE = `enum __FSFILCNT_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT64_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT64_T_TYPE = `enum __FSFILCNT64_T_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__ID_T_TYPE))) {
        private enum enumMixinStr___ID_T_TYPE = `enum __ID_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___ID_T_TYPE); }))) {
            mixin(enumMixinStr___ID_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCK_T_TYPE))) {
        private enum enumMixinStr___CLOCK_T_TYPE = `enum __CLOCK_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCK_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCK_T_TYPE);
        }
    }




    static if(!is(typeof(__TIME_T_TYPE))) {
        private enum enumMixinStr___TIME_T_TYPE = `enum __TIME_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME_T_TYPE); }))) {
            mixin(enumMixinStr___TIME_T_TYPE);
        }
    }




    static if(!is(typeof(__USECONDS_T_TYPE))) {
        private enum enumMixinStr___USECONDS_T_TYPE = `enum __USECONDS_T_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___USECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___USECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__SUSECONDS_T_TYPE))) {
        private enum enumMixinStr___SUSECONDS_T_TYPE = `enum __SUSECONDS_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SUSECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___SUSECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__SUSECONDS64_T_TYPE))) {
        private enum enumMixinStr___SUSECONDS64_T_TYPE = `enum __SUSECONDS64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SUSECONDS64_T_TYPE); }))) {
            mixin(enumMixinStr___SUSECONDS64_T_TYPE);
        }
    }




    static if(!is(typeof(__DADDR_T_TYPE))) {
        private enum enumMixinStr___DADDR_T_TYPE = `enum __DADDR_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___DADDR_T_TYPE); }))) {
            mixin(enumMixinStr___DADDR_T_TYPE);
        }
    }




    static if(!is(typeof(__KEY_T_TYPE))) {
        private enum enumMixinStr___KEY_T_TYPE = `enum __KEY_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___KEY_T_TYPE); }))) {
            mixin(enumMixinStr___KEY_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCKID_T_TYPE))) {
        private enum enumMixinStr___CLOCKID_T_TYPE = `enum __CLOCKID_T_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCKID_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCKID_T_TYPE);
        }
    }




    static if(!is(typeof(__TIMER_T_TYPE))) {
        private enum enumMixinStr___TIMER_T_TYPE = `enum __TIMER_T_TYPE = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMER_T_TYPE); }))) {
            mixin(enumMixinStr___TIMER_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKSIZE_T_TYPE))) {
        private enum enumMixinStr___BLKSIZE_T_TYPE = `enum __BLKSIZE_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___BLKSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__FSID_T_TYPE))) {
        private enum enumMixinStr___FSID_T_TYPE = `enum __FSID_T_TYPE = { int __val [ 2 ] ; };`;
        static if(is(typeof({ mixin(enumMixinStr___FSID_T_TYPE); }))) {
            mixin(enumMixinStr___FSID_T_TYPE);
        }
    }




    static if(!is(typeof(__SSIZE_T_TYPE))) {
        private enum enumMixinStr___SSIZE_T_TYPE = `enum __SSIZE_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___SSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__CPU_MASK_TYPE))) {
        private enum enumMixinStr___CPU_MASK_TYPE = `enum __CPU_MASK_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___CPU_MASK_TYPE); }))) {
            mixin(enumMixinStr___CPU_MASK_TYPE);
        }
    }




    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        private enum enumMixinStr___OFF_T_MATCHES_OFF64_T = `enum __OFF_T_MATCHES_OFF64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T); }))) {
            mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T);
        }
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        private enum enumMixinStr___INO_T_MATCHES_INO64_T = `enum __INO_T_MATCHES_INO64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_MATCHES_INO64_T); }))) {
            mixin(enumMixinStr___INO_T_MATCHES_INO64_T);
        }
    }




    static if(!is(typeof(__RLIM_T_MATCHES_RLIM64_T))) {
        private enum enumMixinStr___RLIM_T_MATCHES_RLIM64_T = `enum __RLIM_T_MATCHES_RLIM64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T); }))) {
            mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T);
        }
    }




    static if(!is(typeof(__STATFS_MATCHES_STATFS64))) {
        private enum enumMixinStr___STATFS_MATCHES_STATFS64 = `enum __STATFS_MATCHES_STATFS64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___STATFS_MATCHES_STATFS64); }))) {
            mixin(enumMixinStr___STATFS_MATCHES_STATFS64);
        }
    }




    static if(!is(typeof(__KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64))) {
        private enum enumMixinStr___KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = `enum __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64); }))) {
            mixin(enumMixinStr___KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64);
        }
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        private enum enumMixinStr___FD_SETSIZE = `enum __FD_SETSIZE = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr___FD_SETSIZE); }))) {
            mixin(enumMixinStr___FD_SETSIZE);
        }
    }




    static if(!is(typeof(_BITS_UINTN_IDENTITY_H))) {
        private enum enumMixinStr__BITS_UINTN_IDENTITY_H = `enum _BITS_UINTN_IDENTITY_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_UINTN_IDENTITY_H); }))) {
            mixin(enumMixinStr__BITS_UINTN_IDENTITY_H);
        }
    }




    static if(!is(typeof(WNOHANG))) {
        private enum enumMixinStr_WNOHANG = `enum WNOHANG = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_WNOHANG); }))) {
            mixin(enumMixinStr_WNOHANG);
        }
    }




    static if(!is(typeof(WUNTRACED))) {
        private enum enumMixinStr_WUNTRACED = `enum WUNTRACED = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_WUNTRACED); }))) {
            mixin(enumMixinStr_WUNTRACED);
        }
    }




    static if(!is(typeof(WSTOPPED))) {
        private enum enumMixinStr_WSTOPPED = `enum WSTOPPED = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_WSTOPPED); }))) {
            mixin(enumMixinStr_WSTOPPED);
        }
    }




    static if(!is(typeof(WEXITED))) {
        private enum enumMixinStr_WEXITED = `enum WEXITED = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_WEXITED); }))) {
            mixin(enumMixinStr_WEXITED);
        }
    }




    static if(!is(typeof(WCONTINUED))) {
        private enum enumMixinStr_WCONTINUED = `enum WCONTINUED = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_WCONTINUED); }))) {
            mixin(enumMixinStr_WCONTINUED);
        }
    }




    static if(!is(typeof(WNOWAIT))) {
        private enum enumMixinStr_WNOWAIT = `enum WNOWAIT = 0x01000000;`;
        static if(is(typeof({ mixin(enumMixinStr_WNOWAIT); }))) {
            mixin(enumMixinStr_WNOWAIT);
        }
    }




    static if(!is(typeof(__WNOTHREAD))) {
        private enum enumMixinStr___WNOTHREAD = `enum __WNOTHREAD = 0x20000000;`;
        static if(is(typeof({ mixin(enumMixinStr___WNOTHREAD); }))) {
            mixin(enumMixinStr___WNOTHREAD);
        }
    }




    static if(!is(typeof(__WALL))) {
        private enum enumMixinStr___WALL = `enum __WALL = 0x40000000;`;
        static if(is(typeof({ mixin(enumMixinStr___WALL); }))) {
            mixin(enumMixinStr___WALL);
        }
    }




    static if(!is(typeof(__WCLONE))) {
        private enum enumMixinStr___WCLONE = `enum __WCLONE = 0x80000000;`;
        static if(is(typeof({ mixin(enumMixinStr___WCLONE); }))) {
            mixin(enumMixinStr___WCLONE);
        }
    }
    static if(!is(typeof(__W_CONTINUED))) {
        private enum enumMixinStr___W_CONTINUED = `enum __W_CONTINUED = 0xffff;`;
        static if(is(typeof({ mixin(enumMixinStr___W_CONTINUED); }))) {
            mixin(enumMixinStr___W_CONTINUED);
        }
    }




    static if(!is(typeof(__WCOREFLAG))) {
        private enum enumMixinStr___WCOREFLAG = `enum __WCOREFLAG = 0x80;`;
        static if(is(typeof({ mixin(enumMixinStr___WCOREFLAG); }))) {
            mixin(enumMixinStr___WCOREFLAG);
        }
    }




    static if(!is(typeof(__WORDSIZE))) {
        private enum enumMixinStr___WORDSIZE = `enum __WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE); }))) {
            mixin(enumMixinStr___WORDSIZE);
        }
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        private enum enumMixinStr___WORDSIZE_TIME64_COMPAT32 = `enum __WORDSIZE_TIME64_COMPAT32 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32); }))) {
            mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32);
        }
    }




    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        private enum enumMixinStr___SYSCALL_WORDSIZE = `enum __SYSCALL_WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_WORDSIZE); }))) {
            mixin(enumMixinStr___SYSCALL_WORDSIZE);
        }
    }
    static if(!is(typeof(_SYS_CDEFS_H))) {
        private enum enumMixinStr__SYS_CDEFS_H = `enum _SYS_CDEFS_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_CDEFS_H); }))) {
            mixin(enumMixinStr__SYS_CDEFS_H);
        }
    }
    static if(!is(typeof(__THROW))) {
        private enum enumMixinStr___THROW = `enum __THROW = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROW); }))) {
            mixin(enumMixinStr___THROW);
        }
    }




    static if(!is(typeof(__THROWNL))) {
        private enum enumMixinStr___THROWNL = `enum __THROWNL = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROWNL); }))) {
            mixin(enumMixinStr___THROWNL);
        }
    }
    static if(!is(typeof(__ptr_t))) {
        private enum enumMixinStr___ptr_t = `enum __ptr_t = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___ptr_t); }))) {
            mixin(enumMixinStr___ptr_t);
        }
    }
    static if(!is(typeof(__flexarr))) {
        private enum enumMixinStr___flexarr = `enum __flexarr = [ ];`;
        static if(is(typeof({ mixin(enumMixinStr___flexarr); }))) {
            mixin(enumMixinStr___flexarr);
        }
    }




    static if(!is(typeof(__glibc_c99_flexarr_available))) {
        private enum enumMixinStr___glibc_c99_flexarr_available = `enum __glibc_c99_flexarr_available = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___glibc_c99_flexarr_available); }))) {
            mixin(enumMixinStr___glibc_c99_flexarr_available);
        }
    }
    static if(!is(typeof(__attribute_malloc__))) {
        private enum enumMixinStr___attribute_malloc__ = `enum __attribute_malloc__ = __attribute__ ( ( __malloc__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_malloc__); }))) {
            mixin(enumMixinStr___attribute_malloc__);
        }
    }






    static if(!is(typeof(__attribute_pure__))) {
        private enum enumMixinStr___attribute_pure__ = `enum __attribute_pure__ = __attribute__ ( ( __pure__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_pure__); }))) {
            mixin(enumMixinStr___attribute_pure__);
        }
    }




    static if(!is(typeof(__attribute_const__))) {
        private enum enumMixinStr___attribute_const__ = `enum __attribute_const__ = __attribute__ ( cast( __const__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_const__); }))) {
            mixin(enumMixinStr___attribute_const__);
        }
    }




    static if(!is(typeof(__attribute_used__))) {
        private enum enumMixinStr___attribute_used__ = `enum __attribute_used__ = __attribute__ ( ( __used__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_used__); }))) {
            mixin(enumMixinStr___attribute_used__);
        }
    }




    static if(!is(typeof(__attribute_noinline__))) {
        private enum enumMixinStr___attribute_noinline__ = `enum __attribute_noinline__ = __attribute__ ( ( __noinline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_noinline__); }))) {
            mixin(enumMixinStr___attribute_noinline__);
        }
    }




    static if(!is(typeof(__attribute_deprecated__))) {
        private enum enumMixinStr___attribute_deprecated__ = `enum __attribute_deprecated__ = __attribute__ ( ( __deprecated__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_deprecated__); }))) {
            mixin(enumMixinStr___attribute_deprecated__);
        }
    }
    static if(!is(typeof(__attribute_warn_unused_result__))) {
        private enum enumMixinStr___attribute_warn_unused_result__ = `enum __attribute_warn_unused_result__ = __attribute__ ( ( __warn_unused_result__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_warn_unused_result__); }))) {
            mixin(enumMixinStr___attribute_warn_unused_result__);
        }
    }






    static if(!is(typeof(__always_inline))) {
        private enum enumMixinStr___always_inline = `enum __always_inline = __inline __attribute__ ( ( __always_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___always_inline); }))) {
            mixin(enumMixinStr___always_inline);
        }
    }






    static if(!is(typeof(__extern_inline))) {
        private enum enumMixinStr___extern_inline = `enum __extern_inline = extern __inline __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_inline); }))) {
            mixin(enumMixinStr___extern_inline);
        }
    }




    static if(!is(typeof(__extern_always_inline))) {
        private enum enumMixinStr___extern_always_inline = `enum __extern_always_inline = extern __inline __attribute__ ( ( __always_inline__ ) ) __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_always_inline); }))) {
            mixin(enumMixinStr___extern_always_inline);
        }
    }




    static if(!is(typeof(__fortify_function))) {
        private enum enumMixinStr___fortify_function = `enum __fortify_function = extern __inline __attribute__ ( ( __always_inline__ ) ) __attribute__ ( ( __gnu_inline__ ) ) ;`;
        static if(is(typeof({ mixin(enumMixinStr___fortify_function); }))) {
            mixin(enumMixinStr___fortify_function);
        }
    }




    static if(!is(typeof(__restrict_arr))) {
        private enum enumMixinStr___restrict_arr = `enum __restrict_arr = __restrict;`;
        static if(is(typeof({ mixin(enumMixinStr___restrict_arr); }))) {
            mixin(enumMixinStr___restrict_arr);
        }
    }
    static if(!is(typeof(__HAVE_GENERIC_SELECTION))) {
        private enum enumMixinStr___HAVE_GENERIC_SELECTION = `enum __HAVE_GENERIC_SELECTION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_GENERIC_SELECTION); }))) {
            mixin(enumMixinStr___HAVE_GENERIC_SELECTION);
        }
    }






    static if(!is(typeof(__attribute_returns_twice__))) {
        private enum enumMixinStr___attribute_returns_twice__ = `enum __attribute_returns_twice__ = __attribute__ ( ( __returns_twice__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_returns_twice__); }))) {
            mixin(enumMixinStr___attribute_returns_twice__);
        }
    }




    static if(!is(typeof(_SYS_SELECT_H))) {
        private enum enumMixinStr__SYS_SELECT_H = `enum _SYS_SELECT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_SELECT_H); }))) {
            mixin(enumMixinStr__SYS_SELECT_H);
        }
    }






    static if(!is(typeof(__NFDBITS))) {
        private enum enumMixinStr___NFDBITS = `enum __NFDBITS = ( 8 * cast( int ) ( __fd_mask ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr___NFDBITS); }))) {
            mixin(enumMixinStr___NFDBITS);
        }
    }
    static if(!is(typeof(FD_SETSIZE))) {
        private enum enumMixinStr_FD_SETSIZE = `enum FD_SETSIZE = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr_FD_SETSIZE); }))) {
            mixin(enumMixinStr_FD_SETSIZE);
        }
    }




    static if(!is(typeof(NFDBITS))) {
        private enum enumMixinStr_NFDBITS = `enum NFDBITS = ( 8 * cast( int ) ( __fd_mask ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr_NFDBITS); }))) {
            mixin(enumMixinStr_NFDBITS);
        }
    }
    static if(!is(typeof(_SYS_TYPES_H))) {
        private enum enumMixinStr__SYS_TYPES_H = `enum _SYS_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_TYPES_H); }))) {
            mixin(enumMixinStr__SYS_TYPES_H);
        }
    }
    static if(!is(typeof(__BIT_TYPES_DEFINED__))) {
        private enum enumMixinStr___BIT_TYPES_DEFINED__ = `enum __BIT_TYPES_DEFINED__ = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___BIT_TYPES_DEFINED__); }))) {
            mixin(enumMixinStr___BIT_TYPES_DEFINED__);
        }
    }
    static if(!is(typeof(bool_))) {
        private enum enumMixinStr_bool_ = `enum bool_ = _Bool;`;
        static if(is(typeof({ mixin(enumMixinStr_bool_); }))) {
            mixin(enumMixinStr_bool_);
        }
    }




    static if(!is(typeof(true_))) {
        private enum enumMixinStr_true_ = `enum true_ = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_true_); }))) {
            mixin(enumMixinStr_true_);
        }
    }




    static if(!is(typeof(false_))) {
        private enum enumMixinStr_false_ = `enum false_ = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_false_); }))) {
            mixin(enumMixinStr_false_);
        }
    }




    static if(!is(typeof(__bool_true_false_are_defined))) {
        private enum enumMixinStr___bool_true_false_are_defined = `enum __bool_true_false_are_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___bool_true_false_are_defined); }))) {
            mixin(enumMixinStr___bool_true_false_are_defined);
        }
    }
    static if(!is(typeof(NULL))) {
        private enum enumMixinStr_NULL = `enum NULL = ( cast( void * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_NULL); }))) {
            mixin(enumMixinStr_NULL);
        }
    }

}



// import core.memory; do NOT import this, we intentionally do NOT want any GC function to compile! ref:do_NOT_GC.removeRoot
import core.thread;

import std.array;
import std.traits;
import std.stdio;
import std.typecons;
import std.datetime.stopwatch;
import std.concurrency : receiveOnly, send, spawn, Tid, thisTid;

alias voidpp = void**;
extern(C) alias element_cleanup_callback = void function(lfds711_queue_bmm_state*, void*, void*);
immutable voidpp NULL_PTR = null;
immutable element_cleanup_callback NULL_CB = null;

unittest {
    import std.traits;

    class C;
    union U;
    struct S;
    interface I;

    static assert( isAggregateType!C);
    static assert( isAggregateType!U);
    static assert( isAggregateType!S);
    static assert( isAggregateType!I);
    static assert(!isAggregateType!void);
    static assert(isArray!string);
    static assert(isArray!(int[]));
    static assert(!isAggregateType!(C[string]));
    static assert(!isAggregateType!(void delegate(int)));

    string s = "hello";
    assert(false == __traits(isRef, s));

    int[] arr = [1,2,3];
    assert(false == __traits(isRef, arr));
}


bool treatAsStructInC(T)() {
  // https://dlang.org/library/std/traits/is_aggregate_type.html
  // string, array is not isAggregateType
  static if (is(T == struct) || is(T == union) || isArray!T) {
    return true;
  } else {
    // basic type int|double will be treated as it is
    // class, interface are treated as pointers in C
    return false;
  }
}

enum queue_bmm_decl = q{

// this class is shared: otherwise, please use a normal queue
shared class queue_bmm(T) { // do NOT use shared, let the user decide
 public:

  static if (treatAsStructInC!T) {
    alias PopT = T*;
    immutable PopT invalidPop = null;
  } else {
    alias PopT = T;
    static if (is(T == class) || is(T == interface)) { // these are pointers in C
      immutable PopT invalidPop = null;
    } else {
      immutable PopT invalidPop = T.max; // 0 is typically used by user!
    }
  }

  this(size_t n=1024) {
    _queue = cast(shared)(queue_bmm_new(n)); // pointer from C is always global can be accessed by any threads
    capacity = n;
  }

  // return false, when the queue is full
  // T: could be stuct|class, string|array, int|double
  // we *always* want to pass by ref, the value should never be copied
  bool push(T)(ref T value) {
   static if(treatAsStructInC!T) {
    void* v = cast(void*)(&value);
    /* we can NOT do this! this same object could be in multiple such C-containers
    ref:do_NOT_GC.removeRoot
    // https://dlang.org/phobos/core_memory.html#addRoot
    GC.addRoot(v);
    GC.setAttr(v, GC.BlkAttr.NO_MOVE);
    */
   } else {
    void* v = cast(void*)value;
   }
    return queue_bmm_push(cast(c_queue_bmm*)_queue, v);
  }

  // return invalidPop if queue empty
  // https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Function_lfds711_queue_bmm_dequeue#Return_Value
  // Returns 1 on a successful dequeue. Returns 0 if dequeing failed. Dequeuing only fails if the queue is empty.
  PopT pop() {
    int ok;
    void* value = queue_bmm_pop(cast(c_queue_bmm*)_queue, &ok);
    if (ok) {
      PopT result = cast(PopT)value;
      static if(treatAsStructInC!T) {
        /* we can NOT do this! this same object could be in multiple such C-containers;
           we can NOT put it back to GC, just because it's popped from this queue
        ref:do_NOT_GC.removeRoot
        GC.removeRoot(value);
        GC.clrAttr(value, GC.BlkAttr.NO_MOVE);
        */
      }
      return result;
    }
    return cast(PopT)invalidPop;
  }

  bool isInvalid(ref PopT p) {
    return p is cast(PopT)invalidPop;
  }

  size_t length() {
    return queue_bmm_length(cast(c_queue_bmm*)_queue);
  }

  bool full() {
    return this.length() == capacity;
  }

  /* this bool is not guaranteed to be correct!
     https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Function_lfds711_queue_bmm_query#Notes
  */
  bool empty() {
    return 0 == this.length();
  }

  ~this() {
    queue_bmm_destroy(cast(c_queue_bmm*)_queue);
  }

 private:
  c_queue_bmm* _queue;
  size_t capacity;
  // PopT invalidPop;  // signal invalid element, e.g. pop from empty queue
}

};

enum queue_bss_decl = queue_bmm_decl.replace("bmm", "bss");
enum queue_umm_decl = queue_bmm_decl.replace("bmm", "umm");

mixin(queue_bmm_decl);
mixin(queue_bss_decl);
mixin(queue_umm_decl);



const size_t n = 100_000_000;
/*
alias SafeQueue = queue_bss;  // speed=41701 msg/msec
alias SafeQueue = queue_bmm;  // speed=19988 msg/msec
*/
alias SafeQueue = queue_umm; // speed= 6215 msg/msec; is ~6x slower than queue_bss, because each push cause one lfds711_queue_umm_element aligned_alloc

void threadProducer(shared(SafeQueue!int) queue) {
  ensure_lfds_valid_init_on_current_logical_core();
  foreach (int i; 0..n) {
    for (;;) {
      if (queue.push(i)) {break;}
      Thread.yield();
    }
  }
}

void threadConsumer(shared(SafeQueue!int) queue) {
  ensure_lfds_valid_init_on_current_logical_core();
  StopWatch sw;
  sw.start();
  long sum = 0;
  int p;

  foreach (i; 0..n) {
    for (;;) {
      p = queue.pop();
      // if (queue.isInvalid(p)) {} // sync call on shared object is very expensive
      if (p != queue.invalidPop) { // empty may not be accurate
        break;
      }
      Thread.yield();
    }
    sum += p;
  }

  sw.stop();
  writefln("received %d messages in %d msec sum=%d speed=%d msg/msec", n, sw.peek().total!"msecs", sum, n/sw.peek().total!"msecs");
  assert(sum == (n*(n-1)/2));
}

unittest {
// will push pop 100_000_000 int
void testIntQueue() {
  auto queue = new shared(SafeQueue!int);

  writeln(int.init, int.max, queue.invalidPop);
  spawn(&threadProducer, queue);
  spawn(&threadConsumer, queue);

  thread_joinAll();
}

void testStringQueue() {
  string name = "string: Madge The Skutter";
  string* temp_td;

  auto queue = new shared(SafeQueue!string)(2);
  ensure_lfds_valid_init_on_current_logical_core();

  assert(0 == queue.length());
  assert(queue.empty());
  assert(!queue.full());

  assert(name == "string: Madge The Skutter");
  queue.push(name);
  assert(1 == queue.length());

  string full = "full";
  queue.push(full); // won't store string literal
  assert(2 == queue.length());
  assert(queue.full());

  name ~= "; change the pushed after push & before pop";
  temp_td = queue.pop();
  assert(1 == queue.length());

  writeln(name);
  writeln(*temp_td);
  assert(name == "string: Madge The Skutter; change the pushed after push & before pop");
  assert(*temp_td == "string: Madge The Skutter; change the pushed after push & before pop");

  temp_td = queue.pop();
  writeln(*temp_td);
  assert(0 == queue.length());
  assert(*temp_td == "full");
}

void testStructQueue() {
  struct test_data {
    string name;
  }

  test_data td;
  test_data* temp_td;
  td.name = "struct: Madge The Skutter";

  auto queue = new shared(SafeQueue!test_data);
  assert(td.name == "struct: Madge The Skutter");
  queue.push(td);
  td.name ~= "; after push & before pop";
  temp_td = queue.pop();
  assert(temp_td.name == "struct: Madge The Skutter; after push & before pop");

  printf( "skutter name = %s %lu\n", &(temp_td.name[0]), voidpp.sizeof );
}

void testClassQueue() {
  class test_data {
    string name;
  }

  test_data td = new test_data;
  test_data temp_td;
  td.name = "class: Madge The Skutter";

  auto queue = new shared(SafeQueue!test_data);
  assert(td.name == "class: Madge The Skutter");
  queue.push(td);
  td.name ~= "; after push & before pop";
  temp_td = queue.pop();
  assert(temp_td.name == "class: Madge The Skutter; after push & before pop");

  assert(td is temp_td);
  assert(td == temp_td);

  printf( "skutter name = %s %lu\n", &(temp_td.name[0]), voidpp.sizeof );
}

void main() {
//testStringQueue();  TODO: revive for queue_bss;
  testStructQueue();
  testClassQueue();
  testIntQueue();
}

main();

}

version(LIBLFDS_TEST) {
  void main() {}
}
