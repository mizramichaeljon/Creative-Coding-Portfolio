(

Tempo.bpm = 100;
n = NetAddr.new("127.0.0.1",12000);
// thisThread.randSeed = 1;
r = thisThread.randData_(Int32Array[ 176321762, 2088233356, 1423040751 ]);

SystemClock.sched(0.0,
	{//0.00min
		~pad.reset.play;
		~point.reset.play;
		// a.play;

	}
);

SystemClock.sched(30.0,
	{//0.30min

	}
);

SystemClock.sched(60.0,
	{//1.00min

		~vCentreRange.reset.play;
	}
);

SystemClock.sched(90.0,
	{//1.30min
		~paramExtra.reset.play;
	}
);

SystemClock.sched(120.0,
	{
		//2.00min
		~meshDistortionIncrease .reset.play;
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
		~vCountDecrease.reset.play;
	}
);

SystemClock.sched(240.0,
	{//4.00min
		~uCountIncrease.reset.play;
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
		~randomScaleRangeDecrease.reset.play;
	}
);

SystemClock.sched(330.0,
	{
		//5.30min
	}
);
SystemClock.sched(360.0,
	{
		~uRangeHighDecrease.reset.play;
	}
);

SystemClock.sched(390.0,
	{
		//6.30min
	}
);
SystemClock.sched(420.0,
	{
		~meshDistortionDecrease.reset.play
	}
);

SystemClock.sched(450.0,
	{
		//7.30min
	}
);

SystemClock.sched(480.0,
	{
		~meshAlphaDecrease.reset.play;
	}
);

SystemClock.sched(510.0,
	{
		//8.30min
	}
);

SystemClock.sched(540.0,
	{
		//9.00min
	}
);

SystemClock.sched(570.0,
	{
		//9.30min
	}
);

SystemClock.sched(600.0,
	{
		//10.00min
	}
);
)

~uCountIncrease.reset.play;
