#---------------------------------------------------------------------------------------------------
# calc_E_tot

"""
   calc_E_tot(species::Species; pc::Union{Number, Nothing} = nothing, β::Union{Number, Nothing} = nothing,
                  E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing) -> E_tot::Number
   
Returns the total energy (in `eV`).
One and only one of the optional arguments `pc`, `β`, `E_kinetic`, or `γ` should be set.

Also see the functions `calc_pc`, `calc_β`, `calc_β1`, `calc_E_kinetic`, and `calc_γ`
""" calc_E_tot 

function calc_E_tot(species::Species; pc::Union{Number, Nothing} = nothing, β::Union{Number, Nothing} = nothing, 
                           E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  m = massof(species)

  if !isnothing(pc)
    return sqrt(pc^2 + m^2)
  elseif !isnothing(β)
    return m / sqrt(1 - β^2)
  elseif !isnothing(E_kinetic)
    return E_kinetic + m
  elseif !isnothing(γ)
    return γ * m
  else
    error("Not one of pc, β, E_kinetic, nor γ set.")
  end
end

#---------------------------------------------------------------------------------------------------
# calc_pc

"""
   calc_pc(species::Species; E_tot::Union{Number, Nothing} = nothing, β::Union{Number, Nothing} = nothing, 
          E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing) -> pc::Number
   
Returns the total energy (in `eV`). 
One and only one of the optional arguments `E_tot`, `β`, `E_kinetic`, or `γ` should be set.

Also see the functions `calc_E_tot`, `calc_β`, `calc_β1`, `calc_E_kinetic`, and `calc_γ`
""" calc_pc

function calc_pc(species::Species; 
                  E_tot::Union{Number, Nothing} = nothing, β::Union{Number, Nothing} = nothing, 
                          E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  m = massof(species)

  if !isnothing(E_tot)
    return sqrt(E_tot^2 - m^2)
  elseif !isnothing(β)
    return β * m / sqrt(1 - β^2)
  elseif !isnothing(E_kinetic)
    return sqrt((E_kinetic + m)^2 - m^2)
  elseif !isnothing(γ)
    return m * sqrt(γ^2 - 1)
  else
    error("Not one of E_tot, β, E_kinetic, nor γ set.")
  end
end

#---------------------------------------------------------------------------------------------------
# calc_β

"""
   calc_β(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
              E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing) -> β::Number
   
Returns the velocity `β` = `v/c`. 
One and only one of the optional arguments `E_tot`, `pc`, `E_kinetic`, or `γ` should be set.

Also see the functions `calc_E_tot`, `calc_pc`, `calc_β1`, `calc_E_kinetic`, and `calc_γ`
""" calc_β

function calc_β(species::Species; 
                E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                          E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  m = massof(species)

  if !isnothing(E_tot)
    return sqrt(1 - (m / E_tot)^2)
  elseif !isnothing(pc)
    return 1 / sqrt(1 + (m / pc)^2)
  elseif !isnothing(E_kinetic)
    f = m / (E_kinetic + m)
    return sqrt(1 - f^2)
  elseif !isnothing(γ)
    return sqrt(1 - 1/γ^2)
  else
    error("Not one of E_tot, pc, E_kinetic, nor γ set.")
  end
end

#---------------------------------------------------------------------------------------------------
# calc_β1

"""
   calc_β1(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
           E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing) -> 1-β::NUmber
Returns the quantity `1 - β` = `1 - v/c`. In the high energy limit, this is `1/(2γ^2)`.
β1 is computed such that in the high energy limit, round off error is not a problem.
One and only one of the optional arguments `E_tot`, `pc`, `E_kinetic`, or `γ` should be set.

Also see the functions `calc_E_tot`; `calc_pc`, `calc_β`, `calc_E_kinetic`, and `calc_γ`
""" calc_β1

function calc_β1(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                           E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  m = massof(species)

  if !isnothing(E_tot)
    mm2 = (m / E_tot)^2
    return  mm2 / (1 + sqrt(1 - mm2))
  elseif !isnothing(pc)
    m = m
    return m^2 / (sqrt(m^2 + pc^2) * (sqrt(m^2 + pc^2) + pc))
  elseif !isnothing(E_kinetic)
    mm2 = (m / (E_kinetic + m))^2
    return  mm2 / (1 + sqrt(1 - mm2))
  elseif !isnothing(γ)
    mm2 = 1 / γ^2
    return  mm2 / (1 + sqrt(1 - mm2))
  else
    error("Not one of E_tot, pc, E_kinetic, nor γ set.")
  end
end

#---------------------------------------------------------------------------------------------------
# calc_E_kinetic

"""
   calc_E_kinetic(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                      β::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing) -> E_kinetic::Number
   
Returns the kinetic energy in `eV`.
One and only one of the optional arguments `E_tot`, `pc`, `β`, or `γ` should be set.

Also see the functions  `calc_E_tot`; `calc_pc`, `calc_β`, `calc_β1`, and `calc_γ`
""" calc_E_kinetic

function calc_E_kinetic(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                                         β::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  m = massof(species)

  if !isnothing(pc)
    return pc^2 / (sqrt(pc^2 + m^2) + m)
  elseif !isnothing(β)
    return m * β^2 / (sqrt(1 - β^2) * (1 + sqrt(1 - β^2)))
  elseif !isnothing(E_tot)
    return E_tot - m
  elseif !isnothing(γ)
    return m * (γ - 1)
  else
    error("Not one of pc, β, E_tot, nor γ set.")
  end
end

#---------------------------------------------------------------------------------------------------
# calc_γ

"""
   calc_γ(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
          β::Union{Number, Nothing} = nothing, E_kinetic::Union{Number, Nothing} = nothing) -> γ::Number
   
Returns the total energy (in `eV`). 
One and only one of the optional arguments `E_tot`, `pc`, `β`, or `E_kinetic` should be set.

Also see the functions `calc_pc`, `calc_β`, `calc_β1`, `calc_E_kinetic`, and `calc_γ`
""" calc_γ 

function calc_γ(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
             β::Union{Number, Nothing} = nothing, E_kinetic::Union{Number, Nothing} = nothing)
  m = massof(species)

  if !isnothing(pc)
    return sqrt((pc/m)^2 + 1)
  elseif !isnothing(β)
    return  1 / sqrt(1 - β^2)
  elseif !isnothing(E_kinetic)
    return 1 + E_kinetic / m
  elseif !isnothing(E_tot)
    return E_tot / m
  else
    error("Not one of pc, β, E_kinetic, nor γ set.")
  end
end

#---------------------------------------------------------------------------------------------------
# calc_changed_energy

"""
    calc_changed_energy(species::Species; old_pc::Number, dE::Number) -> (pc, E_tot)

Given an initial `old_pc` particle momentum*c, and a change in energy `dE`, calculate
the final momentum*c and total energy.

The calculation is done in such a way as to not loose precision.
""" calc_changed_energy

function calc_changed_energy(species::Species; old_pc::Number, dE::Number)
  m = massof(species)
  p2 = old_pc^2 + dE^2 + 2*sqrt(old_pc^2 + m^2)
  return sqrt(p2), sqrt(p2 + m^2)
end

