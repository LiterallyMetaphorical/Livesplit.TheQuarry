state("TheQuarry-Win64-Shipping")
{
}

init
{
    var scn = new SignatureScanner(game, game.MainModule.BaseAddress, game.MainModule.ModuleMemorySize);
    var module = modules.First();
    var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);

    var LoadingBaseAddress = scn.Scan(new SigScanTarget(3, "488B??????????488D????4885??490F????EB??488B??????????488B??FF????84??0F85????????488B") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) });
    vars.LoadingPtr = new DeepPointer (LoadingBaseAddress, 0x70, 0x2E0, 0x3EC);

    vars.Watchers = new MemoryWatcherList
    {
        //Loading SigScan
        new MemoryWatcher<int>(vars.LoadingPtr) { Name = "LoadingPtr"}
    };
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

onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

update
{
vars.Watchers.UpdateAll(game);

vars.SigLoading = vars.Watchers["LoadingPtr"];
//DEBUG CODE
//print(modules.First().ModuleMemorySize.ToString());
print(vars.SigLoading.Current.ToString());
//print(vars.LoadingPtr.ToString("X"));
}

start
{
    return vars.SigLoading.Current == 5 && vars.SigLoading.Old == 4;
}

isLoading
{
    return vars.SigLoading.Current == 5;
}

exit
{
	timer.IsGameTimePaused = true;
}
