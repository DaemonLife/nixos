{ pkgs, config, stylix, ... }:
let
  theme = ''
    /*
    @define-color plugin_bg_color #717171;
    @define-color fg_color #aaaaaa;
    @define-color field_selected_bg #717171;
    @define-color plugin_label_color #aaaaaa;
    @define-color scroll_bar_bg #6a6a6a;
    @define-color scroll_bar_inactive #717171;
    @define-color scroll_bar_active #8f5600;
    @define-color theme_color @selected_bg_color;
    @define-color lighttable_bg_color @gray;
    */

    @define-color accent #7daea3;
    @define-color gray #6a6a6a;
    @define-color gray-light #787878;

    @define-color thumbnail_star_bg_color #ffffff;
    @define-color thumbnail_star_hover_color #ffffff;

    @define-color bauhaus_bg @gray;
    @define-color bauhaus_fill @accent;
    @define-color border_color @gray;

    @define-color field_bg @gray;

    @define-color darkroom_bg_color @gray-light;

    @define-color collapsible_bg_color @gray;
    @define-color bg_color @gray;
    @define-color button_bg @gray;
    @define-color button_hover_bg @accent;

    @define-color field_active_bg @gray;


    @define-color thumbnail_bg_color @gray;
    @define-color thumbnail_selected_bg_color #a1a1a1;
    @define-color thumbnail_hover_bg_color @accent;

    .dt_overlays_hover_extended #thumb-main:hover #thumb-bottom,
    .dt_overlays_mixed #thumb-main:hover #thumb-bottom,
    .dt_overlays_hover #thumb-main:hover #thumb-bottom {
        background-image: none;
        background-color: @accent;
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

    .dt_plugin_ui #blending-tabs
    {
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

    #module-header .dt_module_btn {
        color: #929292;
    }

    #module-header .dt_module_btn:checked {
      color: shade(@button_hover_bg, 1.4);
    }
  '';

in
{ }
