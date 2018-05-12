rust-cuda
=========

Rust nightly image based on nvidia/cuda with LLVM 6.0.

Pull from registory.gitlab.com

```
docker pull registry.gitlab.com/termoshtt/rust-cuda
```

Tags
-----

Command name of LLVM/Clang tool chains is different by tags:

- `cuda9.1`
  - usual naming, e.g. `clang`
- `cuda9.1-llvm6.0`
  - LLVM tools have suffix `*-6.0`, e.g. `clang-6.0`
