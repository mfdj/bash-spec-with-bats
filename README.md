**Goals**

Current: describe the behavior of integeral BASH builtins, and standard commands using [BATS](/Users/markfox/projects/bash-spec-with-bats/README.md) on macOS and the latest version of BASH available in Homberew.

Future: make suite appropriately portable to multiple versions of BASH, common nix operating systems variants, and major shell languages.

**Usage**

Install dependencies

```sh
$ brew tap kaos/shell
$ brew install bash bats-core bats-assert bats-file bats-support
```

Run the sutie

```sh
$ bats -r .
```

**References**

https://www.gnu.org/software/bash/manual/bash.html
