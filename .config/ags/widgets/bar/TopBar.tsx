import { Astal, Gdk, Gtk } from "astal/gtk4";
import {
  Battery,
  Clock,
  PowerControl,
  BrightnessDisplay as Brightness,
  Workspaces,
} from "./BarWidgets";
import config from "../../config";

export default function (monitor: Gdk.Monitor) {
  return (
    <window

      // widthRequest={1910}
      visible={true}
      anchor={
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.LEFT |
        Astal.WindowAnchor.RIGHT
      }
      marginTop={5}
      marginLeft={5}
      marginRight={5}
      cssClasses={["transparentBackground"]}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      gdkmonitor={monitor}
    >
      <centerbox
        orientation={Gtk.Orientation.HORIZONTAL}
        cssClasses={config.barWindows ? ["topBar"] : ["barWindow", "topBar"]}
      >
        <box
          halign={Gtk.Align.START}
          cssClasses={config.barWindows ? ["barWindow"] : []}
        >
          <Workspaces />
        </box>
        <box
          halign={Gtk.Align.CENTER}
          cssClasses={config.barWindows ? ["barWindow"] : []}
        >
          <Clock singleLine={true} />
        </box>
        <box
          halign={Gtk.Align.END}
          cssClasses={config.barWindows ? ["barWindow"] : []}
        >
          <Brightness />
          <Battery />
          <PowerControl />
        </box>
      </centerbox>
    </window>
  );
}
