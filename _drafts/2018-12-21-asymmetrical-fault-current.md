---
layout: post
title: Asymmetrical Fault Currents
excerpt: "Overview of asymmetrical fault currents and curve of asymmetry factors back-calculation"
categories: [power systems engineering]
tags: [power systems engineering]
---

> Asymmetry in fault currents due to the inductive nature of power systems results in higher-than-normal transient conditions that may exceed the interrupting rating of devices or cause saturation of relaying CTs (and thus device misoperation).

Asymmetrical fault currents are AC fault currents with a DC offset that quickly decays to zero. The result is higher than normal fault currents that may exceed the interrupting rating of devices or cause saturation of relaying CTs on protective devices. Asymmetry occurs to some degree in all three-phase faults since all phase currents cannot be 0 at the same time. Conversely, line-to-ground are mostly symmetric, since insulator failure or flashover usually occurs near voltage peaks (zero-current crossing for naturally reactive systems)[^1]. Here we'll talk about asymmetric currents out on the distribution system, far from a generator, so we won't be taking into account the generator subtransient, transient, and steady state impedances.

> Asymmetry occurs to some degree in __all three-phase__ faults since all three-phase currents cannot be 0 simultaneously.

The asymmetry, with respect to the zero axis of the sinusoidal current, arises from the need for currents and voltages to satisfy two rules:

1. Current must lag voltage by the system phase angle (90° for purely reactive systems)
2. Current cannot change instantaneously across an inductance (and both large conductors and large machines are inductive)

Asymmetrical current can be broken into both a purely symmetrical AC component and a purely aperiodic DC component. The AC component is symmetrical about the y-axis. The DC component is exponentially decaying with a time constant proportional to X/R. The initial magnitude of the DC current depends on the time of occurence due to the closing phase angle determined by the offset from the zero-crossing of the voltage waveform and the system phase angle, $$\theta=\tan^{-1}(X/R)$$.

![A basic asymmetrical current waveform]({{"/assets/latex/asym-current/asym-current.pdf"}})

The asymmetrical waveform is the sum of the DC and AC components. In a true power system, it must start from zero as shown.

## Case: Inductive System, $$X>>R$$, $$\theta \approx 90°$$

### Conditions for Maximum DC Offset

The worst case is for a fault occuring near a zero-crossing of the voltage where the _closing angle_ $$\alpha=0$$). At this point the current is at a peak, and so an opposing DC current of the same magnitude will be induced. The asymmetric current will then increase until a point when the current sine wave is lagging the voltage by 90°.

[//]: Todo Figure

$$ i_{ac}(t) = \sqrt{2} I_{ac} sin(\omega t + \alpha - \theta) $$

$$ i_{dc}(t) = I_{dc} e^{-\frac{\omega R}{X}t} $$

Here we can see the RMS value of the symmetrical waveform, $$ I_{ac} $$, and the starting value of the DC component, $$I_{dc}$$. Having no DC voltage to maintain it, the DC component decays with a time constant $$ \tau=\frac{X/R}{\omega} =\frac{L}{R} $$. Usually the system X/R value is given, where a larger value will cause a slower decay. IEEE/IEC standards use X/R $$=$$ 17 ($$\tau =$$ 45ms or ~2.7 cycles), which is an expected value near a distribution breaker, but X/R > 50 is not uncommon for a large generator[^2].

Since current cannot change instantaneously in a power system, the range of the maximum DC offset is

$$
i_{asym}(t=0)=0 \\
\Rightarrow i_{dc}(0) = -i_{ac}(0)  \\
-\sqrt{2}I_{ac} \le I_{dc} \le \sqrt{2}I_{ac} \\
$$

In general, for a asymmetric sinsoidal wave with a DC offset of $$A_0$$ and a purely symmetric **peak** of $$A_1$$, the RMS value is equal to[^3]

$$ u_{RMS} = \sqrt{A_0^2 + \frac{A_1^2}{2}} \\
= \sqrt{A_0^2 + A_{1,RMS}^2} $$

thus the maximum RMS value that the asymmetric fault current can obtain is

$$ \displaystyle I_{max, asym} = \sqrt{(I_{dc}^2 + I_{ac}^2)} \\
= \sqrt{3} I_{dc} \\
= 1.732 \times I_{dc} \\
$$

Since in reality the DC component will decay during the first half cycle before the asymmetric current reaches its peak,

$$ I_{max,asym} \approx 1.6 $$

### Conditions for No DC Offset

Conversely, for no DC offset in this inductive system, if the fault occurs at a voltage peak (zero current crossing), since the closing angle is equal to the system angle, no offset will develop.

In fact the full asymmetrical waveform based on the closing and system angle is 

$$ i_{asym}(t) = \frac{V_f}{Z_f}(sin(\omega t+\alpha-\theta)-sin(\alpha-\theta)e^{-\frac{\omega R}{X}t}) \\
\alpha=\theta\approx 90°\Rightarrow i_{asym}(t) = \frac{V_f}{Z_f}(sin(\omega t)-0) $$

[//]: TODO Figure

## Case: System with Resistance Included

$$ i_{asym}(t) = \sqrt I_{ac} (sin(\omega t + \alpha - \theta) - sin(\theta t e^{-\frac{\omega R}{X}t)) $$

Including the component in front of the DC term since previously $$ sin(\theta=90°)=1 $$.


## Equation & Curve of Asymmetric Factor

The Asymmetry Factor, $$ \kappa $$, can be used to calculate the total asymmetric current from just the symmetric current and the X/R value of the system.


$$ \kappa := \frac{I_{asym}}{I_{ac}} \Rightarrow I_{asym} = \kappa I_{ac} $$

$$ I_{RMS, asym} = \sqrt{I_{dc}^2 + I_{ac}^2} \\
= \sqrt{(\sqrt{2}I_{ac}e^{-\omega tR/X})^2 + I_{ac}^2} \\
= I_{ac} \sqrt{1+2e^{-2\omega t R/X}}
$$

$$ \kappa(t,X,R,\omega) = \sqrt{1+2e^{-2\omega t R/X}} $$

And taking $$t=\text{half cycle}=1/120s $$ since the peak value of the asymmetric current occurs at this point ($$f=60Hz$$),

$$ \kappa(X,R) = \sqrt{1+2e^{-2\pi R/X}} $$




### References
[^1]: Zocholl, Stanley E., _Analyzing and Applying Current Transformers_.

[//]: [^2]: TODO: Generator X/R Citation

[^3]: <https://masteringelectronicsdesign.com/how-to-derive-the-rms-value-of-a-sine-wave-with-a-dc-offset/>