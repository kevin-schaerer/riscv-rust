#!/usr/bin/env bash

set -euo pipefail

# Variables
RUST_VERSION=$1
RUST_TAG=rust-ntl-$RUST_VERSION
RUST_SRC=$PWD/rust

mkdir dist

git clone --recursive https://github.com/kevin-schaerer/rust.git $RUST_SRC -b $RUST_TAG --depth 1

cp config.toml $RUST_SRC/config.toml

pushd $RUST_SRC

./x build -i --stage 1 compiler/rustc library/std
./x dist -i --stage 1

popd

cp $RUST_SRC/build/dist/rust-$RUST_VERSION-$(uname -m)-unknown-linux-gnu.tar.gz dist/
cp $RUST_SRC/build/dist/rust-$RUST_VERSION-$(uname -m)-unknown-linux-gnu.tar.xz dist/

cp $RUST_SRC/build/dist/rust-std-$RUST_VERSION-riscv32imac-unknown-linux-gnu.tar.gz dist/
cp $RUST_SRC/build/dist/rust-std-$RUST_VERSION-riscv32imac-unknown-linux-gnu.tar.xz dist/

echo "Rust toolchain built successfully."

# Cleanup
rm -rf $RUST_SRC
echo "Temporary files cleaned up."
# End of script
# EOF