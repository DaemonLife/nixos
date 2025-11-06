{config, ...}: let
  username = config.home.username;
in {
  programs.rtorrent = {
    enable = true;
  };
  home.file.".rtorrent.rc".text =
    # rc
    ''
        method.insert = cfg.basedir,  private|const|string, (cat,"/home/${username}/Downloads/rtorrent/")
        method.insert = cfg.download, private|const|string, (cat,(cfg.basedir),"download/")
        method.insert = cfg.logs,     private|const|string, (cat,(cfg.basedir),"log/")
        method.insert = cfg.logfile,  private|const|string, (cat,(cfg.logs),"rtorrent-",(system.time),".log")
        method.insert = cfg.session,  private|const|string, (cat,(cfg.basedir),".session/")
        method.insert = cfg.watch,    private|const|string, (cat,(cfg.basedir),"watch/")

        ## Create instance directories
        execute.throw = sh, -c, (cat,\
            "mkdir -p \"",(cfg.download),"\" ",\
            "\"",(cfg.logs),"\" ",\
            "\"",(cfg.session),"\" ")

        ## Basic operational settings (no need to change these)
        session.path.set = (cat, (cfg.session))
        directory.default.set = (cat, (cfg.download))
        # log.execute = (cat, (cfg.logs), "execute.log")
        #log.xmlrpc = (cat, (cfg.logs), "xmlrpc.log")
        execute.nothrow = sh, -c, (cat, "echo >",\
            (session.path), "rtorrent.pid", " ",(system.pid))

        # autostart files in watch directory
      schedule2 = watch_directory,5,5,load.start=/home/${username}/Downloads/rtorrent/watch/*.torrent

        # disk space safe
      schedule2 = low_diskspace,5,60,((close_low_diskspace,500M))

        # if main tracker not works
        dht.mode.set = auto
        dht.port.set = 6881
        protocol.pex.set= yes
        # dht = auto
        # dht_port = 6881

        encoding.add = UTF-8
        pieces.hash.on_completion.set = yes

        ratio.enable=false
        trackers.use_udp.set = yes

        protocol.encryption.set = allow_incoming,try_outgoing,enable_retry
    '';
}
