state("TheQuarry-Win64-Shipping")
{
    int loading    : 0x06EC31B0, 0xFD8, 0x820, 0x1C8; // 0 in game, goes very quickly between some 10 digit values and lands on 1065353216 during load
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
