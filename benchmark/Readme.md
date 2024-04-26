# HTTP server benchmark created for x86 -> aarch64 emulation benchmarking
To ensure you are using the same dependency version build using:
```
cargo b --locked -r --bin quick-start --target [architecture]-unknown-linux-musl
```

and benchmark using:
```
cargo r -r --locked --bin bench --target [arch]-unknown-linux-musl
```