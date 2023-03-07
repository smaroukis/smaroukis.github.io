---
title: "Solar Calcs and Battery Sizing for Off-grid Campervans"
excerpt: "Example energy yield using PVWatts"
categories: [engineering, power systems]
tags: [writings, van, electrical-engineering, energy-calculations]
math: true
img_path: /assets/img/
image:
  path: batteries.png
---

I wanted the van to be as fully electric as possible. Electric cooking, heating, and hot water, in addition to the other loads on the system — is it possible at a reasonable price?

Solar and battery technology has become widespread and cheaper year over year in the past decade. I don’t think a fully electric powered RV or Van would have been possible 10 years ago. But with the markets needs for deep and fast discharging batteries ( for electric scooters, motorcycles, bikes, and more) and the price of photovoltaic cells continually decreasing, such as system is possible today.

## TL;DR

See the full van build over at <https://van.maroukis.net>.

We ended up going with a **2kW [inverter](https://amzn.to/2Nlui2U)**, **380Ah of DIY LiFePo4** batteries ([these batteries](https://www.aliexpress.com/item/4000305763153.html) + this [battery management system](https://www.aliexpress.com/item/4000425316662.html?spm=a2g0s.9042311.0.0.13424c4dniwDm3)), **600W of solar** (2 of [these solar panels](https://www.renogy.com/300-watt-24-volt-monocrystalline-solar-panel/)) a **100|50 Victron Solar Charge Controller** and a **60A Sterling B2B1260 DC-DC charger**. Non-electric systems include hot water heater (hydronic with 120V backup) and gasoline fired heater to minimize load consumption while requiring no additional fuel source.

| Component | Cost |
| --- | --- |
| LiFePO4 Batteries & BMS | $1600 |
| Solar Panels | $600 |
| B2B/Alternator Charger | $400 |
| Solar Controller | $325 |
| 2kW Inverter | $240 |
| **Total Cost of Main Components** | **$3165** |

To be honest, **if you want a hassle free system where you don't have to do load calculations, troubleshoot phantom loads, and maintain battery integrity, just use a gas stove and a few hundred watts of solar panels**. When you add more components you add more points of failure, but doing the design and calculations is half the fun of it when you build your own system.

You're definitely spending and extra $1-3k by going full electric, but you'll have a system that is dependent on less fuel sources and better for the environment.

## Sizing & Components

**Inverter**

-   2kW is needed to supply for the maximum 1800W (15A at 120V) of the NEMA 5-15R 15A receptacle common to households. This allows us to run any power tool or other normal appliance that I would need.

**Solar**

-   600W can harvest around 150Ah per day, so it should take 2-3 days to top off the system from fully depleted. The B2B charger was added for quick top offs or multiple winter days without sun.

**Batteries**

-   LiFePO4 batteries can be fully discharged without greatly impacting their life so the 380Ah is all usable capacity. With my loading this gives us 1.5 days to go without sun or driving, or I can reduce my loads, cook on a camp stove, etc. They have other benefits such as a high discharge/charge rate, able to be stored for long times without a float charge, but the main drawback is price.
-   By buying the batteries from the source and putting it together I saved about $1k and learned a bunch about battery chemistry in the process.

**B2B/Alternator Charger**

-   60A is the maximum I would recommend for the stock 150A Transit alternator. Going up to a 120A charger I would opt for a second alternator [from nations](https://www.nationsstarteralternator.com/11271-300XM-High-Amp-Alternator-for-Ford-Transit-p/transit-11271-300-xm.htm) preferred over the heavy duty alternator upgrade from ford, to avoid the increased wear on the alternator used for the van internal electricals (you're pretty much stranded if one of these fails, I've experienced it).
-   In reality the right charger depends on your battery chemistry. LiFePo4 batteries can be charged faster, but it is best to take advantage of this with a higher output charger, between 0.3 and 1C of the battery. For Lead Acid you must stay under 0.3C. [source](https://www.power-sonic.com/blog/how-to-charge-lithium-iron-phosphate-lifepo4-batteries/)

> Always think of the worst case. For a 100W solar panel what is the worst case for your battery sizing? (A: smaller output is worse case, leaving us stranded with no power, use 4W=1Ah for battery sizing). For the same solar panel what is the worst case for your solar charger sizing? (A: overloading the charger, so use the provided short circuit current x 1.25 for a safety margin).

## Induction Cooktop Loads

**Breakdown of Common Loads at 12Vdc (120V loads include 15% inverter inefficiency)**

| Device | Daily Consumption @ 12V |
| --- | --- |
| Induction Stove | 60Ah ① |
| Fridge | 50Ah |
| Desktop Computer | 50Ah ② |
| Air Heater | 20Ah ② |
| Laptop | 12Ah x 2 |
| Roof Fan | 6Ah |
| Lighting | 4Ah |
| Water Kettle | 5Ah |
| Small Loads | 10Ah total |
| **Total** | **180-230Ah (worst case)** |

① includes 85% efficiency factor of inverter
② optional loads are desktop and air heater

**Breakdown of Induction Cooktop Loads**

| Meal | Consumption at 12V |
| --- | --- |
| Coffee / Tea (Boiling Water) | 6Ah |
| Fried Egg Breakfast | 15Ah |
| Stir Fry Dinner | 48Ah |
| **Total** | **59Ah** |

At this point I knew I could only fit 700W of solar on the roof (=175Ah / day, see section below) so I would be in need of another charging source especially for winter or multiple rainy days. Since I didn't want to go with an upgraded or secondary alternator I would limit it to a 60A charger. I ended up going with the gasoline fired air heater (Webasto) and a hydronic water heater (Isotemp) to give myself ample space on the electric load front. Also these systems were cheaper and easier to install (and maintain) then a $4k combined hydronic + air heating system. But by using the existing coolant lines for the hydronic heating and the existing gasoline tank for the air heating I was pleased not to add another fuel source into the mix.

**Key Points**:

-   **Battery chemistry is important as it affects the usable capacity and charge/discharge rates → know your requirements before you start looking**
-   **Size for 1.5-3x your worst case Ah load, depending on your generation sources (solar, alternator, etc.)**

The first thing we do is size the battery system, since that is what will using to deliver power to the loads (with other power sources there to top of the batteries every day). This sizing is highly dependent on battery chemistry.

I'm not going to get it to the gritty details of battery chemistry and charge acceptance. The most important thing is that **some battery chemistries can only** **be taken down to 50% state of charge (SOC).** So if you have a 500Ah battery you only get 250Ah of **usable capacity**. Discharging it lower will dramatically reduce the lifetime of the battery, the effect depending on the specific chemistry and how often and how low you cycle it. My use case was a fully off-grid, mostly electric camper van, able to go weeks off the grid, mostly on solar but with alternator "top offs" as needed, so I chose Lithium Iron Phosphate. The main reasons I picked LiFePO4 are:

-   can discharge the full capacity (others only ~50% → results in more batteries → more weight)
-   high discharge rates. I am able to power a 2000W inverter with just 1 190Ah LiFePO4 battery (in case one fails)
-   high charge rates: with a heavy duty alternator you can pump 100-200A and top these babies up in an hour.
-   can last a lot longer if you take care of them properly (similar to the first point) → good investment the longer you keep them
-   community of DIY's online using this chemistry with a supporting ecosystem of Battery Management Systems (BMS's)

Note that **you need to match any charger that you buy with the chemistry of the battery that you're using**. Lead Acid has a different charging profile than LiFePO4 has a different charging profile than AGM. The cells have different voltages that they can withstand, and different charge/discharge ratings (0.1C, 0.2C, etc) they can deliver. Most sophisticated chargers can be programmed to use any of these profiles.

> **My rule of thumb for battery sizing is 1.5 to 3 times your worst case scenario Ah loading.**

For me my worst case loading was 230Ah and I could only find 190Ah cells so I ended up with two of them for a total of 380Ah or 1.65x my worst case loading. If I was entirely dependent on solar I would lean toward 3x or even more, depending on where you live.

Note you can't just take a 60A battery charger and say that it can charge a 120Ah battery in 2 hours. See the graph above -- the charging amps drops off after a certain time (the chemistry can no longer accept as much current at a certain SOC), so it might take 2.5 to 3 hours in total to a full state of charge (again, depending on battery chemistry).

_Side note: I bought individual cells from a Chinese supplier with distribution in the States, hooked them up in series, then slapped a third party BMS with a mobile app for monitoring, balancing and cell protection. Each DIY battery cost  $800 with the BMS added, compared to the $1300 that Renogy offers ($1900 for Battleborn). What's more ? **You can get them used for even less**, just make sure to balance them and you're good to go. Batteries may be the most expensive part of the electrical system but if you're willing to put in some DIY time you can have a great system on the (relatively) cheap. See the Pro Tips section for resources._

Now, how do we make sure we can replenish the batteries?

## Solar Sizing

**Key Points**:

-   fit as many **rigid** solar panels as you can on your roof
-   4W of solar = 1Ah harvested per day.
-   you will only ever generate a maximum ~70% of the solar panel nameplate (70W on a 100W panel)
-   for solar as the sole generating resource, the minimum PV size in Watts = Useful Battery Ah \* 2.4 (for a 12V system)

For vans it is common to put anywhere from 150W to 1000W of solar on the roof. For example, a 1000W system would take up the whole roof of an extended length transit or a 170” wheelbase Sprinter. Most people if they’re not using an electric stove will only need max of around 300W. When you start to add heating, cooking, and hot water to the system you start to need over 500W.

First of all we need to understand the limitations of solar. Unfortunately if you by a 300W solar panel you will never get 300W out of it. You will only get ~70-80% of that **maximum** depending on weather, your system efficiencies, the angle at which the sun hits the panels, etc. A great resource is the National Renewable Energy Laboratory solar calculator [PVWatts](https://web.archive.org/web/20211020220617/http://pvwatts.nrel.gov/), which uses historic locational weather and irradiance data to predict your solar output for _each hour over a historically represented year_. For example here is the results of my 600W flat mounted (tilt=0), high efficiency (premium) solar cells for January in San Diego, CA:

![[Solar Calcs & Battery Sizing for Off-grid Campervans-1675217558801.jpeg]]

600W system, tilt=0, premium cells located in San Diego, CA. Top top bottom is January to December for each hour.

The graph shows the average and maximum power output, for each hour of each month. For example the average output at 9AM in January for this system is 99W or about 17%. The maximum output that the system reached in January was 262W at noon, or 44%. The absolute best production for this system is in June peaking at 511W/85% at 11AM (the average for this hour was 446W/74%). Which leads us to our first rule of thumb

> **Most panels will only produce 70% of their nameplate in full sunshine**

Looking at Watts makes it clear that you’re never going to get the nameplate out of your system. Also, we need a better way to estimate our _energy_ output (in Ah or Wh). Below we can see the average daily Amp Hour output for each month (at 12V DC).

![[Solar Calcs & Battery Sizing for Off-grid Campervans-1675217595168.jpeg]]

Same 600W system, the daily Ah output (aggregated over all hours, averaged over the month) 

On any given day in January, the system will produce between 120-150Ah. In June the system will produce around 300Ah. Since this can vary with the weather and bad weather comes in bunches, **a good rule of thumb is that each 4W of solar is able to harvest 1Ah a day.** This does **not** mean if you have 100Ah of batteries you need 400W of solar, since your batteries should be sized for more than your worst case **load**.

Note in the graph that 150Ah is near the minimum for the summer and near the average for the winter, so it looks like our system will be easily able to beat this rule of thumb, since we are located in sunny San Diego.

> **Rule of thumb #3: Each 4W solar is able to harvest 1Ah per day**

I would recommend fitting as many solar panels as can fit on your roof if you are using an electric stove. Otherwise you can use the approximate sizing as follows (note this is for a solar only system, and results will vary by where you live)

**100% Solar powered solar size (Watts) = Useful Battery Size (Ah) \* 2.4**

Note that we're using Useful Battery Size, which is 50% of nameplate capacity in the Lead and AGM case (100% in LiFePO4)

If you mix and match panels you will need to look at using multiple charge controllers, so it is best to stick with multiples of the same panel.

**Examples of System Sizing (Solar Only)**

| Battery Size | Battery Voltage | Solar Size |
| --- | --- | --- |
| 100Ah | 12V | 240W |
| 200Ah | 12V | 480W |
| 300Ah | 12V | 720W |
| 150Ah | **24V** | 720W |
| **380Ah** | **12V** | **912W** |

In out case we have 380Ah of batteries but you'll notice that we only have 600W of solar. 900W is a lot to fit on a roof, and we don't actually need that much if we can supplement the rest by charging from the alternator. It is a good idea to have a backup generating source anyway, so the alternator charger covers both the residual needed to top off the batteries during inclement weather AND provides a backup source if the solar panels get damaged (we call this the N-1 condition in power systems terms).  

> Engineering tip: Think of your system in terms of N-1. Pick a component and hypothesize it failing. What happens to your system? Can you still charge your batteries? Do you overload your batteries? You don't need to cover all cases, but it could make you think about bringing a backup gas camping stove if you only have one power source for your induction cooktop.

### Aside: Solar Charge Controllers

Solar Charger Controllers (SCCs) are used to optimize your solar output. They are the musical conductors of the performing electrons, working to optimize the power output from the solar panel(s). Choose the SCC based on the maximum current and voltages of the panels. These are found in the panel manufacturer's spec sheet as _Voc_ (open circuit voltage) and _Isc_ (short circuit current). These are the max voltages and currents that our panels can produce, although when sizing the charger it is good to use a safety factor of 1.25 due to variations like increased voltages from decreased panel temperatures and higher irradiance than the test conditions.

For me I connected (2) 300W solar panels in _parallel_, so the voltage is just the Voc=39.8V of one panel, but the current was 2xIsc = 9.78\*2 = 19.56A. So I needed at 50V | 20A charger, and the one I choose ended up being much larger, a 100V|50A charger from Victron.

Getting technical, NEC 690.9(A) doesn't require fusing for parallel connect strings **if** the wire ampacity > 1.56 Isc.

My expected max output from the charger is a max of I=P/V = 70% \* 600W / 12V = 35A at 12V minus inefficiencies of the system and charger, so I would size my battery-side fuse for around 40A and use 6 or 8AWG wire.

**SCC written as 100|50 ⇒ can handle up to 100V & 50A** from the _solar side_. Output (_battery side_) will be at 12V, Output Amperes equal to I=P/V minus some losses from the charger.

## Lastly: B2B or Alternator Charger

The battery to battery charger is becoming more standard in van and marine applications due to smart alternators and more complex charge profiles required by e.g. LiFePO4 batteries. Similar to a SCC these coerce the best possible voltage and current out of the starter battery (which is directly connected to the alternator, so I use alternator charger and battery charger interchangeably). This way they're able to reach higher charging currents than normal isolators, as well as overcome some of the unfortunate limitations of newer computer-controlled alternators on newer cars and vans.

Newer van models have regenerative braking systems (sometimes called Euro 6) which [affects the output voltage of the alternator](https://www.12voltplanet.co.uk/auxiliary-battery-charging-in-vehicles-with-smart-alternators.html), causing it to dip below 12V in some cases. When braking, the ECU boosts the alternator's voltage for an increased mechanical load (assisting with braking), and this increased voltage in turn dumps current into the starter battery. Afterwards the alternator voltage is reduced to 12.5V or even lower (usually it runs at 13.8 - 14.2V) so that the battery is the main source for the van's loads, thus taking mechanical load off of the engine (better fuel economy) and leaving headroom for the cycle to start over again (the starter battery sits at around 80% to accept the current dump from the alternator at a moments notice)

Demonstration of voltage excursions (blue) for smart alternators over time. Compared with older alternators which keep a constant ~14.8V output, the smart alternators periodically reduce voltage to improve fuel economy. Source: [https://redarcelectronics.com/pages/faqs](https://web.archive.org/web/20211020220617/https://redarcelectronics.com/pages/faqs)

This jumping around in voltages is not good when we're trying to charge our batteries on a specific charge profile. To charge our house batteries we want the alternator voltage to be higher. In fact, some DC-DC chargers may shutoff if the alternator voltage goes below 12.7V.

**Reasons to use a Battery to Battery charger:**

-   current limiting, increases the lifespan of your alternator
-   most models work with smart alternators, they won't trip off at lower than expected alternator voltages (<13V - read the manual for more info)
-   output voltage profile to match battery chemistry and maximize charging (can boost voltage from an alternator to meet LiFePO4 requirements)

**Other gotchas!**

**Case**: BMS disconnects batteries while charging → alternator tries to dump the current into infinite resistance → large voltage spike → damage to internal diodes of alternator

**Remedy**: 1) Don't charge at 100% SOC or 2) have a signal from the BMS to the charger to disconnect safely. I don't think this is a huge issue since the alternator can dump current into the "starter" battery → there is no actual open circuit which would cause the back emf.  

**Case**: Alternator tries to dump as much current as possible into low impedance LiFePO4 batteries, causing overheating and failure of the alternator:

**Remedy**: 1) DC-DC charger or current limiting device or 2) alternator temperature sensor (preferably both)

**Other options:**

-   battery isolator (specifically for LiFePO4): this prevents your house battery draining your starter battery, but has drawbacks including: **(1) unregulated current**, if high enough could damage your alternator (some use a on/off duty cycle to give the alternator a chance to cool, or an external alternator temperature sensor for a safety shutoff); **(2) unregulated voltage** may not be high enough to charge LiFePO4 to 100%. Note that at lower alternator speeds (where current is fixed by the load) the alternator will _get hotter_ since the fans will not spin as fast. This could be dangerous in stationary applications. The one pro of some isolators is **they allow you to jump start your starter battery** with your house battery.
-   "alternator" chargers: you'll see Sterling sell some of these, apparently they don't have current limiting hardware since they came out before Lithium got popular, so I'd avoid these unless you find a good deal and know what you're doing

## **Final Checks**

-   Battery Ah allows you to run without sun for ~2 days.
-   Inverter power is greater than the max load plus some wiggle room
-   Minimum solar size = Useful Battery Ah \* 2.4 (or alternatively add in another charging source like an alternator charger)
-   SCC can handle the combined (summed) **open circuit** voltages of the series panels :  $V_{SCC} \ge 1.25 \times (V_{oc,1} + V_{oc,2})$
-   SCC can handle the combined (summed) **short circuit** currents of the parallel panels $I_{SCC} \ge 1.25 \times (I_{sc,1} + I_{sc,2})$ (here I substituted short circuit for load current since it is close enough in the datasheet, but check yours)
-   Solar Charger Output Amps Maximum < Battery Bank Maximum Absorption Current (usually ~1C, so 100A for a 100Ah battery)
-   Fuse Sizing > 1.25 x Max Continuous Load (for devices see spec sheet)
-   Fuse Size ≤ Wire Ampacity with deratings applied (bundled conductors, high temperatures, etc.)

> Last Tip: Create the system in a way that is expandable (use larger than necessary AWG), charge controller, etc. This leaves rooms for upgrades in the future.

### Further Notes & Pro Tips

-   The solar panels are actually for 24V systems (38.8Voc), so I could not find a dual battery/alternator and solar charger for the 24V solar and the 12V starter battery/alternator, which would've simplified and reduced the price of the install.
-   For systems that require more than 200A or 2400W **peak** (normally designed with solar > 700W and batteries > 400Ah) it may be economical to use a 24V low voltage system (24V batteries, chargers and loads). Note that a DC-DC converter will needed to be used for any 12V lighting, pumps etc. Part selection will become more limiting, but many some loads are designed to run on both 24V and 12V.
-   Some newer laptops with USB-C can charge via this port. By looking at the charging requirements of your laptop you can find a 12V USB-C charger like I did, bypass the **two conversion** inefficiencies and charge straight from the sun! (No wait, the solar cells are at 36V... but you get what I mean). What else can you find 12V power for? For desktop PC builds the Small Form Factor reddit has some ideas.
-   DIY LiFePO4 battery resource: Will Prowse's YouTube Channel and the DIY Solar Forum
-   LiFePO4 batteries should be stored at 50% SOC if e.g. winterizing. Just bring them back up to 100% when you're ready to use them within a year. If leaving sitting for longer than a year, well, you need to sell your van man!
