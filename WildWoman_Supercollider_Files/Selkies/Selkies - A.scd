(
SynthDef(\randcombFFT,{|outbus = 0, inbus, trig = 0.0, wipe = 0.0|
	var sig, chain;
	sig = In.ar(inbus,2);
	chain = FFT({LocalBuf(2048)}!2,sig);

	chain = PV_RandComb(chain,wipe: wipe, trig: Impulse.kr(trig));
	Out.ar(outbus, IFFT(chain));
}).add;

SynthDef(\brickwallFFTfilter,{
	|out = 0, inbus, wipeFreq|
	var in ,chain,wipeIn,aIn, bIn;

	in = In.ar(inbus);

	chain = FFT({LocalBuf(2048)}!2,in);

	chain = PV_BrickWall(chain, wipeFreq);

	Out.ar(out, IFFT(chain));
}).add;

SynthDef(\whiteNoiseSus,
	{
		|outbus = 0, amp = 0.2, pan = 0|
		var sig;

		sig = WhiteNoise.ar(amp);

		Out.ar(outbus,Pan2.ar(sig,pan));
	}
).add;





)

~randcombBus = Bus.audio(s,2);
~brickWallBus = Bus.audio(s,2);
~dur = 2;
~brickWallBus;

(
r = Routine({

	4.do({
		s.record(duration:30);
		~whiteNoise = Synth(\whiteNoiseSus,[\outbus,~randcombBus]);
		~randComb = Synth.after(~whiteNoise,\randcombFFT, [\inbus, ~randcombBus,\outbus,~brickWallBus, \wipe,0.50]);
		~brickwall = Synth.after(~randComb,\brickwallFFTfilter,[\inbus,~brickWallBus, \outbus,0,\wipeFreq,-0.8]);

		31.0.wait;
		~randComb.free;
		~whiteNoise.free;
		1.0.wait;

	});

}).play;
)

