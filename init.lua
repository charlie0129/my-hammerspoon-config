parentDirPathToAnVMSRBinary = "~/Documents/git/AnVMSR/Release-10.15"
parentDirPathTo_smc_fan_util_Binary = "~/Documents/git/smc_fan_util/build"
parentDirPathToSMCUtilBinary = "~/Documents/git/macNerdsUtilities"

savedTemperatureLimit = 0
savedTurboBoostSetting = false
savedPowerLimit = 0
savedBatteryChargingLimit = 100

mnu1 = hs.menubar.new()
mnu2 = hs.menubar.new()

menuTable1 = {
    { title = "Mac Nerd's Utility", disabled = true },
    { title = "-" },
    { title = "Fans", disabled = true },
    { title = "Auto (SMC)", indent = 1, fn = function() setFansToAuto() end },
    { title = "Auto (User)", indent = 1, fn = function() setFansToAuto_user() end },
    { title = "Auto (SMC+)", indent = 1, fn = function() setFansToAuto_user_plus() end },
    { title = "Completely off", indent = 1, fn = function() turnOffFans() end },
    -- { title = ".22", indent = 1, fn = function() hs.osascript.applescript(string.format('do shell script "%s"', "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -m 1303 1207")) end },
    -- { title = ".27", indent = 1, fn = function() hs.osascript.applescript(string.format('do shell script "%s"', "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -m 1600 1482")) end },
    { title = "0%", indent = 1, fn = function() setFansByPercentage(0) end },
    { title = "10%", indent = 1, fn = function() setFansByPercentage(10) end },
    { title = "20%", indent = 1, fn = function() setFansByPercentage(20) end },
    { title = "30%", indent = 1, fn = function() setFansByPercentage(30) end },
    { title = "40%", indent = 1, fn = function() setFansByPercentage(40) end },
    { title = "50%", indent = 1, fn = function() setFansByPercentage(50) end },
    { title = "75%", indent = 1, fn = function() setFansByPercentage(75) end },
    { title = "100%", indent = 1, fn = function() setFansByPercentage(100) end },
    { title = "-" },
    { title = "Batt. Charging Limit", disabled = true },
    { title = "50% (49%)", indent = 1, fn = function() setBatteryChargingLimit(49); refreshStatus1() end },
    { title = "60%", indent = 1, fn = function() setBatteryChargingLimit(60); refreshStatus1() end },
    { title = "70%", indent = 1, fn = function() setBatteryChargingLimit(70); refreshStatus1() end },
    { title = "80%", indent = 1, fn = function() setBatteryChargingLimit(80); refreshStatus1() end },
    { title = "100%", indent = 1, fn = function() setBatteryChargingLimit(100); refreshStatus1() end },
    { title = "-" },
    { title = "GPU Mode", disabled = true },
    { title = "Auto switch", indent = 1, fn = function() setGraphicsCardAuto(); refreshStatus1() end },
    { title = "Integrated only", indent = 1, fn = function() setGraphicsCardIntegrated(); refreshStatus1() end },
    { title = "Dedicated only", indent = 1, fn = function() setGraphicsCardDedicated(); refreshStatus1() end },
    { title = "-" },
    { title = "Refresh status", indent = 1, fn = function() refreshStatus1() end },
    { title = "-" },
    { title = "by Charlie", disabled = true }
}

menuTable2 = {
    { title = "Mac Nerd's Utility", disabled = true },
    { title = "-" },
    { title = "CPU Temp. Limit", disabled = true },
    { title = "60℃", indent = 1, fn = function() setTemperatureLimit(60); refreshStatus2() end },
    { title = "65℃", indent = 1, fn = function() setTemperatureLimit(65); refreshStatus2() end },
    { title = "70℃", indent = 1, fn = function() setTemperatureLimit(70); refreshStatus2() end },
    { title = "75℃", indent = 1, fn = function() setTemperatureLimit(75); refreshStatus2() end },
    { title = "80℃", indent = 1, fn = function() setTemperatureLimit(80); refreshStatus2() end },
    { title = "85℃", indent = 1, fn = function() setTemperatureLimit(85); refreshStatus2() end },
    { title = "90℃", indent = 1, fn = function() setTemperatureLimit(90); refreshStatus2() end },
    { title = "95℃", indent = 1, fn = function() setTemperatureLimit(95); refreshStatus2() end },
    { title = "100℃", indent = 1, fn = function() setTemperatureLimit(100); refreshStatus2() end },
    { title = "-" }, -- TODO
    { title = "CPU Power Limit", disabled = true },
    { title = "10W", indent = 1, fn = function() setPowerLimit(10); refreshStatus2() end },
    { title = "15W", indent = 1, fn = function() setPowerLimit(15); refreshStatus2() end },
    { title = "20W", indent = 1, fn = function() setPowerLimit(20); refreshStatus2() end },
    { title = "25W", indent = 1, fn = function() setPowerLimit(25); refreshStatus2() end },
    { title = "30W", indent = 1, fn = function() setPowerLimit(30); refreshStatus2() end },
    { title = "35W", indent = 1, fn = function() setPowerLimit(35); refreshStatus2() end },
    { title = "40W", indent = 1, fn = function() setPowerLimit(40); refreshStatus2() end },
    { title = "45W", indent = 1, fn = function() setPowerLimit(45); refreshStatus2() end },
    { title = "50W", indent = 1, fn = function() setPowerLimit(50); refreshStatus2() end },
    { title = "-" },
    { title = "Intel® Turbo Boost", disabled = true },
    { title = "Enable", indent = 1, fn = function() setTurboBoost(true); refreshStatus2() end },
    { title = "Disable", indent = 1, fn = function() setTurboBoost(false); refreshStatus2() end },
    { title = "-" },
    { title = "Refresh status", indent = 1, fn = function() refreshStatus2() end },
    { title = "-" },
    { title = "by Charlie", disabled = true }
}

-----------------------------------------------------------------------------------------

function refreshStatus1()
    currentGraphicsCardMode = getGraphicsCardMode()
    currentBatteryChargingLimit = getBatteryChargingLimit()
    savedBatteryChargingLimit = currentBatteryChargingLimit

    if (currentGraphicsCardMode == 0) then
        graphicsModeChar = "I"
    elseif (currentGraphicsCardMode == 1) then
        graphicsModeChar = "D"
    elseif (currentGraphicsCardMode == 2) then
        graphicsModeChar = "Auto"
    else 
        graphicsModeChar = "Err"
    end

    mnu1:setTitle(tostring(currentBatteryChargingLimit)..tostring(graphicsModeChar))
end

function refreshStatus2()
    currentTurboBoostStatus = getTurboBoostStatus()
    savedTurboBoostSetting = currentTurboBoostStatus
    currentTemperatureLimit = getTemperatureLimit()
    savedTemperatureLimit = currentTemperatureLimit
    currentPowerLimit = getPowerLimit()
    savedPowerLimit = currentPowerLimit

    if (currentTurboBoostStatus) then
        turboBoostStatusChar = "E"
    else
        turboBoostStatusChar = "D"
    end

    mnu2:setTitle(tostring(currentTemperatureLimit)..tostring(currentPowerLimit)..tostring(turboBoostStatusChar))
end

--BATTERY--------------------------------------------------------------------------------

function getBatteryChargingLimit()
    cmd = "cd "..parentDirPathToSMCUtilBinary.."; sudo ./smcutil -r BCLM"
    ok,returnValue = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end

    batteryLimit = tonumber(returnValue)

    return batteryLimit
end

function setBatteryChargingLimit(desiredBatteryChargingLimit)
    savedBatteryChargingLimit = desiredBatteryChargingLimit
    cmd = "cd "..parentDirPathToSMCUtilBinary.."; sudo ./smcutil -w BCLM "..string.format("%x", desiredBatteryChargingLimit)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if result == false then
        hs.alert.show("Operation failed!")
    end
end

--POWER----------------------------------------------------------------------------------

function setPowerLimit(desiredPowerLimit)
    desiredPowerLimit = math.floor(desiredPowerLimit)
    savedPowerLimit = desiredPowerLimit
    cmd = "cd "..parentDirPathToAnVMSRBinary.."; sudo ./anvmsr writemsr 610 428"..(string.format("%03x", desiredPowerLimit * 8)).."00158"..(string.format("%03x", desiredPowerLimit * 8))
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if result == false then
        hs.alert.show("Operation failed!")
    end
end

function getPowerLimit()
    cmd = "cd "..parentDirPathToAnVMSRBinary.."; sudo ./anvmsr readmsr 610"
    ok,returnValue = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end

    PL2hex = string.sub(returnValue, 32, 34)
    PL1hex = string.sub(returnValue, 40, 42)
    --hs.alert.show(PL1hex.." "..PL2hex)
    PL2dec = math.floor(tonumber(PL2hex, 16) / 8)
    PL1dec = math.floor(tonumber(PL1hex, 16) / 8)
    if (math.min(PL1dec,PL2dec) < 5) then
        hs.alert.show("Power Limit too low")
    end
    --hs.alert.show(PL1dec.." "..PL2dec)
    PL1PL2Max = math.max(PL1dec, PL2dec)

    return PL1PL2Max
end

--FANS-----------------------------------------------------------------------------------

function setFansByPercentage(integerPercentage)
    cmd = "sudo killall smc_fan_util"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == true then
        hs.alert.show("Disabled a running instance of user-defined fan controller.")
    end

    cmd = "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -m "..tostring(integerPercentage)
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end
end

function turnOffFans()
    cmd = "sudo killall smc_fan_util"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == true then
        hs.alert.show("Disabled a running instance of user-defined fan controller.")
    end

    cmd = "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -d"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end
end

function setFansToAuto()
    cmd = "sudo killall smc_fan_util"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == true then
        hs.alert.show("Disabled a running instance of user-defined fan controller.")
    end

    cmd = "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -a"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end
end

function setFansToAuto_user()
    cmd = "sudo killall smc_fan_util"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == true then
        hs.alert.show("Disabled a running instance of user-defined fan controller.")
    else
        cmd = "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -A"
        ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
        if ok == false then
            hs.alert.show("Operation failed!")
        end
    end
end

function setFansToAuto_user_plus()
    cmd = "sudo killall smc_fan_util"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == true then
        hs.alert.show("Disabled a running instance of user-defined fan controller.")
    else
        cmd = "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util --SMC-enhanced"
        ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
        if ok == false then
            hs.alert.show("Operation failed!")
        end
    end
end

--TURBOBOOST-----------------------------------------------------------------------------

function getTurboBoostStatus()
    cmd = "cd "..parentDirPathToAnVMSRBinary.."; sudo ./anvmsr readmsr 1A0"
    ok,returnValue = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end
    --hs.alert.show(returnValue)
    strFindEnd,mm = string.find(returnValue, "850089", 1) 
    if (strFindEnd == 29) then
        savedTurboBoostSetting = true
        print("getTurboBoostStatus: enabled")
        return true
    else
        savedTurboBoostSetting = false
        print("getTurboBoostStatus: disabled")
        return false
    end
end

function setTurboBoost(desiredTurboBoostSetting)
    if (desiredTurboBoostSetting) then
        cmd = "cd "..parentDirPathToAnVMSRBinary.."; sudo ./anvmsr writemsr 1A0 850089"
        print("setTurboBoost:       enabled")
    else
        cmd = "cd "..parentDirPathToAnVMSRBinary.."; sudo ./anvmsr writemsr 1A0 0x4000850089"
        print("setTurboBoost:       disabled")
    end
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if result == false then
       hs.alert.show("Operation failed!")
    end
end

--TEMPERATURE----------------------------------------------------------------------------

function setTemperatureLimit(desiredTemperatureLimit)
    savedTemperatureLimit = desiredTemperatureLimit
    cmd = "cd "..parentDirPathToAnVMSRBinary.."; sudo ./anvmsr writemsr 1A2 "..(string.format("%x", 100 - desiredTemperatureLimit)).."640000"
    --hs.alert.show(cmd)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    print("setTemperatureLimit: "..tostring(desiredTemperatureLimit))
    if result == false then
        hs.alert.show("Operation failed!")
    end
    return desiredTemperatureLimit
end

function getTemperatureLimit()
    --hs.alert.show("4")
    cmd = "cd "..parentDirPathToAnVMSRBinary.."; sudo ./anvmsr readmsr 1A2"
    ok,returnValue = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end
    --hs.alert.show(returnValue)
    strFindEnd,mm = string.find(returnValue, "640000", 1) 
    if (strFindEnd == 29) then
        decNum = 0
    else
        hexStr = string.sub(returnValue, 29, strFindEnd - 1)
        decNum = tonumber(hexStr, 16)
    end
    -- hs.alert.show(strFindEnd)
    savedTemperatureLimit = 100 - decNum
    print("getTemperatureLimit: "..tostring(savedTemperatureLimit))
    --hs.alert.show(hexNum)
    return 100 - decNum
end

--GRAPHICS-------------------------------------------------------------------------------

function setGraphicsCardAuto()
    cmd = "sudo pmset -a gpuswitch 2"
    --hs.alert.show(cmd)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    print("setGraphicsMode:     2")
    if result == false then
        hs.alert.show("Operation failed!")
    end
end

function setGraphicsCardDedicated()
    cmd = "sudo pmset -a gpuswitch 1"
    --hs.alert.show(cmd)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    print("setGraphicsMode:     1")
    if result == false then
        hs.alert.show("Operation failed!")
    end
end

function setGraphicsCardIntegrated()
    cmd = "sudo pmset -a gpuswitch 0"
    --hs.alert.show(cmd)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    print("setGraphicsMode:     0")
    if result == false then
        hs.alert.show("Operation failed!")
    end
end

function getGraphicsCardMode()
    cmd = "pmset -g | grep gpuswitch"
    ok,returnValue = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end
    --hs.alert.show(returnValue)
    GPUStr = string.sub(returnValue, 23, 23)
    print("getGraphicsCardMode: "..GPUStr)
    --hs.alert.show(tonumber(GPUStr, 10))
    --hs.alert.show(hexNum)
    return tonumber(GPUStr, 10)
end

-----------------------------------------------------------------------------------------

mnu1:setMenu(menuTable1)
mnu1:setClickCallback(refreshStatus1())
mnu2:setMenu(menuTable2)
mnu2:setClickCallback(refreshStatus2())

-----------------------------------------------------------------------------------------

function caffeinateCallback(eventType)
    if (eventType == hs.caffeinate.watcher.systemDidWake) then
        print("systemDidWake")
        -- restore saved settings
        setTemperatureLimit(savedTemperatureLimit)
        setTurboBoost(savedTurboBoostSetting)
        setPowerLimit(savedPowerLimit)
        setBatteryChargingLimit(savedBatteryChargingLimit)
        setFansToAuto_user_plus()
        -------------------------
        refreshStatus1()
        refreshStatus2()
        

    -- elseif (eventType == hs.caffeinate.watcher.screensDidUnlock) then
    --     print("screensDidUnlock")
    --     setTemperatureLimit(savedTemperatureLimit)
    --     setTurboBoost(savedTurboBoostSetting)

    elseif (eventType == hs.caffeinate.watcher.systemWillSleep) then
        print("systemWillSleep")
        -- kill fan controller
        cmd = "sudo killall smc_fan_util"
        hs.osascript.applescript(string.format('do shell script "%s"', cmd))
        ----------------------
        -- set fans to auto
        setFansToAuto()
        -------------------
    elseif (eventType == hs.caffeinate.watcher.systemWillPowerOff) then
        print("systemWillPowerOff")
        -- set fans to auto
        setFansToAuto()
        -------------------
    end
end

caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
caffeinateWatcher:start()
