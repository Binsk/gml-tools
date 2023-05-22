# About

This repository holds a number of gml-based tools that complement GameMaker's existing code base. Tools come in their own classes and will specify any dependencies they may require but otherwise are generally stand-alone. Syncing this entire repository will give you these classes as well as a GameMaker project with demos showing how to use each tool.

**Compatability:** These scripts are currently only guaranteed to work with the desktop platform using the GameMaker runner.

# Tools

* [Signaler](scripts/scr_signals/scr_signals.gml)
* [Controller Handler](objects/obj_controller_manager)

### Signaler

**About:** Signalers provide a way to attach any number of methods to a text label which will be executed in order simply by calling the label. Each method can be given arguments both when attached and when called thus providing a very effective way to execute actions in a more passive manner.

**Dependencies:** None

### Controller Handler

**About:** The controller handler obfuscates the complexity of handling external controllers. It automatically connects and disconnects controllers, assigning them to player slots. Player slots will be reserved in the case of disconnecting and reconnecting or adding new controllers. It also handles limiting controller counts, locking controller connections, and signalling controller inputs when input arrives. Lastly, it support virtual controllers so you can seamlessly integrate keyboard, mouse, touchscreen, and console inputs all while using the same signaling system without having to adjust controls for each type of input.

**Dependencies:** Signaler
