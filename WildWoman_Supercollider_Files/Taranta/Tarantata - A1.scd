(
SynthDef(\brickWall,{
	|out = 0,wipeBus,aInBus, bInBus, wipeFreq|
	var in ,chain,wipeIn,aIn, bIn;

	aIn = In.ar(aInBus,2);
	bIn = In.ar(bInBus,2);

	in = [aIn, bIn];

	wipeIn = A2K.kr(In.ar(wipeBus,2));

	chain = FFT(LocalBuf([2048,2048]),in);

	chain = PV_BrickWall(chain, SinOsc.kr(wipeFreq));

	Out.ar(out, IFFT(chain));
}).add;


)

(

~wipeBus = Bus.audio(s,2);
~aInBus = Bus.audio(s,2);
~bInBus = Bus.audio(s,2);
~brickwall = Bus.audio(s,2);
~limbus = Bus.audio(s,2);
)
~brickwall.free;


(
t = TempoClock.new;
t.tempo_(70/60);
thisThread.randSeed_(1);

~dur = 0.125;
~brickwall1 = Synth.tail(s, \brickWall,[\outbus,0,\wipeBus,~wipeBus, \aInBus, ~aInBus, \bInBus, ~bInBus ]);
~brickwall2 = Synth.tail(s, \brickWall,[\outbus,0,\wipeBus,~wipeBus, \aInBus, ~aInBus, \bInBus, ~bInBus ]);

// ~limiter = Synth.tail(s, \limiter, [\outbus,0, \inbus, ~brickwall]);

// ~phase = Synth.tail(s,\fftPhase,[\outbus, 0, \inbus,~brickwall,\amp,2.0]);
~pulseOscA = Pdup(2,Pwrand([2.pow(-3),2.pow(-2)],({rand(1.0)}!2).normalizeSum,inf)).asStream;
~pulseOscB = Pdup(2,Pwrand([2.pow(-3),2.pow(-2)],({rand(1.0)}!2).normalizeSum,inf)).asStream;

~pulseOscASUS = Pdup(2,(Pfunc{rand(1.0)})).asStream;
~pulseOscBSUS = Pdup(2,(Pfunc{rand(1.0)})).asStream;

Pbind(
	\instrument, \pulseOsc,
	\dur,~pulseOscA,
	\sus, Pkey(\dur)* ~pulseOscASUS,
	\freq,50,
	\outbus, ~aInBus,
	\amp,1.0,
).play(t);


Pbind(
	\instrument, \pulseOsc,
	\dur,~pulseOscB,
	\sus, Pkey(\dur) * ~pulseOscBSUS,
	\freq,50,
	\outbus, ~bInBus,
	\amp,1.0,
).play(t);

Pbind(
	\instrument, \pulseOsc,
	\dur,~pulseOscA,
	\sus, Pkey(\dur)* ~pulseOscASUS,
	\freq,400,
	\outbus, ~aInBus,
	\amp,0.2,
).play(t);


Pbind(
	\instrument, \pulseOsc,
	\dur,~pulseOscB,
	\sus, Pkey(\dur) * ~pulseOscBSUS,
	\freq,400,
	\outbus, ~bInBus,
	\amp,0.2,
).play(t);


Pbind(
	\instrument, \whiteNoise,
	\dur,Pwrand([2.pow(-3),2.pow(-2)],({rand(1.0)}!2).normalizeSum,inf),
	\sus, Pkey(\dur)* (Pfunc{rand(1.0)}),
	\freq,50,
	\outbus, ~aInBus,
	\amp,0.1,
).play(t);


Pbind(
	\instrument, \whiteNoise,
	\dur,Pwrand([2.pow(-3),2.pow(-2)],({rand(1.0)}!2).normalizeSum,inf),
	\sus, Pkey(\dur) * (Pfunc{rand(1.0)}),
	\freq,50,
	\outbus, ~bInBus,
	\amp,0.1,
).play(t);

Routine({
	loop({
		~brickwall1.set(\wipeFreq,{rand2(0.01)});
		~brickwall2.set(\wipeFreq,{rand2(0.01)});
		~dur.wait.postln;
	});
}).play(t);
)



~brickwall.set(\wipeFreq,-0.25);

~limiter.set(\level,2);
