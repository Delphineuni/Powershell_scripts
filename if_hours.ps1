#==============================================================================================================#
# NAME          : If_hours                                                                                     #
# CREATOR       : Delphine                                                                                     #
# VERSION       : 3.0 - 31/08/2018 - Added comments, functions, possibility to set start hour manually         #
# DESCRIPTION   : Calculating remaining time of a 7-hours day plus 1-hour break based on computer boot time    #
#                 or manually set time                                                                         #
# ARGUMENTS     : -                                                                                            #
#==============================================================================================================#

# Get window's width
$width=(Get-Host).UI.RawUI.WindowSize.Width;
# Get window's height
$heigh=(Get-Host).UI.RawUI.WindowSize.Height;
# Turns cursor invisible to prevent it from flashing during script execution
[console]::CursorVisible=$false;
# Get starting hour from system kernel
$hour=$((Get-Process -id 4).starttime.Hour*3600);    
# Get starting minuter from system kernel
$minute=$((Get-Process -id 4).starttime.minute*60);
# If the powershell console doesn't have the admin rights to get the StartTime, uses a different method to retrieve it
if (-not $hour) {
    $starttime=$([string](net stats workstation |Select-String -Pattern "..:..:.."))
    $starttime=$starttime.Substring($starttime.Length-8)
    $hour=$([int]($starttime[0..1] -join ""))*3600;
    $minute=$([int]($starttime[3..4] -join ""))*60
    }
# Set extra hours/minutes to 0
$extra=0;
# Set the answer to stop the script to null
$answer=''
# Set the start time to null
$starttime=''
$daylength=28800

# Set function to ask if user wants to stop the script after a keypress
function answer {
$Host.UI.RawUI.FlushInputBuffer()
if ( -not ($answer -contains 'y')) {
    $answer=Read-Host $(' '*(($width-("Do you want to stop the script? (y/n)".Length))/2)),"Do you want to stop the script? (y/n)" 
    }
    if ($answer -contains 'y') {
        [console]::CursorVisible=$true;
        exit
    }
}

# Catch if something else than a number is typed
function catch_NaN {
    write-host $(' '*(($width-('Not a number!'.Length))/2)),"Not a Number!"
    sleep 1
}        

# Function to place text for input and read input from user
function set_time ($text,$text_opt) {
    cls;
    $i=($heigh/4);while ($i -ge 1){Write-Host "`n";$i--;};
    if ($text_opt) { 
        Write-Host $(' '*(($width-($text.Length))/2)),$text;
        $global:value=Read-Host $(' '*(($width-($text_opt.Length))/2)),$text_opt;
        }
    else {
        $global:value=Read-Host $(' '*(($width-($text.Length))/2)),$text;
        }
}

#Set starting time manually
while ($true) {
    try {
        set_time 'Starting time? [2400 format]' '(default: computer boot time)'
        $starthour=([int]($value[0..1] -join ""))*3600;
        $startminute=([int]($value[2..3] -join ""))*60
        $starttime=$starthour+$startminute
        break
    }
    catch {
    catch_NaN
    }
}

#Set extra time if planned
while ($true) {
    try {
    set_time 'Any extra/recovered time planned?' '(in minutes)'
    $extra=([int]$value*60)
    $daylength=$daylength+$extra
    break;
    }
    catch {
    catch_NaN
    }
}    


#Set Lunch starting hour, assume 1 hour of break
while ($true){
    try {
    set_time 'Lunch break time?' '(default: 12:00)'
    if ($value -eq '') {
        $value = '1200'
        }
    [int]$breakhr=$value.Substring(0,2)
    [int]$breakmin=$value.Substring(2,2)
    $lunchbreak=$breakhr*3600+$breakmin*60
    # Set value of remaining lunchbreak time
    [int]$brick=(($lunchbreak+3600)-(((get-date).Hour*3600)+((get-date).Minute*60)))
    break
}
catch {
    catch_NaN
    }
}


<# If start time is not manually set, automatically set the starting time at the exact hour if kernel time is between -15 and 15 around the hour (hour +1 if -15 minute)
and the hour and half if between 15 and 45. Starttime is in second. 28800 seconds == 8 hours #>

if ($starttime -eq '') {
    if (($minute -gt 2700) -or ($minute -lt 900)) { 
        if ($minute -gt 2700) {
            $hour=($hour+3600)
            }; $minute= 0;
     };
    if ((($minute -lt 2700) -and ($minute -gt 900))) {
     $minute=1800;
     };
    $starttime=$($hour+$minute);
}

# Verifies if lunchbreak is finished at launch of script
if ((((get-date).Hour*3600)+((get-date).Minute*60)) -le ($lunchbreak+3600)) {
    $lunch=0
}
else {
    $lunch=1
    }
    #Determine the optimal pause time
function pause {
if (($lunchbreak-$starttime) -lt (28800-($lunchbreak+3600-$starttime))) {
 Write-Host $(' '*(($width-("Better have afternoon pause".length))/2)),"Better have afternoon pause"
 }
 elseif (($lunchbreak-$starttime) -eq (28800-($lunchbreak+3600-$starttime))) {
 Write-Host $(' '*(($width-("Can have a break either in morning or afternoon".Length))/2)),"Can have a break either in morning or afternoon"
 }
 else {
 Write-Host $(' '*(($width-("Better have morning pause".Length))/2)),"Better have morning pause"
 }
 read-host
}
pause
# Loop continues until a key is pressed
while ($true) {
while (-not $Host.UI.RawUI.KeyAvailable){
    cls;
    # Centers the text in height
    $i=($heigh/4);while ($i -ge 1){Write-Host "`n";$i--;};
    # Calculate remaining time from a base of 8 hours - 7 hours plus 1 hour break -
    # Show remaining time based on 7 hours before lunch or 8 hours after lunch to account for the lunch break   
    if ($lunch -eq 0) {
        $left=(($daylength-3600)-((((get-date).hour*3600)+((Get-Date).Minute*60)+((get-date).Second)))+$starttime);
    }
    else {
        $left=($daylength-((((get-date).hour*3600)+((Get-Date).Minute*60)+((get-date).Second)))+$starttime);
    }
    # total length minus text length
    $length=($width-8);
    # Add spaces equal to half the length to center the text horizontally
    Write-Host -NoNewline $(' '*(($length/2)));
    # Get HH:MM:ss format from seconds
    $lft=$([timespan]::FromSeconds($left));
    # Display time in 00:00:00 format
    ("{0:00}" -f $lft.hours + ":" + "{0:00}" -f $lft.minutes + ":" + "{0:00}" -f $lft.seconds);
    sleep 1;
    # Display the "Lunch Break!" and stop counting for 1 hour
    while (((((get-date).Hour*3600)+((get-date).Minute*60)) -ge $lunchbreak) -and 
    ((((get-date).Hour*3600)+((get-date).Minute*60)) -lt ($lunchbreak+3600)))  {
        $lunch=1
        Write-Host $(' '*(($width-("Lunch Break!".Length))/2)),"Lunch Break!"
      while ($brick -gt 0) {
            [int]$brick=(($lunchbreak+3600)-(((get-date).Hour*3600)+((get-date).Minute*60)))
            sleep 1
      if ($host.UI.RawUI.KeyAvailable){ 
                answer
                }
        else {
            cls;
            $i=($heigh/4);while ($i -ge 1){Write-Host "`n";$i--;};
            Write-Host -NoNewline $(' '*(($length/2)));
            ("{0:00}" -f $lft.hours + ":" + "{0:00}" -f $lft.minutes + ":" + "{0:00}" -f $lft.seconds);
            Write-Host $(' '*(($width-("Lunch Break!".Length))/2)),"Lunch Break!"
            }
          }
        }
    # Program exits with prompt if remaining time is 0
    if ($left -le 0) {
        cls;
        $i=($heigh/4);while ($i -ge 1){Write-Host "`n";$i--;};
        Write-Host -NoNewline $(' '*(($length/2)-4));
        Write-host -NoNewline -ForegroundColor Red "CASSE TOI !!!`n";
        while ($i -ge 1){Write-Host "`n";$i--;}
        [console]::CursorVisible=$true;
        exit;
        }
   }
answer
}
[console]::CursorVisible=$true