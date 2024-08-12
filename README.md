# About

This repository holds a number of gml-based tools that complement GameMaker's existing code base. Tools come in their own classes and will specify any dependencies they may require but otherwise are generally stand-alone. Syncing this entire repository will give you these classes as well as a GameMaker project with demos showing how to use each tool.

**Compatability:** These scripts are currently only guaranteed to work with the desktop platform using the GameMaker runner. I will be adjusting the project to work under HTML5 and other 'stricter' targets in the future.

# Tools

* [Signaler](scripts/scr_signals/scr_signals.gml)
* [Controller Handler](objects/obj_controller_manager)
* [Load Timer](objects/obj_load_timer)
* [Fixed Timer](objects/obj_fixed_timer)

### Signaler

**About:** Signalers provide a way to attach any number of methods to a text label which will be executed in order simply by calling the label. Each method can be given arguments both when attached and when called thus providing a very effective way to execute actions in a more passive manner.

**Dependencies:** None

### Controller Handler

**About:** The controller handler obfuscates the complexity of handling external controllers. It automatically connects and disconnects controllers, assigning them to player slots. Player slots will be reserved in the case of disconnecting and reconnecting or adding new controllers. It also handles limiting controller counts, locking controller connections, and signalling controller inputs when input arrives. Lastly, it support virtual controllers so you can seamlessly integrate keyboard, mouse, touchscreen, and console inputs all while using the same signaling system without having to adjust controls for each type of input.

**Dependencies:** Signaler

### Load Timer

**About:** The load timer helps distribute expensive CPU tasks across multiple frames. It can be used to queue a large number of individual tasks or even split up a single expensive function. You can specify the maximum frametime allotment the system will use and functions are provided to store and retrieve states of scripts to assist in spreading out calculations.

**Dependencies:** Signaler

### Fixed Timer

**About:** The fixed timer helps execute local instance functions at a stable framerate on delta-timed systems. As an example, the fixed timer can handle updating an instance's velocity while the instance's regular delta-timed step event handles updating the position. This results in consistent jumping and falling rates while providing a smooth positional update regardless of framerate.

**Dependencies:** Signaler