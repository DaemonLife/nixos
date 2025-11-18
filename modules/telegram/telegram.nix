{ config
, lib
, pkgs
, ...
}:
with config.lib.stylix.colors; let
  telegram_experimental_options = ''
    {
        "fractional-scaling-enabled": true,
        "send-large-photos": true
    }
  '';
  telegram_binds = ''
    // This is a list of changed shortcuts for Telegram Desktop
    // You can edit them in Settings > Chat Settings > Keyboard Shortcuts.
    [
        {
            "command": "search",
            "keys": "alt+/"
        },
        {
            "command": "show_contacts",
            "keys": "alt+c"
        },
        {
            "command": "next_chat",
            "keys": "alt+j"
        },
        {
            "command": "previous_chat",
            "keys": "alt+k"
        },
        {
            "command": "next_folder",
            "keys": "alt+shift+j"
        },
        {
            "command": "previous_folder",
            "keys": "alt+shift+k"
        }
    ]
  '';

  telegram_style = ''
    // --- Main UI ---
    windowBg: #${base00};
    windowFg: #${base05};
    windowBgOver: #${base01}; // hover bg in menu
    windowFgOver: #${base06}; // hover fg in menu
    menuBg: #${base00}; // global bg popup animation after click
    windowFgActive: #${base00}; // fg for some light buttons

    // some boxes in ui
    boxBg: windowBg;
    boxTextFg: windowFg;
    boxTextFgGood: #${base0B};
    boxTextFgError: #${base08};
    boxTitleFg: windowFg;
    boxSearchBg: #${base01};
    boxTitleAdditionalFg: #${base06};
    boxTitleCloseFg: #${base05};
    boxTitleCloseFgOver: #${base06};

    // up /\ and down \/ arrow for chat and chat list
    historyToDownBg: #${base01}7f;
    historyToDownBgOver: #${base01};
    historyToDownBgRipple: #${base0D};
    historyToDownFg: #${base05};
    historyToDownFgOver: #${base06};
    historyToDownShadow: #00000000;

    // bottom button in chat or channel (mute/unmute/join)
    historyComposeButtonBg: #${base01};
    historyComposeButtonBgOver: #${base02};
    historyComposeButtonBgRipple: #${base0D};

    // activate buttons
    activeButtonBg: #${base01};
    activeButtonBgOver: #${base02};
    activeButtonBgRipple: #${base0D};
    activeButtonFg: #${base05};
    activeButtonFgOver: #${base06};
    activeButtonSecondaryFg: #${base06};
    activeButtonSecondaryFgOver: #${base07};

    // back cancel, close buttons
    cancelIconFg: #${base05};
    cancelIconFgOver: #${base06};
    walletTitleButtonCloseFgActiveOver: #${base08};

    // --- RBM menu ---
    menuSeparatorFg: #${base01};
    windowBgRipple: #${base02}; // RBM emoji arrow and some animations bg
    menuBgRipple: #${base00};
    menuIconFg: #${base05};
    menuIconFgOver: #${base06};

    // --- Main settings menu ---
    mainMenuBg: #${base00};
    mainMenuCoverBg: #${base01};
    mainMenuCoverFg: #${base05};
    checkboxFg: #${base05}; // checkbox and radio buttons
    sliderBgInactive: #${base01}; // slider (notifications and sounds)
    sliderBgActive: #${base06};

    windowSubTextFg: #${base05};
    windowSubTextFgOver: #${base06};
    windowBoldFg: #${base05}; // fg text in some menu
    windowBoldFgOver: #${base06}; // hover fg text in some menu
    windowActiveTextFg: #${base04}; // setap status, description (on, off, ...)

    // --- Notificaton ---
    notificationBg: #${base00};

    // --- Program window title ---
    titleBg: #${base00};
    titleFg: #${base05};

    titleFgActive: titleFg;
    titleBgActive: titleBg;
    titleButtonBg: titleBg;
    titleButtonFg: titleFg;
    titleButtonBgOver: #${base01};
    titleButtonFgOver: titleFg;
    titleButtonBgActive: titleBgActive;
    titleButtonFgActive: titleFgActive;
    titleButtonBgActiveOver: titleButtonBgOver;
    titleButtonFgActiveOver: titleFgActive;
    titleButtonCloseBg: titleBg;
    titleButtonCloseFg: titleFg;
    titleButtonCloseBgOver: #${base08};
    titleButtonCloseFgOver: #${base00};
    titleButtonCloseBgActive: titleBgActive;
    titleButtonCloseFgActive: titleFgActive;
    titleButtonCloseBgActiveOver: titleButtonCloseBgOver;
    titleButtonCloseFgActiveOver: titleButtonCloseFgOver;

    // --- Scroll in CHAT LIST ---
    // bar itself
    scrollBarBg: #${base04};
    scrollBarBgOver: #${base05};
    // only bg
    scrollBg: #${base01};
    scrollBgOver: #${base02};

    // --- Scroll in CHAT ---
    // bar itself
    historyScrollBarBg: scrollBarBg;
    historyScrollBarBgOver: scrollBarBgOver;
    // only bg
    historyScrollBg: scrollBg;
    historyScrollBgOver: scrollBgOver;

    // --- Media player ---
    windowBgActive: #${base0D}; // player progress line fg in chat and (NO WAY!!!...) sliders color, blue default
    mediaviewPlaybackProgressFg: #${base04}; // player progress line bg in chat and FUCK DAMN time clock in full screen video

    // --- Top compact media player ---
    mediaPlayerBg: #${base00};
    mediaPlayerActiveFg: #${base05};
    mediaPlayerInactiveFg: #${base04};
    mediaPlayerDisabledFg: #${base03};

    // --- Media in full screen ---
    // loading icon
    radialFg: #${base05};
    radialBg: #${base01};

    mediaviewMenuFg: #${base05}; // menu text fg
    mediaviewMenuBgOver: #${base03}; // statick bg of speed line
    mediaviewBg: #${base00};
    mediaviewVideoBg: mediaviewBg;
    mediaviewControlFg: mediaviewMenuFg;

    // caption for photo
    mediaviewCaptionBg: #${base00}aa;
    mediaviewCaptionFg: #${base05};
    mediaviewTextLinkFg: #${base0D};

    // when clicked save button
    mediaviewSaveMsgBg: #${base01};
    mediaviewSaveMsgFg: #${base05};

    // video player
    mediaviewPlaybackActive: #${base05}; // status line fs player
    mediaviewPlaybackInactive: #${base03}; // inactive status line fs player
    mediaviewPlaybackActiveOver: #${base06};
    mediaviewPlaybackInactiveOver: #${base04};
    mediaviewPlaybackIconFg: #${base05};
    mediaviewPlaybackIconFgOver: #${base06};

    // transparent layer (for png)
    mediaviewTransparentBg: #000000ff;
    mediaviewTransparentFg: #${base06};

    // --- Effects ---
    titleShadow: #00000000;
    windowShadowFg: #0000007f;
    windowShadowFgFallback: #0000007f;
    shadowFg: #${base00}; // borders color
    slideFadeOutBg: #0000007f;
    slideFadeOutShadowFg: #0000007f;
    imageBg: #000000ff;
    imageBgTransparent: #000000ff;
    layerBg: #00000050; // Side bar shade

    // input messages in chat
    msgInShadow: #00000000;
    msgInShadowSelected: #00000000;

    // output messages in chat
    msgOutShadow: #00000000;
    msgOutShadowSelected: #00000000;

    // --- Cancel operation button ---
    lightButtonBg: #${base01};
    lightButtonBgOver: #${base02};
    lightButtonBgRipple: #${base01};
    lightButtonFg: #${base05};
    lightButtonFgOver: #${base06};

    // --- Attention (log out button) ---
    attentionButtonFg: #${base05};
    attentionButtonFgOver: #${base00};
    attentionButtonBgOver: #${base08};
    attentionButtonBgRipple: #${base08};

    // --- Close button in notifications? ---
    smallCloseIconFg: #${base05};
    smallCloseIconFgOver: #${base06};

    // --- Message input box ---
    placeholderFg: #${base05}; // 'Wrtie a message...' text (and fg search input... IDIOTS!!!)
    placeholderFgActive: #${base04}; // 'Wrtie a message...' text active (and fg search input active..)
    historyComposeIconFg: #${base05};
    historyComposeIconFgOver: #${base06};

    historyComposeAreaBg: #${base00};
    historyComposeAreaFg: historyComposeIconFg;
    historyComposeAreaFgService: historyComposeIconFg;
    historySendIconFg: historyComposeIconFg;
    historySendIconFgOver: historyComposeIconFgOver;
    historyPinnedBg: #${base00};
    historyReplyBg: historyComposeAreaBg;
    historyReplyIconFg: historyComposeIconFg;
    historyReplyCancelFg: historyComposeIconFg;
    historyReplyCancelFgOver: historyComposeIconFgOver;

    // --- Popup when hover message's clock ---
    tooltipBg: #${base00};
    tooltipFg: #${base05};
    tooltipBorderFg: #${base01};

    // --- System tray icon ---
    trayCounterBg: #${base03};
    trayCounterBgMute: #${base01};
    trayCounterFg: #${base05};
    trayCounterBgMacInvert: #${base05};
    trayCounterFgMacInvert: #${base00};

    // --- Contacts menu ---
    contactsBg: #${base00};
    contactsBgOver: windowBgOver;
    contactsNameFg: boxTextFg;
    contactsStatusFg: windowSubTextFg;
    contactsStatusFgOver: windowSubTextFgOver;
    contactsStatusFgOnline: #${base05};

    // --- Photo editor ---
    photoCropFadeBg: #000000aa;
    photoCropPointFg: #${base02}7f;

    // --- Login menu? ---
    introBg: #${base00};
    introTitleFg: #${base05};
    introDescriptionFg: windowSubTextFg;
    introErrorFg: #${base05};
    introCoverTopBg: #${base00};
    introCoverBottomBg: #${base00};
    introCoverIconsFg: #${base05};
    introCoverPlaneTrace: #${base04};
    introCoverPlaneInner: #${base03};
    introCoverPlaneOuter: #${base04};
    introCoverPlaneTop: #${base03};
    dialogsMenuIconFg: menuIconFg;
    dialogsMenuIconFgOver: menuIconFgOver;

    // --- SMS/PUSH input box? ---
    inputBorderFg: #${base05};

    // --- List of chats, channels and bots ---
    dialogsBg: #${base00};
    dialogsNameFg: #${base05};
    dialogsChatIconFg: dialogsNameFg;
    dialogsDateFg: dialogsNameFg;
    dialogsTextFg: dialogsNameFg;
    dialogsTextFgService: dialogsNameFg;
    dialogsDraftFg: dialogsNameFg;
    dialogsVerifiedIconBg: dialogsNameFg;
    dialogsVerifiedIconFg: dialogsBg;
    dialogsSendingIconFg: dialogsNameFg;
    dialogsSentIconFg: dialogsNameFg;

    // chat msg counter icon
    dialogsUnreadBg: #${base0D};
    dialogsUnreadBgMuted: #${base04};
    dialogsUnreadFg: #${base00};

    dialogsTextFgOver: #${base06};
    dialogsBgOver: #${base01};
    dialogsTextFgServiceOver: dialogsTextFgOver;
    dialogsNameFgOver: dialogsTextFgOver;
    dialogsChatIconFgOver: dialogsTextFgOver;
    dialogsDateFgOver: dialogsTextFgOver;
    dialogsDraftFgOver: dialogsTextFgOver;
    dialogsVerifiedIconBgOver: dialogsVerifiedIconBg;
    dialogsVerifiedIconFgOver: dialogsVerifiedIconFg;
    dialogsSendingIconFgOver: dialogsSendingIconFg;
    dialogsSentIconFgOver: dialogsSentIconFg;
    dialogsUnreadBgOver: dialogsUnreadBg;
    dialogsUnreadBgMutedOver: dialogsUnreadBgMuted;
    dialogsUnreadFgOver: dialogsUnreadFg;

    dialogsBgActive: #${base02};
    dialogsNameFgActive: #${base06};
    dialogsChatIconFgActive: #${base06};
    dialogsDateFgActive: #${base06};
    dialogsTextFgActive: #${base06};
    dialogsTextFgServiceActive: #${base06};
    dialogsDraftFgActive: #${base06};
    dialogsVerifiedIconBgActive: #${base06};
    dialogsVerifiedIconFgActive: dialogsVerifiedIconFg;
    dialogsSendingIconFgActive: dialogsSendingIconFg;
    dialogsSentIconFgActive: #${base06};
    dialogsUnreadBgActive: #${base06};
    dialogsUnreadBgMutedActive: dialogsUnreadBgMuted;
    dialogsUnreadFgActive: dialogsUnreadFg;
    dialogsForwardBg: dialogsBgActive;
    dialogsForwardFg: dialogsNameFgActive;

    // --- Search ---
    filterInputActiveBg: #${base02}; // top search box in chat list
    filterInputInactiveBg: filterInputActiveBg;
    filterInputBorderFg: #${base02}; // ???
    searchedBarBg: #${base00}; // bottom bar bg
    searchedBarFg: #${base04}; // bottom bar fg

    // --- Emoji, stickers, GIFs panel ---
    emojiPanBg: #${base01};
    emojiPanCategories: #${base01};
    emojiPanHeaderFg: #${base05};
    emojiPanHeaderBg: #${base01}; // it does not works...
    emojiIconFg: #${base05}; // emoji category fg
    stickerPreviewBg: #${base00}7f; // full screen bg
    stickerPanDeleteBg: #${base01}; // delete icon for sticker
    stickerPanDeleteFg: #${base05};

    // --- In chat ---
    topBarBg: #${base00}; // chat top bar

    reportSpamBg: #${base00};
    reportSpamFg: #${base05};

    // Media in msg wheh msg selected
    msgSelectOverlay: #${base0D}7f;
    msgStickerOverlay: #${base0D}7f;

    // sound icon in msg media
    historyFileThumbIconFg: #${base05};
    historyFileThumbIconFgSelected: #${base0D};

    // media download animation in msg
    historyFileThumbRadialFg: historyFileThumbIconFg;
    historyFileThumbRadialFgSelected: historyFileThumbIconFgSelected;

    // servis msg is msg of chat itself
    msgServiceFg: #${base06};
    msgServiceBg: #${base01};
    msgServiceBgSelected: #${base0D};

    // date on image in msg
    msgDateImgFg: #${base05};
    msgDateImgBg: #${base01}7f;
    msgDateImgBgOver: msgDateImgBg;
    msgDateImgBgSelected: #${base01};

    // bot buttons
    msgBotKbOverBgAdd: msgServiceBg;
    msgBotKbIconFg: msgServiceFg;
    msgBotKbRippleBg: menuBgRipple;

    // --- Input message in chat ---
    historyTextInFg: #${base05};
    historyCaptionInFg: historyTextInFg;
    historyFileNameInFg: historyTextInFg;
    historySendingInIconFg: historyTextInFg;
    msgInBg: #${base00};
    msgInServiceFg: historyTextInFg;
    msgInDateFg: historyTextInFg;
    msgInMonoFg: historyTextInFg;
    msgInReplyBarColor: historyTextInFg;
    msgInReplyBarSelColor: historyTextInFg;

    historyFileInIconFg: msgInBg;
    historyFileInRadialFg: msgInBg;
    msgFileThumbLinkInFg: lightButtonFg;
    msgFileInBg: #${base05};
    msgFileInBgOver: #${base06};

    msgWaveformInActive: #${base0D};
    msgWaveformInInactive: #${base02};
    mediaInFg: msgInDateFg;
    historyLinkInFg: #${base0E};

    // selected
    historyTextInFgSelected: #${base00};
    msgInBgSelected: #${base0D};
    msgInServiceFgSelected: #${base0D};
    msgInDateFgSelected: #${base00};
    historyFileInIconFgSelected: #${base0D};
    historyFileInRadialFgSelected: historyFileInIconFgSelected;
    msgFileThumbLinkInFgSelected: #${base05};
    msgFileInBgSelected: windowBoldFg;
    msgWaveformInActiveSelected: #${base06};
    msgWaveformInInactiveSelected: #${base01};
    mediaInFgSelected: #${base06};

    // --- Output message in chat (from me) ---
    historyTextOutFg: #${base00};
    historyCaptionOutFg: historyTextOutFg;
    historyFileNameOutFg: historyTextOutFg;
    historyOutIconFg: historyTextOutFg;
    msgOutBg: #${base05};
    msgOutDateFg: historyTextOutFg;
    msgOutServiceFg: historyTextOutFg;
    msgOutMonoFg: historyTextOutFg;
    msgOutReplyBarColor: historyTextOutFg;

    historyFileOutIconFg: msgOutBg;
    historyFileOutRadialFg: msgOutBg;
    msgFileThumbLinkOutFg: #${base0D}; // 'OPEN WITH' file text
    msgFileOutBg: #${base00};
    msgFileOutBgOver: #${base01};

    msgWaveformOutActive: msgWaveformInActive;
    msgWaveformOutInactive: msgWaveformInInactive;

    mediaOutFg: historyTextOutFg;
    historyLinkOutFg: #${base0E};

    // selected like in
    historyTextOutFgSelected: historyTextInFgSelected;
    historyOutIconFgSelected: historyTextInFgSelected;
    msgOutReplyBarSelColor: msgInReplyBarSelColor;
    historySendingOutIconFg: historyTextInFgSelected;
    msgFileThumbLinkOutFgSelected: historyTextInFgSelected;
    msgFileOutBgSelected: msgFileInBgSelected;
    msgWaveformOutActiveSelected: msgWaveformInActiveSelected;
    msgWaveformOutInactiveSelected: msgWaveformInInactiveSelected;
    mediaOutFgSelected: mediaInFgSelected;
    historyFileOutIconFgSelected: historyFileInIconFgSelected;
    historyFileOutRadialFgSelected: historyFilenInRadialFgSelected;
    msgOutServiceFgSelected: msgInServiceFgSelected;
    msgOutDateFgSelected: msgInDateFgSelected;
    msgOutBgSelected: msgInBgSelected;


    // --- User withoin avatar ---
    historyPeerUserpicFg: #${base01}; // default color
    historyPeer1NameFg: #${base08}; // red
    historyPeer1UserpicBg: #${base08};
    historyPeer2NameFg: #${base0B}; // green
    historyPeer2UserpicBg: #${base0B};
    historyPeer3NameFg: #${base0A}; // yellow
    historyPeer3UserpicBg: #${base0A};
    historyPeer4NameFg: #${base0C}; // blue
    historyPeer4UserpicBg: #${base0C};
    historyPeer5NameFg: #${base0E}; // purple
    historyPeer5UserpicBg: #${base0E};
    historyPeer6NameFg: #${base0F}; // pink
    historyPeer6UserpicBg: #${base0F};
    historyPeer7NameFg: #${base0D}; // sea
    historyPeer7UserpicBg: #${base0D};
    historyPeer8NameFg: #${base09}; // orange
    historyPeer8UserpicBg: #${base09};

    // --- Files/links ---
    msgFile1Bg: #${base01}; // blue
    msgFile1BgDark: #${base0D};
    msgFile1BgOver: #${base04};
    msgFile1BgSelected: #${base04};
    msgFile2Bg: #${base01}; // green
    msgFile2BgDark: #${base0B};
    msgFile2BgOver: #${base04};
    msgFile2BgSelected: #${base04};
    msgFile3Bg: #${base01}; // red
    msgFile3BgDark: #${base08};
    msgFile3BgOver: #${base04};
    msgFile3BgSelected: #${base04};
    msgFile4Bg: #${base01}; // yellow
    msgFile4BgDark: #${base0A};
    msgFile4BgOver: #${base04};
    msgFile4BgSelected: #${base04};

    youtubePlayIconBg: #${base00}80; // youtube
    youtubePlayIconFg: #${base08};
    videoPlayIconBg: #${base00}80; // other video services
    videoPlayIconFg: #${base0D};

    toastBg: #${base00}; // for link t.me ?
    toastFg: #${base05};

    // --- Side bar ---
    sideBarBg: #${base00};
    sideBarBgActive: sideBarBg;
    sideBarIconFg: #${base04};
    sideBarIconFgActive: #${base0C};
    sideBarBadgeBg: sideBarIconFgActive;
    sideBarBadgeBgMuted: sideBarIconFg; // not active or muted badge
    sideBarBadgeFg: sideBarBg; // text in badge
    sideBarBgRipple: #${base08}; // bg animation when icon clicked

    // both work like active lol
    sideBarTextFgActive: sideBarIconFgActive;
    sideBarTextFg: sideBarIconFg;

    // --- ??? ---
    activeLineFg: #${base05};
    activeLineFgError: #${base05};
    outlineButtonBg: #${base00};
    outlineButtonBgOver: lightButtonBgOver;
    outlineButtonOutlineFg: windowBgActive;
    outlineButtonBgRipple: lightButtonBgRipple;
    menuSubmenuArrowFg: #${base03};
    menuFgDisabled: #${base03};
    membersAboutLimitFg: windowSubTextFgOver;
    historyIconFgInverted: #${base05};
    historySendingInvertedIconFg: #${base05};
    historyUnreadBarBg: #${base00};
    historyUnreadBarBorder: shadowFg;
    historyUnreadBarFg: #${base05};
    historyForwardChooseBg: #${base03}80;
    historyForwardChooseFg: #${base05};
    msgImgReplyBarColor: #${base05};
    overviewCheckBg: #${base03}80;
    overviewCheckFg: #${base04};
    overviewCheckFgActive: #${base01};
    overviewPhotoSelectOverlay: #bdbdbd4a;
    profileStatusFgOver: #${base04};
    profileVerifiedCheckBg: #${base05};
    profileVerifiedCheckFg: #${base01};
    profileAdminStartFg: #${base05};
    notificationsBoxMonitorFg: #${base05};
    notificationsBoxScreenBg: windowSubTextFg;
    notificationSampleUserpicFg: #${base01};
    notificationSampleCloseFg: #${base05};
    notificationSampleTextFg: #${base05};
    notificationSampleNameFg: #${base04};
    mediaviewFileBg: #000000;
    mediaviewFileNameFg: #${base05};
    mediaviewFileSizeFg: windowSubTextFg;
    mediaviewFileRedCornerFg: #${base08};
    mediaviewFileYellowCornerFg: #${base0A};
    mediaviewFileGreenCornerFg: #${base0B};
    mediaviewFileBlueCornerFg: #${base0D};
    mediaviewFileExtFg: activeButtonFg;
    mediaviewMenuBg: #${base00};
    mediaviewMenuBgRipple: menuBgRipple;
    mediaviewControlBg: #${base07}80;
    mainMenuCloudBg: #${base03};
    overviewCheckBorder: #${base08};
    dialogsOnlineBadgeFgActive: #${base08};
    menuBgOver: #${base02};
  '';
in
{
  home.packages = with pkgs; [
    telegram-desktop
  ];

  home.activation.telegram_style = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # create theme
    cd $HOME/.config && echo "${telegram_style}" > tmp_colors.tdesktop-theme;
    sed '/^#/d' tmp_colors.tdesktop-theme > colors.tdesktop-theme;
    ${pkgs.imagemagick}/bin/magick -size 2960x2960 xc:#${base02} background.jpg;
    ${pkgs.zip}/bin/zip telegram-base16.zip background.jpg colors.tdesktop-theme;
    mv telegram-base16.zip telegram-base16.tdesktop-theme;
    rm -rf colors.tdesktop-theme tmp_colors.tdesktop-theme background.jpg;

    # create binds
    mkdir -p $HOME/.local/share/TelegramDesktop/tdata &&
    cd $HOME/.local/share/TelegramDesktop/tdata &&
    echo '${telegram_binds}' > shortcuts-custom.json

    # create experimental options
    echo '${telegram_experimental_options}' > experimental_options.json
  '';
}
