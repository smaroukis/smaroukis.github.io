---
layout: post
title: Grounding Explained for the Masses (with Drawings!)
excerpt: An explanation of grounding and neutral conductors in the context of your own car and home.
categories: [power, grounding]
img_path: "assets/img/2020/grounding"
katex: true
---
{% capture imgs %}{{site.url}}/{{page.img_path}}{% endcapture %}

[//]: MEDIA
[water-analogy]: {{imgs}}/water-analogy.png
[gfci]: {{imgs}}/gfci.png
[ground-rod]: {{imgs}}/ground-rod.png
[nema5]: {{imgs}}/nema5.png
[nema5-panel]: {{imgs}}/nema5-panel.png
[split-phase-service]: {{imgs}}/split-phase-service.png

[//]: URLs
[nema5-link]:https://en.wikipedia.org/wiki/NEMA_connector#NEMA_5
[closed-loop-physics]: https://physics.stackexchange.com/questions/74625/does-alternating-current-ac-require-a-complete-circuit/74999#74999

So... about that third prong (or not).

Have you ever wondered why some power cords have a third prong and some don't? By popular request, today I will de-mystify the concept of Ground in household electrical systems. 

> Note: I will only be talking about single phase secondary service connections here, or the 120/240V  service commonly delivered to residential customers. For utility grounding systems, see my next post.

1. TOC
{:toc}

[//]: TODO link to utility grounding systems

## Definitions:
{:.no_toc}

**Ground**
: an intentional low impedance path connection to Earth 

**the ground**
: the literal soil

**Earth**
: the Mother of all living things; also an ideal sink for electrons such that no amount of current flow into the earth will create a voltage rise; used to establish a reference voltage

**Grounding conductor**
: a conductive path to Ground used in the case of an equipment failure. The conductive path allows protection equipment to operate and disconnect the failed equipment. Known as EGC — equipment grounding conductor — in the National Electric Code (NEC).

**neutral conductor**
: a system conductor other than a phase conductor that provides a return path for current to the source. Used for single phase and line-to-neutral connected loads to provide a return path to the source.

## Electricity Fundamentals Through Analogies

> Electrons don't necessarily flow; instead, energy moves through them like a travelling wave. When I talk about electrons or current "flowing" from one source to another, I'm really talking about is energy being transported by electrons bumping into one another. I won't even mention conventional current. Now forget this and let's move to the classic water analogy. 

**Think of electricity as water**, flowing from a high potential to a low potential. Voltage is a measure of the *force* that the electricity has. Current is a measure of the *rate of flow*. At the highest voltages even an insulator such as air will break down and allow charges to flow across it (lightning). At higher currents conductors melt. Higher voltages will ”push” higher currents since 

$$V=IR$$

where R is the resistance of the conductor and I is the current flowing over said resistance.

![water-analogy]

> Notice the difference between transmission towers (the metal structures beside the highway) and distribution lines (the wooden poles outside your house). The distance between the conductors and the tower is an indication of the voltage level.

**Why do we need a return path for current?** A circuit needs a closed loop from the power source to the load **and back** for electrons to flow[^closed-loop]. For single phase service, a metallic conductor called the neutral is provided as a return path for electrons.  

**What is more dangerous, current or voltage? "**Current kills", as the saying goes: as little as 1mA is the point at which you will let go because of pain and prolonged exposure to 20mA or more may be fatal[^electric-shock-data]$$^,$$[^dalziel].  Higher voltages will push more current through you. Although there is no **"**safe" voltage, Wikipedia and others mention up to 50V as being safe in normal (dry) conditions. 

## "Ground" as Demonstrated via Your Car's Electrical System

> Batteries provide DC voltage versus the AC voltage from your wall outlet, but the concept of ground is the same

Car batteries are 12V, so it is a safe way to experiment and learn the fundamentals. It also provides us a ready electrical system to play with. 

First you'll notice your battery has a positive (+) and negative (-) terminal. The (-) terminal is connected to the chassis of the car. This provides a common point for any other negative wires — since the chassis is metal, anything attached should be electrically connected. **The common point allows us to complete the circuit *anywhere in the car, without running a second wire back to the battery*.**

This common point for historical reasons is called "ground" (in your home, the common point is in fact connected to ground — the actual Earth). In a car, the metal chassis is used as both the return path and the reference point. Later we will see that home electrical systems have two return paths for different purposes.

If you have a 12V appliance you can connect it between the positive terminal and anywhere on the chassis and it should work. What if you connected it between the positive terminal of *your* car and the chassis of someone *else's* car? Since the cars are insulated from the pavement by tires, there is no way for the circuit to be completed and the appliance won't work. More info on car electrical systems can be found [here](https://www.howacarworks.com/basics/how-car-electrical-systems-work).

Taking this a step further, envision the whole of Earth's soil as a common point that you could, in theory, use as a return path if both the power source and the load were connected to ground[^swer]. In fact this is how it is used on utility power systems to trip protective devices during ground fault conditions.

[//]: TODO link to utility grounding systems

## The Three Wires in Your Home: Live, Neutral, and Ground

Starting with the most common receptacle in your wall, you'll notice three holes. This is a [NEMA 5][nema5-link] plug that has been common since the mid-twentieth century. The wider left slot connects to the neutral conductor and the right slot connects to the phase or hot wire. The U shaped is connected to the grounding conductor from which a connection to Earth is established by driving a "ground rod" into the actual ground near your main panel.

If you were to look at the wiring behind the receptacle, the ground wire would have green insulation, the hot would be red or black, and the neutral would be black with a white stripe.

![nema5]

### The Neutral

Normally current flows in from the phase conductor and back out the neutral. Both the grounding wire and the neutral wire are bonded to the ground rod at the main panel, but for different reasons. The neutral is grounded to provide a stable reference point (ideally 0 volts) and limit over-voltages on equipment during surges and lightning strikes. The grounding wire is used as an alternative (low impedance) path which completes the circuit during fault conditions. 

{% include img.html file="nema5-panel.png" caption="Tracing out the connection from a standard wall outlet to the main panel. Shown above, current normally flows in from the hot (red) and back out through the neutral (black). If the appliance fails internally or the housing becomes energized, the grounding wire (green) provides a path for current to ground, resulting in currents large enough to trip the circuit breaker." %}

### The Grounding Conductor

The ground plug is a safety measure in case the internal wiring of an appliance fails which could energize the appliance housing and cause an electrocution (the failure of the wiring and/or insulation is known as a “fault”). The appliance housing is connected internally to the ground prong which connects through the grounding wire back to the Earth at the main panel. If the applicance becomes energizes, the grounding wire diverts enough of the fault current allowing protective devices to quickly sense and de-energize the circuit. 

If we didn't have this grounding wire (called the effective fault path), the electrons may eventually make their way to Ground, but the impedance could be too high for our protective devices to sense the current.

Any metallic structure that could become accidentally energized will also be grounded for this reason.

Not all appliances require grounding, like when the 120V AC is converted to usable DC voltage right next to the outlet (phone chargers). Other appliances have extra insulation that would prevent the casing or wiring from being exposed.

A special type of receptacle located in kitchens and bathrooms is the GFCI ("ground fault current interrupting") outlet. These work on the principle that the current flowing on the "hot" wire should be equal and opposite the current flowing on the neutral. If any current unbalance is sensed, the receptacle immediately de-energizes the circuit. 

{% include img.html file="gfci.png" caption="A hot wire connected to water will cause a current to flow through the water and into the soil instead of back through the neutral. The GFCI outlet works on the principle that current on the hot must be equal to current on the neutral, else the current is undesirably flowing somewhere else (through a person maybe?). This device senses even micro-amps of current imbalance and immediately de-energizes the circuit." %}

### The Ground Rod

The ground rod at the main panel is the connection to Mother Earth (sustenance of all life forms), providing

* a return path to dissipate fault currents
* an infinite sink for lightning strikes and voltage surges, which protects equipment and human beings from dangerous voltages

The ground rod is also known as the grounding electrode. Installations try to minimize the soil-to-electrode impedance which is the main determining factor in the quality of Ground.   

Without proper Grounding, fault current will find its own path to Earth (an infinite sink for electrons), potentially damaging equipment and creating dangerous touch voltages.




{% include img.html file="ground-rod.png" caption="The more contact with the soil, the lower the impedance. The contact resistance between the rod and soil is high but due to the almost infinite number of parallel paths the Earth itself has a very low resistance. The impedance can be thought of as being contained within a few ''spheres of influence'' after a point which additional distance from the electrode adds no more appreciable impedance. Ground rods are usually driven at least 8 ft into the ground. " %}

## The 120/240V "Split Phase" Service

If we trace our electrical system back to the transformer, we should find two hots and a neutral. This is because the transformer bushing-to-bushing secondary is 240V, and a connection to the middle of the secondary winding gives us half, or 120V. So we have three connections we can make: L1-N is 120V. L2-N is 120V. and L1-L2 is 240V. The 240V service is used for heavier duty equipment such as dryers, water heaters and stoves, and has a different NEMA plug as well. 

![split-phase-service]

If we go back further to the lines on the utility poles, we see that our transformers is only on two out of three or four lines on the primary distribution system. This system is three phase and has its roots in the three rotating magnetic fields of large generators. 


## Further Reading

- [Mike Holt](https://www.mikeholt.com/instructor2/img/product/pdf/1292448885sample.pdf)
- [Does current flow back to the source through Earth?](https://physics.stackexchange.com/questions/71383/does-current-flow-back-to-the-source-through-earth)

## References & Footnotes
[^closed-loop]: Generally, due to displacement currents and capacitance, a physically closed loop with a metallic conductor is **not** required, but I'll let the physicists [prove that one][closed-loop-physics].

[^1]: How fast they flow, or the current, will depend on the material that the wire is in contact with (depending on the resistance, R), and the voltage being used (V), since I=V/R. They will flow fastest if the wire touches Ground (lowest R). 

[^swer]: This is actually done in rare cases to run a single wire out to rural customers, but is not allowed in most U.S. standards, see [https://en.wikipedia.org/wiki/Single-wire_earth_return](https://en.wikipedia.org/wiki/Single-wire_earth_return#Safety) & [GO-95 Rule 33.2](https://www.cpuc.ca.gov/gos/GO95/go_95_rule_33_2.html)

[^electric-shock-data]: [https://www.allaboutcircuits.com/textbook/direct-current/chpt-3/electric-shock-data/](https://www.allaboutcircuits.com/textbook/direct-current/chpt-3/electric-shock-data/)


[^dalziel]: Charles F. Dalziel, “Dangerous Electric Currents”, AIEE Transactions, August – September 1946, Vol. 65, pp. 579 – 585. [sci-hub.tw/10.1109/T-AIEE.1946.5059386](http://sci-hub.tw/10.1109/T-AIEE.1946.5059386)