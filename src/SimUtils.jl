module SimUtils
using FFTW, Random, GTPSA

#export Quaternion
export gen_pinknoise
export cos_one, modulo2
export E_tot, E_kinetic, pc, β, β1, γ

include("math.jl")
include("pinknoise.jl")
include("particle_properties_conversion.jl")
#include("quaternion.jl")

end
