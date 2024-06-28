{

    function allocate_unbounded() -> memPtr {
        memPtr := mload(64)
    }

    function revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() {
        revert(0, 0)
    }

    function revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() {
        revert(0, 0)
    }

    function cleanup_t_uint160(value) -> cleaned {
        cleaned := and(value, 0xffffffffffffffffffffffffffffffffffffffff)
    }

    function cleanup_t_address(value) -> cleaned {
        cleaned := cleanup_t_uint160(value)
    }

    function validator_revert_t_address(value) {
        if iszero(eq(value, cleanup_t_address(value))) { revert(0, 0) }
    }

    function abi_decode_t_address(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_address(value)
    }

    function validator_revert_t_enum$_Role_$12(value) {
        if iszero(lt(value, 5)) { revert(0, 0) }
    }

    function abi_decode_t_enum$_Role_$12(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_enum$_Role_$12(value)
    }

    function abi_decode_tuple_t_addresst_enum$_Role_$12(headStart, dataEnd) -> value0, value1 {
        if slt(sub(dataEnd, headStart), 64) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_address(add(headStart, offset), dataEnd)
        }

        {

            let offset := 32

            value1 := abi_decode_t_enum$_Role_$12(add(headStart, offset), dataEnd)
        }

    }

    function cleanup_t_uint256(value) -> cleaned {
        cleaned := value
    }

    function validator_revert_t_uint256(value) {
        if iszero(eq(value, cleanup_t_uint256(value))) { revert(0, 0) }
    }

    function abi_decode_t_uint256(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_uint256(value)
    }

    function abi_decode_tuple_t_uint256(headStart, dataEnd) -> value0 {
        if slt(sub(dataEnd, headStart), 32) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_uint256(add(headStart, offset), dataEnd)
        }

    }

    function array_length_t_string_memory_ptr(value) -> length {

        length := mload(value)

    }

    function array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, length) -> updated_pos {
        mstore(pos, length)
        updated_pos := add(pos, 0x20)
    }

    function copy_memory_to_memory_with_cleanup(src, dst, length) {
        let i := 0
        for { } lt(i, length) { i := add(i, 32) }
        {
            mstore(add(dst, i), mload(add(src, i)))
        }
        mstore(add(dst, length), 0)
    }

    function round_up_to_mul_of_32(value) -> result {
        result := and(add(value, 31), not(31))
    }

    function abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value, pos) -> end {
        let length := array_length_t_string_memory_ptr(value)
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, length)
        copy_memory_to_memory_with_cleanup(add(value, 0x20), pos, length)
        end := add(pos, round_up_to_mul_of_32(length))
    }

    function panic_error_0x21() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x21)
        revert(0, 0x24)
    }

    function validator_assert_t_enum$_EntityType_$18(value) {
        if iszero(lt(value, 5)) { panic_error_0x21() }
    }

    function cleanup_t_enum$_EntityType_$18(value) -> cleaned {
        cleaned := value validator_assert_t_enum$_EntityType_$18(value)
    }

    function convert_t_enum$_EntityType_$18_to_t_uint8(value) -> converted {
        converted := cleanup_t_enum$_EntityType_$18(value)
    }

    function abi_encode_t_enum$_EntityType_$18_to_t_uint8_fromStack(value, pos) {
        mstore(pos, convert_t_enum$_EntityType_$18_to_t_uint8(value))
    }

    function abi_encode_tuple_t_string_memory_ptr_t_enum$_EntityType_$18__to_t_string_memory_ptr_t_uint8__fromStack_reversed(headStart , value1, value0) -> tail {
        tail := add(headStart, 64)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value0,  tail)

        abi_encode_t_enum$_EntityType_$18_to_t_uint8_fromStack(value1,  add(headStart, 32))

    }

    function revert_error_1b9f4a0a5773e33b91aa01db23bf8c55fce1411167c872835e7fa00a4f17d46d() {
        revert(0, 0)
    }

    function revert_error_987264b3b1d58a9c7f8255e93e81c77d86d6299019c33110a076957a3e06e2ae() {
        revert(0, 0)
    }

    function panic_error_0x41() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x41)
        revert(0, 0x24)
    }

    function finalize_allocation(memPtr, size) {
        let newFreePtr := add(memPtr, round_up_to_mul_of_32(size))
        // protect against overflow
        if or(gt(newFreePtr, 0xffffffffffffffff), lt(newFreePtr, memPtr)) { panic_error_0x41() }
        mstore(64, newFreePtr)
    }

    function allocate_memory(size) -> memPtr {
        memPtr := allocate_unbounded()
        finalize_allocation(memPtr, size)
    }

    function array_allocation_size_t_string_memory_ptr(length) -> size {
        // Make sure we can allocate memory without overflow
        if gt(length, 0xffffffffffffffff) { panic_error_0x41() }

        size := round_up_to_mul_of_32(length)

        // add length slot
        size := add(size, 0x20)

    }

    function copy_calldata_to_memory_with_cleanup(src, dst, length) {
        calldatacopy(dst, src, length)
        mstore(add(dst, length), 0)
    }

    function abi_decode_available_length_t_string_memory_ptr(src, length, end) -> array {
        array := allocate_memory(array_allocation_size_t_string_memory_ptr(length))
        mstore(array, length)
        let dst := add(array, 0x20)
        if gt(add(src, length), end) { revert_error_987264b3b1d58a9c7f8255e93e81c77d86d6299019c33110a076957a3e06e2ae() }
        copy_calldata_to_memory_with_cleanup(src, dst, length)
    }

    // string
    function abi_decode_t_string_memory_ptr(offset, end) -> array {
        if iszero(slt(add(offset, 0x1f), end)) { revert_error_1b9f4a0a5773e33b91aa01db23bf8c55fce1411167c872835e7fa00a4f17d46d() }
        let length := calldataload(offset)
        array := abi_decode_available_length_t_string_memory_ptr(add(offset, 0x20), length, end)
    }

    function abi_decode_tuple_t_string_memory_ptr(headStart, dataEnd) -> value0 {
        if slt(sub(dataEnd, headStart), 32) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := calldataload(add(headStart, 0))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value0 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

    }

    function abi_encode_t_uint256_to_t_uint256_fromStack(value, pos) {
        mstore(pos, cleanup_t_uint256(value))
    }

    function abi_encode_tuple_t_uint256_t_enum$_EntityType_$18__to_t_uint256_t_uint8__fromStack_reversed(headStart , value1, value0) -> tail {
        tail := add(headStart, 64)

        abi_encode_t_uint256_to_t_uint256_fromStack(value0,  add(headStart, 0))

        abi_encode_t_enum$_EntityType_$18_to_t_uint8_fromStack(value1,  add(headStart, 32))

    }

    function abi_decode_tuple_t_addresst_string_memory_ptrt_enum$_Role_$12(headStart, dataEnd) -> value0, value1, value2 {
        if slt(sub(dataEnd, headStart), 96) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_address(add(headStart, offset), dataEnd)
        }

        {

            let offset := calldataload(add(headStart, 32))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value1 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

        {

            let offset := 64

            value2 := abi_decode_t_enum$_Role_$12(add(headStart, offset), dataEnd)
        }

    }

    function abi_encode_t_address_to_t_address_fromStack(value, pos) {
        mstore(pos, cleanup_t_address(value))
    }

    function abi_encode_tuple_t_address__to_t_address__fromStack_reversed(headStart , value0) -> tail {
        tail := add(headStart, 32)

        abi_encode_t_address_to_t_address_fromStack(value0,  add(headStart, 0))

    }

    function abi_decode_tuple_t_address(headStart, dataEnd) -> value0 {
        if slt(sub(dataEnd, headStart), 32) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_address(add(headStart, offset), dataEnd)
        }

    }

    function array_storeLengthForEncoding_t_string_memory_ptr(pos, length) -> updated_pos {
        mstore(pos, length)
        updated_pos := add(pos, 0x20)
    }

    function abi_encode_t_string_memory_ptr_to_t_string_memory_ptr(value, pos) -> end {
        let length := array_length_t_string_memory_ptr(value)
        pos := array_storeLengthForEncoding_t_string_memory_ptr(pos, length)
        copy_memory_to_memory_with_cleanup(add(value, 0x20), pos, length)
        end := add(pos, round_up_to_mul_of_32(length))
    }

    function validator_assert_t_enum$_Role_$12(value) {
        if iszero(lt(value, 5)) { panic_error_0x21() }
    }

    function cleanup_t_enum$_Role_$12(value) -> cleaned {
        cleaned := value validator_assert_t_enum$_Role_$12(value)
    }

    function convert_t_enum$_Role_$12_to_t_uint8(value) -> converted {
        converted := cleanup_t_enum$_Role_$12(value)
    }

    function abi_encode_t_enum$_Role_$12_to_t_uint8(value, pos) {
        mstore(pos, convert_t_enum$_Role_$12_to_t_uint8(value))
    }

    // struct Main.User -> struct Main.User
    function abi_encode_t_struct$_User_$30_memory_ptr_to_t_struct$_User_$30_memory_ptr_fromStack(value, pos)  -> end  {
        let tail := add(pos, 0x40)

        {
            // name

            let memberValue0 := mload(add(value, 0x00))

            mstore(add(pos, 0x00), sub(tail, pos))
            tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr(memberValue0, tail)

        }

        {
            // role

            let memberValue0 := mload(add(value, 0x20))
            abi_encode_t_enum$_Role_$12_to_t_uint8(memberValue0, add(pos, 0x20))
        }

        end := tail
    }

    function abi_encode_tuple_t_struct$_User_$30_memory_ptr__to_t_struct$_User_$30_memory_ptr__fromStack_reversed(headStart , value0) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_struct$_User_$30_memory_ptr_to_t_struct$_User_$30_memory_ptr_fromStack(value0,  tail)

    }

    function abi_encode_tuple_t_string_memory_ptr__to_t_string_memory_ptr__fromStack_reversed(headStart , value0) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value0,  tail)

    }

    function abi_encode_t_enum$_Role_$12_to_t_uint8_fromStack(value, pos) {
        mstore(pos, convert_t_enum$_Role_$12_to_t_uint8(value))
    }

    function abi_encode_tuple_t_string_memory_ptr_t_enum$_Role_$12__to_t_string_memory_ptr_t_uint8__fromStack_reversed(headStart , value1, value0) -> tail {
        tail := add(headStart, 64)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value0,  tail)

        abi_encode_t_enum$_Role_$12_to_t_uint8_fromStack(value1,  add(headStart, 32))

    }

    function validator_revert_t_enum$_EntityType_$18(value) {
        if iszero(lt(value, 5)) { revert(0, 0) }
    }

    function abi_decode_t_enum$_EntityType_$18(offset, end) -> value {
        value := calldataload(offset)
        validator_revert_t_enum$_EntityType_$18(value)
    }

    function abi_decode_tuple_t_uint256t_string_memory_ptrt_enum$_EntityType_$18(headStart, dataEnd) -> value0, value1, value2 {
        if slt(sub(dataEnd, headStart), 96) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_uint256(add(headStart, offset), dataEnd)
        }

        {

            let offset := calldataload(add(headStart, 32))
            if gt(offset, 0xffffffffffffffff) { revert_error_c1322bf8034eace5e0b5c7295db60986aa89aae5e0ea0873e4689e076861a5db() }

            value1 := abi_decode_t_string_memory_ptr(add(headStart, offset), dataEnd)
        }

        {

            let offset := 64

            value2 := abi_decode_t_enum$_EntityType_$18(add(headStart, offset), dataEnd)
        }

    }

    function array_length_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr(value) -> length {

        length := mload(value)

    }

    function array_storeLengthForEncoding_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr_fromStack(pos, length) -> updated_pos {
        mstore(pos, length)
        updated_pos := add(pos, 0x20)
    }

    function array_dataslot_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr(ptr) -> data {
        data := ptr

        data := add(ptr, 0x20)

    }

    // struct Main.User -> struct Main.User
    function abi_encode_t_struct$_User_$30_memory_ptr_to_t_struct$_User_$30_memory_ptr(value, pos)  -> end  {
        let tail := add(pos, 0x40)

        {
            // name

            let memberValue0 := mload(add(value, 0x00))

            mstore(add(pos, 0x00), sub(tail, pos))
            tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr(memberValue0, tail)

        }

        {
            // role

            let memberValue0 := mload(add(value, 0x20))
            abi_encode_t_enum$_Role_$12_to_t_uint8(memberValue0, add(pos, 0x20))
        }

        end := tail
    }

    function abi_encodeUpdatedPos_t_struct$_User_$30_memory_ptr_to_t_struct$_User_$30_memory_ptr(value0, pos) -> updatedPos {
        updatedPos := abi_encode_t_struct$_User_$30_memory_ptr_to_t_struct$_User_$30_memory_ptr(value0, pos)
    }

    function array_nextElement_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr(ptr) -> next {
        next := add(ptr, 0x20)
    }

    // struct Main.User[] -> struct Main.User[]
    function abi_encode_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr_to_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr_fromStack(value, pos)  -> end  {
        let length := array_length_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr(value)
        pos := array_storeLengthForEncoding_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr_fromStack(pos, length)
        let headStart := pos
        let tail := add(pos, mul(length, 0x20))
        let baseRef := array_dataslot_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr(value)
        let srcPtr := baseRef
        for { let i := 0 } lt(i, length) { i := add(i, 1) }
        {
            mstore(pos, sub(tail, headStart))
            let elementValue0 := mload(srcPtr)
            tail := abi_encodeUpdatedPos_t_struct$_User_$30_memory_ptr_to_t_struct$_User_$30_memory_ptr(elementValue0, tail)
            srcPtr := array_nextElement_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr(srcPtr)
            pos := add(pos, 0x20)
        }
        pos := tail
        end := pos
    }

    function abi_encode_tuple_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr__to_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr__fromStack_reversed(headStart , value0) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr_to_t_array$_t_struct$_User_$30_memory_ptr_$dyn_memory_ptr_fromStack(value0,  tail)

    }

    function abi_decode_tuple_t_enum$_EntityType_$18(headStart, dataEnd) -> value0 {
        if slt(sub(dataEnd, headStart), 32) { revert_error_dbdddcbe895c83990c08b3492a0e83918d802a52331272ac6fdb6a7c4aea3b1b() }

        {

            let offset := 0

            value0 := abi_decode_t_enum$_EntityType_$18(add(headStart, offset), dataEnd)
        }

    }

    function array_length_t_array$_t_uint256_$dyn_memory_ptr(value) -> length {

        length := mload(value)

    }

    function array_storeLengthForEncoding_t_array$_t_uint256_$dyn_memory_ptr_fromStack(pos, length) -> updated_pos {
        mstore(pos, length)
        updated_pos := add(pos, 0x20)
    }

    function array_dataslot_t_array$_t_uint256_$dyn_memory_ptr(ptr) -> data {
        data := ptr

        data := add(ptr, 0x20)

    }

    function abi_encode_t_uint256_to_t_uint256(value, pos) {
        mstore(pos, cleanup_t_uint256(value))
    }

    function abi_encodeUpdatedPos_t_uint256_to_t_uint256(value0, pos) -> updatedPos {
        abi_encode_t_uint256_to_t_uint256(value0, pos)
        updatedPos := add(pos, 0x20)
    }

    function array_nextElement_t_array$_t_uint256_$dyn_memory_ptr(ptr) -> next {
        next := add(ptr, 0x20)
    }

    // uint256[] -> uint256[]
    function abi_encode_t_array$_t_uint256_$dyn_memory_ptr_to_t_array$_t_uint256_$dyn_memory_ptr_fromStack(value, pos)  -> end  {
        let length := array_length_t_array$_t_uint256_$dyn_memory_ptr(value)
        pos := array_storeLengthForEncoding_t_array$_t_uint256_$dyn_memory_ptr_fromStack(pos, length)
        let baseRef := array_dataslot_t_array$_t_uint256_$dyn_memory_ptr(value)
        let srcPtr := baseRef
        for { let i := 0 } lt(i, length) { i := add(i, 1) }
        {
            let elementValue0 := mload(srcPtr)
            pos := abi_encodeUpdatedPos_t_uint256_to_t_uint256(elementValue0, pos)
            srcPtr := array_nextElement_t_array$_t_uint256_$dyn_memory_ptr(srcPtr)
        }
        end := pos
    }

    function abi_encode_tuple_t_array$_t_uint256_$dyn_memory_ptr__to_t_array$_t_uint256_$dyn_memory_ptr__fromStack_reversed(headStart , value0) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_array$_t_uint256_$dyn_memory_ptr_to_t_array$_t_uint256_$dyn_memory_ptr_fromStack(value0,  tail)

    }

    function store_literal_in_memory_f7cd737d0e1663b6326868e96c8cb0ee3f1cf43e4247a88303c5e2bbac72d326(memPtr) {

        mstore(add(memPtr, 0), "Access denied: incorrect role")

    }

    function abi_encode_t_stringliteral_f7cd737d0e1663b6326868e96c8cb0ee3f1cf43e4247a88303c5e2bbac72d326_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 29)
        store_literal_in_memory_f7cd737d0e1663b6326868e96c8cb0ee3f1cf43e4247a88303c5e2bbac72d326(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_f7cd737d0e1663b6326868e96c8cb0ee3f1cf43e4247a88303c5e2bbac72d326__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_f7cd737d0e1663b6326868e96c8cb0ee3f1cf43e4247a88303c5e2bbac72d326_to_t_string_memory_ptr_fromStack( tail)

    }

    function store_literal_in_memory_1462473b7a4b33d32b109b815fd2324d00c9e5839b707ecf16d0ab5744f99226(memPtr) {

        mstore(add(memPtr, 0), "Invalid address")

    }

    function abi_encode_t_stringliteral_1462473b7a4b33d32b109b815fd2324d00c9e5839b707ecf16d0ab5744f99226_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 15)
        store_literal_in_memory_1462473b7a4b33d32b109b815fd2324d00c9e5839b707ecf16d0ab5744f99226(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_1462473b7a4b33d32b109b815fd2324d00c9e5839b707ecf16d0ab5744f99226__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_1462473b7a4b33d32b109b815fd2324d00c9e5839b707ecf16d0ab5744f99226_to_t_string_memory_ptr_fromStack( tail)

    }

    function panic_error_0x22() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x22)
        revert(0, 0x24)
    }

    function extract_byte_array_length(data) -> length {
        length := div(data, 2)
        let outOfPlaceEncoding := and(data, 1)
        if iszero(outOfPlaceEncoding) {
            length := and(length, 0x7f)
        }

        if eq(outOfPlaceEncoding, lt(length, 32)) {
            panic_error_0x22()
        }
    }

    function store_literal_in_memory_f7a4780cc8b0569e8e6a0b3105735ec3e582cba3d5a2c53611af2d58beb4ed7e(memPtr) {

        mstore(add(memPtr, 0), "Entity does not exist")

    }

    function abi_encode_t_stringliteral_f7a4780cc8b0569e8e6a0b3105735ec3e582cba3d5a2c53611af2d58beb4ed7e_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 21)
        store_literal_in_memory_f7a4780cc8b0569e8e6a0b3105735ec3e582cba3d5a2c53611af2d58beb4ed7e(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_f7a4780cc8b0569e8e6a0b3105735ec3e582cba3d5a2c53611af2d58beb4ed7e__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_f7a4780cc8b0569e8e6a0b3105735ec3e582cba3d5a2c53611af2d58beb4ed7e_to_t_string_memory_ptr_fromStack( tail)

    }

    function array_storeLengthForEncoding_t_string_memory_ptr_nonPadded_inplace_fromStack(pos, length) -> updated_pos {
        updated_pos := pos
    }

    function abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value, pos) -> end {
        let length := array_length_t_string_memory_ptr(value)
        pos := array_storeLengthForEncoding_t_string_memory_ptr_nonPadded_inplace_fromStack(pos, length)
        copy_memory_to_memory_with_cleanup(add(value, 0x20), pos, length)
        end := add(pos, length)
    }

    function abi_encode_tuple_packed_t_string_memory_ptr__to_t_string_memory_ptr__nonPadded_inplace_fromStack_reversed(pos , value0) -> end {

        pos := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_nonPadded_inplace_fromStack(value0,  pos)

        end := pos
    }

    function store_literal_in_memory_a2dc00c3afd7b86ff91639343eb4e6b0a44e4cc37a3239009543c0119cd058ec(memPtr) {

        mstore(add(memPtr, 0), "Invalid address!")

    }

    function abi_encode_t_stringliteral_a2dc00c3afd7b86ff91639343eb4e6b0a44e4cc37a3239009543c0119cd058ec_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 16)
        store_literal_in_memory_a2dc00c3afd7b86ff91639343eb4e6b0a44e4cc37a3239009543c0119cd058ec(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_a2dc00c3afd7b86ff91639343eb4e6b0a44e4cc37a3239009543c0119cd058ec__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_a2dc00c3afd7b86ff91639343eb4e6b0a44e4cc37a3239009543c0119cd058ec_to_t_string_memory_ptr_fromStack( tail)

    }

    function array_dataslot_t_string_storage(ptr) -> data {
        data := ptr

        mstore(0, ptr)
        data := keccak256(0, 0x20)

    }

    function divide_by_32_ceil(value) -> result {
        result := div(add(value, 31), 32)
    }

    function shift_left_dynamic(bits, value) -> newValue {
        newValue :=

        shl(bits, value)

    }

    function update_byte_slice_dynamic32(value, shiftBytes, toInsert) -> result {
        let shiftBits := mul(shiftBytes, 8)
        let mask := shift_left_dynamic(shiftBits, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
        toInsert := shift_left_dynamic(shiftBits, toInsert)
        value := and(value, not(mask))
        result := or(value, and(toInsert, mask))
    }

    function identity(value) -> ret {
        ret := value
    }

    function convert_t_uint256_to_t_uint256(value) -> converted {
        converted := cleanup_t_uint256(identity(cleanup_t_uint256(value)))
    }

    function prepare_store_t_uint256(value) -> ret {
        ret := value
    }

    function update_storage_value_t_uint256_to_t_uint256(slot, offset, value_0) {
        let convertedValue_0 := convert_t_uint256_to_t_uint256(value_0)
        sstore(slot, update_byte_slice_dynamic32(sload(slot), offset, prepare_store_t_uint256(convertedValue_0)))
    }

    function zero_value_for_split_t_uint256() -> ret {
        ret := 0
    }

    function storage_set_to_zero_t_uint256(slot, offset) {
        let zero_0 := zero_value_for_split_t_uint256()
        update_storage_value_t_uint256_to_t_uint256(slot, offset, zero_0)
    }

    function clear_storage_range_t_bytes1(start, end) {
        for {} lt(start, end) { start := add(start, 1) }
        {
            storage_set_to_zero_t_uint256(start, 0)
        }
    }

    function clean_up_bytearray_end_slots_t_string_storage(array, len, startIndex) {

        if gt(len, 31) {
            let dataArea := array_dataslot_t_string_storage(array)
            let deleteStart := add(dataArea, divide_by_32_ceil(startIndex))
            // If we are clearing array to be short byte array, we want to clear only data starting from array data area.
            if lt(startIndex, 32) { deleteStart := dataArea }
            clear_storage_range_t_bytes1(deleteStart, add(dataArea, divide_by_32_ceil(len)))
        }

    }

    function shift_right_unsigned_dynamic(bits, value) -> newValue {
        newValue :=

        shr(bits, value)

    }

    function mask_bytes_dynamic(data, bytes) -> result {
        let mask := not(shift_right_unsigned_dynamic(mul(8, bytes), not(0)))
        result := and(data, mask)
    }
    function extract_used_part_and_set_length_of_short_byte_array(data, len) -> used {
        // we want to save only elements that are part of the array after resizing
        // others should be set to zero
        data := mask_bytes_dynamic(data, len)
        used := or(data, mul(2, len))
    }
    function copy_byte_array_to_storage_from_t_string_memory_ptr_to_t_string_storage(slot, src) {

        let newLen := array_length_t_string_memory_ptr(src)
        // Make sure array length is sane
        if gt(newLen, 0xffffffffffffffff) { panic_error_0x41() }

        let oldLen := extract_byte_array_length(sload(slot))

        // potentially truncate data
        clean_up_bytearray_end_slots_t_string_storage(slot, oldLen, newLen)

        let srcOffset := 0

        srcOffset := 0x20

        switch gt(newLen, 31)
        case 1 {
            let loopEnd := and(newLen, not(0x1f))

            let dstPtr := array_dataslot_t_string_storage(slot)
            let i := 0
            for { } lt(i, loopEnd) { i := add(i, 0x20) } {
                sstore(dstPtr, mload(add(src, srcOffset)))
                dstPtr := add(dstPtr, 1)
                srcOffset := add(srcOffset, 32)
            }
            if lt(loopEnd, newLen) {
                let lastValue := mload(add(src, srcOffset))
                sstore(dstPtr, mask_bytes_dynamic(lastValue, and(newLen, 0x1f)))
            }
            sstore(slot, add(mul(newLen, 2), 1))
        }
        default {
            let value := 0
            if newLen {
                value := mload(add(src, srcOffset))
            }
            sstore(slot, extract_used_part_and_set_length_of_short_byte_array(value, newLen))
        }
    }

    function store_literal_in_memory_508d577597b73c156f0bd765d89ceae6f8f6454a13ed82363e166b8cab13d5ad(memPtr) {

        mstore(add(memPtr, 0), "User added successfully!")

    }

    function abi_encode_t_stringliteral_508d577597b73c156f0bd765d89ceae6f8f6454a13ed82363e166b8cab13d5ad_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 24)
        store_literal_in_memory_508d577597b73c156f0bd765d89ceae6f8f6454a13ed82363e166b8cab13d5ad(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_508d577597b73c156f0bd765d89ceae6f8f6454a13ed82363e166b8cab13d5ad_t_string_memory_ptr_t_string_memory_ptr__to_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr__fromStack_reversed(headStart , value1, value0) -> tail {
        tail := add(headStart, 96)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_508d577597b73c156f0bd765d89ceae6f8f6454a13ed82363e166b8cab13d5ad_to_t_string_memory_ptr_fromStack( tail)

        mstore(add(headStart, 32), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value0,  tail)

        mstore(add(headStart, 64), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value1,  tail)

    }

    function panic_error_0x32() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x32)
        revert(0, 0x24)
    }

    function panic_error_0x11() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x11)
        revert(0, 0x24)
    }

    function checked_sub_t_uint256(x, y) -> diff {
        x := cleanup_t_uint256(x)
        y := cleanup_t_uint256(y)
        diff := sub(x, y)

        if gt(diff, x) { panic_error_0x11() }

    }

    function panic_error_0x31() {
        mstore(0, 35408467139433450592217433187231851964531694900788300625387963629091585785856)
        mstore(4, 0x31)
        revert(0, 0x24)
    }

    function increment_t_uint256(value) -> ret {
        value := cleanup_t_uint256(value)
        if eq(value, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff) { panic_error_0x11() }
        ret := add(value, 1)
    }

    function store_literal_in_memory_52995662ce920bf46980ea62773e251835df2c073c627b44b4a43895c39c8f5b(memPtr) {

        mstore(add(memPtr, 0), "User deleted successfully!")

    }

    function abi_encode_t_stringliteral_52995662ce920bf46980ea62773e251835df2c073c627b44b4a43895c39c8f5b_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 26)
        store_literal_in_memory_52995662ce920bf46980ea62773e251835df2c073c627b44b4a43895c39c8f5b(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_52995662ce920bf46980ea62773e251835df2c073c627b44b4a43895c39c8f5b_t_string_memory_ptr_t_string_memory_ptr__to_t_string_memory_ptr_t_string_memory_ptr_t_string_memory_ptr__fromStack_reversed(headStart , value1, value0) -> tail {
        tail := add(headStart, 96)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_52995662ce920bf46980ea62773e251835df2c073c627b44b4a43895c39c8f5b_to_t_string_memory_ptr_fromStack( tail)

        mstore(add(headStart, 32), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value0,  tail)

        mstore(add(headStart, 64), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value1,  tail)

    }

    function store_literal_in_memory_9f404bf3dfdb93f78ecbbef8ec8a2ab1ff0c0c282dbf173dce8fa906325bb814(memPtr) {

        mstore(add(memPtr, 0), "Only contract owner can call thi")

        mstore(add(memPtr, 32), "s function")

    }

    function abi_encode_t_stringliteral_9f404bf3dfdb93f78ecbbef8ec8a2ab1ff0c0c282dbf173dce8fa906325bb814_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 42)
        store_literal_in_memory_9f404bf3dfdb93f78ecbbef8ec8a2ab1ff0c0c282dbf173dce8fa906325bb814(pos)
        end := add(pos, 64)
    }

    function abi_encode_tuple_t_stringliteral_9f404bf3dfdb93f78ecbbef8ec8a2ab1ff0c0c282dbf173dce8fa906325bb814__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_9f404bf3dfdb93f78ecbbef8ec8a2ab1ff0c0c282dbf173dce8fa906325bb814_to_t_string_memory_ptr_fromStack( tail)

    }

    function store_literal_in_memory_ed4e042b901cc2560f301a0fc5d98692dc9cabe3755ff94cf0cdd29c053c254a(memPtr) {

        mstore(add(memPtr, 0), "Owner changed successfully!")

    }

    function abi_encode_t_stringliteral_ed4e042b901cc2560f301a0fc5d98692dc9cabe3755ff94cf0cdd29c053c254a_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 27)
        store_literal_in_memory_ed4e042b901cc2560f301a0fc5d98692dc9cabe3755ff94cf0cdd29c053c254a(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_ed4e042b901cc2560f301a0fc5d98692dc9cabe3755ff94cf0cdd29c053c254a_t_address_t_address__to_t_string_memory_ptr_t_address_t_address__fromStack_reversed(headStart , value1, value0) -> tail {
        tail := add(headStart, 96)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_ed4e042b901cc2560f301a0fc5d98692dc9cabe3755ff94cf0cdd29c053c254a_to_t_string_memory_ptr_fromStack( tail)

        abi_encode_t_address_to_t_address_fromStack(value0,  add(headStart, 32))

        abi_encode_t_address_to_t_address_fromStack(value1,  add(headStart, 64))

    }

    function store_literal_in_memory_0ecb20dd38d24c4ba609f9c74daa149f4b2a8bfc08a7710cf66532bfb4cb4807(memPtr) {

        mstore(add(memPtr, 0), "Entity ID already exists")

    }

    function abi_encode_t_stringliteral_0ecb20dd38d24c4ba609f9c74daa149f4b2a8bfc08a7710cf66532bfb4cb4807_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 24)
        store_literal_in_memory_0ecb20dd38d24c4ba609f9c74daa149f4b2a8bfc08a7710cf66532bfb4cb4807(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_0ecb20dd38d24c4ba609f9c74daa149f4b2a8bfc08a7710cf66532bfb4cb4807__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_0ecb20dd38d24c4ba609f9c74daa149f4b2a8bfc08a7710cf66532bfb4cb4807_to_t_string_memory_ptr_fromStack( tail)

    }

    function store_literal_in_memory_2721d9cc37b43faf5508c605ac054334b4c80722b8aa704e5420d61499a6e2fb(memPtr) {

        mstore(add(memPtr, 0), "Entity name already exists")

    }

    function abi_encode_t_stringliteral_2721d9cc37b43faf5508c605ac054334b4c80722b8aa704e5420d61499a6e2fb_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 26)
        store_literal_in_memory_2721d9cc37b43faf5508c605ac054334b4c80722b8aa704e5420d61499a6e2fb(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_2721d9cc37b43faf5508c605ac054334b4c80722b8aa704e5420d61499a6e2fb__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_2721d9cc37b43faf5508c605ac054334b4c80722b8aa704e5420d61499a6e2fb_to_t_string_memory_ptr_fromStack( tail)

    }

    function store_literal_in_memory_a9c9abc86f390eace8116d7bad8c35fa603b9833ff112833556b06bed1671499(memPtr) {

        mstore(add(memPtr, 0), "New entity added!")

    }

    function abi_encode_t_stringliteral_a9c9abc86f390eace8116d7bad8c35fa603b9833ff112833556b06bed1671499_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 17)
        store_literal_in_memory_a9c9abc86f390eace8116d7bad8c35fa603b9833ff112833556b06bed1671499(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_a9c9abc86f390eace8116d7bad8c35fa603b9833ff112833556b06bed1671499_t_uint256_t_string_memory_ptr_t_enum$_EntityType_$18__to_t_string_memory_ptr_t_uint256_t_string_memory_ptr_t_uint8__fromStack_reversed(headStart , value2, value1, value0) -> tail {
        tail := add(headStart, 128)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_a9c9abc86f390eace8116d7bad8c35fa603b9833ff112833556b06bed1671499_to_t_string_memory_ptr_fromStack( tail)

        abi_encode_t_uint256_to_t_uint256_fromStack(value0,  add(headStart, 32))

        mstore(add(headStart, 64), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value1,  tail)

        abi_encode_t_enum$_EntityType_$18_to_t_uint8_fromStack(value2,  add(headStart, 96))

    }

    function store_literal_in_memory_5459b1573e57353ad200a477047c8f807700a4dc27ca4319e3333b133e4a5026(memPtr) {

        mstore(add(memPtr, 0), "Entity deleted successfully!")

    }

    function abi_encode_t_stringliteral_5459b1573e57353ad200a477047c8f807700a4dc27ca4319e3333b133e4a5026_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 28)
        store_literal_in_memory_5459b1573e57353ad200a477047c8f807700a4dc27ca4319e3333b133e4a5026(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_5459b1573e57353ad200a477047c8f807700a4dc27ca4319e3333b133e4a5026_t_uint256_t_string_memory_ptr_t_enum$_EntityType_$18__to_t_string_memory_ptr_t_uint256_t_string_memory_ptr_t_uint8__fromStack_reversed(headStart , value2, value1, value0) -> tail {
        tail := add(headStart, 128)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_5459b1573e57353ad200a477047c8f807700a4dc27ca4319e3333b133e4a5026_to_t_string_memory_ptr_fromStack( tail)

        abi_encode_t_uint256_to_t_uint256_fromStack(value0,  add(headStart, 32))

        mstore(add(headStart, 64), sub(tail, headStart))
        tail := abi_encode_t_string_memory_ptr_to_t_string_memory_ptr_fromStack(value1,  tail)

        abi_encode_t_enum$_EntityType_$18_to_t_uint8_fromStack(value2,  add(headStart, 96))

    }

    function store_literal_in_memory_0f231cbd93769c76aa0fe7fd9af117108e610fe4db57bc1fcd939e66e7966ccb(memPtr) {

        mstore(add(memPtr, 0), "Invalid Role")

    }

    function abi_encode_t_stringliteral_0f231cbd93769c76aa0fe7fd9af117108e610fe4db57bc1fcd939e66e7966ccb_to_t_string_memory_ptr_fromStack(pos) -> end {
        pos := array_storeLengthForEncoding_t_string_memory_ptr_fromStack(pos, 12)
        store_literal_in_memory_0f231cbd93769c76aa0fe7fd9af117108e610fe4db57bc1fcd939e66e7966ccb(pos)
        end := add(pos, 32)
    }

    function abi_encode_tuple_t_stringliteral_0f231cbd93769c76aa0fe7fd9af117108e610fe4db57bc1fcd939e66e7966ccb__to_t_string_memory_ptr__fromStack_reversed(headStart ) -> tail {
        tail := add(headStart, 32)

        mstore(add(headStart, 0), sub(tail, headStart))
        tail := abi_encode_t_stringliteral_0f231cbd93769c76aa0fe7fd9af117108e610fe4db57bc1fcd939e66e7966ccb_to_t_string_memory_ptr_fromStack( tail)

    }

}
