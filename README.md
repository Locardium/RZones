# RZones
RZones serve to track and store the player's location in the different predefined zones within the game, allowing events to be triggered or tracked based on the player's current zone.

## Documentation

### Settings
In Settings file.
- `chatByZone` _(bool)_: Chat only work by zones (This function only work if chat version is "LegacyChatService". Change this in "TextChatService" -> "ChatVersion" -> "LegacyChatService")

- `topBarInfo` _(bool)_: Show current zone in the top bar (recomended)

## API Reference

### How to call API
> Can call api in client or server
```lua
    local zAPI = require(game.ReplicatedStorage:WaitForChild("RZones-RS").API)
```

#### zAPI.getSettings()
- **Description**: Retrieves the settings module required from zFolder.
- **Parameters**: None
- **Returns**: A table containing the settings configuration.

```lua
    local settings = zAPI.getSettings()
    print(settings) -- returns the settings table
```

#### zAPI.getCurrentZone(identifier)

- **Description**: Retrieves the current zone that the player is in based on their identifier.
- **Parameters**: 
    - `identifier` _(string or number or player)_: The identifier used to find the player. Use player name or id or player.
- **Returns**: The name of the current zone the player is in, or false if the player is not found.

```lua
    local currentZone = zAPI.getCurrentZone("Player1")
    print(currentZone) -- returns the name of the current zone or false if not found
```

#### zAPI.getCurrentZoneChanged(identifier, callback)
- **Description**: Sets up a listener for changes to the player's current zone, executing a callback when it changes.
- **Parameters**: 
    - `identifier` _(string or number or player)_: The identifier used to find the player. Use player name or id or player.
    - `callback` _(function)_: The function to execute when the current zone changes. Receives the new zone name as an argument.
- **Returns**: A connection object that can be used to disconnect the listener, or false if the player is not found.

```lua
    local connection = zAPI.getCurrentZoneChanged("Player1", function(newZone)
        print("Player1 has moved to:", newZone)
    end)
    -- To disconnect:
    connection:Disconnect()
```

#### zAPI.getAttributes(zoneName, filterPrefix)
- **Description**: Retrieves the attributes of a specified zone, optionally filtering them by a prefix.
- **Parameters**: 
    - `zoneName` _(string)_: The name of the zone to retrieve attributes from. 
    - `filterPrefix` _(string, optional)_: The prefix to filter attributes by.
- **Returns**: A table containing the attributes of the zone, optionally filtered by the prefix, or false if the zone is not found.

```lua
    local attributes = zAPI.getAttributes("Zone1", "filterPrefix")
    print(attributes) -- returns a table of attributes with the prefix, or all attributes if no prefix is provided
```

#### zAPI.getAttribute(zoneName, prefix, attributeName)
- **Description**: Retrieves a specific attribute from a zone based on a prefix and attribute name.
- **Parameters**: 
    - `zoneName` _(string)_: The name of the zone to retrieve the attribute from. 
    - `prefix` _(string)_: The prefix used in the attribute name 
    - `attributeName` _(string)_: The specific attribute name to retrieve.
- **Returns**: The value of the attribute, or false if the zone or attribute is not found.

```lua
    local attributeValue = zAPI.getAttribute("Zone1", "prefix", "attributeName")
    print(attributeValue) -- returns the attribute value or false if not found
```

#### zAPI.setAttribute(zoneName, prefix, attributeName, value)
- **Description**: Sets the value of a specific attribute in a zone, ensuring the prefix is properly formatted.
- **Parameters**:
    - `zoneName` _(string)_: The name of the zone to set the attribute for.
    - `prefix` _(string)_: The prefix for the attribute name.
    - `attributeName` _(string)_: The specific attribute name.
    - `value` _(any)_: The value to set for the attribute.
- **Returns**: true if the attribute was successfully set, or false if the zone was not found.

```lua
    local success = zAPI.setAttribute("Zone1", "prefix", "attributeName", "newValue")
    print(success) -- returns true if the attribute was set, or false if the zone was not found
```
