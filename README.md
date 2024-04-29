# Wheelchair Handle Deterrent
This is a 3D-printable device that you can attach to the handles of a wheelchair.
It prevents/deters people from grabbing the handles without your permission/consent.

If you don't care about customization and/or your handles are either 7/8" or 5/8",
there are pre-built STLs in the `build/` directory.

## Authoritative links
- [Git repo](https://github.com/Joedang/wheelchairHandleDeterrent)
    - This is the "canonical" source. I'll try to make sure Thingiverse matches, but it's a manual process.
- [Thingiverse thing](https://www.thingiverse.com/thing:6600517)

## Manufacturing
This is intended to be FDM printed without supports.
0.2 mm layers with 15% infill and 2 walls should be enough. (If they break, they only become more effective.)
If you intend to leave these somewhere very hot, like in your car during the summer, 
it's best to print these in a plastic with a higher glass transition temperature like ASA, polycarbonate, or ABS.
You may need to add tabs to the spikes, if you have trouble with them peeling off the bed.
It's not going to hurt the function of the part if the spikes *do* peel, it will just be a cosmetic defect.

### What if I don't have access to a 3D printer?
That's okay! Many libraries, universities, schools, maker spaces, and hacker spaces offer cheap 3D printing services.
A few internet searches should turn one up.
If that's not an option either, you can use an online manufacturing broker (list of examples below).
Just upload the `.stl` file and select the material, quantity, delivery address, etc.

Make sure the units are correct and the part is the right size! (STLs don't contain unit/scale information.)
By default, this `.scad` file takes input parameters in inches and outputs in millimeters.
So, unless you've changed `scaleFactor`, that should still be the case.

#### Instant-quote Manufacturing Brokers
- [Hubs](https://www.hubs.com/) (This is the one I typically use.)
- [Xometry](https://www.xometry.com)
- [Protolabs](https://www.protolabs.com/services/3d-printing/)
- [Fictiv](https://www.fictiv.com/3d-printing-service)
- [Rapid Direct](https://www.rapiddirect.com/services/3d-printing/)
- [PCBWay](https://www.pcbway.com/rapid-prototyping/manufacture/)
- [Fathom](https://fathommfg.com/3d-printing-quotes)
- [Jaws Tec](https://app.jawstec.com/3d-print-quote/)

## Customization
The model is fully parameterized, so you can customize it however you like.
Realistically, `ringID` is the only thing that may need tweaking.

### Thingiverse
If running OpenSCAD isn't an option, you can customize the model online via 
[Thingiverse](https://www.thingiverse.com/apps/customizer/run?thing_id=6600517).

__Currently, the Thingiverse customizer is broken by this design!__
I'll try to fix it later. For now, you'll have to just use OpenSCAD.
Fortunately, that process is relatively painless (see below).

### OpenSCAD
To customize on your local machine:

1. Install [OpenSCAD](https://openscad.org/) (available on all major desktop OSes).
1. Download [wheelchairHandleDeterrent.scad](https://raw.githubusercontent.com/Joedang/wheelchairHandleDeterrent/main/wheelchairHandleDeterrent.scad)
1. Open `wheelchairHandleDeterrent.scad` in OpenSCAD.
1. Click "Window" and __uncheck__ "Hide Customizer".
1. In the customizer, click the dropdown that says "design default values" and select your preference.
    1. Alternatively, you can tweak each parameter individually, using one of the presets as a starting point.
1. Click "Design" then "Render" and wait for the render to finish. (This should only take a second or two.)
1. Click "File", then "Export", then "Export as STL".
    1. This is the file you'll either upload to one of the instant-quote sites (see above) or open in your slicer.
