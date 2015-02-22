// ActionScript file
import flash.utils.setTimeout;

var velocity:Array = new Array();
var velocityCache:Number = 0;
var focusTimer:Number;

public function removeZoomback():void {
	trace(">>>>>> Killing Zoomback <<<<<<<");
	  clearTimeout(focusTimer);	
}


public function velocityInterval():void {
	/*var lastItem = velocity[velocity.length-1];
	var curTime = parseInt(new Date().getTime().toString());
	if((curTime - lastItem.time) >200 && fovealDepth > 1) {
		fovealDepth--;
		recomputeFoveal();		
	}*/
	trace("Focusing! from " + fovealDepth + " with factor " + ((maxZoomOut- (maxZoomOut - fovealDepth))/3)  );
	// Disabling until configuration of foveal size based upon screen available
	//fovealDepth--;
	velocity = new Array();
	//zoomFovea(-.5 - ((maxZoomOut- (maxZoomOut - fovealDepth))/3));	
	//trace("Focused to " + fovealDepth);
	if(fovealDepth > 1) focusTimer = setTimeout(velocityInterval,50);	
}



//focusTimer=  setInterval(velocityInterval(), 200);

function logMouseMove(x:Number, y:Number, time:Number) {
	
	
	
	trace(fovealDepth + "::" + velocity.length + " with " + x + "," + y + "," + time);
	var distance:Number;
	var elapsed:Number;
	var pauseThreshold:Number = 200;
	var pauseConfirm:Number = 140;
	var maxTimepoints = 20;
	var maxTime = 2000;
	var looper:Number = 0;
	// Got a pause, zoom in
	if(velocity.length > 1 && (time - velocity[velocity.length-1].time) > pauseThreshold) {
	
		// Need to clear the timer, still moving		
		velocity = new Array();
		trace("Killing velocity to " + velocity.length);
		//fovealDepth = 1;
		// Disabling until configuration of foveal size based upon screen available
		//zoomFovea(-.25);
		clearInterval(focusTimer);
		focusTimer = setTimeout(velocityInterval,pauseConfirm);
	}
	
	if(velocity.length > 1 && (time - velocity[velocity.length-1].time) < pauseThreshold) {
		// Still moving, kill the timeout
		if(velocity.length > 1) {
			if(focusTimer) {
				//trace("clearing");
				clearTimeout(focusTimer);
				focusTimer = 0;
			}
		}
	}
	//trace("Add a record? len: " + velocity.length);
	if (velocity.length == 0) {
			trace("First record");
			velocity[0] = new Object();
			velocity[0].x = x;
			velocity[0].y = y;
			velocity[0].time = time;
			
	} else {
		// Still moving! 
		//trace("Still moving? " + time + " vs " + velocity[velocity.length-1].time);
		//if (time - velocity[velocity.length-1].time < pauseThreshold) {
			velocityCache = velocity.length;
			// Add a record
			// Still got room?
			/*if(velocity.length < maxTimepoints) {
				trace("new record");
				velocity[velocityCache] = new Object();
				velocity[velocityCache].x = x;
				velocity[velocityCache].y = y;
				velocity[velocityCache].time = time;
				//velocityCache++;
			}*/

			
			velocity.splice(velocity.length);
			velocity.splice(0,0,new Object());
			velocity[0].x=x;
			velocity[0].y=y;
			velocity[0].time=time;			
			//trace("Checking at " + looper  + " with delta " + (time - velocity[looper].time) );
			while(looper < velocity.length && !isNaN(time) && !isNaN(velocity[looper].time) && (time - velocity[looper].time) < maxTime) {
				looper++;
			}
			if(looper > 0 && looper < velocity.length) {
				//trace("splicing");
				//trace("Trimming from " + looper + " to " +  velocity.length);
				velocity.splice(looper, velocity.length-looper);	
			}
		//}
	}
	//	trace("Distance time");
	distance=0;
	elapsed=0;
	// Recompute distance & velocity
	// Do we have two records?
	if(velocity.length > 2) {
		// Sum the distance from across records 0 to length-1
		for(var i=1;i<velocity.length-1;i++) {

			distance += Math.sqrt((velocity[i].x-velocity[i+1].x)*(velocity[i].x-velocity[i+1].x) + (velocity[i].y - velocity[i+1].y)*(velocity[i].y - velocity[i+1].y));
			elapsed += velocity[i-1].time - velocity[i].time;
			//trace("Dist: " + distance + "." + elapsed);
		}
		trace("Logged" + velocity.length + " at distance " + distance + " of time " + elapsed);
		trace("Velocity:" + distance/elapsed);
		if(distance > 0 && elapsed > 0 && ((distance/elapsed) > .55 || ((distance/elapsed) > .25 ) && distance > 100) ) {
				// Disabling until configuration of foveal size based upon screen available
				// if(distance > 50) zoomFovea((distance/elapsed) +(5*distance/stage.nativeWindow.height));
		} else {
			//trace("skip");
			focusTimer = setTimeout(velocityInterval,60);
		}
	}
}