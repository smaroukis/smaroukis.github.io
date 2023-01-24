---
title: "Current Transformers for Protective Relaying: Saturation and Knee Point Explained"
excerpt: "A graphical explanation of magnetic saturation, knee point demonstration and voltage ratings of CTs"
categories: [Engineering, Power Systems]
tags: [technical-post, power-systems, electrical-engineering]
math: true
img_path: /assets/img/
image:
  path: excitation_curve_ann.png
---

Current transformers (CTs) are one of the most important devices in a power system, yet it took me a few years in the industry to find a proper explanation of CT saturation and the meaning "knee point" of the excitation curve.  The knee point is not the point of saturation — the point of saturation corresponds to a volt-time area since the flux is given by the integration of the voltage waveform. Although it is desired to operate in the linear region below the knee, where the excitation current is small compared to the current through the secondary burden, CTs often operate beyond this knee point for relaying applications due to asymmetrical fault currents, remanence flux, and design constraints. 

> The knee point is not the point of saturation — the point of saturation corresponds to a volt-time area since the flux is given by the integration of the voltage waveform.

## Current Transformer Theory

Transformers operate on the fundamental principle that a time-varying magnetic flux induces a voltage to oppose it (Faraday's Law). A current through a primary winding creates a magnetic field (H-field) which induces an amount of flux depending on the magnetic properties of the material, the excitation level and the number of turns of coil around the secondary. 

> Note: load must be connected for current to flow. Never open circuit a CT.

![window_ct](window_ct.png)
*Example flux paths of a time varying current of a primary winding inducing a secondary current.*

$$e=N\frac{d\phi}{dt}$$

When a load (normally called a "burden") is connected to this secondary voltage, a current will flow. How well this secondary current is an exact replication of the primary current depends on the level of excitation. At low excitation values all of the current is used to develop the core's magnetic field and at high excitation values the core can saturate.

The magnetic atoms in the magnetic core material react in a non-linear fashion when an H-field is applied, since they can only "line-up" so much in one direction. This results in the familiar B-H curve showing magnetic flux density vs. magnetic field intensity. The Flux-Magnetizing Current curve has the same shape since it is the magnetizing current driving the H-field and the flux also includes the proportional affect of the area of the magnetic core. This curve will be different for varying levels of excitation.

Also note that $$d\phi/dI$$ represents the magnetizing inductance of the core. 

![excitation](excitation.gif)
*The B-H curve of a current transformer core for varying levels of excitation[^Zocholl].*

To understand the above graph we need the equivalent circuit of the current transformer.

## Equivalent Circuit

![ct_equivalent_circuit](ct_equivalent_circuit.png)
*Equivalent circuit of current transformer. Note the exciting branch is made up of a varying reactive magnetizing impedance and resistive losses.*

Since the primary turns is 1, the burden appears on the primary as a very small impedance ($Z_B'=Z_B \cdot 1/N_2^2$)

Clearly not all current is delivered to the burden (which is what we can measure, and what our relays "see"). The **ratio correction factor** (RCF) is used to correct the secondary current for this non-ideal case. 

Above we can see the variable magnetizing impedance. At low excitation levels $$d\phi / dI = L$$ is low, so the majority of the total secondary current ($I_{ST}$) flows over $Z_e$ and not through the burden. At moderate levels of excitation the magnetizing impedance increases and most of the secondary current flows over the burden. At high levels of excitation the impedance flips between an open and a short. This is the saturation region where the secondary current that flows across the burden (which is the only current that we "see") is not an accurate representation of the primary current.

The magnetization current lags the exciting voltage by 90 degrees and the losses are nearly in phase. These two vectors give the excitation current. 

Simplifying the equivalent circuit above, the secondary can be represented as a current source from the ideal transformer where $I_{sec}=I_{pri} \cdot N_1/N_2$. This current is "fixed" depending on the primary current — the excitation voltage will be developed due to the connected burden, secondary resistance and leakage impedance. 

![ct_secondary_equivalent_excitation](ct_secondary_equivalent_excitation.gif)
*A simplified secondary CT equivalent with animation of different excitation levels: 1) the current source is a reflection of the primary current 2) since the magnetizing impedance dominates the losses, we just show Zm 3) ) leakage reactance is negligible for Class C CTs.  At low excitation (green), the majority of current flows through the small magnetizing impedance to generate the magnetic field. At moderate levels of excitation (orange) most of the secondary current flows through the burden. At high levels of excitation (red) the magnetizing impedance switches between an open and a short during different values of the sinusoidal current and resulting B-H curve.*

> An increase in burden impedance at a given current will demand an increase in excitation voltage.

![ct_equivalent_circuit_phasors](ct_equivalent_circuit_phasors.png){: width="400"}
*Phasor diagram of CT secondary with standard burden of 0.5 power factor (60 degrees). Take the secondary current and add the voltage drop from the leakage reactance and winding impedance. This voltage plus the secondary terminal voltage equals the excitation voltage. The flux and magnetizing current lag this voltage by 90 degrees.[^c37]*

## The Volt-Time Area

Integrating both sides of the flux-voltage equation gives

$$\phi N=BAN=\int_0^t v\cdot dt$$

So the flux can be thought of as the area under the voltage sine wave, known as the volt-time area. There is a value for this volt-time area that corresponds to the saturation flux point. Increased area due to asymmetrical offset or a higher peak can result in the core going above the saturation flux limit. 

Other things to note:

- a larger cross sectional area results in an increased volt-time area before saturation
- from Faraday's law, an increase in turns reduces the amount of flux necessary to produce a given secondary EMF, which means saturation occurs at a proportionally higher voltage when the number of secondary turns is increased

## Excitation Curve and the Knee Point

> The rating is the voltage the CT can support across a standard burden with 20 times rated current without exceeding 10% ratio correction error

The excitation curve is a graph of the secondary voltage ($V_e$) vs the excitation current ($I_e$). This shows us what current the burden **won't** see for various voltage levels. It is directly related to the magnetizing impedance given by $V_e/I_e$. This also gives us our ratio correction factor. 

![excitation_curve_ann](excitation_curve_ann.png)

The standard CT excitation curve that manufacturers provide. Here we can read the voltage rating from the excitation voltage at 10A of excitation current. The voltage rating must be less the voltage read off the graph minus the winding and leakage drop, which means that the CT can develop this voltage without exceeding 10A excitation (or 10% error at 100A secondary)[^Hargrave].

The "knee point" represents the maximum permeability, or the minimum magnetizing impedance. Since most current will flow through the burden at this point, it is where we want our CT to operate for maximum fault currents.

The voltage rating can be taken directly from this since "the rating is the voltage the CT can support across a standard burden with 20 times rated current without exceeding 10% ratio correction error"[^c37]. Since 20 times the rated secondary current of 5A equals 100A, a 10% ratio correction error means 10A of shunted excitation current. We can read this secondary voltage corresponding to 10A excitation. This voltage value from the graph minus voltage drop of the winding resistance should be ***greater than*** the voltage rating of the CT, meaning that the CT can develop this voltage level without saturating the flux core. 

For multi-ratio CTs, the ability to develop voltage without saturating is scaled proportionally by the number of turns. Thus for a C400 600:5 CT operating on the 300:5 tap, the new voltage "rating" is 200V. 

## Criterion to Avoid Saturation

> When the DC offset is at maximum, the CT flux can potentially increase to $1+X/R$ times the flux of the non-offset component

Saturation can occur from both symmetrical and asymmetrical currents on the primary. Symmetrical current waveforms with a large peak can saturate the core within the first cycle. Asymmetrical current waveforms with a DC offset may not saturate in the first cycle, but in the latter cycle since the volt-time area does not cancel out with negative values.   

The asymmetrical current is due to the X/R system ratio. With the voltage developed by the fault current and the secondary burden, we can develop the criterion to avoid saturation (to stay under the voltage rating of the CT) as[^1]: 

$$20 \ge (\frac{X}{R}+1)\cdot I_f \cdot Z_b$$

We risk saturation if

1. The fault current is higher than 20 times rated current OR
2. The connected burden is higher than standard

This gives the following rule of thumbs:

- Limit max fault current <100A max on secondary
- Limit $I_f \cdot Z_b$ < half the voltage rating of the CT. This allows for DC offset and remanence flux ($I_f$ is maximum symmetrical fault current)

## CT Ratings, Classes and Other Types

Almost all CTs used in protective relaying are class C or K

- **C**: "**Calculated**", negligible leakage flux, excitation curve can be used directly to determine performance, assumed that burden and excitation currents are in phase and that secondary winding is uniformly distributed; ANSI
    - e.g. C100, C200, C400, C800 corresponding to secondary voltages (@100A) of 100V,200V,400V,800V etc and burdens of 1,2,4,8 respectively (due to Z=V/100);  ANSI specifies PF of burden at 0.5 (60 degrees);
- **K**: same as C + knee-point voltage at least 70% of voltage rating; results in larger core cross section area
- **T**: "**Test**", ratio error must be determined by test; has appreciable core flux leakage and thus ratio error
- **H,L**: old ANSI classifications mostly for CTs manufactured before 1954

### Other CT types

**Gapped cores**
An air gap can be added to the core which 1) increases magnetizing current and 2) reduces the possibility of remanence. Large-gapped cores are known as linearized cores; the effect is to increase the linear region of the BH curve & decrease the permeability (lower magnetizing impedance). 

![core_gap_effect](core_gap_effect.gif){: width="300"}
An air gap can be introduce to extend the linear region of the B-H curve at the expense of reduced permeability.

## Further Reading

- C57.13-2016: IEEE Standard Requirements for Instrumentation Transformers
- Moreton, S. D. "A simple method for the determination of bushing-current-transformer characteristics." Electrical Engineering 62.9 (1943): 581-585.

## References & Footnotes

[^Zocholl]: Zocholl, Stanley E. _Analyzing and applying current transformers_. Schweitzer Engineering Laboratories, Incorporated, 2004.
[^c37]: C37.110-2007: IEEE Guide for the Application of Current Transformers Used for Protective Relaying Purposes
[^1]: This assumes 1) the worst case DC offset given by the X/R ratio — in fact the offset will be determined by the closing angle of the fault and 2) a purely resistive burden. For inductive burden see C37.110-2007.
[^Hargrave]: Ariana Hargrave, Michael J. Thompson, and Brad Heilman. "Beyond the Knee Point: Understanding the Maximum Available Fault Current." Schweitzer Engineering Laboratories, Inc. 2018. [https://cms-cdn.selinc.com/assets/Literature/Publications/Technical%20Papers/6811_BeyondKneePoint_AH_20200501_Web.pdf?v=20200504-195517](https://cms-cdn.selinc.com/assets/Literature/Publications/Technical%20Papers/6811_BeyondKneePoint_AH_20200501_Web.pdf?v=20200504-195517)
