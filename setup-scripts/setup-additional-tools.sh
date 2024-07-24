#!/bin/bash

## Update rust version
rustup update stable

# Install bottom - better alternative for top
cargo install bottom --locked

# Install dust - better alternative for du
cargo install du-dust
