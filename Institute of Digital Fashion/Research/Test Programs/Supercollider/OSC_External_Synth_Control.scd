(
//OSC communicatio between Processing and Supercollider
//Processing Mouse Input controls the creation and modulation of a 
//continuously running SynthDef.
//RIGHT CLICK in Processing window creates a new synth.
//LEFT CLICK in Processing window removes the synth from the server.


//* SynthDef *///////////////////

SynthDef(\sineOsc,
	{
		| outbus, freq = 440,iphase = 0.0, pan = 0, loop = 2, amp = 0.2, atk = 0.1, sus = 1.0|
		var sig,env;


		env = EnvGen.kr(Env.new([atk, atk, 0], [ sus, 0], \lin,releaseNode:loop), doneAction:2);

		sig = FSinOsc.ar(freq, iphase) * env * amp;

		Out.ar(outbus, Pan2.ar(sig,pan));

	}
).add;


//* OSC Synth Controls *///////////////////


~mouseControl = OSCdef(\mouseControl,{
	|msg|

	~freq = msg[1];
	~amp = msg[2];

},'/mouse');


~synthOn = OSCdef(\synthOn,{
	|msg|

	~on = msg[1];
	if(~on == 1){
		x = Synth(\sineOsc,[\loop,1,\freq,~freq,\amp,~amp]);
		r = Routine({
			inf.do({
				x.set(\freq,~freq.linlin(-1.0,1.0,100,1000),\amp,~amp);
				0.001.wait;

			})
		}).play;

	}{};
},'/on');


~synthOff = OSCdef(\synthOff,{
	|msg|
	~off = msg[1];
	if(~off ==0){
		x.free;
		r.stop;

	}{}
},'/off');




)
