---
layout: post
title: Distribution Autotransformers -- Configurations, Fault Analysis and Model Verification
excerpt: Protection considerations for connecting distribution voltage level power systems together with autotransformers.
categories: [engineering, power systems, transformers]
tags: [technical, power systems]
katex: true
img_path: "assets/img/2019/autotransformer"
---
{% capture imgs %}{{site.url}}/{{page.img_path}}{% endcapture %}
[//]: MEDIA

[auto-sld]:{{imgs}}/auto-sld.png
[three-legged-core]:{{imgs}}/three-legged-core.png
[five-legged-core]:{{imgs}}/five-legged-core.png
[auto-three-terminal]:{{imgs}}/auto-three-terminal.png
[auto-sequence-networks]:{{imgs}}/auto-sequence-networks.png
[auto-fault-flow1]:{{imgs}}/auto-protection1.png
[auto-fault-flow2]:{{imgs}}/auto-protection2.png

In this post I'll talk about tying different level distribution systems together with autotransformers and walk through the fault analysis of different tertiary and grounding configurations.

1. TOC
{:toc}

# Construction and Use Cases

Autotransformers ("autos") are a special type of transformer that have their primary and secondary windings electrically connected, allowing for cheaper construction in certain cases but losing the electrical isolation that normal two or three-winding transformers have.

On the distribution power system they are usually pad-mounted three-phase transformers used to connect two disparate distribution voltage levels together (e.g. 12kV to 21kV). This could be the result of a voltage cutover (upgrade) or when two disparate sources come together over time from system expansion. 

The bushings are labeled as H1, H2, H3, X1, X2, X3, and H0-X0. H0-X0 is the neutral bushing for the wye connection which is brought out to connect to the system neutral (if available). For the ungrounded case it is left unconnected. On the nameplate you should see that for each phase there is a tapped winding which separates the coil into the high and low side windings. 

{% include img.html file="auto-sld.png" caption="Single phase schematic of an autotransformer" %}

## Winding Configuration

[//]: TODO: nameplate of transformer

Three-phase autotransformers are normally connected in Wye with a Delta-connected tertiary that can be opened or closed depending on desired operation. This delta tertiary allows for zero-sequence fault currents to flow so that source side protective devices can operate and isolate the faulted section, otherwise the fault duty may be too low for protective devices to detect the fault. The specific fault duty depends on

- the system design (3 wire or 4 wire)
- the delta tertiary switch status
- if the H0-X0 bushing is grounded or ungrounded.

Additionally the delta tertiary acts as a stabilizing winding for unbalanced voltages and a path for third harmonics. Specific protection schemes will be explained in detail in the [Protection](#protection-of-distribution-autos) section.

[//]: TODO link to why delta connections do not pass third harmonics

## Virtual Tertiary and Zero Sequence Flux Paths

Just like an imbalance of line currents results in a neutral or zero sequence current, the imbalance of flux in a magnetic core can result in a zero sequence flux. This happens during unbalanced conditions like a single phase-to-ground fault, load imbalance, or neutral shift. For three-phase core type transformer construction there is no return path for zero sequence flux, so the flux must return outside the core which can lead to severe tank heating[^c57-105]. This return path is known as a virtual, phantom, or tank tertiary.

{% include img.html file="three-legged-core.png" caption="In the three-legged core (esp. without a tertiary), there is no return path for zero sequence flux. This flux, resulting from single phase faults or voltage imbalance, is forced to return via a high reluctance path outside of the core and can cause heating in conductive material such as the tank. The high reluctance path is known as the 'virtual tertiary'" %}

To provide a path for zero sequence flux and limit any tank heating during unbalanced conditions, the preferred construction is four or five-legged cores. Note that per IEEE C57.105

> Adding a third winding (tertiary) of a substantially lower power rating and connected Δ reduces the zero-sequence exciting flux by reducing the level to which zero-sequence voltage may rise, but **does not prevent flux from entering the tank**.

{% include img.html file="five-legged-core.png" caption="A five-legged core construction for a three-phase transformer provides two return paths for zero sequence flux." %}

The economics of auto's usually results in a turns ratio near 2:1. That's why they are used on both Transmission and Distribution levels to tie e.g. 230kV and 115kV together, or 12 and 21kV circuits together. 

An interesting fact is that if you took an existing single phase transformer and turned it into an autotransformer by connecting its primary and secondary windings, you would increase your kVA rating of the transformer. This is due to the fact that not all the current needs to flow over both windings. Using the ideal transformer equation $$V_2/V_1=N_2/N_1$$ and with $$N_1=N_C+N_S$$ we can solve for the power that is in common winding, $$P_W$$ versus the input and output power, $$P_{IO}$$.

$$
\begin{aligned}
    V_L&=V_H\frac{N_C}{N_C+N_S}  \\ 
    P_W&=I_S(V_H-V_L) \\
    &= I_S V_H(1-\frac{N_C}{N_C+N_S}) \\ 
    &= P_{IO}(\frac{N_S}{N_C+N_S})  \\ 
    & \therefore P_W < P_{IO}
\end{aligned}
$$

# Protection of Distribution Autos

The type of system-tie transformer can greatly affect the protection scheme of the distribution circuit. Here we will focus only on Wye connected autos. Note there is only really one (tapped) winding, so there is only one configuration (Delta or Wye) plus a tertiary if available.

## Three Terminal Equivalent

The three terminal equivalent model is used to convert the multi-winding impedances ($$Z_{HL/HT/LT}$$) to branch impedances ($$Z_{H/L/T}$$) which is used in the zero sequence network for fault analysis. 

{% include img.html file="auto-three-terminal.png" caption="Three terminal equivalent where H, L, and T are high, low and tertiary windings respectively." %}

The branch impedance of one winding is equal to the sum of the adjacent minus the opposite, divided by two. For example:

$$Z_H=\frac{Z_{HL}+Z_{HT}-Z_{LT}}{2}$$

## Sequence Networks

A Wye-grounded auto without a tertiary will have the sequence network impedance of just the primary-to-secondary winding for both the positive and zero sequence. Grounded autotransformers with tertiaries (and even without, due to the virtual tertiary) create a zero sequence source of current. Ungrounded autos without a delta tertiary, or with the tertiary switch open, are essentially an open-circuit to zero sequence impedances and are not recommended due to the difficulty of fault detection. Ungrounded autos with a delta tertiary pass un-transformed zero sequence current. 

{% include img.html file="auto-sequence-networks.png" caption="Sequence networks for autotransformers 1) Wye-grounded without tertiary (or with tertiary switch open) 2) Wye-grounded with delta tertiary and 3) Wye-ungrounded with delta tertiary." %}

The nameplate usually gives the positive sequence impedance for $$Z_1^{HL}$$ and the zero sequence values as shown above (HL, HT, LT). In modeling it is usually assumed that the negative sequence impedance is equal to the positive.

[//]: TODO Table of common values for impedances

## To Ground or Not to Ground? Connections for 3 and 4 Wire System Interties

How to choose what protection is required? It will be based on the fault analysis, which is based on the configuration and grounding of the auto. Let's walk through some common scenarios when connecting two systems of different voltage levels together.

Note in the cases we are assuming a 4-wire multi-grounded system and a 3-wire system grounded at the substation only[^ca-system]. Of course even in the "ungrounded" case (uni-ground at the substation), there will still be grounds on the tank and equipment. "Grounding" the transformer means connecting the H0/X0 bushing to the neutral wire and establishing an effective ground.

Although it will be most common that the autotransformer can be fed from both directions (dual-source), it will help to first investigate the radial case to understand the configuration's effect on fault currents.

### Single Source Scenarios (Radially Fed)

These are radial connections where there is no chance of reverse feeding the transformer.

_3-wire system sourcing a 4-wire system_

- The 3-wire system is grounded only at the substation, but the 4-wire system is grounded at many points along the primary. **Since we are sourcing a 4-wire multi-grounded system we must ground the auto.** Closing the tertiary will help stabilize voltages and provide a path for zero sequence current. **This introduces a source of ground current** so a gang-operated source-side protective device should be used to interrupt the auto feeding *upstream* faults. Also there must be no open delta regulators on the 3-wire side since off-neutral taps will shift the neutral point and could cause sensitive ground relays to false target.**⇒ grounded + closed tertiary + source-side protection**

_4-wire system sourcing a 3-wire system_

- Since our 3-wire system is an ungrounded primary we don't necessarily need a ground (protective elements can operate on residual currents), we can unground the autotransformer so it is not a ground source. **For the ungrounded case we must have a closed tertiary to pass zero-sequence currents**. This is a special technical case for fault analysis — the current does not flow across the common winding and thus is not transformed. The zero sequence impedance used is a calculated value called the series-to-tertiary impedance. **⇒ ungrounded + closed tertiary**
- Note that if we had a large generator downstream we would want to ground the transformer.

_3-wire system sourcing a 3-wire system_

- Similar to the 4-wire → 3-wire case **⇒ ungrounded + closed tertiary**. In this case there is no reason to ground since the source system is only grounded at the substation.

_4-wire system sourcing a 4-wire system_

- Clearly we will be **grounded** since we have two multi-grounded systems. But what about the tertiary? We should **open the tertiary** so that we don't introduce a ground source. The auto still passes zero sequence currents since it is grounded. **⇒ grounded + open tertiary**
- note that in this case it is important that we have a four or five legged core to have a zero-sequence flux return path for any unbalance or fault conditions

#### Radial Protection Summary Table

| Source → Load | Grounding  | Tertiary | Protection  |
|:--------------:|:----------:|:--------:|:-----------:|
| 3W→3W          | Ungrounded | Closed   | None        |
| 3W→4W          | Grounded   | Closed   | Source Side |
| 4W→3W          | Ungrounded | Closed   | None        |
| 4W→4W          | Grounded   | Open     | None        |

### Intertie Use (Dual Source)

This is the most common since it increases reliability by allowing for uninterrupted power delivery during normal or emergency system maintenance. The only difference for the dual source will be the mix of a 4-wire system with a 3-wire system (since 3W↔3W and 4W↔4W are the same as the radial case).

_4-wire ↔ 3-wire_

- Again, anytime we source a 4-wire system with a 3-wire system, we want to provide a good ground at the point of transition (the 4-wire system is already "grounded")  **⇒ grounded + closed tertiary + source side protection**

#### Intertie/Dual Source Protection Summary Table

| Source ↔ Load | Grounding  | Tertiary | Protection  |
|:--------------:|:----------:|:--------:|:-----------:|
| 3W↔3W          | Ungrounded | Closed   | None        |
| 3W↔4W          | Grounded   | Closed   | Source and Load Side|
| 4W↔4W          | Grounded | Open       | None              |


### Fault Flow Summary Diagram

The fault flow summary is shown in these two diagrams: 

![autotransformer fault flow diagram][auto-fault-flow1]

![autotransformer fault flow diagram][auto-fault-flow2]


Usually distribution autotransformers are located far from the substation, but for autos with a higher fault duty the engineer should check the protection clearing time is below the IEEE C57.109 transformer damage curve. 

### Further Reading

- IEEE Std C57.105 Guide for Application of Transformers in Three-Phase Distribution Systems
- IEEE Std C57.158 Guide for the Application of Tertiary and Stabilizing Windings in Power Transformers
- IEEE Std C57.109 IEEE Guide for Liquid-Immersed Transformers Through-Fault-Current Duration
- X. Zhang and A. Echeverria, "Three-Winding Autotransformer Fault Study and Impact on Protection Application", New York Power Authority. [Online]. Available: [https://www.eiseverywhere.com/file_uploads/a99e2aa556135afc2ea43c68303bd462_zha_pap.pdf](https://www.eiseverywhere.com/file_uploads/a99e2aa556135afc2ea43c68303bd462_zha_pap.pdf)

### Notes & References

[^c57-105]: IEEE Guide for Application of Transformers in Three-Phase Distribution Systems, Section 3.3.3 "Zero Sequence Flux"

[^ca-system]: These are the two most common setups in California. the 4-wire multigrounded system operates at a nominal 20.78 kV with most service transformers connected Line-to-Neutral (12.00 kV) and the 3-wire uni-grounded system operates at a nominal 12.00 kV with service transformers connected Line-to-Line.