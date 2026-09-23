{
  config,
  lib,
  pkgs,
  ...
}:
# Telegram Desktop theme generated from the stylix base16 palette.
#
# Format reference:
#   https://github.com/telegramdesktop/tdesktop/wiki/Theme-Reference
# Every key with the developers' own comments (the source of truth):
#   ui/colors.palette in https://github.com/desktop-app/lib_ui
# Key -> UI location map:
#   https://vkarach.github.io/oleander-palette/
#
# How the file format works:
#   - one "key: value;" per line, "//" starts a comment;
#   - a value is #rrggbb, #rrggbbaa, or the name of another key;
#   - unknown names are NOT errors: they are treated as custom constants.
#     That is handy (see the palette block below), but it also means a typo
#     in a key name is silently ignored. Check names in the in-app editor
#     (Settings > Chat Settings > Create new theme) if something doesn't apply.
#
# Telegram does not watch this file. Open it once from
# Settings > Chat Settings > Choose from file; after a stylix palette change,
# open it again (Telegram keeps its own copy of the applied theme).
let
  c = config.lib.stylix.colors; # base00..base0F as "rrggbb", without "#"

  palette = ''
    // ================================================================
    // Palette: custom constants, so the rest of the file stays readable
    // and only these lines depend on stylix.
    // ================================================================
    base00: #${c.base00}; // default background
    base01: #${c.base01}; // lighter background: panels, popups
    base02: #${c.base02}; // selection background
    base03: #${c.base03}; // comments, invisibles
    base04: #${c.base04}; // dark foreground: secondary text
    base05: #${c.base05}; // default foreground
    base06: #${c.base06}; // light foreground
    base07: #${c.base07}; // light background
    base08: #${c.base08}; // red
    base09: #${c.base09}; // orange
    base0A: #${c.base0A}; // yellow
    base0B: #${c.base0B}; // green
    base0C: #${c.base0C}; // cyan
    base0D: #${c.base0D}; // blue
    base0E: #${c.base0E}; // magenta
    base0F: #${c.base0F}; // brown

    // Main accent: buttons, links, badges, progress bars, send icon.
    accent: base0D;
    // Unread badge of muted chats / folders. Its digits share the color of
    // the normal badge (base00), so it needs to be light enough for them.
    badgeMuted: base04;

    // Outgoing message bubbles. Default: a quiet bubble on base02, so every
    // accent color stays readable inside it.
    outBg: base02;         // bubble
    outBgSelected: base03; // bubble when the message is selected
    outFg: base06;         // text (base05 is often too dim on base02)
    outSubFg: base04;      // time, "sending" clock, file status
    outAccent: base0D;     // links, ticks, reply bar, forwarded-from name
    outCode: base0B;       // `monospace` text
    // Inverted bubbles (text on base05) instead: replace the six lines above
    // with the ones below. Links then share the text color, because accents
    // on base05 often have too little contrast.
    //   outBg: base05; outBgSelected: base04; outFg: base00;
    //   outSubFg: base02; outAccent: base00; outCode: base00;

    // ================================================================
    // Generic window colors. Many keys below fall back to these in the
    // default palette, so they set the overall look.
    // ================================================================
    windowBg: base00;           // generic background
    windowFg: base05;           // generic text
    windowBgOver: base01;       // background with mouse over
    windowBgRipple: base02;     // click ripple effect
    windowFgOver: base06;       // text with mouse over
    windowSubTextFg: base04;    // secondary text (descriptions, "last seen")
    windowSubTextFgOver: base04;
    windowBoldFg: base06;       // bold text (names, headers in settings)
    windowBoldFgOver: base06;
    windowBgActive: accent;     // filled active areas (also default slider fill)
    windowFgActive: base00;     // text drawn on windowBgActive
    windowActiveTextFg: accent; // active text: "online", enabled options
    windowShadowFg: base00;
    windowShadowFgFallback: base00;
    shadowFg: base00;
    slideFadeOutBg: base00;
    slideFadeOutShadowFg: base00;
    imageBg: base00;            // behind photos smaller than the minimum size
    imageBgTransparent: base00; // behind images with an alpha channel

    // ================================================================
    // Buttons
    // ================================================================
    // Filled "primary" buttons (Send in boxes, Join, Save...).
    activeButtonBg: accent;
    activeButtonBgOver: accent;
    activeButtonBgRipple: base0C;
    activeButtonFg: base00;
    activeButtonFgOver: base00;
    activeButtonSecondaryFg: base01; // counter inside a primary button (Forward 3)
    activeButtonSecondaryFgOver: base01;
    // Underline of a focused text field (login code, box inputs).
    activeLineFg: accent;
    activeLineFgError: base08;
    // Flat text buttons in boxes (Cancel, Save, Close).
    lightButtonBg: base00;
    lightButtonBgOver: base01;
    lightButtonBgRipple: base02;
    lightButtonFg: accent;
    lightButtonFgOver: accent;
    // Destructive buttons (Log out, Delete).
    attentionButtonFg: base08;
    attentionButtonFgOver: base08;
    attentionButtonBgOver: base02;
    attentionButtonBgRipple: base03;
    // Buttons with a left outline (shared media links in profiles).
    outlineButtonBg: base00;
    outlineButtonBgOver: base01;
    outlineButtonOutlineFg: accent;
    outlineButtonBgRipple: base02;

    // ================================================================
    // Popup menus (right-click menu, main menu items)
    // ================================================================
    menuBg: base01;
    menuBgOver: base02;
    menuBgRipple: base03;
    menuIconFg: base04;
    menuIconFgOver: base05;
    menuSubmenuArrowFg: base04;
    menuFgDisabled: base03;
    menuSeparatorFg: base02;

    // ================================================================
    // Scroll bars (everywhere except the chat view, see historyScroll*)
    // ================================================================
    scrollBarBg: base02;     // the bar itself
    scrollBarBgOver: base03; // the bar with mouse over it
    scrollBg: base00;
    scrollBgOver: base01;    // the track with mouse over the scroll area

    // ================================================================
    // Small shared controls
    // ================================================================
    smallCloseIconFg: base04; // small X (terminate session, remove item)
    smallCloseIconFgOver: base05;
    radialFg: base05;         // circular loading indicator
    radialBg: base01;
    placeholderFg: base04;       // input placeholder ("Write a message...", "Search")
    placeholderFgActive: base03; // placeholder while the field is focused
    inputBorderFg: base03;       // bottom border of an unfocused field
    filterInputBorderFg: accent; // chat list search field border when focused
    filterInputActiveBg: base01; // chat list search field background, focused
    filterInputInactiveBg: base01; // ...and unfocused
    checkboxFg: base04;          // unchecked checkbox / radio outline
    sliderBgInactive: base02;    // settings sliders (scale, volume): empty part
    sliderBgActive: accent;      // ...filled part
    tooltipBg: base01;           // tooltip (hover a message timestamp)
    tooltipFg: base05;
    tooltipBorderFg: base02;
    cancelIconFg: base04;        // close icon in settings, search cancel icon
    cancelIconFgOver: base05;
    layerBg: #${c.base00}b3; // dims what is behind the main menu and boxes: the only translucent key

    // ================================================================
    // Custom window title bar (used when the system title bar is off)
    // ================================================================
    titleShadow: base00;
    titleBg: base00;       // inactive window
    titleBgActive: base00; // active window
    titleFg: base04;       // title text, inactive window
    titleFgActive: base05; // title text, active window
    titleButtonBg: titleBg; // minimize / maximize buttons, inactive window
    titleButtonFg: base04;
    titleButtonBgOver: base01;
    titleButtonFgOver: base05;
    titleButtonBgActive: titleBgActive; // ...active window
    titleButtonFgActive: base05;
    titleButtonBgActiveOver: base01;
    titleButtonFgActiveOver: base06;
    titleButtonCloseBg: titleBg; // close button, inactive window
    titleButtonCloseFg: base04;
    titleButtonCloseBgOver: base08;
    titleButtonCloseFgOver: base00;
    titleButtonCloseBgActive: titleBgActive; // ...active window
    titleButtonCloseFgActive: base05;
    titleButtonCloseBgActiveOver: base08;
    titleButtonCloseFgActiveOver: base00;

    // ================================================================
    // Tray icon unread counter
    // ================================================================
    trayCounterBg: base08;
    trayCounterBgMute: badgeMuted; // all unread chats are muted
    trayCounterFg: base00;

    // ================================================================
    // Boxes (modal dialogs) and their lists
    // ================================================================
    boxBg: base00; // same as windowBg: settings rows are drawn on windowBg
    boxDividerBg: base00; // gap between groups of rows in settings and boxes
    boxTextFg: base05;
    boxTextFgGood: base0B;  // "username is available"
    boxTextFgError: base08; // "username is taken"
    boxTitleFg: base06;
    boxTitleAdditionalFg: base04; // e.g. selected members count in the title
    boxTitleCloseFg: cancelIconFg;
    boxTitleCloseFgOver: cancelIconFgOver;
    boxSearchBg: base00;
    boxSearchCancelIconFg: cancelIconFg;
    boxSearchCancelIconFgOver: cancelIconFgOver;
    membersAboutLimitFg: base04; // note about the shown members limit
    contactsBg: base00;          // rows in contacts and similar boxes
    contactsBgOver: base01;
    contactsNameFg: base05;
    contactsStatusFg: base04;    // "last seen ..."
    contactsStatusFgOver: base04;
    contactsStatusFgOnline: accent;
    photoCropFadeBg: layerBg;    // avatar crop: area outside the crop
    photoCropPointFg: base05;    // avatar crop: corner handles
    callArrowFg: base0B;         // calls list: received call arrow
    callArrowMissedFg: base08;   // calls list: missed call arrow

    // ================================================================
    // Login screen
    // ================================================================
    introBg: base00;
    introTitleFg: base06;
    introDescriptionFg: base04;
    introErrorFg: base08;          // wrong code, wrong password
    introCoverTopBg: base01;       // cover gradient: top
    introCoverBottomBg: base01;    // cover gradient: bottom
    introCoverIconsFg: base02;     // clouds
    introCoverPlaneTrace: base03;  // plane trail
    introCoverPlaneInner: base05;  // plane parts
    introCoverPlaneOuter: base04;
    introCoverPlaneTop: base06;

    // ================================================================
    // Folders sidebar (left of the chat list, when folders are shown)
    // ================================================================
    sideBarBg: base01;
    sideBarBgActive: base02;   // selected folder
    sideBarBgRipple: base03;
    sideBarIconFg: base04;
    sideBarIconFgActive: accent;
    sideBarTextFg: base04;
    sideBarTextFgActive: accent;
    sideBarBadgeBg: accent;      // unread badge on a folder
    sideBarBadgeBgMuted: badgeMuted; // ...when everything in it is muted
    sideBarBadgeFg: base00;

    // ================================================================
    // Chat list
    // ================================================================
    dialogsMenuIconFg: menuIconFg; // hamburger and lock icons above the list
    dialogsMenuIconFgOver: menuIconFgOver;
    dialogsBg: base00;
    dialogsNameFg: base05;
    dialogsChatIconFg: dialogsNameFg; // group / channel icon before the name
    dialogsDateFg: base04;
    dialogsTextFg: base04;            // last message preview
    dialogsTextFgService: accent;     // sender name / media type in the preview
    dialogsDraftFg: base08;           // "Draft:" label
    dialogsVerifiedIconBg: accent;
    dialogsVerifiedIconFg: base00;
    dialogsSendingIconFg: base04;     // clock while sending
    dialogsSentIconFg: base0B;        // tick / double tick
    dialogsUnreadBg: accent;          // unread badge
    dialogsUnreadBgMuted: badgeMuted;     // unread badge in a muted chat (also pin)
    dialogsUnreadFg: base00;
    dialogsOnlineBadgeFg: base0B;     // green dot on an online user's avatar
    dialogsRippleBg: base02;

    // Row under the mouse.
    dialogsBgOver: base01;
    dialogsNameFgOver: base06;
    dialogsChatIconFgOver: dialogsNameFgOver;
    dialogsDateFgOver: base04;
    dialogsTextFgOver: base04;
    dialogsTextFgServiceOver: accent;
    dialogsDraftFgOver: base08;
    dialogsVerifiedIconBgOver: accent;
    dialogsVerifiedIconFgOver: base00;
    dialogsSendingIconFgOver: base04;
    dialogsSentIconFgOver: base0B;
    dialogsUnreadBgOver: accent;
    dialogsUnreadBgMutedOver: badgeMuted;
    dialogsUnreadFgOver: base00;

    // The open chat: selection background, as base16 intends for base02.
    dialogsBgActive: base02;
    dialogsNameFgActive: base06;
    dialogsChatIconFgActive: dialogsNameFgActive;
    dialogsDateFgActive: base04;
    dialogsTextFgActive: base05;
    dialogsTextFgServiceActive: accent;
    dialogsDraftFgActive: base08;
    dialogsVerifiedIconBgActive: accent;
    dialogsVerifiedIconFgActive: base00;
    dialogsSendingIconFgActive: base04;
    dialogsSentIconFgActive: base0B;
    dialogsUnreadBgActive: accent;
    dialogsUnreadBgMutedActive: badgeMuted;
    dialogsUnreadFgActive: base00;
    dialogsOnlineBadgeFgActive: base0B;
    dialogsRippleBgActive: base03;

    dialogsForwardBg: dialogsBgActive; // "choose recipient" panel (narrow window)
    dialogsForwardFg: dialogsNameFgActive;

    searchedBarBg: base01;   // "Found N messages" bar in search results
    searchedBarBorder: base02;
    searchedBarFg: base04;

    // ================================================================
    // Chat view: top bar and compose area
    // ================================================================
    topBarBg: base00;            // bar with the chat name
    historyComposeAreaBg: base00; // message input area
    historyComposeAreaFg: base05; // typed text
    historyComposeAreaFgService: base04; // reply preview text for media
    historyComposeIconFg: base04; // emoji, attach, bot command icons
    historyComposeIconFgOver: base05;
    historySendIconFg: accent;
    historySendIconFgOver: accent;
    historyPinnedBg: base00;      // pinned message bar
    historyReplyBg: base00;       // reply / forward / edit bar above the input
    historyReplyIconFg: accent;
    historyReplyCancelFg: base04;
    historyReplyCancelFgOver: base05;
    // Big button instead of the input: Join, Mute, Unblock.
    historyComposeButtonBg: base00;
    historyComposeButtonBgOver: base01;
    historyComposeButtonBgRipple: base02;
    // Round "scroll to the bottom" button.
    historyToDownBg: base01;
    historyToDownBgOver: base02;
    historyToDownBgRipple: base03;
    historyToDownFg: base04;
    historyToDownFgOver: base05;
    historyToDownShadow: base00;
    // Scroll bar of the chat view.
    historyScrollBarBg: base02;
    historyScrollBarBgOver: base03;
    historyScrollBg: base00;
    historyScrollBgOver: base01;
    reportSpamBg: base01;         // "Report spam / Add contact" bar
    reportSpamFg: base05;
    historyUnreadBarBg: base01;   // "Unread messages" divider
    historyUnreadBarBorder: base01;
    historyUnreadBarFg: accent;
    historyForwardChooseBg: base00;
    historyForwardChooseFg: base05;

    // ================================================================
    // Messages: incoming
    // ================================================================
    msgInBg: base01;
    msgInBgSelected: base02;     // selected message (and selected text in it)
    msgInShadow: base00;
    msgInShadowSelected: base00;
    historyTextInFg: base05;
    historyTextInFgSelected: base06;
    historyLinkInFg: accent;
    historyLinkInFgSelected: accent;
    historyFileNameInFg: base05;
    historyFileNameInFgSelected: base06;
    msgInServiceFg: accent;      // "Forwarded from", reply author
    msgInServiceFgSelected: accent;
    msgInDateFg: base04;         // time
    msgInDateFgSelected: base04;
    msgInReplyBarColor: accent;  // vertical bar of a quoted reply
    msgInReplyBarSelColor: accent;
    msgInMonoFg: base0B;         // `monospace` ("Markup Code" in base16)
    msgInMonoFgSelected: base0B;
    historySendingInIconFg: base04; // clock in chats with yourself / channels
    mediaInFg: base04;           // file status ("1.2 MB", "Downloading")
    mediaInFgSelected: base04;

    // ================================================================
    // Messages: outgoing (colors come from the out* constants on top)
    // ================================================================
    msgOutBg: outBg;
    msgOutBgSelected: outBgSelected;
    msgOutShadow: base00;
    msgOutShadowSelected: base00;
    historyTextOutFg: outFg;
    historyTextOutFgSelected: outFg;
    historyLinkOutFg: outAccent;
    historyLinkOutFgSelected: outAccent;
    historyFileNameOutFg: outFg;
    historyFileNameOutFgSelected: outFg;
    msgOutServiceFg: outAccent;
    msgOutServiceFgSelected: outAccent;
    msgOutDateFg: outSubFg;
    msgOutDateFgSelected: outSubFg;
    msgOutReplyBarColor: outAccent;
    msgOutReplyBarSelColor: outAccent;
    msgOutMonoFg: outCode;
    msgOutMonoFgSelected: outCode;
    historyOutIconFg: outAccent;          // tick / double tick
    historyOutIconFgSelected: outAccent;
    historySendingOutIconFg: outSubFg;    // clock while sending
    mediaOutFg: outSubFg;
    mediaOutFgSelected: outSubFg;

    // ================================================================
    // Messages: shared parts
    // ================================================================
    // Service messages: date dividers, "X joined the group".
    msgServiceFg: base05;
    msgServiceBg: base01;
    msgServiceBgSelected: base02;
    // Selection over media and stickers.
    msgSelectOverlay: #00000000; // off: a solid overlay would hide the selected media
    msgStickerOverlay: #00000000; // off, same reason
    msgImgReplyBarColor: base05;          // reply bar of a sticker message
    // Time bubble drawn on photos and videos.
    msgDateImgFg: base05;
    msgDateImgBg: base00;
    msgDateImgBgOver: base01;
    msgDateImgBgSelected: base02;
    historyIconFgInverted: base05;        // ticks on media
    historySendingInvertedIconFg: base05; // clock on media
    // Calls in the chat.
    historyCallArrowInFg: base0B;
    historyCallArrowInFgSelected: base0B;
    historyCallArrowMissedInFg: base08;
    historyCallArrowMissedInFgSelected: base08;
    historyCallArrowOutFg: base0B;
    historyCallArrowOutFgSelected: base0B;

    // Sender names and avatar placeholders: 8 colors, named as in Telegram.
    historyPeer1NameFg: base08; // red
    historyPeer1NameFgSelected: base08;
    historyPeer1UserpicBg: base08;
    historyPeer2NameFg: base0B; // green
    historyPeer2NameFgSelected: base0B;
    historyPeer2UserpicBg: base0B;
    historyPeer3NameFg: base0A; // yellow
    historyPeer3NameFgSelected: base0A;
    historyPeer3UserpicBg: base0A;
    historyPeer4NameFg: base0D; // blue
    historyPeer4NameFgSelected: base0D;
    historyPeer4UserpicBg: base0D;
    historyPeer5NameFg: base0E; // purple
    historyPeer5NameFgSelected: base0E;
    historyPeer5UserpicBg: base0E;
    historyPeer6NameFg: base0F; // pink
    historyPeer6NameFgSelected: base0F;
    historyPeer6UserpicBg: base0F;
    historyPeer7NameFg: base0C; // sea
    historyPeer7NameFgSelected: base0C;
    historyPeer7UserpicBg: base0C;
    historyPeer8NameFg: base09; // orange
    historyPeer8NameFgSelected: base09;
    historyPeer8UserpicBg: base09;
    historyPeerUserpicFg: base00; // initials on the placeholder

    // ================================================================
    // Files, voice messages, bot keyboards
    // ================================================================
    // Round download / play button of files without a preview (audio, docs).
    msgFileInBg: accent;
    msgFileInBgOver: accent;
    msgFileInBgSelected: accent;
    msgFileOutBg: outAccent;
    msgFileOutBgOver: outAccent;
    msgFileOutBgSelected: outAccent;
    // Arrow / radial progress drawn inside that button: bubble color.
    historyFileInIconFg: base01;
    historyFileInIconFgSelected: base02;
    historyFileInRadialFg: base01;
    historyFileInRadialFgSelected: base02;
    historyFileOutIconFg: outBg;
    historyFileOutIconFgSelected: outBgSelected;
    historyFileOutRadialFg: outBg;
    historyFileOutRadialFgSelected: outBgSelected;
    // The same button on photos / videos / files with a thumbnail.
    historyFileThumbIconFg: base05;
    historyFileThumbIconFgSelected: base05;
    historyFileThumbRadialFg: base05;
    historyFileThumbRadialFgSelected: base05;
    historyVideoMessageProgressFg: base05; // round video messages
    // "Download" / "Open with" link on files with a thumbnail.
    msgFileThumbLinkInFg: accent;
    msgFileThumbLinkInFgSelected: accent;
    msgFileThumbLinkOutFg: outAccent;
    msgFileThumbLinkOutFgSelected: outAccent;
    // Square placeholders of files without an image, by file type,
    // in messages and in Shared files / Shared links.
    msgFile1Bg: base0D; // blue
    msgFile1BgDark: base0D;
    msgFile1BgOver: base0D;
    msgFile1BgSelected: base0D;
    msgFile2Bg: base0B; // green
    msgFile2BgDark: base0B;
    msgFile2BgOver: base0B;
    msgFile2BgSelected: base0B;
    msgFile3Bg: base08; // red
    msgFile3BgDark: base08;
    msgFile3BgOver: base08;
    msgFile3BgSelected: base08;
    msgFile4Bg: base0A; // yellow
    msgFile4BgDark: base0A;
    msgFile4BgOver: base0A;
    msgFile4BgSelected: base0A;
    // Voice message waveform: played / not yet played part.
    msgWaveformInActive: accent;
    msgWaveformInActiveSelected: accent;
    msgWaveformInInactive: base03;
    msgWaveformInInactiveSelected: base03;
    msgWaveformOutActive: outAccent;
    msgWaveformOutActiveSelected: outAccent;
    msgWaveformOutInactive: outSubFg;
    msgWaveformOutInactiveSelected: outSubFg;
    // Inline bot buttons under a message (drawn on msgServiceBg).
    msgBotKbOverBgAdd: #00000000; // off: drawn over the button
    msgBotKbIconFg: base05;
    msgBotKbRippleBg: #00000000; // off: drawn over the button
    // Reply keyboard of a bot (instead of the emoji panel).
    botKbBg: base01;
    botKbDownBg: base02;
    // Link previews.
    youtubePlayIconBg: base08;
    youtubePlayIconFg: base00;
    videoPlayIconBg: base00;
    videoPlayIconFg: base05;

    // ================================================================
    // Emoji / stickers / GIF panel
    // ================================================================
    emojiPanBg: base01;
    emojiPanCategories: base01; // category bar
    emojiPanHeaderBg: base01;   // section header ("Frequently used")
    emojiPanHeaderFg: base04;
    emojiIconFg: base04;        // category icons
    emojiIconFgActive: accent;
    stickerPanDeleteBg: base01; // X on custom stickers (legacy)
    stickerPanDeleteFg: base05;
    stickerPreviewBg: base00;

    // ================================================================
    // Main menu, profiles, shared media, toasts
    // ================================================================
    mainMenuBg: base00; // same as windowBg: menu items are drawn on windowBg
    mainMenuCoverBg: base02; // top part with your name
    mainMenuCoverFg: base05;
    mainMenuCloudBg: accent; // Saved Messages cloud icon
    mainMenuCloudFg: base00;
    profileStatusFgOver: base04;
    profileVerifiedCheckBg: accent;
    profileVerifiedCheckFg: base00;
    profileAdminStartFg: base0A; // admin star in members lists
    // Shared media / files / links in selection mode.
    overviewCheckBg: base00;
    overviewCheckFg: base05;
    overviewCheckFgActive: base00;
    overviewCheckBorder: base04;
    overviewPhotoSelectOverlay: #00000000; // off, same reason
    // Toasts ("Link copied") and important tooltips.
    toastBg: base01;
    toastFg: base05;
    importantTooltipBg: toastBg;
    importantTooltipFg: toastFg;
    importantTooltipFgLink: accent;

    // ================================================================
    // Notifications
    // ================================================================
    notificationBg: base00; // Telegram's own popup notifications
    // Preview in Settings > Notifications > position on screen.
    notificationsBoxMonitorFg: base05;
    notificationsBoxScreenBg: base02;
    notificationSampleUserpicFg: accent;
    notificationSampleCloseFg: base03;
    notificationSampleTextFg: base03;
    notificationSampleNameFg: base04;

    // ================================================================
    // Music player (top bar while playing audio)
    // ================================================================
    mediaPlayerBg: base00;
    mediaPlayerActiveFg: accent;   // played part
    mediaPlayerInactiveFg: base02; // not yet played part
    mediaPlayerDisabledFg: base03; // still loading

    // ================================================================
    // Media viewer (full-screen photos and videos)
    // ================================================================
    mediaviewBg: base00;
    mediaviewVideoBg: base00;
    mediaviewControlBg: base00;
    mediaviewControlFg: base05;
    mediaviewCaptionBg: base00;
    mediaviewCaptionFg: base05;
    mediaviewTextLinkFg: accent;
    mediaviewSaveMsgBg: toastBg;  // "Saved to Downloads" toast
    mediaviewSaveMsgFg: toastFg;
    mediaviewMenuBg: base01;      // right-click menu in the viewer
    mediaviewMenuBgOver: base02;
    mediaviewMenuBgRipple: base03;
    mediaviewMenuFg: base05;
    // Video playback bar.
    mediaviewPlaybackActive: base05;
    mediaviewPlaybackInactive: base02;
    mediaviewPlaybackActiveOver: base06;
    mediaviewPlaybackInactiveOver: base03;
    mediaviewPlaybackProgressFg: base05; // time text
    mediaviewPlaybackIconFg: base05;
    mediaviewPlaybackIconFgOver: base06;
    // Checkerboard behind transparent PNGs.
    mediaviewTransparentBg: base01;
    mediaviewTransparentFg: base02;
    // Placeholder for a file that is not loaded yet.
    mediaviewFileBg: base00;
    mediaviewFileNameFg: base05;
    mediaviewFileSizeFg: base04;
    mediaviewFileExtFg: base00;
    mediaviewFileRedCornerFg: base08;    // e.g. .pdf
    mediaviewFileYellowCornerFg: base0A; // e.g. .zip
    mediaviewFileGreenCornerFg: base0B;  // e.g. .exe
    mediaviewFileBlueCornerFg: base0D;   // e.g. .dmg

    // ================================================================
    // Calls
    // ================================================================
    callBg: base00;
    callNameFg: base06;
    callFingerprintBg: base01;
    callStatusFg: base04;
    callIconFg: base05;
    callAnswerBg: base0B;
    callAnswerRipple: base0B;
    callAnswerBgOuter: #00000000; // off: outer glow around the answer button
    callHangupBg: base08;
    callHangupRipple: base08;
    callCancelBg: base05;
    callCancelFg: base00;
    callCancelRipple: base04;
    callMuteRipple: base01;
    // Bar on top of the window during a call.
    callBarBg: base02;
    callBarMuteRipple: base03;
    callBarBgMuted: base03;
    callBarUnmuteRipple: base04;
    callBarFg: base05;
    // Voice chat member list and menu.
    groupCallMembersFg: base05;
    groupCallMenuBg: base01;
    groupCallMenuBgOver: base02;
    groupCallMenuBgRipple: base03;
  '';

  # A .tdesktop-theme file is a zip with colors.tdesktop-theme and an optional
  # background. "tiled.*" is repeated, "background.*" is stretched. PNG keeps
  # the flat color exact; JPEG compression can shift it slightly.
  theme =
    pkgs.runCommand "base16.tdesktop-theme" {
      nativeBuildInputs = [pkgs.imagemagick pkgs.zip];
      inherit palette;
      passAsFile = ["palette"];
    } ''
      cp "$palettePath" colors.tdesktop-theme
      magick -size 64x64 'xc:#${c.base00}' tiled.png
      zip -q -X "$out" colors.tdesktop-theme tiled.png
    '';
in {
  # Built in the Nix store and linked into ~/.config: no activation script,
  # rebuilt only when the palette changes.
  xdg.configFile."telegram-base16.tdesktop-theme".source = theme;
}
