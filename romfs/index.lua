save_manager_uniqueid = 0x02C23200
save_manager_filename = "/0004000002C23200.sav"
save_manager_name = "JKSM"

config_default = [[save_manager_uniqueid = 0x02C23200
save_manager_filename = "/0004000002C23200.sav"
save_manager_name = "JKSM"]]

co = Console.new(TOP_SCREEN)
function add(t)
    Screen.waitVblankStart()
    Screen.refresh()
    Screen.clear(TOP_SCREEN)
    Console.append(co, t)
    Console.show(co)
    Screen.flip()
    Screen.refresh()
    Console.show(co)
    Screen.flip()
end

co2 = Console.new(BOTTOM_SCREEN)
function add2(t)
    Screen.waitVblankStart()
    Screen.refresh()
    Screen.clear(BOTTOM_SCREEN)
    Console.append(co2, t)
    Console.show(co2)
    Screen.flip()
    Screen.refresh()
    Console.show(co2)
    Screen.flip()
end

if System.doesFileExist("/gwse_config.lua") then
    dofile("/gwse_config.lua")
    add2("/gwse_config.lua used\n\n")
else
    local cfgfile = io.open("/gwse_config.lua", FCREATE)
    io.write(cfgfile, 0, config_default, config_default:len())
    io.close(cfgfile)
    add2("/gwse_config.lua was created\n\n")
end

--- Returns HEX representation of num
function num2hex(num)
    local hexstr = '0123456789abcdef'
    local s = ''
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    if s == '' then s = '0' end
    return s
end

productcode = System.getGWRomID()
cardid = num2hex(System.getCardID()):upper()

function rename()
    System.deleteFile(save_manager_filename)
    local original = io.open("/000"..cardid..".sav",FREAD)
    local original_c = io.read(original, 0, io.size(original))
    local savefile = io.open(save_manager_filename, FCREATE)
    io.write(savefile, 0, original_c, #original_c)
    io.close(original)
    io.close(savefile)
end
function launch()
    Console.destroy(co)
    System.launchCIA(save_manager_uniqueid, SDMC)
end
function exit()
    Console.destroy(co)
    System.exit()
end

info = "Gateway Save Export Helper\n"
if productcode ~= "" then
    info = info.."\nProduct ID: "..productcode.."\n"
    info = info.."Title ID: 000"..cardid.."\n"
end
info = info.."\nSave manager:\n  "..save_manager_name.."\n"
info = info.."Save manager UniqueID:\n  "..num2hex(save_manager_uniqueid):upper().."\n"
info = info.."Save manager save file:\n  "..save_manager_filename.."\n\n"

fileexist = System.doesFileExist("/000"..cardid..".sav")
if fileexist then
    info = info.."A: Copy save & start "..save_manager_name.."\n"
    info = info.."X: Copy save & exit\n"
    info = info.."START: Do nothing & exit\n"
else
    if productcode == "" then
        info = info.."Please choose a ROM to use!\n"
    else
        info = info.."Save file for this game does not exist!\n"
    end
    info = info.."START: Exit\n"
end
add(info)

while true do
    local pad = Controls.read()
    if Controls.check(pad, KEY_A) and fileexist then
        add2("Copying save\n")
        rename()
        add2("Launching "..save_manager_name.."\n")
        launch()
    elseif Controls.check(pad, KEY_X) and fileexist then
        add2("Copying save\n")
        rename()
        add2("Exiting\n")
        exit()
    elseif Controls.check(pad, KEY_START) then
        add2("Exiting\n")
        exit()
    end
end
