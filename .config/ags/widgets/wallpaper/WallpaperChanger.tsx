import { Gio } from "astal";
import { Gtk } from "astal/gtk4";
import config from "../../config";

function Wallpapers() {
  const wallpaperDirectory = Gio.File.new_for_path(config.wallpaperDir);
  let wallpaperEnumerator = wallpaperDirectory.enumerate_children(
    "standard::*",
    Gio.FileQueryInfoFlags.NONE,
    null
  );

  let col = 1;
  let row = 1;
  let fileInfo: Gio.FileInfo| null;
  while ((fileInfo = wallpaperEnumerator.next_file()) != null) {
    let fileName = fileInfo.get_name();

    if (config.supportedWallpaperTypes.some((ty) => fileName.endsWith(ty))) {
      let filePath = wallpaperDirectory.get_child(fileName).get_path();
      // const img = Widget.Box({
      //   class_name: `wpc_grid_item_container`,
      //   children: [
      //     Widget.Box({
      //       class_name: `wpc_grid_item`,
      //       css: WALL_DIR.bind().as((_) => {
      //         GdkPixbuf.Pixbuf.new_from_file(filePath!);
      //         return `background-image: url("${filePath!}")`;
      //       }),
      //     }),
      //     Widget.Box({
      //       vertical: true,
      //       hexpand: true,
      //       spacing: 10,
      //       children: [
      //         Widget.Label({
      //           label: fileName,
      //           css: `margin-left: 6px;`,
      //           hpack: "center",
      //         }),
      //         Widget.Button({
      //           class_names: ["ro_btn", "wpc_button"],
      //           label: wallpaper
      //             .bind("wallpaper_path")
      //             .as((w) => (w === filePath ? "Applied" : "Apply")),
      //           sensitive: wallpaper
      //             .bind("wallpaper_path")
      //             .as((w) => !(w === filePath)),
      //           vexpand: false,
      //           hexpand: true,
      //           vpack: "start",
      //           hpack: "center",
      //           on_clicked: () => {
      //             changeWallpaperAndTheme(filePath!);
      //           },
      //         }),
      //       ],
      //     }),
      //   ],
      // });

      // grid.attach(img, column, row, 1, 1);

      col++;
      if (col === 4) {
        col = 1;
        row++;
      }
    }
  }

  return <Gtk.Grid columnSpacing={10} rowSpacing={10}></Gtk.Grid>;
}
