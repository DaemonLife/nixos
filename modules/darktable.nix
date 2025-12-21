{ pkgs, config, stylix, ... }:
let
  theme = ''
    /* My variables */

    @define-color accent #7daea3;
    @define-color accent_2 #d8a657;
    @define-color dark #444;
    @define-color gray #666;
    @define-color gray-light #777;
    @define-color light #aaa;
    @define-color white #ddd;

    /* General */
    @define-color selected_bg_color @grey_55;       /* legacy stuff */
    @define-color border_color @grey_40;            /* border, when used */
    @define-color bg_color @grey_45;                /* general background */
    @define-color fg_color @grey_95;                /* general text */
    @define-color text_color @grey_35;              /* same */
    @define-color placeholder_text_color @grey_70;  /* placeholder text color (text on search background fields) */
    @define-color disabled_fg_color @grey_65;       /* disabled controls */

    /* Scroll bars (sliders) */
    @define-color scroll_bar_inactive @grey_60;
    @define-color scroll_bar_active @grey_80;
    @define-color scroll_bar_bg @grey_40;

    /* Modules box (plugins) */
    @define-color plugin_bg_color shade(@darkroom_bg_color, 0.95);
    @define-color plugin_label_color @grey_80;
    @define-color collapsible_bg_color @grey_55;

    /* Modules controls (sliders and comboboxes) */
    @define-color bauhaus_fg shade(@fg_color, 0.95);   /* needed to show color picker on bauhaus sliders */
    @define-color bauhaus_indicator_border @grey_50;
    @define-color bauhaus_fill @grey_70;
    @define-color bauhaus_bg_hover @grey_80;
    @define-color bauhaus_fg_hover @grey_100;
    @define-color bauhaus_fg_selected @grey_75;
    @define-color bauhaus_fg_insensitive alpha(@bauhaus_fg, 0.5);

    /* GTK Buttons and tabs */
    @define-color button_bg shade(@grey_55,0.95);
    @define-color button_hover_bg @grey_70;
    @define-color button_hover_fg @grey_30;

    /* text fields */
    @define-color field_bg @grey_45;
    @define-color field_active_bg @grey_50;
    @define-color field_active_fg @grey_95;
    @define-color field_selected_bg @grey_60;
    @define-color field_selected_fg @grey_100;
    @define-color field_hover_bg @grey_75;
    @define-color field_hover_fg @grey_35;

    /* Tooltips and contextual helpers */
    @define-color tooltip_bg_color @grey_35;
    @define-color tooltip_fg_color @grey_80;
    @define-color log_fg_color @grey_95;

    /* Views */
    @define-color lighttable_bg_color @grey_60;
    @define-color lighttable_bg_font_color @grey_95;

    @define-color range_bg_color alpha(@fg_color, 0.05);

    /* Graphs : histogram, navigation thumbnail and some items on tone curve */
    @define-color graph_bg @grey_40;
    @define-color graph_border @grey_15;
    @define-color graph_fg @grey_100;
    @define-color graph_grid @grey_30;
    @define-color inset_histogram alpha(@grey_95, 0.50);

    /* Adjust middle grey picker on levels and rgb levels modules to make it visible */
    #picker-grey
    {
      color: @grey_70;
    }

    /* hover effect on combo and bauhaus */
    .combo:hover,
    .combo:hover cellview,
    .dt_bauhaus:hover,
    combobox window *:hover
    {
      color: shade(@fg_color, 0.94);
    }

    /* set default text, items that can be selected : items inside categories titles set above */
    .dt_bauhaus_popup
    {
      color: shade(@fg_color, 0.75);
    }


    @define-color thumbnail_bg_color @gray;
    @define-color lighttable_bg_color @thumbnail_bg_color;
    @define-color thumbnail_selected_bg_color @accent_2;
    @define-color thumbnail_hover_bg_color @accent;
    @define-color thumbnail_font_color @dark;
    @define-color thumbnail_fg_color @light;
    @define-color thumbnail_hover_fg_color @light;
    @define-color thumbnail_localcopy_color @light;

    /* set selected image and/or focus one */
    .dt_act_on_hover #thumb-main:active #thumb-back,
    .dt_act_on_hover #thumb-main:selected #thumb-back,
    .dt_act_on_selection #thumb-main:hover #thumb-back
    {
      border: none;
    }

    .dt_overlays_hover_extended #thumb-main:hover #thumb-bottom,
    .dt_overlays_mixed #thumb-main:hover #thumb-bottom,
    .dt_overlays_hover #thumb-main:hover #thumb-bottom {
        background-image: none;
        background-color: @thumbnail_hover_bg_color;
    }

    #left {
      padding: 0 8px 0 0;
    }

    #left > :not(scrolledwindow) {
      padding-left: 4px;
    }

    #right {
      padding: 0 0 0 8px;
    }

    #right > :not(scrolledwindow) {
      padding-right: 0px;
    }

    #plugins_vbox_left > box:not(#basics-box-labels) {
      background-color: @plugin_bg_color;
      border-radius: 4px;
    }

    #basics-module-hbox,
    #plugins_vbox_left > box:not(#basics-box-labels) {
      margin-bottom: 4px;
    }

    #basics-box-labels widget,
    #basics-module-hbox {
      background-color: @plugin_bg_color;
    }

    #basics-box-labels widget {
      border: none;
    }

    #basics-module-hbox,
    #plugins_vbox_left frame.dt_plugin_ui {
      border-radius: 0 0 4px 4px;
    }

    #basics-module-hbox {
      padding: 0px 0 0px;
    }

    #basics-box-labels #basics-header-box {
      padding: 6px 4px 6px 10px;
    }

    #basics-module-hbox + widget {
      border-radius: 4px 4px 0 0;
    }

    #plugins_vbox_left #module-header,
    #left > box:nth-child(3) #module-header,
    #right > box:nth-child(3) #module-header {
      border: none;
    }

    .dt_plugin_ui #blending-tabs .dt_module_btn,
    #modules-tabs .dt_module_btn
    {
      padding: 0.5em;
      margin: 0.2em;
      border-radius: 4px;
    }

    .dt_plugin_ui #blending-tabs {
      border-radius: 0 0 4px 4px;
    }

    #left > box:first-child,
    #modules-tabs {
      margin-bottom: 4px;
    }

    .font {
      margin: 8px 0;
    }

    #module-filtering #collect-rule-widget:last-child {
      border-bottom-left-radius: 6px;
      border-bottom-right-radius: 6px;
    }

    /* Increase min-height to account for auto-hideable buttons */
    #module-header {
      min-height: 6px;
    }

    #module-header .dt_module_btn:checked {
      color: shade(@accent, 1.3);

    }
  '';

in
{ }
