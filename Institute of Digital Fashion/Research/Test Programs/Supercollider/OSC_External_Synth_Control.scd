(
n = NetAddr("127.0.0.1",57120);

~control;

o = OSCdef(\pbindTest,{
	|msg|
	~control = msg[1];
},'/test');


x = Synth(\sineOsc,[\loop,1,\freq,~control]);

r = Routine({
	inf.do({
		x.set(\freq,~control);
		0.01.wait
	})
}).play;
)