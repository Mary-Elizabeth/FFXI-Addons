# About Fisher

Fisher is an automatic fishing bot for the fishing mini-game in Final Fantasy XI designed as an addon for [Windower 5](https://github.com/Windower/packages/wiki) and [Windower 4](http://windower.net).

This project is a complete rewrite of my old Windower 4 addon of the same name.

## Known Issues

* Under certain conditions fisher may confuse `adoulinian kelp` with an `arrowwood log` and display both names if either is hooked.
* Under certain conditions fisher may confuse how many `tiny goldfish` you hooked and display multiple amounts.

### Windower 4 Limitations

When using Windower 4 you will need to manually edit settings files:
* To change [advanced settings](#advanced-settings), you will need to modify the settings file named after your character.
* If FFXI was installed to a non-default location,[^1] you will need to modify the shared `client_path.xml` settings file.

[^1]: The default install location is `C:\Program Files (x86)\PlayOnline\SquareEnix\Final Fantasy XI\`

### Equipment Restrictions

Automatic fishing will not start and fish/item identification will not work if any of the following items are equipped:
* A `maze monger fishing rod`
* A `peguin ring`, even if it's not activated

## Comparison with Old Addon

### New Features

* No "learning" required for fish/item identification
* More accurate fatigue tracking
* Catch delay is automatically calculated based on the fishing parameters
* Message IDs are automatically parsed from your installed game files
* Ability to catch all fishes and/or items
* Windower 5 support

### Missing Features

* Option to disable moving catches between bags
* Option to disable automatically equipping bait
* Option to stop automatic fishing after a number of `You didn't catch anything.` messages
* Fishing statistics

# Installation

## Automatic (Windower 5 only)

> Windower 5 will also keep fisher up-to-date if you install with this method.

```
/pkg addsrc https://svanheulen.gitlab.io/fisher
/install fisher
```

## Manual

The latest version is always available here: https://svanheulen.gitlab.io/fisher/fisher.zip

When using Windower 4 you will need to extract the archive to the `addons` folder. By default the `addons` folder will be inside the same folder as the `Windower.exe`.

When using Windower 5 you will need to extract the archive to the `packages` folder. By default that will be located at `%LOCALAPPDATA%\Windower\packages`.

# Usage

> When using Windower 4 be sure to use two forward slashes for commands (i.e. `//fisher ...`).

## Specify Catch and Bait

```
/fisher add <item_name>
/fisher remove <item>
/fisher list
```

There is no need to use the same capitalization as the game, and you can also use both the short and long names.
There are also special names `all fish`, `all item`, `all bait` or `all` which can be used to add or remove all fishes/items/baits.
Also when removing a fish, item or bait you can also use the item ID instead of the name.

Here are some examples:

```
/fisher add moat carp
/fisher add CrAyFiSh
/fisher add insect ball
/fisher add ball of insect paste
/fisher add all fish
/fisher remove Moat Carp
/fisher remove 4472
/fisher remove all
/fisher list
```

## Start and Stop Automatic Fishing

> You will need to add at least one fish/item and one bait before starting automatic fishing.

```
/fisher start [catch_limit]
/fisher stop
```

When starting automatic fishing, you can also specify the optional `catch_limit` to stop fishing after the specified number of catches.

Automatic fishing will also stop under the following conditions:
* Your fishing fatigue limit for the day has been reached
* Your catch limit is reached
* You run out of bait
* You run out of inventory space
* You are targeted by an action
* Your player state changes to something other than fishing or idle
* You receive a chat message from a GM
* You perform any action other than `/fish`
* You manually perform any fishing action
* You change zones or log out
* You have a `maze monger fishing rod` equipped
* You have a `penguin ring` equipped, even if it's not activated
* Casting fails multiple times in a row

## Without Automatic Fishing

When fisher is loaded but the automatic fishing is not started it will still track fishing fatigue and display the name of the catches you hook.

## Viewing Tracked Fishing Fatigue

> Your tracked fishing fatigue may be inaccurate if you do any fishing without fisher loaded.

> Modifying your tracked fishing fatigue will not allow you to exceed the actual fishing fatigue limit.

```
/fisher fatigue [modifier]
```

When a `modifier` is not provided this command will display your current amount of tracked fishing fatigue.
If one is provided it will modify or overwrite the amount of tracked fishing fatigue.

Here are some examples:

```
/fisher fatigue
/fisher fatigue +10
/fisher fatigue -10
/fisher fatigue 123
```

## Advanced Settings

> These commands are not available in Windower 4 so you will need to manually edit your settings file to change advanced settings.

```
/settings get fisher <name> <value>
/settings set fisher <name> <value>
```

Here are the available advanced settings:

| Name | Description | Default |
| --- | --- | ---: |
| `equip_delay` | The amount of time in seconds to wait after equipping bait. *If you set this value too low, you may have failed casts after bait is equipped.* | 2 |
| `move_delay` | The amount of time in seconds to wait after moving items between bags. | 0 |
| `cast_attempt_delay` | The amount of time in seconds to wait before retrying to cast your fishing rod. | 3 |
| `cast_attempt_max` | The maximum number of times to attempt casting your fishing rod if fishing does not start. | 3 |
| `release_delay` | The amount of time in seconds to wait before releasing a hooked item that's not in your catch list. | 3 |
| `catch_delay_min` | The minimum amount of time in seconds to wait before reeling in a hooked item. | 3 |
| `catch_delay_override` | An override for the amount of time in seconds to wait before reeling in a hooked item. *A value of zero will disable the override.* | 0 |
| `recast_delay` | The amount of time in seconds to wait after fishing ends to recast your fishing rod. | 3 |
| `catch_unknown` | Specifies if unidentified items should be caught. | false |
| `debug_messages` | Specifies if debug messages should be output to the chat log. | false |

