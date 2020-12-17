parentDirPathToAnVMSRBinary = "~/Documents/git/AnVMSR/Release-10.15"
parentDirPathTo_smc_fan_util_Binary = "~/Documents/git/charlie0129/smc_fan_util/build"
parentDirPathToSMCUtilBinary = "~/Documents/git/macNerdsUtilities"

savedTemperatureLimit = 0
savedTurboBoostSetting = false
savedPowerLimit = 0
savedBatteryChargingLimit = 100
isGPUModeTemporary = false

mnu1 = hs.menubar.new()
mnu2 = hs.menubar.new()

menuTable1 = {
    { title = "Mac Nerd's Utility", disabled = true },
    { title = "-" },
    { title = "Fans", disabled = true },
    { title = "Auto (SMC)", indent = 1, fn = function() setFansToAuto() end },
    { title = "Auto (User)", indent = 1, fn = function() setFansToAuto_user() end },
    { title = "Auto (SMC+, 0)", indent = 1, fn = function() setFansToAuto_user_plus(0) end },
    { title = "Auto (SMC+, 4)", indent = 1, fn = function() setFansToAuto_user_plus(4) end },
    { title = "Completely off", indent = 1, fn = function() turnOffFans() end },
    -- { title = ".22", indent = 1, fn = function() hs.osascript.applescript(string.format('do shell script "%s"', "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -m 1303 1207")) end },
    { title = ".25", indent = 1, fn = function() setFansBySpeed(1481, 1372) end },
    { title = "0%", indent = 1, fn = function() setFansByPercentage(0) end },
    { title = "10%", indent = 1, fn = function() setFansByPercentage(10) end },
    { title = "20%", indent = 1, fn = function() setFansByPercentage(20) end },
    { title = "30%", indent = 1, fn = function() setFansByPercentage(30) end },
    { title = "40%", indent = 1, fn = function() setFansByPercentage(40) end },
    { title = "50%", indent = 1, fn = function() setFansByPercentage(50) end },
    { title = "75%", indent = 1, fn = function() setFansByPercentage(75) end },
    { title = "100%", indent = 1, fn = function() setFansByPercentage(100) end },
    { title = "-" },
    { title = "Batt. Charge Limit", disabled = true },
    { title = "50%", indent = 1, fn = function() setBatteryChargeLimit(50); refreshStatus1() end },
    { title = "55%", indent = 1, fn = function() setBatteryChargeLimit(55); refreshStatus1() end },
    { title = "60%", indent = 1, fn = function() setBatteryChargeLimit(60); refreshStatus1() end },
    { title = "70%", indent = 1, fn = function() setBatteryChargeLimit(70); refreshStatus1() end },
    { title = "80%", indent = 1, fn = function() setBatteryChargeLimit(80); refreshStatus1() end },
    { title = "100%", indent = 1, fn = function() setBatteryChargeLimit(100); refreshStatus1() end },
    { title = "Custom...", indent = 1, fn = function() setBatteryChargeLimit(askForBatteryChargeLimit()); refreshStatus1() end },
    { title = "-" },
    { title = "GPU Mode", disabled = true },
    { title = "Auto switch", indent = 1, fn = function() setGraphicsCardAuto(); refreshStatus1() end },
    { title = "Integrated", indent = 1, fn = function() setGraphicsCardIntegrated(); refreshStatus1() end },
    { title = "High Performance", indent = 1, fn = function() setGraphicsCardDedicated(); refreshStatus1() end },
    { title = "Temporary Mode", indent = 1, fn = function() isGPUModeTemporary = not isGPUModeTemporary; refreshStatus1() end },
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
    { title = "Custom...", indent = 1, fn = function() setTemperatureLimit(askForTemperatureLimit()); refreshStatus2() end },
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
    { title = "Custom...", indent = 1, fn = function() setPowerLimit(askForPowerLimit()); refreshStatus2() end },
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
    currentBatteryChargingLimit = getBatteryChargeLimit()
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

    isAfterFanSpeed = false
    for idx, iTable in pairs(menuTable1) do
        if string.sub(iTable["title"], 1, 4) == "Batt" then
            isAfterFanSpeed = true
        end
        if isAfterFanSpeed then
            -- Tick battery charge limits
            if string.sub(iTable["title"], -1) == "%" then
                if iTable["title"] == tostring(currentBatteryChargingLimit).."%" then
                    iTable["checked"] = true
                else
                    iTable["checked"] = false
                end
            end
            -- Tick graphics card mode
            if iTable["title"] == "Auto switch" then
                if (currentGraphicsCardMode == 0) then
                    menuTable1[idx]["checked"] = false
                    menuTable1[idx + 1]["checked"] = true
                    menuTable1[idx + 2]["checked"] = false
                elseif (currentGraphicsCardMode == 1) then
                    menuTable1[idx]["checked"] = false
                    menuTable1[idx + 1]["checked"] = false
                    menuTable1[idx + 2]["checked"] = true
                elseif (currentGraphicsCardMode == 2) then
                    menuTable1[idx]["checked"] = true
                    menuTable1[idx + 1]["checked"] = false
                    menuTable1[idx + 2]["checked"] = false
                end
            end
            -- Tick 'Temporary' label
            if iTable["title"] == "Temporary Mode" then
                menuTable1[idx]["checked"] = isGPUModeTemporary
            end
        end
        
    end
    mnu1:setMenu(menuTable1)
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

    for idx, iTable in pairs(menuTable2) do
        -- Tick temperatures
        if string.sub(iTable["title"], -3) == "℃" then
            if iTable["title"] == tostring(currentTemperatureLimit).."℃" then
                iTable["checked"] = true
            else
                iTable["checked"] = false
            end
        end
        -- Tick power limits
        if string.sub(iTable["title"], -1) == "W" then
            if iTable["title"] == tostring(currentPowerLimit).."W" then
                iTable["checked"] = true
            else
                iTable["checked"] = false
            end
        end
        -- Tick Turbo Boost status
        if iTable["title"] == "Enable" then
            if currentTurboBoostStatus then
                iTable["checked"] = true
                menuTable2[idx + 1]["checked"] = false
            else
                iTable["checked"] = false
                menuTable2[idx + 1]["checked"] = true
            end
        end
    end
    mnu2:setMenu(menuTable2)
end

--BATTERY--------------------------------------------------------------------------------

function getBatteryChargeLimit()
    cmd = "cd "..parentDirPathToSMCUtilBinary.."; sudo ./smcutil -r BCLM"
    ok,returnValue = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end

    batteryLimit = tonumber(returnValue)

    return batteryLimit
end

function setBatteryChargeLimit(desiredBatteryChargeLimit)
    savedBatteryChargingLimit = desiredBatteryChargeLimit
    cmd = "cd "..parentDirPathToSMCUtilBinary.."; sudo ./smcutil -w BCLM "..string.format("%x", desiredBatteryChargeLimit)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if result == false then
        hs.alert.show("Operation failed!")
    end
end

function askForBatteryChargeLimit()
    button, input = hs.dialog.textPrompt("Set custom battery charge limit", "Please enter your battery charge limit (%)", tostring(getBatteryChargeLimit()), "OK", "Cancel")
    if (button == "Cancel") then
        return getBatteryChargeLimit()
    end

    input_num = math.floor(tonumber(input))
    if (input_num <= 100 and input_num >= 50) then
        return input_num
    else
        hs.alert.show("Invalid battery charge limit! Nothing will be changed.")
        return getBatteryChargeLimit()
    end
    return getBatteryChargeLimit()
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

function askForPowerLimit()
    button, input = hs.dialog.textPrompt("Set custom power limit", "Please enter your power limit (watts)", tostring(getPowerLimit()), "OK", "Cancel")
    if (button == "Cancel") then
        return getPowerLimit()
    end

    input_num = math.floor(tonumber(input))
    if (input_num < 500 and input_num > 5) then
        return input_num
        
    else
        hs.alert.show("Invalid power limit! Nothing will be changed.")
        return getPowerLimit()
    end
    return getPowerLimit()
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

function setFansBySpeed(speedL, speedR)
    cmd = "sudo killall smc_fan_util"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == true then
        hs.alert.show("Disabled a running instance of user-defined fan controller.")
    end

    cmd = "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -m "..tostring(speedL).." "..tostring(speedR)
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
    end

    cmd = "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util -A"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
    end
end

function setFansToAuto_user_plus(offset)
    cmd = "sudo killall smc_fan_util"
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == true then
        hs.alert.show("Disabled a running instance of user-defined fan controller.")
    end

    cmd = "cd "..parentDirPathTo_smc_fan_util_Binary.."; sudo ./smc_fan_util --SMC-enhanced --offset "..tostring(offset)
    ok = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    if ok == false then
        hs.alert.show("Operation failed!")
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

function askForTemperatureLimit()
    button, input = hs.dialog.textPrompt("Set custom temperature limit", "Please enter your temperature limit (celsius)", tostring(getTemperatureLimit()), "OK", "Cancel")
    if (button == "Cancel") then
        return getTemperatureLimit()
    end

    input_num = math.floor(tonumber(input))
    if (input_num <= 100 and input_num >= 50) then
        return input_num
    else
        hs.alert.show("Invalid temperature limit! Nothing will be changed.")
        return getTemperatureLimit()
    end
    return getTemperatureLimit()
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
        setPowerLimit(savedPowerLimit)
        setTemperatureLimit(savedTemperatureLimit)
        setTurboBoost(savedTurboBoostSetting)
        setBatteryChargeLimit(savedBatteryChargingLimit)
        -- setFansToAuto_user_plus(4)
        -------------------------
        refreshStatus1()
        refreshStatus2()
        

    -- elseif (eventType == hs.caffeinate.watcher.screensDidUnlock) then
    --     print("screensDidUnlock")
    --     setTemperatureLimit(savedTemperatureLimit)
    --     setTurboBoost(savedTurboBoostSetting)

    elseif (eventType == hs.caffeinate.watcher.systemWillSleep) then
        print("systemWillSleep")
        -- Revert GPU Mode to auto (if isGPUModeTemporary is true)
        if (isGPUModeTemporary) then
            setGraphicsCardAuto()
            isGPUModeTemporary = false;
        end

        -------------------
    elseif (eventType == hs.caffeinate.watcher.systemWillPowerOff) then
        print("systemWillPowerOff")
        -- kill fan controller and set fans to auto
        cmd = "sudo killall smc_fan_util"
        hs.osascript.applescript(string.format('do shell script "%s"', cmd))
        setFansToAuto()
        -- Revert GPU Mode to auto (if isGPUModeTemporary is true)
        if (isGPUModeTemporary) then
            setGraphicsCardAuto()
            isGPUModeTemporary = false;
        end
    end
end

caffeinateWatcher = hs.caffeinate.watcher.new(caffeinateCallback)
caffeinateWatcher:start()
