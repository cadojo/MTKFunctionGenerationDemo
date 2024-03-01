all: precompile test

precompile:
	julia --project=v8 -e 'import Pkg; Pkg.instantiate()'
	julia --project=v9 -e 'import Pkg; Pkg.instantiate()'

test:
	julia --project=v8 ode.jl
	julia --project=v9 ode.jl

.SILENT: precompile test

.PHONY: precompile test