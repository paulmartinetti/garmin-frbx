import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;

// Define number representations (example for '0' and '1')
var numberPatterns as Array = [
  [
    [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ],
    [ 1, 1, 1, 1, 1 ]
  ],
  [
    [ 0, 0, 0, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ],
    [ 0, 0, 0, 0, 1 ]
  ], 
  [
    [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 0 ],
    [ 1, 1, 1, 1, 1 ]
  ], 
  [
    [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ],
    [ 1, 1, 1, 1, 1 ]
  ], 
  [
    [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ],
    [ 0, 0, 0, 0, 1 ]
  ], 
  [
    [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ],
    [ 1, 1, 1, 1, 1 ]
  ], 
  [
    [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ],
    [ 1, 1, 1, 1, 1 ]
  ],
  [
    [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ],
    [ 0, 0, 0, 0, 1 ]
  ],  
  [
    [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ],
    [ 1, 1, 1, 1, 1 ]
  ], 
  [
    [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ],
    [ 1, 1, 1, 1, 1 ]
  ]
];

var days as Array<String> = ["","un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix", 
"onze", "douze", "treize", "quatorze", "quinze", "seize", "dix-sept", "dix-huit", "dix-neuf", "vingt",
"vingt-et-un", "vingt-deux", "vingt-trois", "vingt-quatre", "vingt-cinq", "vingt-six", "vingt-sept", 
"vingt-huit", "vingt-neuf", "trente", "trente-et-un"];

var size = 20;
var hg = 3;
var p1 = 195 - (size * 5) - hg;
var p2 = 195 + hg;
var ydif = 20;

class WatchFaceView extends WatchUi.WatchFace {
  function initialize() { WatchFace.initialize(); }

  // Load your resources here
  function onLayout(dc as Dc) as Void { setLayout(Rez.Layouts.WatchFace(dc)); }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  function drawNumber(dc as Graphics.Dc, number as Number, x as Number,
                      y as Number, size as Number) {
    var pattern = numberPatterns[number] as Array<Array>;
    for (var row = 0; row < pattern.size(); row++) {
      for (var col = 0; col < pattern[row].size(); col++) {
        if (pattern[row][col] == 1) {
          dc.fillRectangle(x + col * size, y + row * size, size, size);
        }
      }
    }
  }
  function drawTime(dc as Graphics.Dc, hour as Number, minute as Number) {
    dc.setColor(0x8a8e1b, Graphics.COLOR_BLACK);

    // Draw hour (dc, number, x, y, size)
    drawNumber(dc, (hour / 10 % 10), p1, p1 - ydif, size);  // Tens place of hour
    drawNumber(dc, (hour % 10), p2, p1 - ydif, size);       // Ones place of hour

    // Draw minute
    drawNumber(dc, (minute / 10 % 10), p1, p2 - ydif, size);  // Tens place of minute
    drawNumber(dc, (minute % 10), p2, p2 - ydif, size);       // Ones place of minute
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Get and show the current time
    //var clockTime = System.getClockTime();
    
    // get date
    var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);

    var dateString = "le " + days[today.day];
    var view = View.findDrawableById("DateLabel") as Text; 
    view.setText(dateString);

    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);

    dc.clear();

    drawTime(dc, today.hour, today.min);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be
  // started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}
}
