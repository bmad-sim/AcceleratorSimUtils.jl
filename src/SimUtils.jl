module SimUtils
using FFTW, Random, GTPSA

export gen_pinknoise, Quaternion

include("pinknoise.jl")
include("quaternion.jl")

end
