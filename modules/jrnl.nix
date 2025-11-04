{pkgs, ...}: let
  confTemplate = ''
    colors:
      body: none
      date: white
      tags: blue
      title: cyan
    default_hour: 9
    default_minute: 0
    editor: vi
    encrypt: false
    highlight: true
    indent_character: '|'
    journals:
      default:
        journal: $HOME/.local/share/jrnl/journal.txt
      main:
        journal: /mnt/temp/jrnl/jrnl.txt
    linewrap: 79
    tagsymbols: '#@'
    template: false
    timeformat: '%Y-%m-%d %H:%M'
    version: <VERSION_PLACEHOLDER>
  '';

  # Создаем Nix-деривацию, которая выполнит команду и извлечет версию
  jrnlVersion = pkgs.runCommand "jrnl-version-extractor" {buildInputs = [pkgs.jrnl];} ''
    # Выполняем jrnl --version и получаем первую строку (например, "jrnl v4.2")
    version_output="$(${pkgs.jrnl}/bin/jrnl --version | head -n 1)"
    # Используем awk для извлечения последнего поля (т.е. самой версии "v4.2")
    echo "$version_output" | awk '{print $NF}' > "$out"
  '';

  # Считываем извлеченную версию из файла, созданного деривацией
  actualJrnlVersion = builtins.readFile jrnlVersion;

  # Объединяем шаблон с реальной версией, заменяя плейсхолдер
  finalConf = builtins.replaceStrings ["<VERSION_PLACEHOLDER>"] [actualJrnlVersion] confTemplate;
in {
  home.packages = with pkgs; [
    jrnl
  ];
  home.file.".config/jrnl/jrnl.yaml".text = finalConf;
}
