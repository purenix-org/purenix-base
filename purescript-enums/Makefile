clean:
	rm -rf .spago output

build:
	spago build

tests:
	spago build && \
	nix-build -E '(import ./output/Test.Main/default.nix).main null'

docs:
	spago docs