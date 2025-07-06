#!/bin/bash

# ==============================================================================
# Script para organizar el repositorio 'community' de KISS Linux
# ==============================================================================
#
# INSTRUCCIONES:
# 1. Guarda este script como 'organizar_repo.sh' en la raíz de tu repositorio.
# 2. Dale permisos de ejecución: chmod +x organizar_repo.sh
# 3. ¡IMPORTANTE! Ejecuta primero en modo "ensayo" (DRY_RUN="true").
#    Verifica que la salida sea la esperada: ./organizar_repo.sh
# 4. Cuando estés seguro, cambia DRY_RUN="false" y ejecuta de nuevo para
#    mover los archivos realmente.

# --- CONFIGURACIÓN ---
# Cambia a "false" para mover los archivos de verdad.
# Por seguridad, empieza con "true".
DRY_RUN="false"

# Directorio base de los paquetes de la comunidad
COMMUNITY_DIR="community"

# --- VERIFICACIÓN INICIAL ---
if [ ! -d "$COMMUNITY_DIR" ]; then
  echo "Error: El directorio '$COMMUNITY_DIR' no se encuentra."
  echo "Asegúrate de ejecutar este script desde la raíz de tu repositorio."
  exit 1
fi

# --- DEFINICIÓN DE CATEGORÍAS Y PAQUETES ---

# Herramientas de línea de comandos y utilidades del sistema
CLI_TOOLS=(
    abduco age aml aria2 asciinema autoconf autoconf-archive automake axel
    bandwhich bash bat bc bdfedit btop bubblewrap btrfs-progs ccrypt cfm cloc
    coreutils cproc cryptsetup ctags dash delta dialog discount diskonaut
    dmidecode dogefetch entr evtest exa execline exfatprogs exiftool fdm feh
    fff fftw file fnf fossil fzy gawk gc gcompat gdb gettext-tiny gnupg1
    gnupg2 groff gron-git gsl gspt gtar htop hugo idmap inih iniparser
    init-hooks iproute2 iptables isync iw jo jq kexec-tools keyutils
    kiss-find kmod less lm-sensors lsof lvm2 lz4 lzo mblaze mdev-usb mg
    mksh mtools mtr nano nawk-git ncdu1 neofetch nmap npth nq nsd ntfs-3g
    numactl oksh pash patch patchelf pciutils perl pfetch pick pinentry
    pmount popt powertop procps-ng pv qbe qrencode readline reptyr ripgrep

    rsync s6 s6-linux-init s6-rc sbase sc sc-im sccache screenfetch sed sed-i
    shepherd shfm shfmt-bin shinit sinit smu-karlb ssu strace sudo sysmgr
    tea terminus-font texinfo tig tmate tmux tokei totp tre tree uacme
    ubase ugrep unifdef-git unzip uthash viu vmwh wireguard-tools wireless_tools
    xxd yajl yaml-cpp yarn yash yasm yt-dlp ytfzf zip zsh zzz
)

# Entorno de Escritorio (Gestores de Ventanas, Barras, Lanzadores, etc.)
DESKTOP_WM=(
    2bwm 9base 9wm-git berry-git bspwm compfy-git cwm-git dwm frankenwm-git
    fvwm-git herbstluftwm i3 jwm openbox picom picom-git sowm spectrwm
    stumpwm-git tinywm-git twm windowmaker
)
DESKTOP_BARS_LAUNCHERS=(
    bemenu dmenu dzen-git lemonbar polybar-git rofi wmenu xmenu-git
)
DESKTOP_UTILS=(
    alacritty autorandr btop brownout cava dunst herbe hsetroot maim neovim
    nitrogen nsxiv pounce pqiv sct slock slop st st-luke-git stalonetray-git
    svkbd sxhkd tabbed volumeicon xcompmgr xssstate xwallpaper
)
DESKTOP_THEMES=(
    lxappearance
)

# Bibliotecas (Dependencias de otros paquetes)
LIBS=(
    atk babl boost brotli c-ares cairo cgal chemtool coin cp-rs crosstool-ng
    cups-filters curlpp cyrus-sasl double-conversion eigen erlang-otp exiv2
    fdk-aac flac flatpak fltk fmt freeglut fribidi fuse fuse2 gd gegl
    gettext-tiny gexiv2 giflib girara glew glfw glib-networking glm gmp gnutls
    gobject-introspection godot goffice gpgme graphene gsl gst-plugins-base
    gstreamer gt5 gtest gtk+2 gtk+4 guile3 gumbo-parser harfbuzz-icu hdf5
    icu imath imlib2 jansson jbig2dec json-glib jsoncpp lcms ldns libadwaita

    libaio libarchive libassuan libatomic_ops libbpf libburn libcap libconfig
    libcupsfilters libdvdcss libdvdread libedit libev libevent libexif
    libfixposix libgcrypt libgphoto2 libgsf libisoburn libisofs libjpeg
    libksba libmedc libmupdf libmypaint libnghttp2 libnl libnotify libpcap
    libportaudio2 libppd libpsl libptytty librsvg libsass libseccomp libsecret
    libsigc++ libsixel libslirp libsndfile libsodium libsoup libsoup3
    libspectre libspnav libssh libtasn1 libtermkey libtool libtorrent
    libtorrent-rasterbar libunistring liburing libusb libutemper libuv
    libvncserver libwebsockets libxaw3d libxdp libxml2 libxmlb libxslt libyaml
    limine links lpeg lua luajit libgpg-error lzo msgpack-c mypaint-brushes
    neatvnc neon nettle nspr nss openal-soft opencascade opencsg openjpeg2

    opus pango pcre2 pixman pkcs11-helper poppler protobuf protobuf-c pystring
    python-pivy qpdf qscintilla-qt5 qt5 qt5-declarative qt5-multimedia qt5-svg
    qt5-wayland qt5-webchannel qt5-webengine qt5-x11extras qt5-xmlpatterns qt6
    raylib retrogram-rtlsdr rtaudio s2n-tls sane sasm sassc scenefx skalibs
    slang sndio spirv-headers spirv-tools sqlite swig tcl tdb tiff tk tre
    unixodbc virglrenderer vte3-git wayland-protocols wv wxWidgets xerces-c
    zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-pdf-poppler zstd
)

# Multimedia (Reproductores, Editores, etc.)
MEDIA=(
    abiword aerc amfora apulse ardour audacity azpainter cmus discco
    djvulibre dosbox gimp-git gnumeric gnuplot gphoto2 imagemagick lame
    libvpx mplayer mtpaint neomutt ocrfeeder opencore-amr potrace pulseaudio

    qjackctl qsynth sound-theme-freedesktop sox soxr speex speexdsp swh-plugins
    sylpheed vokoscreen vlc vorbis-tools webrtc-audio-processing x264 x265
    xvidcore zathura
)

# Redes e Internet
NET=(
    amfora apint-git catgirl darkhttpd dillo elinks falkon gftp-git
    github-cli glorytun globe-cli gtk-gnutella-git hostapd isync links luakit
    mosh msmtp neomutt neon netsurf-gtk3 nyxt pounce sfeed surf syncthing
    tftp-hpa transmission unbound whois
)

# Desarrollo de Software
DEV=(
    android-tools appstream appstream-glib bear bluez ccache chicken cmark-gfm
    cmake coin containerd crosstool-ng cscope ctags doxygen ecl erlang fossil
    gc gdb go go-bootstrap go-ipfs goimports gopls gperf gtest guile3
    guile3-fibers-git hugo jo kak-lsp-bin kakoune kfc kicad libexecinfo
    libgit2 lldb ltrace lua luajit nasm nodejs picolisp prolog
    pybind11 python python-pivy qemu qtcreator racket rls rust rust-analyzer
    sbcl scons strace swig tcc tcl tk vala verible yasm zig-bin zls-bin
)

# Juegos
GAMES=(
    sgt-puzzles
)

# Tipografías
FONTS=(
    cantarell-fonts dejavu-ttf hack iosevka-nerd-fonts liberation-fonts
    terminus-font ttf-font-awesome ttf-jetbrains-mono twemoji-color-font
)

# Aplicaciones y utilidades de Xorg
XORG_APPS=(
    bdfedit bdftopcf ctwm dzen-git farbfeld hsetroot libXaw3d libXmu libXpm
    maim mkfontdir motif otf2bdf-git setxkbmap slop st stalonetray-git
    sx sxcs sxhkd tabbed x11fs-git x11up x11vnc-git xbanish xcalc
    xcb-util-xrm xcircuit xclip xcompmgr xdo xdotool xf86-video-fbdev
    xf86-video-qxl xf86-video-vmware xfiles-git xhidecursor-git xhost xkill
    xmenu-git xmodmap xnotify xob xrandr-invert-colors-git xsel xssstate
    xwallpaper xwm
)


# --- LÓGICA DEL SCRIPT ---

# Función para mover paquetes
move_package() {
  local pkg_name=$1
  local dest_dir=$2

  if [ -d "$COMMUNITY_DIR/$pkg_name" ]; then
    if [ "$DRY_RUN" = "true" ]; then
      echo "Ensayo: mv $COMMUNITY_DIR/$pkg_name $COMMUNITY_DIR/$dest_dir/"
    else
      echo "Moviendo $pkg_name a $dest_dir/"
      mv "$COMMUNITY_DIR/$pkg_name" "$COMMUNITY_DIR/$dest_dir/"
    fi
  fi
}

# Crear las nuevas categorías
echo "--- Creando directorios de categorías ---"
CATEGORIES=(
    "cli-tools"
    "desktop/wm"
    "desktop/bars-launchers"
    "desktop/utils"
    "desktop/themes"
    "libs"
    "media"
    "net"
    "dev"
    "games"
    "fonts"
    "xorg-apps"
)

for cat in "${CATEGORIES[@]}"; do
  if [ "$DRY_RUN" = "true" ]; then
    echo "Ensayo: mkdir -p $COMMUNITY_DIR/$cat"
  else
    mkdir -p "$COMMUNITY_DIR/$cat"
  fi
done
echo "Directorios creados (o ya existían)."
echo ""

# Mover los paquetes
echo "--- Moviendo paquetes a sus nuevas categorías ---"

for pkg in "${CLI_TOOLS[@]}"; do move_package "$pkg" "cli-tools"; done
for pkg in "${DESKTOP_WM[@]}"; do move_package "$pkg" "desktop/wm"; done
for pkg in "${DESKTOP_BARS_LAUNCHERS[@]}"; do move_package "$pkg" "desktop/bars-launchers"; done
for pkg in "${DESKTOP_UTILS[@]}"; do move_package "$pkg" "desktop/utils"; done
for pkg in "${DESKTOP_THEMES[@]}"; do move_package "$pkg" "desktop/themes"; done
for pkg in "${LIBS[@]}"; do move_package "$pkg" "libs"; done
for pkg in "${MEDIA[@]}"; do move_package "$pkg" "media"; done
for pkg in "${NET[@]}"; do move_package "$pkg" "net"; done
for pkg in "${DEV[@]}"; do move_package "$pkg" "dev"; done
for pkg in "${GAMES[@]}"; do move_package "$pkg" "games"; done
for pkg in "${FONTS[@]}"; do move_package "$pkg" "fonts"; done
for pkg in "${XORG_APPS[@]}"; do move_package "$pkg" "xorg-apps"; done

echo ""
if [ "$DRY_RUN" = "true" ]; then
  echo "--- Ensayo finalizado ---"
  echo "No se ha movido ningún archivo. Revisa la salida."
  echo "Para mover los archivos, edita el script y cambia DRY_RUN a \"false\"."
else
  echo "--- ¡Organización completada! ---"
fi
