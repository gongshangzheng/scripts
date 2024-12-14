// an example to create a new mapping `ctrl-y`
api.mapkey('<ctrl-y>', 'Show me the money', function() {
    Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
api.map('gt', 'T');

// an example to remove mapkey `Ctrl-i`
api.unmap('<ctrl-i>');

//lurk mode

//settings.lurkingPattern = /https:\/\/(www\.)?(youtube\.com|gmail\.com|bilibili\.com)/i;
//settings.lurkingPattern = /https:\/\/(www\.)?(gmail\.com)/i;

api.cmap('<Ctrl-n>', '<Tab>');
api.cmap('<Ctrl-p>', '<Shift-Tab>');

api.imap(',,', "<Esc>");        // 按两次逗号退出当前输入框。
api.imap(';;', "<Ctrl-'>");     // 按两次分号切换双引号。
api.mapkey('<Space>', 'Choose a tab with omnibar', function() {
    api.Front.openOmnibar({type: "Tabs"});
});

/////////////////////////////////////////////
// mapkeys
/////////////////////////////////////////////

api.mapkey("<Space>", "pause/resume on youtube", function() {
    var btn = document.querySelector("button.ytp-ad-overlay-close-button") || document.querySelector("button.ytp-ad-skip-button") || document.querySelector('ytd-watch-flexy button.ytp-play-button');
    btn.click();
}, {domain: /youtube.com/i});

api.map("<ctrl-g>", '<Esc>');
api.map('F', 'gf'); // open in new unactive tab
api.mapkey('p', "Open the clipboard's URL in the current tab", function() {
    navigator.clipboard.readText().then(
        text => {
            if (text.startsWith("http://") || text.startsWith("https://")) {
                window.location = text;
            } else {
                window.location = text = "https://www.google.com/search?q=" + text;
            }
        }
    );
});
api.mapkey('P', 'Open link from clipboard', function() {
    navigator.clipboard.readText().then(
        text => {
            if (text.startsWith("http://") || text.startsWith("https://")) {
                tabOpenLink(text);
            } else {
                tabOpenLink("https://www.google.com/search?q=" + text);
            }
        }
    );
});

/////////////////////////////////////////////
// searchalias
/////////////////////////////////////////////

api.addSearchAlias('d', 'duckduckgo', 'https://duckduckgo.com/?q=', 's', 'https://duckduckgo.com/ac/?q=', 'l', 'http://16.171.150.115:9090/bookmarks?q=', 'b', 'https://search.bilibili.com/all?keyword=', function(response) {
    var res = JSON.parse(response.text);
    return res.map(function(r){
        return r.phrase;
    });
});

/////////////////////////////////////////////
// set style
/////////////////////////////////////////////

api.Hints.style('border: solid 3px #552a48; color:#efe1eb; background: none; background-color: #552a48;');
api.Hints.style("div{border: solid 3px #707070; color:#efe1eb; background: none; background-color: #707070;} div.begin{color:red;}", "text");

api.Visual.style('marks', 'background-color: #89a1e2;');
api.Visual.style('cursor', 'background-color: #9065b7;');

/////////////////////////////////////////////
// set theme
/////////////////////////////////////////////
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// click `Save` button to make above settings to take effect.</ctrl-i></ctrl-y>


