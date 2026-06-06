#!/bin/bash

C_ACCENT="#c4a0f0"
C_MUTED="#8c92a3"

SPOTIFY_PLAYING=$(playerctl -p spotify status 2>/dev/null)

if [ "$SPOTIFY_PLAYING" = "Playing" ]; then
  ANIM_FILE="/tmp/waybar_music_anim"
  FRAME=0
  if [ -f "$ANIM_FILE" ]; then
    read FRAME < "$ANIM_FILE"
    FRAME=$(( (FRAME + 1) % 12 ))
  fi
  echo "$FRAME" > "$ANIM_FILE"

  case $FRAME in
    0)  EQQ="⡀"  ;;
    1)  EQQ="⡄"  ;;
    2)  EQQ="⡆"  ;;
    3)  EQQ="⡇"  ;;
    4)  EQQ="⣇"  ;;
    5)  EQQ="⣧"  ;;
    6)  EQQ="⣷"  ;;
    7)  EQQ="⣿"  ;;
    8)  EQQ="⣷"  ;;
    9)  EQQ="⣧"  ;;
    10) EQQ="⣇"  ;;
    11) EQQ="⡇"  ;;
  esac

  ARTIST=$(playerctl -p spotify metadata artist 2>/dev/null)
  TITLE=$(playerctl -p spotify metadata title 2>/dev/null)
  [ -z "$ARTIST" ] && ARTIST=""
  [ -z "$TITLE" ] && TITLE=""

  NOW_PLAYING="${ARTIST} - ${TITLE}"
  [ ${#NOW_PLAYING} -gt 45 ] && NOW_PLAYING="${NOW_PLAYING:0:45}…"

  jq -n -c --arg text "<span color='${C_ACCENT}'>${EQQ}</span>  ${NOW_PLAYING}" --arg class "playing" '{text: $text, class: $class}'
  exit 0
fi

if ! command -v hyprctl &>/dev/null; then
  echo "{\"text\": \"\", \"class\": \"empty\"}"
  exit 0
fi

WIN=$(hyprctl activewindow -j 2>/dev/null)
if [ -z "$WIN" ] || [ "$WIN" = "null" ]; then
  jq -n -c --arg text "<span color='${C_ACCENT}'>OMARCHY</span>" --arg class "empty" '{text: $text, class: $class}'
  exit 0
fi

CLASS=$(echo "$WIN" | jq -r '.class // empty')
TITLE=$(echo "$WIN" | jq -r '.title // empty')

if [ -z "$CLASS" ]; then
  jq -n -c --arg text "<span color='${C_ACCENT}'>OMARCHY</span>" --arg class "empty" '{text: $text, class: $class}'
  exit 0
fi

clean_class() {
  local c="$1"
  c=$(echo "$c" | sed 's/\.exe$//; s/.*\.//')
  echo "$c"
}

SHORT_CLASS=$(clean_class "$CLASS")

is_browser() {
  case "$1" in
    firefox*|Firefox*|firefoxpwa*|FirefoxPWA*)
      return 0 ;;
    tor-browser*|torbrowser*|TorBrowser*)
      return 0 ;;
    google-chrome*|chromium*|Chromium*|brave*|Brave*)
      return 0 ;;
    microsoft-edge*|edge*|vivaldi*|Vivaldi*|opera*|Opera*|slimjet*|Slimjet*)
      return 0 ;;
    yandex-browser*|Yandex*|arc*|Arc*|epiphany*|org.gnome.Epiphany*)
      return 0 ;;
    librewolf*|LibreWolf*|mullvad*|Mullvad*|duckduckgo*|DuckDuckGo*)
      return 0 ;;
    crx_*|chrome-*|chromium-*|brave-*|edge-*|opera-*)
      return 0 ;;
    *) return 1 ;;
  esac
}

strip_browser_suffix() {
  local t="$1"
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*(Mozilla )?Firefox$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Google Chrome$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Chromium$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Brave$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*(Microsoft )?Edge$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Vivaldi$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Opera$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Tor Browser$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Yandex$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Arc$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Epiphany$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*LibreWolf$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*Mullvad Browser$//I')
  t=$(echo "$t" | sed -E 's/\s*[—–\-|·/]\s*DuckDuckGo$//I')
  echo "$t"
}

is_newtab() {
  local t="$1"
  local lower
  lower=$(echo "$t" | tr '[:upper:]' '[:lower:]')
  case "$lower" in
    ""|"new tab"|"about:blank"|"about:newtab"|"about:home"|"home"|"start page"|"speed dial"|"untitled"|"brave new tab"*)
      return 0 ;;
    *) return 1 ;;
  esac
}

get_site_icon() {
  local name="$1"
  local lower
  lower=$(echo "$name" | tr '[:upper:]' '[:lower:]')
  case "$lower" in
    # ----- GOOGLE -----
    *youtube*)                  echo "" ;;
    *gmail*|*mail.google*)      echo "" ;;
    *drive*|*google.drive*)     echo "" ;;
    *calendar*|*google.calendar*) echo "" ;;
    *keep*|*google.keep*)       echo "" ;;
    *maps*|*google.maps*)       echo "" ;;
    *docs*|*google.docs*)       echo "" ;;
    *sheets*|*google.sheets*)   echo "" ;;
    *slides*|*google.slides*)   echo "" ;;
    *meet*|*google.meet*)       echo "" ;;
    *photos*|*google.photos*)   echo "" ;;
    *google*search*)            echo "" ;;
    *contacts.google*)         echo "" ;;
    *messages.google*)         echo "" ;;
    *classroom*|*google.classroom*) echo "󰎚" ;;
    *translate*|*google.translate*) echo "󰗊" ;;
    *news*|*google.news*)      echo "󰑞" ;;
    *play.google*|*google.play*) echo "" ;;
    *books*|*play.books*)      echo "" ;;
    *earth*|*google.earth*)    echo "󰆋" ;;
    *admin.google*)            echo "" ;;
    *tasks*|*google.tasks*)    echo "󰡖" ;;
    *flights*|*google.flights*) echo "" ;;
    *hotels*|*google.hotels*)  echo "" ;;
    *fonts.google*)            echo "" ;;
    *analytics.google*)        echo "󰔎" ;;
    *ads.google*)              echo "󰕈" ;;
    *cloud.google*)            echo "" ;;
    *colab*|*colab.google*)    echo "󰙨" ;;
    *firebase*)                echo "󰌨" ;;
    *forms*|*google.forms*)    echo "󰽚" ;;
    *chat.google*)             echo "󰇮" ;;
    *groups.google*)           echo "󰁼" ;;
    *one.google*)              echo "󰆣" ;;
    *myaccount.google*)       echo "" ;;
    *shopping*|*google.shopping*) echo "" ;;
    *takeout.google*)          echo "󰉏" ;;
    *alerts.google*)           echo "󰛏" ;;
    *google*workspace*|*workspace.google*) echo "󱁕" ;;

    # ----- AI & CHAT -----
    *chatgpt*|*openai*)        echo "󰚩" ;;
    *gemini*|*gemini.google*)  echo "󰊭" ;;
    *claude*)                  echo "󰘳" ;;
    *perplexity*)              echo "󰭹" ;;
    *deepseek*)                echo "󰠧" ;;
    *notebooklm*)              echo "󰠮" ;;
    *notion*)                  echo "󰇈" ;;
    *github*)                  echo "󰊤" ;;
    *copilot*)                 echo "󰚩" ;;
    *huggingface*)             echo "󰬺" ;;
    *midjourney*)              echo "󰬷" ;;

    # ----- SOCIAL & MEDIA -----
    *spotify*)                 echo "󰓇" ;;
    *reddit*)                  echo "󰑍" ;;
    *x.com*|*twitter*)         echo "" ;;
    *whatsapp*|*web.whatsapp*) echo "" ;;
    *figma*)                   echo "󰈔" ;;
    *zoom*|*app.zoom*)         echo "" ;;
    *discord*)                 echo "󰙯" ;;
    *stackoverflow*)           echo "󰓌" ;;
    *canva*)                   echo "󰕑" ;;
    *instagram*)               echo "" ;;
    *facebook*)                echo "" ;;
    *linkedin*)                echo "" ;;
    *tiktok*)                  echo "󰬼" ;;
    *netflix*)                 echo "󰐃" ;;
    *prime*|*prime.video*)     echo "󰐃" ;;
    *hulu*)                    echo "󰐃" ;;
    *disney*|*disneyplus*)     echo "󰐃" ;;
    *twitch*)                  echo "" ;;
    *pinterest*)               echo "" ;;
    *telegram*|*web.telegram*) echo "" ;;
    *slack*)                   echo "" ;;
    *signal*)                  echo "󰭹" ;;
    *element*)                 echo "" ;;
    *matrix*)                  echo "" ;;

    # ----- PROTON -----
    *proton.mail*|*protonmail*)  echo "󰇮" ;;
    *proton.drive*)              echo "󱑢" ;;
    *proton.calendar*)           echo "󰃭" ;;
    *proton.pass*)               echo "󰷛" ;;
    *proton.vpn*)                echo "󰒄" ;;
    *proton.wallet*)             echo "󱠔" ;;

    # ----- MICROSOFT -----
    *outlook*)                  echo "󰇮" ;;
    *teams*)                    echo "󰊻" ;;
    *onedrive*)                 echo "󰏫" ;;
    *office*|*office.com*)     echo "󰏆" ;;
    *word*|*wordonline*|*word.microsoft*) echo "󰏫" ;;
    *excel*|*excelonline*)     echo "󰏫" ;;
    *powerpoint*|*powerpointonline*) echo "󰏫" ;;
    *sharepoint*)               echo "󰏬" ;;
    *onenote*)                  echo "󰏩" ;;
    *todo*|*to.do*)            echo "󰡖" ;;
    *planner*)                  echo "󰻞" ;;
    *dynamics*)                 echo "󰏪" ;;
    *powerbi*)                  echo "󰔎" ;;
    *azure*)                    echo "󰏫" ;;
    *linkedin*)                 echo "" ;;
    *bing*)                     echo "󰒄" ;;
    *skype*)                    echo "" ;;
    *yammer*)                   echo "󰇮" ;;
    *loop*|*microsoft.loop*)   echo "󱞵" ;;
    *forms*|*microsoft.forms*) echo "󰽚" ;;
    *stream*|*microsoft.stream*) echo "󰐃" ;;
    *whiteboard*)               echo "󰏬" ;;
    *lists*|*microsoft.lists*) echo "󰻞" ;;
    *admin.microsoft*)          echo "" ;;
    *sway*)                     echo "󰏫" ;;
    *clipchamp*)                echo "󰇈" ;;
    *xbox*|*xbox.com*)          echo "" ;;
    *code*visual*|*code.visualstudio.com*) echo "" ;;

    # ----- PRODUCTIVITY -----
    *basecamp*|*37signals*)     echo "󰓾" ;;
    *fizzy*|*fizzy.do*)         echo "󰄬" ;;
    *hey*|*app.hey*)            echo "󰇮" ;;
    *linear*)                   echo "󰘶" ;;
    *asana*)                    echo "󰓾" ;;
    *trello*)                   echo "󰓾" ;;
    *jira*)                     echo "󰎚" ;;
    *confluence*)               echo "󰎚" ;;
    *miro*)                     echo "󰈔" ;;
    *monday.com*)               echo "󰓾" ;;
    *clickup*)                  echo "󰓾" ;;
    *notion*)                   echo "󰇈" ;;
    *slack*)                    echo "" ;;

    # ----- PRIVACY & SECURITY (WEB) -----
    *proton*)                   echo "󰒄" ;;
    *bitwarden*)                echo "󰷛" ;;
    *1password*)                echo "󰷛" ;;
    *duckduckgo*)               echo "󰇀" ;;
    *mullvad*)                  echo "󰒄" ;;
    *tailscale*)                echo "󰒄" ;;
    *nextcloud*)                echo "󰛧" ;;
    *tutanota*)                 echo "󰇮" ;;
    *startpage*)                echo "󰅪" ;;
    *brave*search*)             echo "󰅪" ;;

    # ----- DEV & CLOUD -----
    *gitlab*)                   echo "󰊢" ;;
    *docker*|*hub.docker*)      echo "󰡨" ;;
    *vercel*)                   echo "󰇥" ;;
    *netlify*)                  echo "󰇥" ;;
    *railway*)                  echo "󰇥" ;;
    *render*)                   echo "󰇥" ;;
    *fly.io*)                   echo "󰇥" ;;
    *aws*|*amazon*aws*)        echo "󰏫" ;;
    *digitalocean*)             echo "󰏫" ;;
    *cloudflare*)               echo "󰜈" ;;
    *heroku*)                   echo "󰏫" ;;

    # ----- MISC -----
    *wikipedia*)                echo "󰖬" ;;
    *medium*)                   echo "󰬘" ;;
    *substack*)                 echo "󰇮" ;;
    *dropbox*)                  echo "󰏫" ;;
    *icloud*)                   echo "󰅹" ;;
    *)                          echo "" ;;
  esac
}

get_app_info() {
  local class="$1"
  local short="$2"

  case "$class" in

    # ----- BROWSERS -----
    firefox*|Firefox*)           app_name=" Firefox" ;;
    firefoxpwa*|FirefoxPWA*)     app_name=" Firefox" ;;
    google-chrome*)              app_name=" Chrome" ;;
    chromium*|Chromium*)         app_name=" Chromium" ;;
    brave*|Brave*)               app_name=" Brave" ;;
    brave-origin*|Brave-Origin*|com.brave.Origin*) app_name=" Brave Origin" ;;
    helium*|Helium*)             app_name=" Helium" ;;
    microsoft-edge*|edge*)       app_name=" Edge" ;;
    vivaldi*|Vivaldi*)           app_name=" Vivaldi" ;;
    opera*|Opera*)               app_name=" Opera" ;;
    tor-browser*|TorBrowser*|torbrowser*) app_name=" Tor Browser" ;;
    yandex-browser*|Yandex*)     app_name=" Yandex" ;;
    arc*|Arc*)                   app_name=" Arc" ;;
    epiphany*|org.gnome.Epiphany*) app_name=" Epiphany" ;;
    librewolf*|LibreWolf*)       app_name=" LibreWolf" ;;
    zen*|Zen*)                   app_name=" Zen" ;;

    # ----- TERMINALS -----
    ghostty*|com.mitchellh.ghostty*) app_name=" Ghostty" ;;
    alacritty*|Alacritty*)       app_name=" Alacritty" ;;
    kitty*|Kitty*)               app_name=" Kitty" ;;
    foot*)                       app_name=" Foot" ;;
    wezterm*|WezTerm*)           app_name=" WezTerm" ;;
    konsole*|Konsole*|org.kde.konsole*) app_name=" Konsole" ;;
    gnome-terminal*|org.gnome.Terminal*) app_name=" Terminal" ;;
    kgx*|Kgx*|org.gnome.Console*)     app_name=" Console" ;;
    ptyxis*|Ptyxis*)             app_name=" Ptyxis" ;;
    blackbox*|BlackBox*)         app_name=" BlackBox" ;;
    xterm*|XTerm*|UXTerm*)       app_name=" XTerm" ;;
    st|St|st-*)                  app_name=" st" ;;
    urxvt*|URxvt*)               app_name=" URxvt" ;;
    termite*|Termite*)           app_name=" Termite" ;;
    hyper*|Hyper*)               app_name=" Hyper" ;;
    warp*|Warp*)                 app_name=" Warp" ;;

    # ----- CODE EDITORS & IDES -----
    code*|Code*|com.visualstudio.code*)  app_name=" VS Code" ;;
    code-oss*|Code-OSS*)         app_name=" Code" ;;
    vscodium*|VSCodium*|com.vscodium.codium*) app_name=" VSCodium" ;;
    cursor*|Cursor*)             app_name=" Cursor" ;;
    windsurf*|Windsurf*)         app_name=" Windsurf" ;;
    nvim*|neovim*|Neovim*)       app_name=" Neovim" ;;
    vim*|Vim*)                   app_name=" Vim" ;;
    helix*|Helix*|hx*)           app_name=" Helix" ;;
    zed*|Zed*)                   app_name=" Zed" ;;
    sublime*|Sublime*)           app_name=" Sublime" ;;
    idea*|Idea*|intellij*|IntelliJ*) app_name=" IntelliJ" ;;
    pycharm*|PyCharm*)           app_name=" PyCharm" ;;
    goland*|GoLand*)             app_name=" GoLand" ;;
    webstorm*|WebStorm*)         app_name=" WebStorm" ;;
    phpstorm*|PhpStorm*)         app_name=" PhpStorm" ;;
    rubymine*|RubyMine*)         app_name=" RubyMine" ;;
    clion*|CLion*)               app_name=" CLion" ;;
    datagrip*|DataGrip*)         app_name=" DataGrip" ;;
    fleet*|Fleet*)               app_name=" Fleet" ;;
    gedit*|org.gnome.TextEditor*) app_name=" Text Editor" ;;
    mousepad*|Mousepad*)         app_name=" Mousepad" ;;
    xed*|Xed*)                   app_name=" Xed" ;;

    # ----- GNOME APPS -----
    nautilus*|Nautilus*|org.gnome.Nautilus*) app_name=" Files" ;;
    org.gnome.Settings*|gnome-control-center*) app_name=" Settings" ;;
    gnome-system-monitor*|org.gnome.SystemMonitor*) app_name=" System Monitor" ;;
    org.gnome.Calculator*|gnome-calculator*) app_name=" Calculator" ;;
    org.gnome.Calendar*|gnome-calendar*) app_name=" Calendar" ;;
    org.gnome.clocks*|gnome-clocks*) app_name=" Clocks" ;;
    org.gnome.Contacts*|gnome-contacts*) app_name=" Contacts" ;;
    org.gnome.Characters*|gnome-characters*) app_name=" Characters" ;;
    org.gnome.Weather*|gnome-weather*) app_name=" Weather" ;;
    org.gnome.Maps*|gnome-maps*) app_name=" Maps" ;;
    org.gnome.Photos*|gnome-photos*) app_name=" Photos" ;;
    org.gnome.Logs*|gnome-logs*) app_name=" Logs" ;;
    org.gnome.Loupe*|loupe*|Loupe*) app_name=" Image Viewer" ;;
    org.gnome.eog*|eog*|Eog*)    app_name=" Image Viewer" ;;
    org.gnome.Software*|gnome-software*) app_name=" Software" ;;
    org.gnome.Extensions*|gnome-extensions*) app_name="杻 Extensions" ;;
    org.gnome.Tweaks*|gnome-tweaks*|tweaks*) app_name=" Tweaks" ;;
    org.gnome.font-viewer*|gnome-font-viewer*) app_name=" Fonts" ;;
    org.gnome.DiskUtility*|gnome-disks*) app_name=" Disks" ;;
    org.gnome.baobab*|baobab*)   app_name=" Disk Usage" ;;
    totem*|Totem*|org.gnome.Totem*|org.gnome.Showtime*) app_name=" Videos" ;;
    org.gnome.Music*|gnome-music*) app_name=" Music" ;;
    org.gnome.Evince*|evince*)   app_name=" Document Viewer" ;;
    org.gnome.Screenshot*|gnome-screenshot*) app_name=" Screenshot" ;;
    org.gnome.SimpleScan*|simple-scan*) app_name=" Scanner" ;;
    org.gnome.Boxes*|gnome-boxes*) app_name=" Boxes" ;;
    org.gnome.Connections*|gnome-connections*) app_name=" Connections" ;;
    org.gnome.Firmware*|gnome-firmware*) app_name=" Firmware" ;;
    org.gnome.PowerStats*|gnome-power-statistics*) app_name=" Power" ;;
    org.gnome.Recipes*|gnome-recipes*) app_name=" Recipes" ;;
    org.gnome.Usage*|gnome-usage*) app_name=" Usage" ;;
    yelp*|Yelp*|org.gnome.Yelp*) app_name=" Help" ;;
    org.gnome.Tour*|gnome-tour*) app_name=" Tour" ;;
    org.gnome.Cheese*|cheese*)   app_name=" Cheese" ;;
    org.gnome.Calls*|gnome-calls*) app_name=" Calls" ;;
    org.gnome.Snapshot*|gnome-snapshot*) app_name=" Snapshot" ;;
    org.gnome.Decibels*|decibels*) app_name=" Decibels" ;;
    org.gnome.Builder*|gnome-builder*) app_name=" Builder" ;;
    org.gnome.design.IconLibrary*) app_name=" Icon Library" ;;
    org.gnome.design.Contrast*)   app_name=" Contrast" ;;
    org.gnome.design.Palette*)   app_name=" Palette" ;;
    org.gnome.Notes*|gnome-notes*|bijiben*) app_name=" Notes" ;;
    org.gnome.SoundRecorder*|gnome-sound-recorder*) app_name=" Sound Recorder" ;;
    org.gnome.Todo*|gnome-todo*)  app_name="󰡖 To Do" ;;
    org.gnome.World.Secrets*|secrets*) app_name=" Secrets" ;;
    org.gnome.World.PikaBackup*|pika-backup*) app_name=" Pika Backup" ;;
    org.gnome.gitlab.somas.isoimagewriter*) app_name=" Image Writer" ;;
    org.gnome.FontManager*|font-manager*) app_name=" Font Manager" ;;

    # ----- KDE APPS -----
    dolphin*|Dolphin*|org.kde.dolphin*) app_name=" Dolphin" ;;
    kate*|Kate*|org.kde.kate*)   app_name=" Kate" ;;
    konsole*|org.kde.konsole*)   app_name=" Konsole" ;;
    gwenview*|Gwenview*|org.kde.gwenview*) app_name=" Gwenview" ;;
    okular*|Okular*|org.kde.okular*) app_name=" Okular" ;;
    spectacle*|Spectacle*|org.kde.spectacle*) app_name=" Spectacle" ;;
    kdenlive*|Kdenlive*|org.kde.kdenlive*) app_name=" Kdenlive" ;;
    krita*|Krita*|org.kde.krita*) app_name=" Krita" ;;
    ktorrent*|KTorrent*|org.kde.ktorrent*) app_name=" KTorrent" ;;
    k3b*|K3b*|org.kde.k3b*)     app_name=" K3b" ;;
    ksystemlog*|org.kde.ksystemlog*) app_name=" System Log" ;;
    partitionmanager*|org.kde.partitionmanager*) app_name=" Partition Manager" ;;
    ark*|Ark*|org.kde.ark*)      app_name=" Ark" ;;
    kalendar*|Kalendar*|org.kde.kalendar*) app_name=" Kalendar" ;;
    kontact*|Kontact*|org.kde.kontact*) app_name=" Kontact" ;;
    kmail*|KMail*|org.kde.kmail*) app_name=" KMail" ;;
    korganizer*|KOrganizer*|org.kde.korganizer*) app_name=" KOrganizer" ;;
    knotes*|KNotes*|org.kde.knotes*) app_name=" KNotes" ;;
    kwrite*|KWrite*|org.kde.kwrite*) app_name=" KWrite" ;;
    kcalc*|KCalc*|org.kde.kcalc*) app_name=" KCalc" ;;
    kolourpaint*|KolourPaint*|org.kde.kolourpaint*) app_name=" KolourPaint" ;;
    krunner*|krunner*)           app_name=" KRunner" ;;
    ksmserver*|ksmserver*)       app_name=" KDE" ;;
    latte-dock*|latte*)          app_name=" Latte Dock" ;;
    discover*|Discover*|org.kde.discover*) app_name=" Discover" ;;
    filelight*|Filelight*|org.kde.filelight*) app_name=" Filelight" ;;
    sweeper*|Sweeper*|org.kde.sweeper*) app_name=" Sweeper" ;;
    kwave*|Kwave*|org.kde.kwave*) app_name=" Kwave" ;;
    kamoso*|Kamoso*|org.kde.kamoso*) app_name=" Kamoso" ;;
    kclock*|org.kde.kclock*)     app_name=" KClock" ;;
    kweather*|org.kde.kweather*) app_name=" KWeather" ;;
    kdevelop*|org.kde.kdevelop*) app_name=" KDevelop" ;;
    kdiff3*|org.kde.kdiff3*)     app_name=" KDiff3" ;;
    kget*|org.kde.kget*)         app_name=" KGet" ;;
    konqueror*|org.kde.konqueror*) app_name=" Konqueror" ;;
    krdc*|org.kde.krdc*)         app_name=" Remote Desktop" ;;
    krfb*|org.kde.krfb*)         app_name=" VNC" ;;
    neochat*|org.kde.neochat*)   app_name=" NeoChat" ;;
    tokodon*|org.kde.tokodon*)   app_name="󰑍 Tokodon" ;;
    kasts*|org.kde.kasts*)       app_name=" Kasts" ;;
    plasmatube*|org.kde.plasmatube*) app_name=" PlasmaTube" ;;
    angelfish*|org.kde.angelfish*) app_name=" Angelfish" ;;
    falkon*|org.kde.falkon*)     app_name=" Falkon" ;;
    kamoso*|org.kde.kamoso*)     app_name=" Kamoso" ;;
    merkuro*|org.kde.merkuro*)   app_name=" Merkuro" ;;
    zanshin*|org.kde.zanshin*)   app_name="󰡖 Zanshin" ;;
    amarok*|org.kde.amarok*)     app_name=" Amarok" ;;
    juk*|org.kde.juk*)           app_name=" Juk" ;;
    kmix*|org.kde.kmix*)         app_name=" KMix" ;;
    kcolorchooser*|org.kde.kcolorchooser*) app_name=" Color Chooser" ;;

    # ----- FILE MANAGERS -----
    thunar*|Thunar*)             app_name=" Thunar" ;;
    pcmanfm*|Pcmanfm*)           app_name=" PCManFM" ;;
    ranger|Ranger|yazi|Yazi|lf|Lf|nnn|Nnn) app_name=" FM" ;;

    # ----- OFFICE -----
    libreoffice*|LibreOffice*|org.libreoffice.LibreOffice*) app_name=" LibreOffice" ;;
    onlyoffice*|OnlyOffice*|desktopeditors*) app_name=" ONLYOFFICE" ;;
    wps*|Wps*|wps-office*)       app_name=" WPS Office" ;;
    soffice*|openoffice*)        app_name=" OpenOffice" ;;

    # ----- PDF / DOCUMENTS -----
    zathura*|Zathura*)           app_name=" Zathura" ;;
    atril*|Atril*)               app_name=" Atril" ;;
    mupdf*|MuPDF*)               app_name=" MuPDF" ;;
    sioyek*|Sioyek*)             app_name=" Sioyek" ;;
    papers*|Papers*|org.gnome.Papers*) app_name=" Papers" ;;

    # ----- MEDIA PLAYERS -----
    spotify*|Spotify*|com.spotify.Client*) app_name=" Spotify" ;;
    wiremix*|Wiremix*)           app_name=" Wiremix" ;;
    mpv*|MPV*)                   app_name=" MPV" ;;
    vlc*|VLC*|org.videolan.VLC*) app_name=" VLC" ;;
    cellulo*|Celluloid*|io.gitlab.celluloid*) app_name=" Celluloid" ;;
    haruna*|Haruna*|org.kde.haruna*) app_name=" Haruna" ;;
    clapper*|Clapper*|io.github.clapper*) app_name=" Clapper" ;;
    audacious*|Audacious*)       app_name=" Audacious" ;;
    rhythmbox*|Rhythmbox*)       app_name=" Rhythmbox" ;;
    lollypop*|Lollypop*)         app_name=" Lollypop" ;;
    strawberry*|Strawberry*)     app_name=" Strawberry" ;;
    tauon*|Tauon*)               app_name=" Tauon" ;;
    deadbeef*|DeadBeeF*)         app_name=" DeaDBeeF" ;;
    foobar*|Foobar*)             app_name=" Foobar" ;;
    clementine*|Clementine*)     app_name=" Clementine" ;;
    amberol*|Amberol*)           app_name=" Amberol" ;;
    elisa*|Elisa*|org.kde.elisa*) app_name=" Elisa" ;;
    stremio*|Stremio*|com.stremio.Stremio*) app_name=" Stremio" ;;

    # ----- CHAT & SOCIAL -----
    discord*|Discord*|com.discordapp.Discord*) app_name=" Discord" ;;
    vesktop*|Vesktop*|dev.vencord.Vesktop*) app_name=" Vesktop" ;;
    webcord*|WebCord*)           app_name=" WebCord" ;;
    slack*|Slack*|com.slack.Slack*) app_name=" Slack" ;;
    telegram*|Telegram*|org.telegram.desktop*) app_name=" Telegram" ;;
    ayugram*|AyuGram*|com.ayugram.desktop*) app_name=" AyuGram" ;;
    signal*|Signal*|org.signal.Signal*) app_name="󰭹 Signal" ;;
    whatsapp*|WhatsApp*)         app_name=" WhatsApp" ;;
    element*|Element*)           app_name=" Element" ;;
    fractal*|Fractal*)           app_name=" Fractal" ;;
    hexchat*|Hexchat*)           app_name=" HexChat" ;;
    irssi*|Irssi*)               app_name=" Irssi" ;;
    weechat*|WeeChat*)           app_name=" WeeChat" ;;
    zoom*|Zoom*|us.zoom.Zoom*|com.zoomcwm.Zoom*) app_name=" Zoom" ;;
    teams*|Teams*|teams-for-linux*) app_name=" Teams" ;;

    # ----- DESIGN & IMAGE -----
    gimp*|GIMP*|org.gimp.GIMP*)  app_name=" GIMP" ;;
    inkscape*|Inkscape*|org.inkscape.Inkscape*) app_name=" Inkscape" ;;
    figma*|Figma*)               app_name=" Figma" ;;
    drawing*|Drawing*|com.github.maoschanz.drawing*) app_name=" Drawing" ;;
    xournal*|Xournal*|xournalpp*|Xournalpp*|com.github.xournalpp.xournalpp*) app_name=" Xournal++" ;;
    rnote*|Rnote*)               app_name=" Rnote" ;;
    drawio*|Drawio*|Draw.io*)    app_name=" Draw.io" ;;
    gcolor3*|Gcolor3*|gpick*|Gpick*) app_name=" Color Picker" ;;
    pinta*|Pinta*|com.github.PintaProject.Pinta*) app_name=" Pinta" ;;
    satty*|Satty*|com.gabm.satty*) app_name=" Satty" ;;
    collision*|Collision*|dev.geopjr.Collision*) app_name=" Collision" ;;
    darktable*|Darktable*)       app_name=" Darktable" ;;
    rawtherapee*|RawTherapee*)   app_name=" RawTherapee" ;;
    digikam*|Digikam*|org.kde.digikam*) app_name=" DigiKam" ;;
    shotwell*|Shotwell*)         app_name=" Shotwell" ;;

    # ----- GAMING -----
    steam*|Steam*|com.valvesoftware.Steam*) app_name=" Steam" ;;
    lutris*|Lutris*|net.lutris.Lutris*) app_name=" Lutris" ;;
    heroic*|Heroic*|com.heroicgameslauncher.hgl*) app_name=" Heroic" ;;
    bottles*|Bottles*|com.usebottles.bottles*) app_name=" Bottles" ;;
    minecraft*|Minecraft*)       app_name=" Minecraft" ;;
    prism*|Prism*|PrismLauncher*|prismlauncher*) app_name=" Prism" ;;
    retroarch*|RetroArch*)       app_name=" RetroArch" ;;
    rpcs3*|Rpcs3*|RPCS3*)        app_name=" RPCS3" ;;
    yuzu*|Yuzu*)                 app_name=" Yuzu" ;;
    ryujinx*|Ryujinx*)           app_name=" Ryujinx" ;;
    dolphin-emu*|Dolphin-Emu*)   app_name=" Dolphin" ;;
    pcsx2*|Pcsx2*)               app_name=" PCSX2" ;;
    duckstation*|DuckStation*)   app_name=" DuckStation" ;;
    mame*|MAME*)                 app_name=" MAME" ;;
    nvidia-geforce-now*|geforcenow*|GeForceNOW*) app_name=" GeForce NOW" ;;
    moonlight*|Moonlight*)       app_name=" Moonlight" ;;
    xbox*cloud*|XboxCloud*)      app_name=" Xbox Cloud" ;;
    crush*|Crush*)               app_name=" Crush" ;;

    # ----- VIRTUALIZATION -----
    virt-manager*|VirtManager*)  app_name=" Virt Manager" ;;
    virtualbox*|VirtualBox*)     app_name=" VirtualBox" ;;
    vmware*|Vmware*)             app_name=" VMware" ;;
    qemu*|Qemu*)                 app_name=" QEMU" ;;
    gnome-boxes*|org.gnome.Boxes*) app_name=" Boxes" ;;

    # ----- DEVELOPMENT & DEVOPS -----
    docker*|Docker*)             app_name=" Docker" ;;
    docker-db*|DockerDB*)        app_name=" Docker DB" ;;
    podman*|Podman*)             app_name=" Podman" ;;
    lazydocker*|LazyDocker*)     app_name=" Lazydocker" ;;
    portainer*|Portainer*)       app_name=" Portainer" ;;
    kubectl*|kubectl*|lens*|Lens*|k9s*|K9s*) app_name=" Kubernetes" ;;
    postman*|Postman*|com.getpostman.Postman*) app_name=" Postman" ;;
    bruno*|Bruno*)               app_name=" Bruno" ;;
    insomnia*|Insomnia*)         app_name=" Insomnia" ;;
    dbeaver*|DBeaver*|dbeaver-ce*) app_name=" DBeaver" ;;
    tableplus*|TablePlus*)       app_name=" TablePlus" ;;
    mongodb*|MongoDB*|mongodb-compass*|MongoDBCompass*) app_name=" MongoDB" ;;
    android-studio*|AndroidStudio*) app_name=" Android Studio" ;;
    arduino*|Arduino*|arduino-ide*) app_name=" Arduino" ;;
    rpi-imager*|RaspberryPiImager*) app_name=" Raspberry Pi" ;;
    emacs*|Emacs*)               app_name=" Emacs" ;;
    neovide*|Neovide*)           app_name=" Neovide" ;;
    once*|Once*|ONCE*)           app_name=" ONCE" ;;
    ruby*|Ruby*)                 app_name=" Ruby" ;;
    rails*|Rails*|ruby-on-rails*) app_name=" Rails" ;;
    javascript*|node*|Node*|npm*|Npm*|yarn*|Yarn*|bun*|Bun*) app_name=" JS" ;;
    go*|Go*|golang*)             app_name=" Go" ;;
    php*|PHP*|Php*)              app_name=" PHP" ;;
    python*|Python*|python3*)    app_name=" Python" ;;
    elixir*|Elixir*)             app_name=" Elixir" ;;
    zig*|Zig*)                   app_name=" Zig" ;;
    rust*|Rust*|rustc*|rustup*)  app_name=" Rust" ;;
    dotnet*|Dotnet*|dotnet*)     app_name=" .NET" ;;
    ocaml*|Ocaml*|OCaml*)        app_name=" OCaml" ;;
    clojure*|Clojure*)           app_name=" Clojure" ;;
    scala*|Scala*)               app_name=" Scala" ;;

    # ----- SCIENCE & 3D -----
    blender*|Blender*|org.blender.Blender*) app_name=" Blender" ;;
    godot*|Godot*|org.godotengine.Godot*) app_name=" Godot" ;;
    rstudio*|RStudio*)           app_name=" RStudio" ;;
    jupyter*|Jupyter*|jupyter-lab*|JupyterLab*) app_name=" Jupyter" ;;
    octave*|Octave*|gnuplot*|Gnuplot*) app_name=" Octave" ;;
    matlab*|Matlab*|MATLAB*)     app_name=" MATLAB" ;;
    prusa-slicer*|PrusaSlicer*|bambu-studio*|BambuStudio*|orcaslicer*|OrcaSlicer*|cura*|Cura*) app_name=" Slicer" ;;
    kalzium*|Kalzium*|org.kde.kalzium*) app_name=" Kalzium" ;;

    # ----- EDUCATIONAL -----
    tuxmath*|TuxMath*|com.tux4kids.tuxmath*) app_name=" Tux Math" ;;
    tuxtype*|TuxType*|com.tux4kids.tuxtype*) app_name=" Tux Typing" ;;

    # ----- DOWNLOAD & SHARING -----
    ab-download-manager*|ABDownloadManager*|com.abdownloadmanager*|com-abdownloadmanager-desktop-AppKt*) app_name=" AB Download Manager" ;;
    transmission*|Transmission*|org.transmissionbt.Transmission*) app_name=" Transmission" ;;
    qbittorrent*|Qbittorrent*|org.qbittorrent.qBittorrent*) app_name=" qBittorrent" ;;
    deluge*|Deluge*)             app_name=" Deluge" ;;
    filezilla*|FileZilla*)       app_name=" FileZilla" ;;
    motrix*|Motrix*)             app_name=" Motrix" ;;

    # ----- SYSTEM -----
    btop*|htop*|btm*|bottom*|nvtop*|gotop*) app_name=" System Monitor" ;;
    pavucontrol*|Pavucontrol*|org.pulseaudio.pavucontrol*) app_name=" Audio" ;;
    qpwgraph*|Qpwgraph*)         app_name=" Audio" ;;
    helvum*|Helvum*)             app_name=" Audio" ;;
    easyeffects*|EasyEffects*)   app_name=" EasyEffects" ;;
    nm-connection-editor*|networkmanager*) app_name=" Network" ;;
    blueman*|blueman-manager*)   app_name=" Bluetooth" ;;
    gparted*|GParted*)           app_name=" GParted" ;;
    redshift*|Redshift*|gammastep*) app_name=" Redshift" ;;
    wdisplays*|Wdisplays*|wlr-randr*|arandr*|Arandr*) app_name=" Displays" ;;
    printer*|system-config-printer*) app_name=" Printers" ;;
    gufw*|Gufw*|firewall-config*) app_name=" Firewall" ;;
    file-roller*|FileRoller*|engrampa*|ark*|Ark*) app_name=" Archive" ;;
    bleachbit*|BleachBit*|org.bleachbit.BleachBit*) app_name=" BleachBit" ;;
    cryptomator*|Cryptomator*|org.cryptomator.Cryptomator*) app_name=" Cryptomator" ;;

    # ----- PRIVACY & SECURITY -----
    veracrypt*|VeraCrypt*)        app_name=" VeraCrypt" ;;
    wireguard*|WireGuard*)        app_name=" WireGuard" ;;
    openvpn*|OpenVPN*)            app_name=" OpenVPN" ;;
    nordvpn*|NordVPN*)            app_name="󰒄 NordVPN" ;;
    tailscale*|Tailscale*)        app_name="󰒄 Tailscale" ;;
    mullvad*|Mullvad*)            app_name="󰒄 Mullvad" ;;
    onionshare*|OnionShare*)      app_name=" OnionShare" ;;
    session*|Session*)            app_name=" Session" ;;
    simplex*|SimpleX*)            app_name=" SimpleX" ;;
    tor*|Tor*)                    app_name=" Tor" ;;
    tails*|Tails*)                app_name=" Tails" ;;
    duckduckgo*)                  app_name="󰇀 DuckDuckGo" ;;
    ublock*|ublock-origin*)       app_name=" uBlock Origin" ;;
    noscript*|NoScript*)          app_name=" NoScript" ;;
    privacybadger*|PrivacyBadger*) app_name=" Privacy Badger" ;;
    authy*|Authy*)                app_name=" Authy" ;;
    ente*|ente-auth*)             app_name=" Ente Auth" ;;
    aegis*|Aegis*)                app_name=" Aegis" ;;

    # ----- OMARCHY ECOSYSTEM -----
    waybar*)                     app_name="󰠘 Waybar" ;;
    walker*)                     app_name=" Walker" ;;
    wofi*|rofi*|Rofi*)           app_name=" Launcher" ;;
    nwg-look*|nwglook*)          app_name=" Nwg-Look" ;;
    aether*|Aether*)             app_name=" Aether" ;;
    omarchylink*|OmarchyLink*)   app_name="󱗼 Omarchy Link" ;;
    imv*|Imv*)                   app_name=" Imv" ;;
    localsend*|LocalSend*)       app_name=" LocalSend" ;;
    flatseal*|Flatseal*|com.github.tchx84.Flatseal*) app_name=" Flatseal" ;;
    warehouse*|Warehouse*|io.github.flattool.Warehouse*) app_name=" Warehouse" ;;
    blanket*|Blanket*|com.rafaelmardojai.Blanket*) app_name=" Blanket" ;;

    # ----- MAIL & COMMUNICATION -----
    thunderbird*|Thunderbird*|org.mozilla.Thunderbird*) app_name=" Thunderbird" ;;
    geary*|Geary*)               app_name=" Geary" ;;
    evolution*|Evolution*)       app_name=" Evolution" ;;
    mailspring*|Mailspring*)     app_name=" Mailspring" ;;
    bitwarden*|Bitwarden*|com.bitwarden.desktop*) app_name=" Bitwarden" ;;
    1password*|1Password*)       app_name=" 1Password" ;;
    keepassxc*|KeePassXC*)       app_name=" KeePassXC" ;;

    # ----- AI & ML -----
    lmstudio*|LMStudio*|com.lmstudio.LMStudio*) app_name="󰚩 LM Studio" ;;
    ollama*|Ollama*)             app_name="󰚩 Ollama" ;;
    dictation*|Dictation*|omarchy-dictation*) app_name="󰎙 Dictation" ;;

    # ----- NOTE TAKING -----
    obsidian*|Obsidian*|md.obsidian.Obsidian*) app_name=" Obsidian" ;;
    logseq*|Logseq*)             app_name=" Logseq" ;;
    notion*|Notion*)             app_name=" Notion" ;;
    typora*|Typora*)             app_name=" Typora" ;;
    marktext*|MarkText*)         app_name=" MarkText" ;;
    ghostwriter*|Ghostwriter*)   app_name=" Ghostwriter" ;;
    zotero*|Zotero*)             app_name=" Zotero" ;;

    # ----- AUDIO / VIDEO PRODUCTION -----
    obs*|OBS*|obs-studio*|com.obsproject.Studio*) app_name=" OBS Studio" ;;
    kdenlive*|org.kde.kdenlive*) app_name=" Kdenlive" ;;
    audacity*|Audacity*|org.audacityteam.Audacity*) app_name=" Audacity" ;;
    shotcut*|Shotcut*)           app_name=" Shotcut" ;;
    handbrake*|HandBrake*|fr.handbrake.ghb*) app_name=" HandBrake" ;;

    # ----- CLOUD & SYNC -----
    nextcloud*|Nextcloud*)       app_name=" Nextcloud" ;;
    dropbox*|Dropbox*)           app_name=" Dropbox" ;;
    syncthing*|Syncthing*|syncthing-gtk*) app_name=" Syncthing" ;;

    # ----- INSTALLED FLATPAKS -----
    app.drey.Dialect*)           app_name=" Dialect" ;;
    com.ranfdev.DistroShelf*)    app_name=" DistroShelf" ;;
    io.github.peazip.PeaZip*)    app_name=" PeaZip" ;;
    com.tonikelope.MegaBasterd*|com-tonikelope-megabasterd*) app_name=" MegaBasterd" ;;
    de.schmidhuberj.tubefeeder*|Pipeline*) app_name=" Pipeline" ;;
    fr.handbrake.ghb*|HandBrake*) app_name=" HandBrake" ;;
    io.github.AshBuk.FingerGo*|fingergo*) app_name=" FingerGo" ;;
    io.github.fabrialberio.pinapp*) app_name=" Pins" ;;
    io.github.flattool.Warehouse*) app_name=" Warehouse" ;;
    io.github.kolunmi.Bazaar*)   app_name=" Bazaar" ;;
    io.github.linx_systems.ClamUI*) app_name=" ClamUI" ;;
    io.github.vmkspv.lenspect*)  app_name=" Lenspect" ;;
    io.gitlab.adhami3310.Converter*) app_name=" Switcheroo" ;;
    io.gitlab.theevilskeleton.Upscaler*) app_name=" Upscaler" ;;
    net.nokyan.Resources*)       app_name=" Resources" ;;
    org.bunkus.mkvtoolnix-gui*)  app_name=" MKVToolNix" ;;
    org.gnome.gitlab.YaLTeR.VideoTrimmer*) app_name=" Video Trimmer" ;;
    com.rafaelmardojai.Blanket*) app_name=" Blanket" ;;
    dev.bragefuglseth.Keypunch*) app_name=" Keypunch" ;;
    de.swsnr.keepmeawake*)       app_name=" Keep Awake" ;;
    garden.jamie.Morphosis*)     app_name=" Morphosis" ;;
    com.github.tchx84.Flatseal*) app_name=" Flatseal" ;;

    # ----- DEFAULT -----
    *)                           app_name=" $short" ;;
  esac

  echo "$app_name"
}

APP_INFO=$(get_app_info "$CLASS" "$SHORT_CLASS")
ICON="${APP_INFO%% *}"
NAME="${APP_INFO#* }"

if is_browser "$CLASS"; then
  RAW_NAME=$(strip_browser_suffix "$TITLE")
  RAW_NAME=$(echo "$RAW_NAME" | sed -E 's/^\([0-9]+\)\s*//; s/^\[[0-9]+\]\s*//')
  RAW_NAME=$(echo "$RAW_NAME" | sed -E 's/^.*\s[—–·|]\s+//')

  if [ -n "$RAW_NAME" ] && ! is_newtab "$RAW_NAME"; then
    SITE_ICON=$(get_site_icon "$RAW_NAME")
    [ -n "$SITE_ICON" ] && ICON="$SITE_ICON"
    NAME="$RAW_NAME"
  fi
fi

[ ${#NAME} -gt 35 ] && NAME="${NAME:0:35}…"

jq -n -c --arg text "<span color='${C_ACCENT}'>${ICON}</span>    ${NAME}" --arg class "" '{text: $text, class: $class}'
