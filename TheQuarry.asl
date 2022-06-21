state("TheQuarry-Win64-Shipping")
{
    int loading    : 0x07262F00, 0xE18, 0x8D8;
    int menuState  : 0x6E1B350;
    int Chapter    : 0x7165650; //problematic for splitting cause it changes a lot lol but works for starting
}

startup
  {
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | The Quarry",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

start
{
    return (old.Chapter == 0 && current.Chapter == 3);
}

init
{
	vars.loading = false;
}

update
{
    //tells isLoading to look for the value of 0
    vars.loading = current.loading != 0; 

 //   print(current.Chapter.ToString());     
}       

isLoading
{
   return vars.loading;
}

exit
{
	timer.IsGameTimePaused = true;
}