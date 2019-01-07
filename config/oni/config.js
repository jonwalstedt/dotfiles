"use strict";
exports.__esModule = true;
exports.activate = function (oni) {
    console.log("config activated");
    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", function () { return console.log("Control+Enter was pressed"); });
    oni.input.bind(["<enter>", "<tab>"], "contextMenu.select");
    oni.input.unbind("<c-g>"); // make C-g work as expected in vim
    oni.input.unbind("<c-v>"); // make C-v work as expected in vim
    oni.input.bind("<s-c-g>", function () { return oni.commands.executeCommand("sneak.show"); }); // You can rebind Oni's behaviour to a new keybinding
    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")
};
exports.deactivate = function (oni) {
    console.log("config deactivated");
};
exports.configuration = {
    //add custom config here, such as
    //"ui.colorscheme": "nord",
    //"oni.useDefaultConfig": false,
    "oni.bookmarks": ["~/Documents"],
    "editor.fontSize": "12px",
    "editor.fontFamily": "Hack",
    // UI customizations
    "achievements.enabled": false,
    "autoClosingPairs.enabled": false,
    "autoUpdate.enabled": true,
    "commandline.mode": false,
    "editor.renderer": "webgl",
    "editor.textMateHighlighting.enabled": true,
    "editor.typingPrediction": true,
    "experimental.markdownPreview.enabled": true,
    "learning.enabled": false,
    "oni.hideMenu": "hidden",
    "oni.plugins.prettier": {
        formatOnSave: true,
        enabled: true,
        allowedFileTypes: [".jsx", ".js", ".ts", ".tsx", "css"]
    },
    "oni.useDefaultConfig": false,
    "oni.enhancedSyntaxHighlighting": true,
    "oni.loadInitVim": true,
    "sidebar.default.open": false,
    "sidebar.enabled": false,
    "statusbar.enabled": false,
    "tabs.mode": "native",
    "ui.animations.enabled": true,
    "ui.colorscheme": "n/a",
    "ui.fontSmoothing": "auto",
    "wildmenu.mode": false,
    "debug.neovimPath": "/Users/jonwalstedt/dev-tools/nvim-osx64/bin/nvim",
    activate: exports.activate
};
