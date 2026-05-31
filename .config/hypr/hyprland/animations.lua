Bezier("linear", 0, 0, 1, 1)
Bezier("accel", 0.3, 0, 0.8, 0.15)
Bezier("decel", 0.05, 0.7, 0.1, 1)
Bezier("soft", 0.26, 0.26, 0.15, 1)

BAnimation("windows", true, 2, "decel", "popin 60%")
BAnimation("windowsIn", true, 2, "decel", "popin 60%")
BAnimation("windowsOut", true, 2, "accel", "popin 60%")

BAnimation("border", true, 10, "linear")
BAnimation("fade", true, 3, "soft")

BAnimation("layers", true, 1.5, "decel", "slide")
BAnimation("layersIn", true, 1.5, "decel", "slide")
BAnimation("layersOut", true, 0.5, "accel")

BAnimation("fadeLayersIn", true, 1, "decel")
BAnimation("fadeLayersOut", true, 1, "accel")

BAnimation("workspaces", true, 1.5, "soft", "slidefade 15%")
BAnimation("specialWorkspace", true, 2, "decel", "slidefadevert 15%")
