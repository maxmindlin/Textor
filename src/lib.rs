use std::ffi::{CStr, CString};
use std::os::raw::{c_char};

#[no_mangle]
pub extern "C" fn free_string(s: *mut c_char) {
    let cstring = unsafe { CString::from_raw(s) };
    drop(cstring); // not technically required but shows what we're doing
}

#[no_mangle]
pub extern "C" fn memeify(input: *const c_char) -> *mut c_char {
    let ins = unsafe { CStr::from_ptr(input) };
    let ins = ins.to_str().unwrap();
    let out = memeify_string(ins);
    let cstring = CString::new(out).unwrap();
    cstring.into_raw()
}

fn memeify_string(input: &str) -> String {
    let vec: Vec<String> = input.chars().enumerate()
        .map(|(i, x)| 
            if i % 2 == 0 {
                x.to_lowercase().collect()
            } else {
                x.to_uppercase().collect()
            }
        )
        .collect();
    vec.join("")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_memeify() {
        assert_eq!(String::from("hElLo"), memeify_string("hello"));
    }
}