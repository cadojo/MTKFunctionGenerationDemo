#
# The following script is adapted from the `labelledarrays.jl` test file
# in the ModelingToolkit.jl repository on GitHub.
#
#   https://github.com/SciML/ModelingToolkit.jl/blob/78ec2b296781893995e98a25c2a1309a8aa58cf7/test/labelledarrays.jl#L11
#
# The ModelingToolkit.jl package is licensed under the MIT "Expat" License:

# > Copyright (c) 2018-22: Yingbo Ma, Christopher Rackauckas, Julia Computing, and
# > contributors
# > 
# > Permission is hereby granted, free of charge, to any person obtaining a copy
# > 
# > of this software and associated documentation files (the "Software"), to deal
# > 
# > in the Software without restriction, including without limitation the rights
# > 
# > to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# > 
# > copies of the Software, and to permit persons to whom the Software is
# > 
# > furnished to do so, subject to the following conditions:
# > 
# > The above copyright notice and this permission notice shall be included in all
# > 
# > copies or substantial portions of the Software.
# > 
# > THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# > 
# > IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# > 
# > FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# > 
# > AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# > 
# > LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# > 
# > OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# > 
# > SOFTWARE.


using ModelingToolkit
using PkgVersion
using LabelledArrays, StaticArrays

# Not in original test -- I added this to avoid t_nounits and D_nounits in v8 
@variables t
D = Differential(t)

# Define some variables
@parameters σ ρ β
@variables x(t) y(t) z(t)

# Define a differential equation
eqs = [
    D(x) ~ σ * (y - x),
    D(y) ~ t * x * (ρ - z) - y,
    D(z) ~ x * y - β * z
]

@named de = ODESystem(eqs, t)
de = complete(de)
ff = ODEFunction(de, [x, y, z], [σ, ρ, β], jac=true)

a = @SVector [1.0, 2.0, 3.0]
b = SLVector(x=1.0, y=2.0, z=3.0)
c = [1.0, 2.0, 3.0]
p = SLVector(σ=10.0, ρ=26.0, β=8 / 3)

@info "ModelingToolkit @ $(PkgVersion.Version(ModelingToolkit))" ff(a, p, 0.0)
