module SimUtils
using FFTW, Random, GTPSA

export gen_pinknoise, Quaternion
export cos_one, modulo2

include("math.jl")
include("pinknoise.jl")
include("quaternion.jl")

end
