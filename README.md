# Gateway Save Export Helper

Nintendo 3DS homebrew tool to help export saves from Gateway saves. Originally created probably May 29 2016, then edited June 18 2016.

Default config uses JKSM. If you want to change the title ID, run the program once and edit `/config.lua` or create the file and insert/modify:

```lua
save_manager_uniqueid = 0x02C23200
save_manager_filename = "/0004000002C23200.sav"
save_manager_name = "JKSM"
```

## License/Credits
Gateway Save Export Helper licensed under MIT. Uses a modified lpp-3ds which uses GPLv3; see `/extra/lpp-3ds-mod.md`. Banner and icon graphics by [@TheReturningVoid](https://github.com/TheReturningVoid).
