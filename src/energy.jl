# Particle energy conversions =============================================================
# Absolute conversions ------------------------------------------------------------------
R_to_pc(species::Species, R)  = @FastGTPSA R*chargeof(species)*C_LIGHT
pc_to_R(species::Species, pc) = @FastGTPSA pc/C_LIGHT/chargeof(species)

R_to_E(species::Species, R)   = @FastGTPSA sqrt((R*C_LIGHT*chargeof(species))^2 + massof(species)^2)
pc_to_E(species::Species, pc) = @FastGTPSA sqrt(pc^2 + massof(species)^2)

# (E-m)(E+m) avoids cancellation at low kinetic energy
function E_to_pc(species::Species, E)
  if E < massof(species)
    throw(DomainError(E, "E must be ≥ mass"))
  else
    return @FastGTPSA sqrt((E - massof(species))*(E + massof(species)))
  end
end
function E_to_R(species::Species, E)
  if E < massof(species)
    throw(DomainError(E, "E must be ≥ mass"))
  else
    return @FastGTPSA sqrt((E - massof(species))*(E + massof(species)))/C_LIGHT/chargeof(species)
  end
end

E_to_v(species::Species, E)   = @FastGTPSA sqrt((E - massof(species))*(E + massof(species))) * C_LIGHT / E
R_to_v(species::Species, R)   = @FastGTPSA R*C_LIGHT*chargeof(species) * C_LIGHT / sqrt((R*C_LIGHT*chargeof(species))^2 + massof(species)^2)
R_to_gamma(species::Species, R)      = @FastGTPSA sqrt((R*C_LIGHT*chargeof(species)/massof(species))^2 + 1)
R_to_beta_gamma(species::Species, R) = @FastGTPSA R*chargeof(species)*C_LIGHT/massof(species)

# Delta conversions ---------------------------------------------------------------------
# Linear: only the delta is needed.
dR_to_dpc(species::Species, dR)  = @FastGTPSA dR*chargeof(species)*C_LIGHT
dpc_to_dR(species::Species, dpc) = @FastGTPSA dpc/C_LIGHT/chargeof(species)

# Nonlinear: need the reference value (R0, pc0, E0). Uses a^2 - b^2 = (a-b)(a+b) so small
# deltas don't suffer cancellation.
dpc_to_dE(species::Species, pc0, dpc) =
  @FastGTPSA dpc*(2*pc0 + dpc) / (sqrt((pc0 + dpc)^2 + massof(species)^2) + sqrt(pc0^2 + massof(species)^2))

dE_to_dpc(species::Species, E0, dE) =
  @FastGTPSA dE*(2*E0 + dE) / (sqrt((E0 + dE - massof(species))*(E0 + dE + massof(species))) +
                               sqrt((E0 - massof(species))*(E0 + massof(species))))

dR_to_dE(species::Species, R0, dR) = dpc_to_dE(species, R_to_pc(species, R0), dR_to_dpc(species, dR))
dE_to_dR(species::Species, E0, dE) = dpc_to_dR(species, dE_to_dpc(species, E0, dE))

# Extra ---------------------------------------------------------------------------------
@generated function beta_gamma_to_v(beta_gamma::T) where {T}
  clight = C_LIGHT
  TS = ForwardDiff.valtype(T)
  if TS == Float32 || TS == Float16
    clight = TS(C_LIGHT)
  end
  return :($clight*beta_gamma/sqrt(1+beta_gamma^2))
end
