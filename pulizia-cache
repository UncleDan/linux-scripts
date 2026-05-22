#!/bin/bash

set -e  # Exit on error
clear

# Configurazione
TB_PROFILE_PATH="$HOME/.thunderbird"
TB_CACHE_PATH="$HOME/.cache/thunderbird"
CHROME_CACHE_ROOT="$HOME/.cache/google-chrome"
CHROME_CONFIG_ROOT="$HOME/.config/google-chrome"
PCLOUD_CACHE_PATH="$HOME/.pcloud/Cache"
PCLOUD_TN_PATH="$HOME/.pcloud/ntfthumbs"
FIREFOX_PROFILES_PATH="$HOME/.mozilla/firefox"
FIREFOX_CACHE_PATH="$HOME/.cache/mozilla/firefox"

# Funzioni
check_process_running() {
    local process_name=$1
    if pgrep -x "$process_name" > /dev/null; then
        echo "❌ ERRORE: $process_name è in esecuzione. Chiudilo prima."
        return 1
    fi
    return 0
}

clean_directory() {
    local dir_path=$1
    local description=$2

    if [ -d "$dir_path" ]; then
        echo "🧹 $description: $dir_path"
        if [ "$(ls -A "$dir_path")" ]; then
            rm -rf "$dir_path"/*
            echo "✅ $description completata."
        else
            echo "ℹ️  Directory già vuota."
        fi
    else
        echo "ℹ️  Directory non trovata: $dir_path"
    fi
}

clean_firefox_cache() {
    echo -e "\n\n\n### PULIZIA FIREFOX ###\n"

    # Controllo processo Firefox
    if pgrep -x "firefox" > /dev/null; then
        echo "❌ ERRORE: Firefox è in esecuzione. Chiudilo prima."
        return 1
    fi

    echo "🚀 Inizio pulizia approfondita di Firefox..."

    # --- FASE 1: Pulizia Cache Principale (.cache) ---
    if [ -d "$FIREFOX_CACHE_PATH" ]; then
        echo "📂 Pulizia cache principale: $FIREFOX_CACHE_PATH"
        find "$FIREFOX_CACHE_PATH" -mindepth 1 -maxdepth 1 -type d | while read -r profile_cache; do
            if [ -d "$profile_cache" ]; then
                profile_name=$(basename "$profile_cache")
                echo "   🧹 Pulizia cache per profilo: $profile_name"
                rm -rf "$profile_cache"/*
            fi
        done
        echo "✅ Cache principale svuotata."
    else
        echo "ℹ️  Nessuna cartella cache principale trovata: $FIREFOX_CACHE_PATH"
    fi

    # --- FASE 2: Pulizia Cache nei Profili (.mozilla/firefox) ---
    if [ -d "$FIREFOX_PROFILES_PATH" ]; then
        echo "🔍 Pulizia cache nei profili: $FIREFOX_PROFILES_PATH"

        # Trova tutte le cartelle dei profili (escludendo i file)
        find "$FIREFOX_PROFILES_PATH" -mindepth 1 -maxdepth 1 -type d | while read -r profile_dir; do
            profile_name=$(basename "$profile_dir")
            echo "   📁 Elaborazione profilo: $profile_name"

            # Directory della cache all'interno del profilo
            cache_dirs=(
                "cache"
                "cache2"
                "thumbnails"
                "startupCache"
                "weave"
                "storage"
            )

            for cache_dir in "${cache_dirs[@]}"; do
                cache_path="$profile_dir/$cache_dir"
                if [ -d "$cache_path" ]; then
                    echo "      🗑️  Rimozione: $cache_dir"
                    rm -rf "$cache_path"
                fi
            done

            # Pulizia file specifici della cache
            find "$profile_dir" -type f \( -name "*.jsonlz4" -o -name "*.bak" -o -name "*.tmp" \) -delete

            # Pulizia cache offline
            offline_cache="$profile_dir/offlinecache"
            if [ -d "$offline_cache" ]; then
                echo "      🗑️  Rimozione cache offline"
                rm -rf "$offline_cache"
            fi
        done
        echo "✅ Cache dei profili pulita."
    else
        echo "ℹ️  Nessuna cartella profili Firefox trovata: $FIREFOX_PROFILES_PATH"
    fi

    # --- FASE 3: Pulizia Cache di Sistema ---
    echo "🔍 Pulizia cache di sistema Firefox..."

    # Cache shader
    if [ -d "$HOME/.cache/mesa_shader_cache" ]; then
        echo "   🗑️  Rimozione cache shader Mesa"
        rm -rf "$HOME/.cache/mesa_shader_cache"
    fi

    # Cache IPC
    if [ -d "$HOME/.cache/mozilla-ipc" ]; then
        echo "   🗑️  Rimozione cache IPC"
        rm -rf "$HOME/.cache/mozilla-ipc"
    fi

    echo "✅ Pulizia Firefox completata. Al prossimo avvio Firefox ricostruirà le cache."
}

clean_thunderbird() {
    echo -e "\n\n\n### PULIZIA THUNDERBIRD ###\n"

    # Controllo processo Thunderbird
    check_process_running "thunderbird" || return 1

    echo "🚀 Inizio pulizia approfondita di Thunderbird..."

    # --- FASE 1: Pulizia Cache Web ---
    clean_directory "$TB_CACHE_PATH" "Pulizia Cache temporanea"

    # --- FASE 2: Pulizia ImapMail ---
    echo "🔍 Ricerca cartelle ImapMail..."
    find "$TB_PROFILE_PATH" -type d -name "ImapMail" 2>/dev/null | while read -r imap_folder; do
        if [ -n "$(ls -A "$imap_folder")" ]; then
            echo "   🗑️  Svuoto: $imap_folder"
            rm -rf "$imap_folder"/*
        fi
    done
    echo "✅ Cartelle ImapMail pulite."

    # --- FASE 3: Reset Indice Globale ---
    echo "🔍 Ricerca database global-messages-db.sqlite..."
    find "$TB_PROFILE_PATH" -name "global-messages-db.sqlite" -type f -delete
    echo "✅ Database di ricerca eliminato (sarà ricostruito all'avvio)."

    # --- FASE 4: Pulizia file .msf ---
    echo "🔍 Rimozione indici .msf corrotti..."
    find "$TB_PROFILE_PATH" -name "*.msf" -type f -delete
    echo "✅ File .msf eliminati."

    echo "🏁 Pulizia Thunderbird completata. Al riavvio Thunderbird reindicizzerà i messaggi."
}

clean_chrome() {
    echo -e "\n\n\n### PULIZIA CHROME ###\n"

    # Controllo processo Chrome
    if pgrep -x "chrome" > /dev/null || pgrep -x "google-chrome" > /dev/null; then
        echo "❌ ERRORE: Google Chrome è in esecuzione."
        echo "Per favore chiudi il browser completamente e riprova."
        return 1
    fi

    echo "🚀 Inizio pulizia cache Google Chrome..."

    # --- FASE 1: Pulizia Cache Principale (.cache) ---
    if [ -d "$CHROME_CACHE_ROOT" ]; then
        echo "📂 Analisi cartella cache principale: $CHROME_CACHE_ROOT"
        for profile_cache in "$CHROME_CACHE_ROOT"/*; do
            if [ -d "$profile_cache" ]; then
                profile_name=$(basename "$profile_cache")
                echo "   🧹 Pulizia cache per profilo: $profile_name"
                rm -rf "$profile_cache"/*
            fi
        done
        echo "✅ Cache web principale svuotata."
    else
        echo "ℹ️  Cartella .cache/google-chrome non trovata."
    fi

    # --- FASE 2: Pulizia Cache GPU e Shader (.config) ---
    echo "🔍 Controllo cache secondarie (GPUCache) in $CHROME_CONFIG_ROOT..."
    if [ -d "$CHROME_CONFIG_ROOT" ]; then
        find "$CHROME_CONFIG_ROOT" -type d \( -name "GPUCache" -o -name "ShaderCache" \) | while read -r extra_cache; do
            echo "   🗑️  Rimuovo: $extra_cache"
            rm -rf "$extra_cache"
        done
        echo "✅ Cache GPU e Shader svuotate."
    fi

    echo "✅ Pulizia Chrome completata. Al prossimo avvio Chrome sarà un po' più lento a caricare le prime pagine."
}

clean_pcloud() {
    echo -e "\n\n\n### PULIZIA PCLOUD ###\n"

    # Controllo processo pCloud
    check_process_running "pcloud" || return 1

    # --- FASE 1: Pulizia Cache ---
    clean_directory "$PCLOUD_CACHE_PATH" "Pulizia Cache temporanea pCloud"

    # --- FASE 2: Pulizia Thumbnails ---
    clean_directory "$PCLOUD_TN_PATH" "Pulizia Thumbnails pCloud"

    echo "✅ Cartelle pCloud pulite."
}

clean_history() {
    echo -e "\n\n\n### PULIZIA TERMINAL HISTORY ###\n"

    history -c

    echo "✅ Pulizia terminale completata."
}

# Esecuzione principale
main() {
    echo "🔄 INIZIO PULIZIA COMPLETA SISTEMA"
    echo "==================================="

    clean_thunderbird
    clean_chrome
    clean_pcloud
    clean_firefox_cache
    # clean_history

    echo -e "\n\n\n🎉 PULIZIA COMPLETATA CON SUCCESSO!"
    echo "==================================="
    echo "Tutti i programmi sono stati puliti."
    echo -e "I prossimi avvi potrebbero essere più lenti mentre ricostruiscono le cache.\n\n\n"
}

# Esegui lo script principale
main
