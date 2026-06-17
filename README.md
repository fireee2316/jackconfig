# jackconfig
Jack's NixOS configuration.nix file


-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("uwsm app -- grimblast save screen"))
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("uwsm app -- grimblast save active"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("uwsm app -- grimblast copy screen"))
hl.bind("ALT + SHIFT + PRINT", hl.dsp.exec_cmd("uwsm app -- grimblast copy active"))
hl.bind("XF86SelectiveScreenshot", hl.dsp.exec_cmd("uwsm app -- grimblast save area"))
hl.bind("SHIFT + XF86SelectiveScreenshot", hl.dsp.exec_cmd("uwsm app -- grimblast copy area"))
