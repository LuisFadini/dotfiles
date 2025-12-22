import { App } from "astal/gtk4";
import style from "./scss/main.scss";
import TopBar from "./widgets/bar/TopBar";
import Hyprland from "gi://AstalHyprland";

const hyprland = Hyprland.get_default();

App.start({
  requestHandler(req, res) { },
  css: style,
  main(...args: Array<string>) {
    [TopBar].map((win) => App.get_monitors().map(win));
  },
});
