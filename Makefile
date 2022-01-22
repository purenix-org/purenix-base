clean:
	rm -rf .spago output

build:
	spago build

tests:
	spago build --config spago-test.dhall && \
	nix-build -E '(import ./output/Test.Main/default.nix).main null'

docs:
	spago docs --config spago-lib.dhall