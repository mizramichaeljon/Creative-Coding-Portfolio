(

/////////////////////////////////////////////////////////////SETUP//////////////////////////////////////////////////////////////////

var server = Server(\nrt_test,
	options: ServerOptions.new
	.numOutputBusChannels_(2)
	.numInputBusChannels_(2)
	.memSize_(2.pow(18))
	.maxNodes_(2.pow(16))
),




//////////////////////////////////////////////////////BUFFER/////////////////////////////////////////////////////////////////////

winenv = Env([0.0,1.0,1.0,0.0],[0.0,1.0,0.01]).discretize(2.pow(10)),
env = Buffer.new(server,winenv.size,1),
bufA = Buffer.new(server,0,1),
bufB = Buffer.new(server,0,1);

///////////////////////////////////////////////////////////////////SYNTH DEF



////////////////////////////////////////////////////////////PATTERN/////////////////////////////////////////////////////////////
Tempo.bpm = 140;

~duration = 300*(140/60);
r = thisThread.randData_(Int32Array[ 176321762, 2088233356, 1423040751 ]);


~pad1 = Pmono(
	\padMix,
	\freq,440,
	\lo,1.3,
	\sus,1,
).asScore(duration: ~duration, timeOffset:0.001);


~pad2 = Pmono(
	\padMix,
	\freq,440,
	\lo,1.4,
	\sus,1,
).asScore(duration: ~duration, timeOffset:0.001);


~pad3 = Pmono(
	\padMix,
	\freq,440,
	\lo,1.2,
	\sus,1,
).asScore(duration: ~duration, timeOffset:0.001);


~pad4 =Pmono(
	\padMix,
	\freq,440,
	\lo,1.1,
	\sus,1,
).asScore(duration: ~duration, timeOffset:0.001);

~pad5 =Pmono(
	\padMix,
	\freq,440,
	\lo,1.0,
	\sus,1,
).asScore(duration: ~duration, timeOffset:0.001);

~pad6 =Pmono(
	\padMix,
	\freq,440,
	\lo,1.9,
	\sus,1,
).asScore(duration: ~duration, timeOffset:0.001);

~pad7 =Pmono(
	\padMix,
	\freq,440,
	\lo,1.6,
	\sus,1,
).asScore(duration: ~duration, timeOffset:0.001);

~bass = Pmono(
	\sineOsc,
	\freq,55,
	\sus,1,
).asScore(duration: ~duration, timeOffset:0.001);



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// x.add([0.0, env.allocMsg]);



//////////////////////////////////////////////////GRANULAR SAMPLER/////////////////////////////////////////////////

// ~sample.add([0.0, bufA.allocReadChannelMsg("C:/Users/mmizr/OneDrive/Samples/$9blue/data stream/texture_warper1.wav"
// , channels:[0])]);




//////////////////////////////////////////////////STEREO SAMPLER/////////////////////////////////////////////////

/*
x.add([0.0, buf.allocReadMsg("C:/Users/mmizr/OneDrive/Samples/Taverner_theLamb/little_Long.wav")]);*/


//////////////////////////////////////////////////ENVELOPES /////////////////////////////////////////////////

// x.add([0.0, env.setnMsg(0,winenv)]);

//////////////////////////////////////////////////SORT/////////////////////////////////////////////////
// x.sort;


/////////////////////////// NRT Options
~pad1.recordNRT(
	outputFilePath: ("~/desktop" +/+ UniqueID.next ++ "format_pad1.aiff").standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: server.options,
	duration: ~duration
);

~pad2.recordNRT(
	outputFilePath: ("~/desktop" +/+ UniqueID.next ++ "format_pad2.aiff").standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: server.options,
	duration: ~duration
);



~pad3.recordNRT(
	outputFilePath: ("~/desktop" +/+ UniqueID.next ++ "format_pad3.aiff").standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: server.options,
	duration: ~duration
);


~pad4.recordNRT(
	outputFilePath: ("~/desktop" +/+ UniqueID.next ++ "format_pad4.aiff").standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: server.options,
	duration: ~duration
);




~pad5.recordNRT(
	outputFilePath: ("~/desktop" +/+ UniqueID.next ++ "format_pad5.aiff").standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: server.options,
	duration: ~duration
);




~pad6.recordNRT(
	outputFilePath: ("~/desktop" +/+ UniqueID.next ++ "format_pad6.aiff").standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: server.options,
	duration: ~duration
);



~pad7.recordNRT(
	outputFilePath: ("~/desktop" +/+ UniqueID.next ++ "format_pad7.aiff").standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: server.options,
	duration: ~duration
);

~bass.recordNRT(
	outputFilePath: ("~/desktop" +/+ UniqueID.next ++ "format_bass.aiff").standardizePath,
	sampleRate: 44100,
	headerFormat: "AIFF",
	sampleFormat: "int16",
	options: server.options,
	duration: ~duration
);


server.remove;
)