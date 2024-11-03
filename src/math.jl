#---------------------------------------------------------------------------------------------------
# cos_one

"""
    cos_one(x)

Function to calculate `cos(x) - 1` to machine precision.
This is usful if angle can be near zero where the direct evaluation of `cos(x) - 1` is inaccurate.
""" cos_one

cos_one(x) = -2.0 * sin(x/2.0)^2

#---------------------------------------------------------------------------------------------------
# modulo2

"""
    function modulo2(x, amp)

 Function to return
```
     mod2 = x + 2 * n * amp
```
where `n` is an integer chosen such that
```
    -amp <= mod2 < amp
```
""" modulo2

function modulo2(x, amp)
  m2 = mod(x, 2*amp)
  m2 < amp ? (return m2) : (return m2 - 2*amp)
end
