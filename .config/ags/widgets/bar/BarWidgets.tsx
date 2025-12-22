import AstalHyprland from "gi://AstalHyprland";
import AstalBattery from "gi://AstalBattery";
import Tray from "gi://AstalTray";
import { bind, exec, GLib, Variable } from "astal";
import { Gtk } from "astal/gtk4";
import Brightness from "../../utils/brightness";
import { ButtonProps } from "astal/gtk4/widget";

type WsButtonProps = ButtonProps & {
  ws: AstalHyprland.Workspace;
};

function WorkspaceButton({ ws, ...props }: WsButtonProps) {
  const hyprland = AstalHyprland.get_default();
  const classNames = Variable.derive(
    [bind(hyprland, "focusedWorkspace"), bind(hyprland, "clients")],
    (fws, _) => {
      let classes = [];
      const active = fws.id == ws.id;
      active && classes.push("active");

      return classes;
    },
  );

  return (
    <button
      cssClasses={classNames()}
      onDestroy={() => classNames.drop()}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      onClicked={() => ws.focus()}
      {...props}
    />
  );
}

export function Workspaces() {
  const hyprland = AstalHyprland.get_default();
  return (
    <box cssClasses={["workspaces"]} spacing={4}>
      {bind(hyprland, "workspaces").as((wss) =>
        wss
          .filter((ws) => !(ws.id >= -99 && ws.id <= -2))
          .sort((a, b) => a.id - b.id)
          .map((ws) => <WorkspaceButton ws={ws} />),
      )}
    </box>
  );
}
export function Clock({ singleLine }: { singleLine: boolean }) {
  let format: string;

  if (singleLine) {
    format = "%H:%M";
  } else {
    format = "%H\n%M";
  }

  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <button
      cssClasses={["clockButton"]}
      onClicked={() => {
        // toggleWindow(CalendarWindowName);
      }}
    >
      {time()}
    </button>
  );
}

export function TrayContent() {
  const tray = Tray.get_default();
  return (
    <box heightRequest={20}>
      {bind(tray, "items").as((items) =>
        items.map((item) => (
          <menubutton
            cssClasses={["trayButton"]}
            heightRequest={15}
            setup={(self) => {
              self.insert_action_group("dbusmenu", item.actionGroup);
            }}
            tooltipText={bind(item, "tooltipMarkup")}
          >
            <image gicon={bind(item, "gicon")} />
            {Gtk.PopoverMenu.new_from_model(item.menuModel)}
          </menubutton>
        )),
      )}
    </box>
  );
}

export function BrightnessDisplay() {
  const brightness = Brightness.get_default();

  return (
    <box cssClasses={["brightnessContainer"]}>
      <image
        valign={Gtk.Align.CENTER}
        iconName={"display-brightness-symbolic"}
      />
      <label valign={Gtk.Align.CENTER}>
        {bind(brightness, "screen").as((p) => `${Math.floor(p * 100)}%`)}
      </label>
    </box>
  );
}

export function Battery() {
  const battery = AstalBattery.get_default();

  return (
    <box
      visible={bind(battery, "isPresent")}
      cssClasses={bind(battery, "percentage").as((p) => {
        const classes = ["batteryContainer"];
        if (p <= 0.1) classes.push("batteryTooLow");
        else if (p <= 0.3) classes.push("batteryLow");
        return classes;
      })}
    >
      <image
        valign={Gtk.Align.CENTER}
        iconName={bind(battery, "batteryIconName")}
      />
      <label valign={Gtk.Align.CENTER}>
        {bind(battery, "percentage").as((p) => `${Math.floor(p * 100)}%`)}
      </label>
    </box>
  );
}

export function PowerControl() {
  return (
    <button
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      cssClasses={["powerIconButton"]}
      onClicked={() => exec(["wlogout", " --protocol", "layer-shell"])}
    >
      <image iconName={"system-shutdown-symbolic"} />
    </button>
  );
}
