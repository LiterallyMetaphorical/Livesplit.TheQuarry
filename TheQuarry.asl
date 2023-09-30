state("TheQuarry-Win64-Shipping")
{
    int loading              : 0x071DD9E8, 0x70, 0x2E0, 0x3EC; //5 on load, 4 in game and MM
    string150 activeSubtitle : 0x07309D38, 0x550, 0x608, 0x0; //current active subtitle (and some other on-screen strings)
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

update
{ 
    //print(current.loading.ToString());
    //print(current.loadedMap.ToString());
    //print(current.activeSubtitle.ToString());
    //print(modules.First().ModuleMemorySize.ToString());
}   

isLoading
{
   return current.loading == 5;
}

exit
{
	timer.IsGameTimePaused = true;
}
