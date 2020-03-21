define 'ObservableCollection',
[],
() ->
    class ObservableCollection
        @items
        @listenFunction

        getItems: ->
            [@items...]

        constructor: ->
            @items = []
            @listenFunction = null
        mutate: (mutateItems) ->
            @items = mutateItems
            @listenFunction(@items)
        mutateSilent: (mutateItems) ->
            @items = mutateItems
        onChange: (callback) ->
            @listenFunction = callback