#!/usr/bin/env python3

import os
import socket
import subprocess
import json

APP_MAP = {
    "zen browser": "\uf269",
    "firefox": "\uf269",
    "chrome": "\uf268",
    "code": "\ue8da",
    "nvim": "\uf36f",
    "ghostty": "\uf120",
    "/home/luis": "\uf120",
    "thunar": "\uf07b",
    "libreoffice": "\uf376",
    "obsidian": "\uf249",
    "discord": "\uf1ff",
}
DEFAULT_ICON = "\uf10c"
OCCUPIED_ICON = "\uf192"
MULTIPLE_ICON = "\uf2d2"
ACTIVE_ICON  = "\uf111"


def get_workspaces():
    output = subprocess.check_output(["hyprctl", "workspaces", "-j"])
    return json.loads(output.decode("utf-8"))


def get_active_workspace():
    output = subprocess.check_output(["hyprctl", "activeworkspace", "-j"])
    return json.loads(output.decode("utf-8"))


def workspace_icon(wsp):
    if not wsp:
        return DEFAULT_ICON
    windows = wsp["windows"] or 0

    if windows == 0:
        return DEFAULT_ICON

    if windows > 1:
        return MULTIPLE_ICON

    title = (wsp["lastwindowtitle"] or "").lower()

    for key, icon in APP_MAP.items():
        if key in title:
            return icon
        
    return OCCUPIED_ICON


def generate_workspace_data() -> dict:
    data = {}

    workspaces = get_workspaces()
    active = get_active_workspace()
    active_name = str(active["name"])
    active_monitor = active["monitor"]

    by_monitor = {}
    for wsp in workspaces:
        by_monitor.setdefault(wsp["monitor"], {})[str(wsp["name"])] = wsp

    for monitor, wsps in by_monitor.items():
        data[monitor] = []

        occupied_ids = [int(name) for name in wsps.keys() if name.isdigit()]
        max_id = max(occupied_ids, default=5)

        count = max(5, max_id)

        for n in range(1, count + 1):
            name = str(n)
            wsp = wsps.get(name)

            is_active = name == active_name and monitor == active_monitor
            icon = workspace_icon(wsp)

            if is_active and (icon == DEFAULT_ICON or icon == OCCUPIED_ICON):
                icon = ACTIVE_ICON

            data[monitor].append(
                {
                    "name": name,
                    "monitor": monitor,
                    "icon": icon,
                    "class": "active" if is_active else "",
                    "exists": wsp is not None,
                }
            )

    return data


def listen_for_events():
    runtime = os.environ.get("XDG_RUNTIME_DIR")
    signature = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE")

    if not runtime or not signature:
        raise RuntimeError("Hyrpland environment variables not found")

    socket_path = f"{runtime}/hypr/{signature}/.socket2.sock"

    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect(socket_path)

    return sock


if __name__ == "__main__":
    sock = listen_for_events()

    while True:
        print(json.dumps(generate_workspace_data()), flush=True)

        data = sock.recv(4096)
        if not data:
            break

        if data.startswith(b"workspace"):
            continue
