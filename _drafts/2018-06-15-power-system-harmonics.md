---
layout: post
title: Harmonics in Power Systems
excerpt: ""
categories: [power systems engineering]
tags: [power systems engineering]
---


> Delta connected transformers will filter third order harmonics.

After coming across this a few times I wanted to find a source. In fact it was one of the most simple proofs, and probably was mentioned at one time in my power systems class.

It has to do with the phase angle shift caused by the $$k^{th}$$ harmonic component. 

First, we can represent the current waveform as a Fourier Series, which is an infinite sum of sinusoids that can be used to represent _any_ periodic function. 

$$ i_a(t) = \sum_{k=1}^{\infty} I_k sin(k\omega_1 t + \Theta_k) $$ 