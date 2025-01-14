#---------------------------------------------------------------------------------------------------
# calc_E_tot

"""
    calc_E_tot(mass; pc = nothing, β = nothing, E_kinetic = nothing, γ = nothing) -> E_tot
    calc_E_tot(species; pc = nothing, β = nothing, E_kinetic = nothing, γ = nothing) -> E_tot

Returns the total energy of a particle (in `eV`) given one of `pc` (momentum*c), `β` (velocity/c), 
`E_kinetic` (kinetic energy), or `γ` (relativistic factor).
One and only one of the optional arguments `pc`, `β`, `E_kinetic`, or `γ` should be set.
All arguments are `Numbers` except `species` which is of type `Species`.

The `mass` argument is in units of `energy/c^2`.

Also see the functions `calc_pc`, `calc_β`, `calc_β1`, `calc_E_kinetic`, and `calc_γ`
""" calc_E_tot 

function calc_E_tot(mass::Number; pc::Union{Number, Nothing} = nothing, β::Union{Number, Nothing} = nothing, 
                           E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  if !isnothing(pc)
    return sqrt(pc^2 + mass^2)
  elseif !isnothing(β)
    return mass / sqrt(1 - β^2)
  elseif !isnothing(E_kinetic)
    return E_kinetic + mass
  elseif !isnothing(γ)
    return γ * mass
  else
    error("Not one of pc, β, E_kinetic, nor γ set.")
  end
end

function calc_E_tot(species::Species; pc::Union{Number, Nothing} = nothing, β::Union{Number, Nothing} = nothing, 
                           E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  return calc_E_tot(massof(species), pc = pc, β = β, E_kinetic = E_kinetic, γ = γ)
end
#---------------------------------------------------------------------------------------------------
# calc_pc

"""
    calc_pc(mass; E_tot = nothing, β = nothing, E_kinetic = nothing, γ = nothing) -> pc
    calc_pc(species; E_tot = nothing, β = nothing, E_kinetic = nothing, γ = nothing) -> pc
   
Returns the particle momentum*c (in `eV`) given one of `E_tot` (total energy), `β` (velocity/c), 
`E_kinetic` (kinetic energy), or `γ` (relativistic factor). 
One and only one of the optional arguments `E_tot`, `β`, `E_kinetic`, or `γ` should be set.
All arguments are `Numbers` except `species` which is of type `Species`.

The `mass` argument is in units of `energy/c^2`.

Also see the functions `calc_E_tot`, `calc_β`, `calc_β1`, `calc_E_kinetic`, and `calc_γ`
""" calc_pc

function calc_pc(mass::Number; 
                  E_tot::Union{Number, Nothing} = nothing, β::Union{Number, Nothing} = nothing, 
                          E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  if !isnothing(E_tot)
    return sqrt(E_tot^2 - mass^2)
  elseif !isnothing(β)
    return β * mass / sqrt(1 - β^2)
  elseif !isnothing(E_kinetic)
    return sqrt((E_kinetic + mass)^2 - mass^2)
  elseif !isnothing(γ)
    return mass * sqrt(γ^2 - 1)
  else
    error("Not one of E_tot, β, E_kinetic, nor γ set.")
  end
end

function calc_pc(species::Species; 
                  E_tot::Union{Number, Nothing} = nothing, β::Union{Number, Nothing} = nothing, 
                          E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  return calc_pc(massof(species), E_tot = E_tot, β = β, E_kinetic = E_kinetic, γ = γ)
end
#---------------------------------------------------------------------------------------------------
# calc_β

"""
    calc_β(mass; E_tot = nothing, pc = nothing, E_kinetic = nothing, γ = nothing) -> β
    calc_β(species; E_tot = nothing, pc = nothing, E_kinetic = nothing, γ = nothing) -> β
   
Returns the normalized velocity `β` = `v/c` of a particle given one of `E_tot` (total energy), 
`pc` (momentum*c), `E_kinetic` (kinetic energy), or `γ` (relativistic factor). 
One and only one of the optional arguments `E_tot`, `pc`, `E_kinetic`, or `γ` should be set.
All arguments are `Numbers` except `species` which is of type `Species`.

The `mass` argument is in units of `energy/c^2`.

Also see the functions `calc_E_tot`, `calc_pc`, `calc_β1`, `calc_E_kinetic`, and `calc_γ`
""" calc_β

function calc_β(mass::Number; 
                E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                          E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  if !isnothing(E_tot)
    return sqrt(1 - (mass / E_tot)^2)
  elseif !isnothing(pc)
    return 1 / sqrt(1 + (mass / pc)^2)
  elseif !isnothing(E_kinetic)
    f = mass / (E_kinetic + mass)
    return sqrt(1 - f^2)
  elseif !isnothing(γ)
    return sqrt(1 - 1/γ^2)
  else
    error("Not one of E_tot, pc, E_kinetic, nor γ set.")
  end
end

function calc_β(species::Species; 
                E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                          E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  return calc_β(massof(species), E_tot = E_tot, pc = pc, E_kinetic = E_kinetic, γ = γ)
end

#---------------------------------------------------------------------------------------------------
# calc_1β

"""
    calc_1β(mass; E_tot = nothing, pc = nothing, E_kinetic = nothing, γ = nothing) -> 1-β
    calc_1β(species; E_tot = nothing, pc = nothing, E_kinetic = nothing, γ = nothing) -> 1-β

Returns the quantity `1 - β` = `1 - v/c` of a particle given one of `E_tot` (total energy), 
`pc` (momentum*c), `E_kinetic` (kinetic energy), or `γ` (relativistic factor). 
In the high energy limit, this is approximately `1/(2γ^2)`.
`calc_1β` is computed such that in the high energy limit, round off error is not a problem.

One and only one of the optional arguments `E_tot`, `pc`, `E_kinetic`, or `γ` should be set.
All arguments are `Numbers` except `species` which is of type `Species`.
The `mass` argument is in units of `energy/c^2`.

Also see the functions `calc_E_tot`; `calc_pc`, `calc_β`, `calc_E_kinetic`, and `calc_γ`
""" calc_1β

function calc_1β(mass::Number; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                           E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  if !isnothing(E_tot)
    gamma_inv2 = (mass / E_tot)^2
    return  gamma_inv2 / (1 + sqrt(1 - gamma_inv2))
  elseif !isnothing(pc)
    return mass^2 / (sqrt(mass^2 + pc^2) * (sqrt(mass^2 + pc^2) + pc))
  elseif !isnothing(E_kinetic)
    gamma_inv2 = (mass / (E_kinetic + mass))^2
    return  gamma_inv2 / (1 + sqrt(1 - gamma_inv2))
  elseif !isnothing(γ)
    gamma_inv2 = 1 / γ^2
    return  gamma_inv2 / (1 + sqrt(1 - gamma_inv2))
  else
    error("Not one of E_tot, pc, E_kinetic, nor γ set.")
  end
end

function calc_1β(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                           E_kinetic::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  return calc_1β(massof(species), E_tot = E_tot, pc = pc, E_kinetic = E_kinetic, γ = γ)
end

#---------------------------------------------------------------------------------------------------
# calc_E_kinetic

"""
    calc_E_kinetic(mass; E_tot = nothing, pc = nothing, β = nothing, γ = nothing) -> E_kinetic
    calc_E_kinetic(species; E_tot = nothing, pc = nothing, β = nothing, γ = nothing) -> E_kinetic
   
Returns the kinetic energy of a particle in `eV` given one of `E_tot` (total energy), 
`pc` (momentum*c), `β` (velocity/c), or `γ` (relativistic factor).
One and only one of the optional arguments `E_tot`, `pc`, `β`, or `γ` should be set.

All arguments are `Numbers` except `species` which is of type `Species`.
The `mass` argument is in units of `energy/c^2`.

Also see the functions  `calc_E_tot`; `calc_pc`, `calc_β`, `calc_β1`, and `calc_γ`
""" calc_E_kinetic

function calc_E_kinetic(mass::Number; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                                         β::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  if !isnothing(pc)
    return pc^2 / (sqrt(pc^2 + mass^2) + mass)
  elseif !isnothing(β)
    return mass * β^2 / (sqrt(1 - β^2) * (1 + sqrt(1 - β^2)))
  elseif !isnothing(E_tot)
    return E_tot - mass
  elseif !isnothing(γ)
    return mass * (γ - 1)
  else
    error("Not one of pc, β, E_tot, nor γ set.")
  end
end

function calc_E_kinetic(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
                                         β::Union{Number, Nothing} = nothing, γ::Union{Number, Nothing} = nothing)
  return calc_E_kinetic(massof(species), E_tot = E_tot, pc = pc, β = β, γ = γ)
end

#---------------------------------------------------------------------------------------------------
# calc_γ

"""
    calc_γ(mass; E_tot = nothing, pc = nothing, β = nothing, E_kinetic = nothing) -> γ
    calc_γ(species; E_tot = nothing, pc = nothing, β = nothing, E_kinetic = nothing) -> γ

Returns the relativistic gamma factor of a particle given `E_tot` (total energy), 
`pc` (momentum*c), `β` (velocity/c), or `E_kinetic` (kinetic energy). 
One and only one of the optional arguments `E_tot`, `pc`, `β`, or `E_kinetic` should be set.

All arguments are `Numbers` except `species` which is of type `Species`.
The `mass` argument is in units of `energy/c^2`.

Also see the functions `calc_pc`, `calc_β`, `calc_β1`, `calc_E_kinetic`, and `calc_γ`
""" calc_γ 

function calc_γ(mass::Number; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
             β::Union{Number, Nothing} = nothing, E_kinetic::Union{Number, Nothing} = nothing)
  if !isnothing(pc)
    return sqrt((pc/mass)^2 + 1)
  elseif !isnothing(β)
    return  1 / sqrt(1 - β^2)
  elseif !isnothing(E_kinetic)
    return 1 + E_kinetic / mass
  elseif !isnothing(E_tot)
    return E_tot / mass
  else
    error("Not one of pc, β, E_kinetic, nor γ set.")
  end
end

function calc_γ(species::Species; E_tot::Union{Number, Nothing} = nothing, pc::Union{Number, Nothing} = nothing, 
             β::Union{Number, Nothing} = nothing, E_kinetic::Union{Number, Nothing} = nothing)
  return calc_γ(massof(species), E_tot = E_tot, pc = pc, β = β, E_kinetic = E_kinetic)
end

#---------------------------------------------------------------------------------------------------
# calc_changed_energy

"""
    calc_changed_energy(mass; old_pc, dE) -> (pc, E_tot)
    calc_changed_energy(species::Species; old_pc, dE) -> (pc, E_tot)

Given an initial `old_pc` particle `momentum*c`, and a change in energy `dE`, calculate
the final `momentum*c` and total energy. If `dE` is too large and negative for there
to be a solution, `NaN, NaN` is returned.
All arguments are `Numbers` except `species` which is of type `Species`.

The `mass` argument is in units of `energy/c^2`.

The calculation is done in such a way as to not loose precision.
""" calc_changed_energy

function calc_changed_energy(mass::Number, old_pc::Number, dE::Number)
  p2 = old_pc^2 + dE^2 + 2*sqrt(old_pc^2 + mass^2) * dE
  if p2 < 0; (return NaN, NaN); end
  return sqrt(p2), sqrt(p2 + mass^2)
end

function calc_changed_energy(species::Species, old_pc::Number, dE::Number)
  return calc_changed_energy(massof(species), old_pc::Number, dE::Number)
end
