#![no_main]

use libfuzzer_sys::fuzz_target;

fuzz_target!(|data: &[u8]| {
    // fuzzed code goes here

    use zune_qoi::zune_core::bytestream::ZCursor;
    let data = ZCursor::new(data);
    let mut decoder = zune_qoi::QoiDecoder::new(data);
    let _ = decoder.decode();
});
