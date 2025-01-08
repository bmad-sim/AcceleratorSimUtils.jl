# SimUtils

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://bmad-sim.github.io/SimUtils.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://bmad-sim.github.io/SimUtils.jl/dev/)
[![Build Status](https://github.com/bmad-sim/SimUtils.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/bmad-sim/SimUtils.jl/actions/workflows/CI.yml?query=branch%3Amain)

A package of utility routines used by the SciBmad project for the simulation of high energy accelerators and storage rings.

## Conversions of particle energy, momentum, speed, and γ factor
- `calc_E_kinetic(...)`  - Calculate kinetic energy.
- `calc_γ(...)` - Calculate relativistic gamma factor.
- `calc_E_tot(...)` - Calculate total energy.
- `calc_pc(...)` - Calculate momentum * c.
- `calc_β(...)` - Calculate calculate velocity/c.
- `calc_1β(...)` - Calculate calculate `1 - β`.
- `calc_changed_energy(...)` - Calculate the new energy and momentum given initial momentum and energy change.

## Math routines

- `modulo2(x, amp)` - Calculate `x + 2 * n * amp` where the output is in the range `[-amp, amp)`.
- `un_sinc(x, n)` - Calculate `n`th derivative of `sin(x)/x`.
- `un_cosc(x, n)` - Calculate `n`th derivative of `(1 - cos(x)) / x^2`.
- `one_cos(x)` - Calculate `1 - cos(x)`.

## Pink noise

- `gen_pinknoise(beta, size, dt, f0)` - Random number generator that has a "pink noise spectrum.

 