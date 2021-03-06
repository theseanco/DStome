//SUMMON HIM WITH THE LEFT CLICK OF A MOUSE...
//this is played loud enough for CD to shout over, this needs to be sorted in the space
(
~maxorganvol = 1.7;
~orgverb = {0};
~organvol = {~maxorganvol};
~organvol.fadeTime=3;
~organ = {FreeVerb.ar(PlayBuf.ar(2,d[\organ][2],1,1,0,1,0)*~organvol,~orgverb,0.9,0.1)};
~organ.play;
)

//GO BACK TO THE LIGHTING FILE
//then i get a thumbs up.
//Then Charlie puts the battery in
//first bit of text is over the music
//Sermon, start to add backing track



/*

Something to consider, as the organ fades out do I fade IN a reverb on top? Something to experiment with.

Don't forget to clear it because it will eat CPU later

*/
//trigger this when charlie finishes the tome.

//OUR GRANDFATHERS MUSIC FADING INTO SOUNDTRACK
(
~organvol = {Line.kr(~maxorganvol,0,20)};
~orgverb = {Line.kr(0,1,10.0)};
~back1 = {Pan2.ar(Warp1.ar(1,d[\water][3],SinOsc.kr(0.01),1,0.5,-1,8,0,4,0.3),SinOsc.kr(0.31),Line.kr(0.00001,1,160).poll(2))};
~back1x = {Pan2.ar(Warp1.ar(1,d[\water][3],SinOsc.kr(0.08),1,0.1,-1,8,0,4,0.1),SinOsc.kr(0.3),Line.kr(0.00001,1,200))};
~back2 = {Pan2.ar(Mix.ar(PlayBuf.ar(2,d[\water][2],1,1,0,1)*EnvGen.ar(Env.perc(0.3,0.3),Dust.kr(0.5)),LFNoise1.kr(0.5)),LFNoise1.kr(0.1),Line.kr(0.00001,1,280))};
~back1.play;
~back1x.play;
~back2.play;
)
s.scope


//edit here
(
~back1 = {arg amp=0.1; Pan2.ar(Warp1.ar(1,d[\water][3],SinOsc.kr(0.01),1,0.5,-1,8,0,4,0.3),SinOsc.kr(0.31),amp)};
~back1x = {arg amp=0.1; Pan2.ar(Warp1.ar(1,d[\water][3],SinOsc.kr(0.08),1,0.1,-1,8,0,4,0.1),SinOsc.kr(0.3),amp)};
~back2 = {arg amp=1; Pan2.ar(Mix.ar(PlayBuf.ar(2,d[\water][2],1,1,0,1)*EnvGen.ar(Env.perc(0.3,0.3),Dust.kr(0.5)),LFNoise1.kr(0.5)),LFNoise1.kr(0.1),amp)};
~back1.play;
~back1x.play;
~back2.play;
)

(
//have this fade up, when talking about pressing one's face to the river
~suntask = Task({
	5.do({ arg fq;
		fq = [160,160,160,160,320,320].choose;
~sun = {arg amp = 0.05; Splay.ar(SinOscFB.ar(Array.fill(15,{rrand(160,1600*1.5).round(fq)})/4,LFNoise1.kr(Array.fill(15,rrand(0.1,0.5)),1.2).abs,amp))};
		rrand(1,10).wait;
	});
}).start;
~sun.fadeTime=10;
~sun.play
)


//END of the SERMON - Charlie comes back to the mic, last line is

// HOME COLD BLUE LIT, BORN AGAIN WITH MORE QUESTIONS
(
//this will quieten the whole thing down.
~back1.stop(5);
~back1x.stop(10);
~back2.stop(20);
~sun.stop(60);
)

(
~back1.clear;
~back1x.clear;
~back2.clear;
~sun.clear;
)



(
//this sets up control
//FIRST FOUR KNOBS AT ZERO, NINTH KNOB AT FULL
~fund = 40;
~fund.fadeTime=1;
c.knob1.onChanged = {|val| "fund = ".post; ~fund = val.linlin(0,127,40,100).postln};
c.knob2.onChanged = {|val| "fund = ".post; ~fund = val.linlin(0,127,100,300).postln};
c.knob3.onChanged = {|val| "fund = ".post; ~fund = val.linlin(0,127,300,900).postln};
c.knob4.onChanged = {|val| "fund = ".post; ~fund = val.linlin(0,127,1,20).postln};
)


//this is the splash function
(
var prev = 0;
q = { |in|
    var result = in - prev;
    prev = in;
    result;
	result = if ( result < 300, {0},{result});
};
);

EnvGen.ar(Env.perc(0.01,0.1),Impulse.kr(~tempo*5))

//NOTE; The first text takes one minute to reach full volume.
//FADER 1 MINIMUM
//FADER 2 MINIMUM
//FADER 3 MINIMUM

//move up knob 1 while moving up faders 1 and 2
//when knob 1 is full, turn down faders 1 and 2
//then turn up knob 2, turn up faders 1 and 2, then release envelope with fader 3
//then turn up knob 3 when charlie does the crab
//BUT SWITCH TO THE LIGHTS, WHEN CHARLIE DOES THE CRAB AND I'VE TURNED UP KNOB 3


(
~back1.stop(5);
~back1x.stop(10);
~back2.stop(20);
~sun.stop(60);
~intensity = 0.5;
c.fader1.onChanged = {|val| "intensity = ".post; ~intensity = val.linlin(0,127,0.5,4).postln};
~env = 0.5;
c.fader2.onChanged = {|val| "envelope = ".post; ~env = val.linlin(0,127,0.5,3).postln};
c.fader3.onChanged = {|val| "envelopeMAX = ".post; ~env = val.linlin(0,127,3,10).postln};
~drn0 = {SinOsc.ar([~fund,~fund*1.1],0,0.2)};
~drn1.play;
~drn0.play;
~drn1 = {arg intensity = ~intensity, amp= 0.8; DFM1.ar(SinOsc.ar([~fund+SinOsc.kr(0.2),~fund],0,0.3),[~fund+SinOsc.kr(0.2),~fund],Saw.kr(SinOsc.kr(0.7)).range(0.01,~intensity),1,0,0.00002,amp)*EnvGen.ar(Env.perc(0.01,~env),Impulse.kr(~tempo))};

~drn2 = {arg intensity = ~intensity, amp=1; DFM1.ar(SinOsc.ar([(~fund*2)+LFNoise1.kr(0.1),(~fund*2)+LFNoise1.kr(0.1)],0,0.3),[~fund*2,(~fund*2)*1.01],Saw.kr(LFNoise1.kr(0.1)).range(0.01,~intensity),1,0,0.00002,amp)*EnvGen.ar(Env.perc(0.01,~env),Impulse.kr(~tempo*2))};

~drn3 = {arg intensity1 = ~intensity*2, intensity2 = ~intensity, amp=0.5; DFM1.ar(DFM1.ar(SinOsc.ar([~fund+LFNoise1.kr(0.1),~fund+LFNoise1.kr(0.1)],0,0.3),[~fund*2.5,(~fund*2.5)*1.01],Saw.kr(LFNoise1.kr(0.1)).range(0.01,~intensity*2),1,0,0.00002,0.2),~fund*2.5,LFNoise1.kr(0.4,~intensity).abs,1,0,0.0001,amp)*EnvGen.ar(Env.perc(0.01,~env*0.2),Impulse.kr(~tempo*3))};

~drnx = {arg amp=0.1; Pan2.ar(DFM1.ar(WhiteNoise.ar(0.5),LFNoise1.kr(1).range(~fund,~fund*20).round(~fund*2),LFNoise1.kr(0.2,2).abs,1,0,0.004,amp))*EnvGen.ar(Env.perc(0.01,~env*0.1),Impulse.kr(~tempo*2))};

~drn5 = {arg amp=0.04; Pan2.ar(Mix.ar(DFM1.ar(SinOsc.ar(~fund,0,0.1),[5,10,15,20,25,30,35]*~fund,LFNoise1.kr([0.1,0.11,0.12,0.13,0.14,0.15,0.16],4),1,0,0.00004,amp)))*EnvGen.ar(Env.perc(0.01,~env*0.2),Impulse.kr(~tempo*6))};

~warp1 = {arg amp = 2.5, posx = 0, posy = 0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],pos+LFNoise1.kr(100,0.001),rate,0.2,interp:4),posx,XLine.kr(0.00001,amp,60))};
~warp2 = {arg amp = 2.5, posx = -0.7, posy = 0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],pos+LFNoise1.kr(100,0.001),rate,0.2,interp:4),posx,amp)};
~warp3 = {arg amp = 2.5, posx = 0.7, posy = -0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],pos+LFNoise1.kr(100,0.001),rate,0.2,interp:4),posx,amp)};
OSCdef(\warpx,{|msg| ~warp1.set(\pos,msg[1].linlin(-16000,16000,0,1.0))},'/x');
OSCdef(\warpy,{|msg| ~warp2.set(\pos,msg[1].linlin(-16000,16000,0,1.0))},'/y');
OSCdef(\warpz,{|msg| ~warp3.set(\pos,msg[1].linlin(-16000,16000,0,1.0))},'/z');
(
OSCdef(\xdiff, {|msg| ~splash.set(\amp,q.(msg[1]))},\x1);
~splash = {arg amp = 1; Pan2.ar(PlayBuf.ar(1,d[\water][2],1,1,0,1,0)*Lag.kr(amp/100,0.5),SinOsc.kr(0.1,0,0.7))};
);
~warp1.play;
)
~warp1.stop

~drn2.play;
//
~drn2.play;

~drn3.play;

~warp2.play;

~splash.play;

~drnx.play;

~drn5.play;

~warp3.play;

~warp1.stop


(
~drn1.play;
~drn2.play;
~drn3.play;
~drnx.play;
~drn5.play;
)

~drn1.stop

/*

FOR THE END, SEE LIGHTING FILE

WAIT FOR CHARLIE TO RETURN TO THE CENTER

*/

~fund.fadeTime=2
~fund = 510

~drnx = {arg amp=0.1; Pan2.ar(DFM1.ar(WhiteNoise.ar(0.5),LFNoise1.kr(1).range(~fund,~fund*20).round(~fund*2),LFNoise1.kr(0.2,2).abs,1,0,0.004,amp))}

~drnx.play
~drn5.play


~drn5 = {arg amp=0.04; Pan2.ar(Mix.ar(DFM1.ar(SinOsc.ar(~fund,0,0.1),[5,10,15,20,25,30,35]*~fund,LFNoise1.kr([0.1,0.11,0.12,0.13,0.14,0.15,0.16],4),1,0,0.00004,amp)))}


~drn5.play

~kick = Pbind(\instrument,\bplay,\buf,d[\kick][2],\rate,0.5,\dur,Pwhite(0.25,1.5).round(0.25)*2,\amp,6)

~snare = Pbind(\instrument,\bplay,\buf,d[\clap][1],\rate,0.7,\dur,Pwhite(0.25,1.5).round(0.25)*4,\amp,2)

~snare.play
~kick.play

~drn3.play


~drn1.clear

~kick.play
~snare.play

~kick.stop
~snare.stop

~drn3.play

//TEXT MANIPULATION, using GRANULAR SYNTHESIS
(
~warp1 = {arg amp = 2, posx = 0, posy = 0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],pos+LFNoise1.kr(100,0.001),rate,0.2,interp:4),posx,amp)};
~warp2 = {arg amp = 2, posx = -0.7, posy = 0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],pos+LFNoise1.kr(100,0.001),rate,0.2,interp:4),posx,amp)};
~warp3 = {arg amp = 2, posx = 0.7, posy = -0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],pos+LFNoise1.kr(100,0.001),rate,0.2,interp:4),posx,amp)};

OSCdef(\warpx,{|msg| ~warp1.set(\pos,msg[1].linlin(-16000,16000,0,1.0))},'/x');
OSCdef(\warpy,{|msg| ~warp2.set(\pos,msg[1].linlin(-16000,16000,0,1.0))},'/y');
OSCdef(\warpz,{|msg| ~warp3.set(\pos,msg[1].linlin(-16000,16000,0,1.0))},'/z');
)
(
~warp1.play;
~warp2.play;
~warp3.play;
)

//HAVE A WARP WITH NOISE
(
~warp1 = {arg amp = 1, posx = 0.5, posy = 0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],LFNoise1.kr(LFNoise1.kr(0.1).range(0.1,1),1).abs,interp:4),posx,amp)};
~warp2 = {arg amp = 1, posx = 0.5, posy = 0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],LFNoise1.kr(LFNoise1.kr(0.1).range(0.1,1),1).abs,rate,0.2,interp:4),posx,amp)};
~warp3 = {arg amp = 1, posx = 0.5, posy = 0.5, pos = 0.01, rate = 1; Pan2.ar(Warp1.ar(1,d[\tome],LFNoise1.kr(LFNoise1.kr(0.1).range(0.1,1),1).abs,rate,0.2,interp:4),posx,amp)};
)


(
~warp1.play;
~warp2.stop;
~warp3.stop;
)


(
~warp1.clear;
~warp2.clear;
~warp3.clear;
)


//water splash

//using the grabbing of d as a function
//if statement added as a gate, because fuck off gate Ugens
(
var prev = 0;
q = { |in|
    var result = in - prev;
    prev = in;
    result;
	result = if ( result < 300, {0},{result});
};
);
(
OSCdef(\xdiff, {|msg| ~splash.set(\amp,q.(msg[1]))},\x1);
~splash = {arg amp = 0.7; Pan2.ar(PlayBuf.ar(1,d[\water][2],1,1,0,1,0)*Lag.kr(amp/100,0.5),SinOsc.kr(0.1,0,0.7))};
~splash.play;
);

~splash.stop

OSCFunc.trace(false)

//TOME
(
~drn1.stop;
~drn2.stop;
~drn3.stop;
~drnx.stop;
~drn5.stop;
)

//COMMITTAL
//Trigger this when the tome finishes
//TURN UP BASS ON MIXER!!!!!!
(
~organvol.fadeTime=0;
~organvol= 0;
~drn1.stop(20);
~drn2.stop(20);
~drn3.stop(20);
~drnx.stop(20);
~drn5.stop(20);
~drn0.stop(20);
~maxorganvol = 2.6;
~organvol = {XLine.kr(0.001,~maxorganvol,12)};
~orgverb = {Line.kr(1,0.0,20)};
~organ = {FreeVerb.ar(PlayBuf.ar(2,d[\organ][1],1,1,0,0,0)*~organvol,~orgverb,0.99,0.01)};
~organ.play;
)

