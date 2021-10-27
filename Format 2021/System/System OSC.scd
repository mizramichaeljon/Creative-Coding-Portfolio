(

Tempo.bpm = 100;
n = NetAddr.new("127.0.0.1",12000);
// thisThread.randSeed = 1;
r = thisThread.randData_(Int32Array[ 176321762, 2088233356, 1423040751 ]);

SystemClock.sched(0.0,
	{//0.00min

		//with kick//withhiHat//withHiHat125.//withUVrange//
		~kick.reset.play;
		~rotationZ.reset.play;
		~randomScaleRange.reset.play;
		~meshSpecular.reset.play;
		~uRangeLow.reset.play;
		~vRangeHigh.reset.play;
		~hiHat.reset.play;

	}
);

SystemClock.sched(30.0,n
	{//0.30min

	}
);

SystemClock.sched(60.0,
	{//1.00min
		// ~rotationX.play;

	}
);

SystemClock.sched(90.0,
	{//1.30min
	~uRangeLow.reset.play;
	}
);

SystemClock.sched(120.0,
	{
		//2.00min
	~vRangeHigh.reset.play;
	}
);

SystemClock.sched(150.0,
	{
		//2.30min

	}
);

SystemClock.sched(180.0,
	{
		//3min
	}
);

SystemClock.sched(210.0,
	{
		//3.30min

	}
);

SystemClock.sched(240.0,
	{//4.00min

	}
);

SystemClock.sched(270.0,
	{
		//4.30min
	}
);

SystemClock.sched(300.0,
	{
		//5.00min

	}
);

SystemClock.sched(330.0,
	{
		//5.30min
	}
);

)

~uCountIncrease.reset.play;
